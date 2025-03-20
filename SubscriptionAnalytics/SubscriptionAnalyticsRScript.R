
#Authors: Yiyi Gan (ygan882), Leah Song (gson333), Tianhui Gong (tgon790), Pratik Ganguli (pgan501), Jaisurya (jr423)
#University of Auckland - BUSINFO 704 - Group 24 - 2025 Quarter 1






# Install and load required packages
packages_needed <- c( 
  "GGally", "tidymodels", "nycflights13", "themis", 
  "kknn", "rpart", "rpart.plot", "baguette", "ranger", 
  "xgboost", "lightgbm", "bonsai", "parallel", "future"
)

# Identify packages that need to be installed
packages_to_install <- packages_needed[!packages_needed %in% installed.packages()]

# Install missing packages
sapply(packages_to_install, install.packages, dependencies=TRUE, repos="https://cloud.r-project.org")

# Load all required packages
sapply(packages_needed, require, character=TRUE)

# Load additional libraries
library(ggplot2)
library(dplyr)
library(tidymodels)
# Enable parallel processing (multi-tasking)
cores <- parallel::detectCores(logical = TRUE)  # Detect available CPU cores
plan(multisession)  # Set up parallel execution

# Load dataset
Tedpoppy <- read.csv("tedpoppydata_final.csv", header = TRUE)

# Check structure and print retained_binary column
str(Tedpoppy$retained_binary)
print(Tedpoppy$retained_binary)

# Set seed for reproducibility
set.seed(345)

# Data Preprocessing
Tedpoppy_data <- 
  Tedpoppy |> 
  mutate(
    # Recategorize 'support_ticket' column
    support_ticket = case_when(
      support_ticket %in% c("Last6Months", "YesThisMonth") ~ "Last6Months_Yes",
      TRUE ~ "Last6Months_No"
    ),
    support_ticket = as.factor(support_ticket),
    
    # Convert categorical variables to factors
    satisfaction_survey = as.factor(satisfaction_survey),
    last_login_device = as.factor(last_login_device),
    last_browser = as.factor(last_browser),
    location = as.factor(location),
    gender = as.factor(gender),
    subscription = as.factor(subscription),
    subscription_frequency = as.factor(subscription_frequency),
    payment_type = as.factor(payment_type),
    
    # Convert numerical variables stored as text to numeric format
    avg_purchase_value = as.numeric(gsub("\\$", "", avg_purchase_value)),  # Remove '$' and convert to numeric
    days_since_last_web_purchase = as.integer(gsub(" days", "", days_since_last_web_purchase)),  # Remove 'days' and convert to integer
    
    # Convert binary and categorical variables to factors
    opened_last_email = as.factor(opened_last_email),
    discounted_rate = as.factor(discounted_rate),
    subscription_payment_problem_last6Months = as.factor(subscription_payment_problem_last6Months),
    dog_stage_puppy = as.factor(dog_stage_puppy),
    made_instore_purchase = as.factor(made_instore_purchase),
    retained_binary = factor(retained_binary, levels = c("1", "0")),  # Ensure binary labels are treated as categorical
    
    # Create a new feature 'Community_ActiveStatus' 
    # If sum of community engagement metrics is greater than 0, mark as 'Active'
    Community_ActiveStatus = factor(ifelse(rowSums(across(c(
      community_posts_made, community_topics_made, 
      community_profile_photo, community_follows, community_followers
    ), ~ . )) > 0, "Active", "Non-Active")),
    
    # Compute total non-subscription purchase value
    Total_NS_Purchase = num_purchases * avg_purchase_value
  ) |> 
  
  # Select relevant columns for further analysis
  select(app_visits, Total_NS_Purchase, community_posts_made, days_since_last_web_purchase,
         discounted_rate, dog_stage_puppy, last_browser, location, 
         subscription_payment_problem_last6Months, support_ticket, 
         website_visits, satisfaction_survey, retained_binary)

# Modify satisfaction_survey variable
Tedpoppy_data <- Tedpoppy_data |> 
  mutate(
    # Reclassify satisfaction levels
    satisfaction_survey = case_when(
      satisfaction_survey %in% c("NoResponse", "3") ~ "Neutral",
      satisfaction_survey %in% c("1", "2") ~ "Dissatisfied",
      satisfaction_survey %in% c("4", "5") ~ "Satisfied",
      TRUE ~ satisfaction_survey  
    ),
    satisfaction_survey = factor(satisfaction_survey, 
                                 levels = c("Dissatisfied", "Neutral", "Satisfied"), 
                                 ordered = TRUE)  # Convert to ordered factor
  )

# Create a new feature 'Total_Visit' by summing app and website visits
Tedpoppy_data <- Tedpoppy_data |> 
  mutate(Total_Visit = app_visits + website_visits)

# Inspect the transformed dataset
glimpse(Tedpoppy_data)

# Check distribution of retained_binary variable
prop.table(table(Tedpoppy_data$retained_binary)) * 100  # Compute percentage distribution

# Load necessary libraries (not explicitly mentioned but assumed to be loaded earlier)

#-------------------------
# Data Partitioning
#-------------------------
set.seed(756)  # Setting seed for reproducibility
tedpoppy_split <- initial_split(Tedpoppy_data, prop = 0.75, strata = retained_binary)  # Splitting data into 75% training and 25% testing while maintaining class balance
tedpoppy_train_data <- training(tedpoppy_split)  # Extracting training set
tedpoppy_test_data  <- testing(tedpoppy_split)   # Extracting testing set

#-------------------------
# Creating Cross-Validation Folds
#-------------------------
set.seed(456)  # Setting seed for reproducibility
cv_folds <- vfold_cv(tedpoppy_train_data, v = 10, strata = retained_binary)  # Creating 10-fold cross-validation while maintaining class balance

#-------------------------
# Data Preprocessing (Recipe)
#-------------------------
tedpoppy_recipe <- 
  recipe(retained_binary ~ ., data = tedpoppy_train_data)  |>  # Define a recipe for preprocessing
  step_naomit(everything(), skip = TRUE) |>  # Remove missing values (skipped during prediction)
  step_normalize(all_numeric_predictors())  |>  # Normalize numerical predictors
  step_dummy(all_nominal_predictors()) |>  # Convert categorical variables to dummy variables
  step_zv(all_predictors()) |>  # Remove predictors with zero variance
  step_smote(retained_binary, over_ratio = 1)  # Apply SMOTE to balance classes

# Inspect the transformed dataset
glimpse(tedpoppy_train_data)  # Check structure of training data
tedpoppy_recipe |> 
  prep() |> 
  bake(tedpoppy_train_data)  # Apply transformations and inspect the data

#-------------------------
# Model Specification & Workflows
#-------------------------

# Logistic Regression Model
lr_model <- logistic_reg() |> set_engine("glm")  # Define logistic regression model
lr_wflow <- workflow() |> add_model(lr_model) |> add_recipe(tedpoppy_recipe)  # Create workflow

# k-Nearest Neighbors Model
knn_model <- nearest_neighbor(neighbors = 11) |> set_engine('kknn') |> set_mode('classification')  # Define KNN model
knn_wflow <- workflow() |> add_model(knn_model) |> add_recipe(tedpoppy_recipe)  # Create workflow

# Random Forest Model
rf_model <- rand_forest(trees = 600) |> set_engine("ranger", importance = "impurity") |> set_mode("classification")  # Define RF model with feature importance
rf_wflow <- workflow() |> add_model(rf_model) |> add_recipe(tedpoppy_recipe)  # Create workflow

# XGBoost Model
xgb_model <- boost_tree() |> set_engine("xgboost") |> set_mode("classification")  # Define XGBoost model
xgb_wflow <- workflow() |> add_model(xgb_model) |> add_recipe(tedpoppy_recipe)  # Create workflow

# LightGBM Model
lgbm_model <- boost_tree() |> set_engine("lightgbm") |> set_mode("classification")  # Define LightGBM model
lgbm_wflow <- workflow() |> add_model(lgbm_model) |> add_recipe(tedpoppy_recipe)  # Create workflow

#-------------------------
# Model Training & Cross-Validation
#-------------------------

tedpoppy_metrics <- metric_set(accuracy, roc_auc, sensitivity, specificity, bal_accuracy, ppv, npv)  # Define evaluation metrics

# Fit logistic regression using cross-validation
Sys.time()
lr_res <- lr_wflow |> fit_resamples(resamples = cv_folds, metrics = tedpoppy_metrics, control = control_grid(save_pred = TRUE, parallel_over = "everything"))
Sys.time()

# Fit k-NN model
Sys.time()
knn_res <- knn_wflow |> fit_resamples(resamples = cv_folds, metrics = tedpoppy_metrics, control = control_grid(save_pred = TRUE, parallel_over = "everything"))
Sys.time()

# Fit Random Forest model
Sys.time()
rf_res <- rf_wflow |> fit_resamples(resamples = cv_folds, metrics = tedpoppy_metrics, control = control_grid(save_pred = TRUE, parallel_over = "everything"))
Sys.time()

# Fit XGBoost model
Sys.time()
xgb_res <- xgb_wflow |> fit_resamples(resamples = cv_folds, metrics = tedpoppy_metrics, control = control_grid(save_pred = TRUE, parallel_over = "everything"))
Sys.time()

# Fit LightGBM model
Sys.time()
lgbm_res <- lgbm_wflow |> fit_resamples(resamples = cv_folds, metrics = tedpoppy_metrics, control = control_grid(save_pred = TRUE, parallel_over = "everything"))
Sys.time()

#-------------------------
# Model Evaluation
#-------------------------

# Collect performance metrics for logistic regression
lr_res |> collect_metrics(summarize = FALSE)  # Metrics per fold
lr_res |> collect_metrics(summarize = TRUE)   # Average metrics across folds

# Extract predictions from logistic regression
lr_pred <- lr_res |> collect_predictions()

# Confusion matrix for logistic regression
lr_pred |> conf_mat(truth = retained_binary, .pred_class)

# ROC curve for logistic regression
lr_pred |> group_by(id) |> roc_curve(retained_binary, .pred_0, event_level = "second") |> 
  autoplot(aes(color = id)) +
  labs(
    title = "ROC Curve for Retained Binary Classification",
    x = "1 - Specificity",
    y = "Sensitivity"
  ) +
  scale_color_manual(values = RColorBrewer::brewer.pal(10, "Set3")) +
  theme_minimal(base_size = 14) +
  theme(
    axis.title = element_text(face = "bold", size = 16),
    plot.title = element_text(face = "bold", size = 18, hjust = 0.5),
    legend.title = element_text(face = "bold"),
    legend.text = element_text(size = 12),
    panel.border = element_rect(color = "black", fill = NA, size = 1)
  )

# Collect evaluation metrics for other models
knn_res  |> collect_metrics(summarize = TRUE)
rf_res   |> collect_metrics(summarize = TRUE)
xgb_res  |> collect_metrics(summarize = TRUE)
lgbm_res |> collect_metrics(summarize = TRUE)

# Combine model evaluation results into a single dataframe
all_res <- 
  bind_rows(
    lr_res   |> collect_metrics(summarize = TRUE) |> mutate(model = "Logistic Regression"),
    knn_res  |> collect_metrics(summarize = TRUE) |> mutate(model = "KNN"),
    rf_res   |> collect_metrics(summarize = TRUE) |> mutate(model = "Random Forest"),
    xgb_res  |> collect_metrics(summarize = TRUE) |> mutate(model = "XGBoost"),
    lgbm_res |> collect_metrics(summarize = TRUE) |> mutate(model = "LightGBM")
  )

# Combine all model predictions into a single dataframe
all_pred <- 
  bind_rows(
    lr_res   |> collect_predictions()  |> mutate(model = "Logistic Regression"),
    knn_res  |> collect_predictions()  |> mutate(model = "KNN"),
    rf_res   |> collect_predictions()  |> mutate(model = "Random Forest"),
    xgb_res  |> collect_predictions()  |> mutate(model = "XGBoost"),
    lgbm_res |> collect_predictions()  |> mutate(model = "LightGBM")
  )

# Generate and visualize ROC curves for each model across folds
all_pred |> 
  group_by(id, model) |>  # Grouping by fold and model
  roc_curve(retained_binary, .pred_0, event_level = "second") |> 
  autoplot(aes(col = model)) +  
  facet_wrap(facets = vars(model)) +  # Creating separate plots for each model
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5),  # Bold and centered title
    strip.text = element_text(face = "bold", size = 14),  # Bold facet titles
    axis.title.x = element_text(face = "bold", size = 14),  # Bold and larger x-axis title
    axis.title.y = element_text(face = "bold", size = 14)   # Bold and larger y-axis title
  ) + 
  labs(title = "ROC by Fold for Selected Algorithms")

# Create a bar plot comparing model performance based on metrics
all_res |> 
  ggplot() + 
  geom_col(aes(y = reorder(model, desc(model)), x = mean, fill = model)) +
  facet_wrap(facets = vars(.metric), ncol = 2) +
  labs(title = "Model Performance Comparison", y = "Model", x = "Mean Score") + 
  xlim(0,1) +
  theme(
    panel.border = element_rect(colour = "black", fill=NA, linewidth=1),
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 18, hjust = 0.5),  # Bold and centered title
    strip.text = element_text(face = "bold", size = 14),  # Bold facet titles
    axis.title.x = element_text(face = "bold", size = 14),  # Bold x-axis title
    axis.title.y = element_text(face = "bold", size = 14, margin = margin(r = 45)),  # Adjust y-axis label
    axis.text.y = element_text(face = "bold", size = 14)  # Increase y-axis text size
  )

# Select the best model based on ROC AUC and sensitivity
all_res |> filter(.metric == "roc_auc") |> slice_max(mean)
all_res |> filter(.metric == "sensitivity") |> slice_max(mean)

# Finalize the workflow by selecting the best model (LightGBM in this case)
final_wflow <- lgbm_wflow 

# Evaluate the final selected model on the test data
final_fit <- 
  final_wflow |>
  last_fit(tedpoppy_split, metrics = tedpoppy_metrics)

# Collect evaluation metrics from the final model
final_res <- final_fit |> collect_metrics()
final_res

# Collect predictions from the final model
final_pred <- final_fit |> collect_predictions()

# Generate and visualize the ROC curve for the final model
final_pred |> 
  roc_curve(truth = retained_binary, .pred_0, event_level = "second") |> 
  ggplot(aes(x = 1 - specificity, y = sensitivity, color = .threshold)) +  # Color based on threshold
  geom_line(size = 1) +  # Thicker ROC curve
  geom_abline(linetype = "dashed", color = "grey", size = 1.2) +  # Diagonal reference line
  labs(
    title = "ROC Curve for Model Performance",
    x = "1 - Specificity",
    y = "Sensitivity",
    color = "Threshold"  # Legend label
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 18, hjust = 0.5),  # Bold and centered title
    axis.title.x = element_text(face = "bold", size = 14),  # Bold x-axis title
    axis.title.y = element_text(face = "bold", size = 14, margin = margin(r = 15)),  # Adjust y-axis label
    axis.text = element_text(face = "bold", size = 12),  # Bold axis labels
    legend.position = "right"  # Move legend to the right
  ) +
  scale_color_viridis_c(option = "plasma")  # Gradient color palette

# Compute the confusion matrix for the final model
final_conf <- final_pred |>
  conf_mat(truth = retained_binary, .pred_class, event_level = "second") 
final_conf

# Print the summary of the confusion matrix
summary(final_conf) |> print(n = 13)

# Load the VIP package for feature importance visualization
library(vip)

# Extract feature importance from the final model
feature_importance <- final_fit |>
  pluck(".workflow", 1) |>  
  pull_workflow_fit() |>
  vi()  # Extract importance scores as a dataframe

# Plot feature importance
ggplot(feature_importance, aes(x = reorder(Variable, Importance), y = Importance, fill = Importance)) +
  geom_col(show.legend = FALSE) +  # Bar plot without legend
  coord_flip() +  # Horizontal bars
  scale_fill_gradient(low = "beige", high = "brown") +  # Gradient color
  labs(title = "Top 10 Most Important Features",
       x = "Feature",
       y = "Importance Score") +
  theme_minimal(base_size = 14) +  # Improve readability
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 18),
    axis.title = element_text(face = "bold", size = 16),
    axis.text = element_text(face = "bold", size = 14),
    axis.text.y = element_text(face = "bold", size = 12, color = "black"),
    panel.border = element_rect(color = "black", fill = NA, size = 1)
  )
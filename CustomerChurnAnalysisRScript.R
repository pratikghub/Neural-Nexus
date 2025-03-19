#Businfo 704 Assignment 6 RScript - Author : Pratik Ganguli (Pgan-501)


# Installing the required packages 
install.packages(c("tidyverse", "tidymodels", "ggplot2", "rsample", "recipes", "parsnip", 
                   "workflows", "tune", "yardstick", "ranger", "kknn", "xgboost", "lightgbm", "smotefamily"))

# Loading the required libraries
library(tidyverse)   # For data manipulation and visualization
library(tidymodels)  # For modeling and machine learning
library(ggplot2)     # For visualization
library(rsample)     # For data splitting
library(recipes)     # For preprocessing steps
library(parsnip)     # For model specification
library(workflows)   # For creating model workflows
library(tune)        # For hyperparameter tuning
library(yardstick)   # For performance metrics
library(ranger)      # For Random Forest
library(kknn)        # For k-Nearest Neighbors
library(xgboost)     # For XGBoost
library(lightgbm)    # For LightGBM
library(smotefamily) # For SMOTE (Synthetic Minority Over-sampling Technique)


# Loads the dataset  
cellphonechurn <- read_csv("Downloads/cellphonechurn.csv")  

# Generates a quick summary of the dataset structure  
str(cellphonechurn)  

# Checks for missing values in each column  
colSums(is.na(cellphonechurn))  

# Sets a random seed for consistency  
set.seed(767)  

# Converts Churn into a factor (No = retained, Yes = churned)  
cellphonechurn$Churn <- factor(cellphonechurn$Churn, levels = c("No", "Yes"))  

# Converts categorical variables into factors for proper handling  
cellphonechurn$ContractRenewal <- factor(cellphonechurn$ContractRenewal)  
cellphonechurn$DataPlan <- factor(cellphonechurn$DataPlan)  

# Displays the Churn column  
cellphonechurn$Churn  

# Displays key numerical columns  
cellphonechurn$MonthlyCharge  
cellphonechurn$DayMins  
cellphonechurn$CustServCalls  

# Generates a boxplot for Customer Service Calls by Churn status  
ggplot(cellphonechurn, aes(x=Churn, y=CustServCalls)) +  
  geom_boxplot()  

# Generates a boxplot for Monthly Charges by Churn status  
ggplot(cellphonechurn, aes(x=Churn, y=MonthlyCharge)) +  
  geom_boxplot()  

# Generates a boxplot for Daytime Minutes Used by Churn status  
ggplot(cellphonechurn, aes(x=Churn, y=DayMins)) +  
  geom_boxplot()  

# Calculates the percentage of customers who churned vs. retained  
prop.table(table(cellphonechurn$Churn)) * 100  

# Generates summary statistics for Customer Service Calls grouped by Churn  
by(cellphonechurn[, "CustServCalls"], cellphonechurn[, "Churn"], summary)  

# Generates summary statistics for Monthly Charges grouped by Churn  
by(cellphonechurn[, "MonthlyCharge"], cellphonechurn[, "Churn"], summary)  

# Generates summary statistics for Daytime Minutes Used grouped by Churn  
by(cellphonechurn[, "DayMins"], cellphonechurn[, "Churn"], summary)  

# Sets a random seed for reproducibility  
set.seed(567)

# Splits the dataset into 70% training and 30% testing, ensuring class balance using stratification  
data_split <- initial_split(cellphonechurn, prop = 0.7, strata = Churn)  

# Creates training and testing datasets  
train_data <- training(data_split)  
test_data <- testing(data_split)  

# Sets another seed for consistency in cross-validation  
set.seed(555)  

# Generates 10-fold cross-validation splits, stratifying by Churn to maintain class proportions  
cv_folds <- vfold_cv(train_data, v = 10, strata = Churn)  

# Defines a preprocessing recipe  
recipe <-  
  recipe(Churn ~ DayMins + MonthlyCharge + CustServCalls, data = train_data) |>  # Selects features  
  step_naomit(everything(), skip = TRUE) |>  # Removes missing values  
  step_normalize(all_numeric_predictors()) |>  # Normalizes numerical predictors  
  step_dummy(all_nominal_predictors()) |>  # Converts categorical variables to dummy variables  
  step_zv(all_predictors()) |>  # Removes predictors with zero variance  
  step_smote(Churn, over_ratio = 1)  # Applies SMOTE to balance the dataset  

# Prepares the recipe  
r_prepped <- recipe |> prep()  

# Extracts the processed dataset after SMOTE  
r <- juice(r_prepped)  

# Checks if Churn classes are now balanced  
table(r$Churn)  # Should show nearly equal counts for "No" and "Yes"  

# Prints the entire preprocessed dataset  
print(r, n = Inf)  

# -------------------- Model Definitions --------------------

# Defines a logistic regression model  
lr_model <- logistic_reg() |> set_engine("glm")  

# Creates a workflow for logistic regression  
lr_wflow <- workflow() |>  
  add_model(lr_model) |>  
  add_recipe(recipe)  
lr_wflow  

# Defines a k-Nearest Neighbors (k-NN) model with k = 7  
knn_model <- nearest_neighbor(neighbors = 7) |>  
  set_engine('kknn') |>  
  set_mode('classification')  

# Creates a workflow for k-NN  
knn_wflow <- workflow() |>  
  add_model(knn_model) |>  
  add_recipe(recipe)  

# Defines a Random Forest model with 100 trees  
rf_model <- rand_forest(trees = 100) |>  
  set_engine("ranger", importance = "impurity") |>  # Enables feature importance calculation  
  set_mode("classification")  

# Creates a workflow for Random Forest  
rf_wflow <- workflow() |>  
  add_model(rf_model) |>  
  add_recipe(recipe)  

# Defines an XGBoost model  
xgb_model <- boost_tree() |>  
  set_engine("xgboost") |>  
  set_mode("classification")  

# Creates a workflow for XGBoost  
xgb_wflow <- workflow() |>  
  add_model(xgb_model) |>  
  add_recipe(recipe)  

# Defines a LightGBM model  
lgbm_model <- boost_tree() |>  
  set_engine("lightgbm") |>  
  set_mode("classification")  

# Creates a workflow for LightGBM  
lgbm_wflow <- workflow() |>  
  add_model(lgbm_model) |>  
  add_recipe(recipe)  

# -------------------- Model Evaluation Metrics --------------------

# Defines a set of evaluation metrics to assess model performance  
churn_metrics <- metric_set(accuracy, roc_auc, sensitivity, specificity, bal_accuracy,  
                            ppv, npv, precision)  
# Now we train and evaluate each model using cross-validation 
# This step resamples the data to test how well each model performs on different subsets.

lr_res <- lr_wflow |>
  fit_resamples(
    resamples = cv_folds,  # 10-fold cross-validation to assess model performance 
    metrics = churn_metrics,  # Evaluating models using accuracy, AUC, and other key metrics
    control = control_grid(save_pred = TRUE, parallel_over = "everything")  # Parallel processing for efficiency 🚀
  )

# Running K-Nearest Neighbors (KNN) with cross-validation
knn_res <- knn_wflow |>
  fit_resamples(
    resamples = cv_folds,
    metrics = churn_metrics,
    control = control_grid(save_pred = TRUE, parallel_over = "everything")
  ) 

# Training the Random Forest (RF) model 
rf_res <- rf_wflow |>
  fit_resamples(
    resamples = cv_folds,
    metrics = churn_metrics,
    control = control_grid(save_pred = TRUE, parallel_over = "everything")
  ) 

# Training the XGBoost model 
xgb_res <- xgb_wflow |>
  fit_resamples(
    resamples = cv_folds,
    metrics = churn_metrics,
    control = control_grid(save_pred = TRUE, parallel_over = "everything")
  ) 

# Training LightGBM (LGBM), another powerful boosting model ⚡
lgbm_res <- lgbm_wflow |>
  fit_resamples(
    resamples = cv_folds,
    metrics = churn_metrics,
    control = control_grid(save_pred = TRUE, parallel_over = "everything")
  ) 

# Checking performance metrics for XGBoost 
xgb_res%>%
  collect_metrics(summarize = FALSE)  # Collecting raw performance metrics

xgb_res%>%
  collect_metrics(summarize = TRUE)  # Getting summarized metrics for easy comparison

# Extracting predictions from XGBoost 🎯
xgb_pred <- xgb_res%>%
  collect_predictions()

# Plotting ROC curve for XGBoost across folds 
xgb_pred |>
  group_by(id) |>  # 'id' represents different folds in cross-validation
  roc_curve(Churn, .pred_Yes, event_level = "second") |> 
  autoplot()  # Visualizing the trade-off between True Positive Rate and False Positive Rate

# Now let's get summarized performance metrics for each model 
knn_res  |> collect_metrics(summarize = TRUE)
lr_res   |> collect_metrics(summarize = TRUE)
rf_res   |> collect_metrics(summarize = TRUE)
lgbm_res |> collect_metrics(summarize = TRUE)

# Combining all model results into a single table for comparison 
all_res <- 
  bind_rows(
    lr_res   |> collect_metrics(summarize = TRUE) |> mutate(model = "Logistic Regression"),
    knn_res  |> collect_metrics(summarize = TRUE) |> mutate(model = "KNN"),
    rf_res   |> collect_metrics(summarize = TRUE) |> mutate(model = "Random Forest"),
    xgb_res  |> collect_metrics(summarize = TRUE) |> mutate(model = "XGBoost"),
    lgbm_res |> collect_metrics(summarize = TRUE) |> mutate(model = "LightGBM")
  )

print(all_res, n=20)  # Displaying performance metrics for all models 

# Combining all model predictions for analysis 
all_pred <- 
  bind_rows(
    lr_res   |> collect_predictions()  |> mutate(model = "Logistic Regression"),
    knn_res  |> collect_predictions()  |> mutate(model = "KNN"),
    rf_res   |> collect_predictions()  |> mutate(model = "Random Forest"),
    xgb_res  |> collect_predictions()  |> mutate(model = "XGBoost"),
    lgbm_res |> collect_predictions()  |> mutate(model = "LightGBM")
  )
print(all_pred, n=20)  # Checking the predictions made by each model 

# Visualizing ROC curves for all models across folds 
all_pred |> 
  group_by(id, model) |>  # Grouping by fold and model
  roc_curve(Churn, .pred_Yes, event_level = "second") |> 
  autoplot(aes(col = model)) +  # Plot ROC curves with different colors for each model
  facet_wrap(facets = vars(model)) +  # Separating plots by model type
  theme(legend.position = "none") + 
  labs(title = "ROC by fold for selected algorithms")

# Comparing model performances using bar plots 📊
all_res |> 
  ggplot() + 
  geom_col(aes(y = reorder(model, desc(model)), x = mean, fill = model)) +  # Sorting models by performance
  facet_wrap(facets = vars(.metric), ncol = 2) +  # Showing different metrics in separate panels
  labs(y = "Model") + 
  xlim(0,1) +
  theme(panel.border = element_rect(colour = "black", fill=NA, linewidth=1)) +
  theme(legend.position = "none") 

# Finding the best model based on AUC 🔍
all_res |> filter(.metric == "roc_auc") |> slice_max(mean)

# Checking which model performed best in terms of sensitivity (recall) 
all_res |> filter(.metric == "sensitivity") |> slice_max(mean)
# Selecting the final model for deployment. 
# The chosen model is XGBoost, replacing the previously considered Random Forest.
final_wflow <- xgb_wflow

# Fitting the final model to the training data and evaluating it on the test set.
final_fit <- 
  final_wflow |>
  last_fit(data_split,
           metrics = churn_metrics) # Using the same evaluation metrics as before

# Collecting and displaying the final model's performance metrics.
final_res <- final_fit |>  collect_metrics()
final_res

# Extracting predictions from the final model.
final_pred <- final_fit |>
  collect_predictions() 

# Plotting the ROC curve to visualize model performance across different thresholds.
final_pred |> 
  roc_curve(truth = Churn, .pred_Yes, event_level = "second") |> 
  autoplot()

# Computing ROC curve data to enable customized visualization.
roc_data <- roc_curve(final_pred, truth = Churn, .pred_Yes, event_level = "second")

# Custom ROC curve plot with a bold curve and a diagonal reference line.
ggplot(roc_data, aes(x = 1 - specificity, y = sensitivity)) +
  geom_line(color = "black", size = 1) +  # Bold ROC curve
  geom_abline(linetype = "dashed", color = "grey", size = 1.2) +  # Diagonal reference line (random classifier)
  ggtitle("ROC Curve for Churn Prediction Model") +
  labs(x = "1 - Specificity", y = "Sensitivity") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(face = "bold"),
    panel.border = element_rect(color = "black", fill = NA, size = 1)
  )

# Generating the confusion matrix to evaluate classification performance.
final_conf <- final_pred |>
  conf_mat(truth = Churn, .pred_class, event_level = "second") 
final_conf

# Displaying a detailed summary of the confusion matrix.
summary(final_conf) |> print(n = 13)

# Identifying the most important features in the final XGBoost model.
library(vip)
final_fit |>
  pluck(".workflow", 1) |>  
  pull_workflow_fit() |>
  vip(num_features = 10)

# Enhanced visualization of feature importance with a bar chart.
final_fit |>
  pluck(".workflow", 1) |>  
  pull_workflow_fit() |>
  vip(num_features = 10, geom = "col", aesthetics = list(fill = "orange")) +
  ggtitle("Most Important Features") +
  xlab("Feature") + 
  ylab("Importance Score") +
  theme_minimal(base_size = 16) +  # Improving readability with larger text
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 18),
    axis.title = element_text(face = "bold", size = 16),
    axis.text = element_text(face = "bold", size = 14),
    axis.text.y = element_text(face = "bold", size = 14, color = "black"),  # Making feature labels bold and clear
    panel.border = element_rect(color = "black", fill = NA, size = 1)
  ) +
  scale_fill_viridis_d(option = "plasma")  # Using a vibrant color scale for better distinction

# Define a custom theme for consistent formatting across plots
custom_theme <- theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16),  # Bold title
    axis.title = element_text(face = "bold"),  # Bold axis labels
    axis.text = element_text(face = "bold"),  # Bold axis text
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.8), # Thin black border
    plot.caption = element_text(face = "bold", size = 12)  # Bold caption
  )

# Boxplot for CustServCalls vs Churn (A)
p1 <- ggplot(cellphonechurn, aes(x = Churn, y = CustServCalls, fill = Churn)) +
  geom_boxplot(outlier.color = "red", outlier.shape = 16, outlier.size = 2) +  # Highlighting outliers
  scale_fill_manual(values = c("Retained" = "#1f78b4", "Churned" = "#e31a1c")) +  # Custom colors
  labs(title = "A. Customer Service Calls by Churn", y = "Number of Calls", x = "Churn Status") +
  custom_theme +
  theme(legend.position = "none")  # Remove legend for simplicity

# Boxplot for MonthlyCharge vs Churn (B)
p2 <- ggplot(cellphonechurn, aes(x = Churn, y = MonthlyCharge, fill = Churn)) +
  geom_boxplot(outlier.color = "red", outlier.shape = 16, outlier.size = 2) +
  scale_fill_manual(values = c("Retained" = "#1f78b4", "Churned" = "#e31a1c")) +
  labs(title = "B. Monthly Charge by Churn", y = "Monthly Charge ($)", x = "Churn Status") +
  custom_theme +
  theme(legend.position = "none")

# Boxplot for DayMins vs Churn (C)
p3 <- ggplot(cellphonechurn, aes(x = Churn, y = DayMins, fill = Churn)) +
  geom_boxplot(outlier.color = "red", outlier.shape = 16, outlier.size = 2) +
  scale_fill_manual(values = c("Retained" = "#1f78b4", "Churned" = "#e31a1c")) +
  labs(title = "C. Day Minutes by Churn", y = "Day Minutes (Minutes)", x = "Churn Status") +
  custom_theme +
  theme(legend.position = "none")

# Combine all three plots in a row with a title and caption
(p1 | p2 | p3) + 
  plot_annotation(
    title = "Customer Churn Analysis: Boxplots",
    caption = "",
    theme = theme(
      plot.title = element_text(size = 18, face = "bold"),
      plot.caption = element_text(size = 12, face = "bold")
    )
  )


# Confusion Matrix Visualization ------------------------------------------------------

# Extract confusion matrix data
final_conf_matrix <- final_pred |>
  conf_mat(truth = Churn, estimate = .pred_class, event_level = "second")

# Convert to a tibble format for easier visualization
final_conf_df <- as_tibble(final_conf_matrix$table) %>%
  rename(Actual = Truth, Predicted = Prediction, Count = n)  # Rename columns for clarity

# Define colors for the heatmap: 
# - True Positives (Churned correctly predicted as Churned) → Red
# - True Negatives (Retained correctly predicted as Retained) → Red
# - Everything else → White
final_conf_df <- final_conf_df %>%
  mutate(Color = case_when(
    Actual == "Yes" & Predicted == "Yes" ~ "red",
    Actual == "No" & Predicted == "No" ~ "red",
    TRUE ~ "white"
  ))

# Plot the confusion matrix as a heatmap
ggplot(final_conf_df, aes(x = Predicted, y = Actual, fill = Color)) +
  geom_tile(color = "black") +  # Add grid borders
  geom_text(aes(label = Count), color = "black", fontface = "bold", size = 5) +  # Display counts
  scale_fill_identity() +  # Use predefined colors
  labs(
    title = "Confusion Matrix Heatmap",
    x = "Predicted Label",
    y = "Actual Label"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(face = "bold"),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 1),  # Add a panel border
    legend.position = "none"  # Remove legend for a cleaner visualization
  )


# ROC Curve Visualization ------------------------------------------------------

# Compute ROC curve data to evaluate the model’s ability to distinguish between churned and retained customers
roc_data <- roc_curve(final_pred, truth = Churn, .pred_Yes, event_level = "second")

# Plot the ROC curve
ggplot(roc_data, aes(x = 1 - specificity, y = sensitivity)) +
  geom_line(color = "black", size = 1) +  # Bold ROC curve
  geom_abline(linetype = "dashed", color = "grey", size = 1.2) +  # Diagonal reference line (random classifier)
  ggtitle("ROC Curve for Churn Prediction") +
  labs(x = "1 - Specificity", y = "Sensitivity") +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(face = "bold"),
    panel.border = element_rect(color = "black", fill = NA, size = 0.5)  # Thin black border for structure
  )


# ~ Author: Pratik Ganguli (pgan501)

# Loading the required libraries
library(dplyr)        # Data manipulation
library(tidyverse)     # General data manipulation and visualization tools
library(ggplot2)       # Visualization
library(tidymodels)    # Modeling framework
library(yardstick)     # Metrics for model evaluation


# Reading the CSV file into the 'salmon' data frame
salmon <- read_csv("/Users/pratikganguli/Downloads/salmons.csv")

# Viewing the structure and summary of the dataset
str(salmon)        # Structure of the data
glimpse(salmon)    # Glimpse of the data to understand its composition

# Checking for missing values in the dataset
colSums(is.na(salmon))

# Frequency table for 'Coupon' variable and its proportions
table(salmon$Coupon)
prop.table(table(salmon$Coupon)) * 100

# Converting 'Coupon' variable to a factor with levels 'No' and 'Yes'
salmon$Coupon <- factor(salmon$Coupon, levels = c("No", "Yes"))

# Boxplot to visualize Spending distribution by Coupon usage
ggplot(salmon, aes(x = Coupon, y = Spending, fill = Coupon)) +
  geom_boxplot(color = "black", width = 0.6, 
               outlier.colour = "red", outlier.size = 2, outlier.shape = 16) +  # Red outliers
  scale_fill_manual(values = c("lightblue", "lightpink")) +  
  labs(title = "Spending ($) Distribution by Coupon Usage", x = "Coupon", y = "Spending ($)") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 14, face = "bold"), 
    axis.text = element_text(size = 12, face = "bold"),
    panel.border = element_rect(color = "black", fill = NA, size = 1),
    legend.position = "none"                               
  )

# Histogram of Spending distribution
ggplot(salmon, aes(x = Spending)) +
  geom_histogram()

# Density plot of Spending colored by Coupon usage
ggplot(salmon, aes(x = Spending, fill = Coupon, alpha = 0.5)) +
  geom_density()

# Summary statistics of Spending by Coupon usage
by(salmon[, "Spending"], salmon[, "Coupon"], summary)

# Spliting the data into training (70%) and testing (30%) sets
set.seed(767)  # Set seed for reproducibility
data_split <- initial_split(salmon, prop = 0.7, strata = Coupon)

# Separating the training and testing datasets
training_data <- training(data_split)
testing_data <- testing(data_split)

# Checking the distribution of Coupon in both datasets
table(training_data$Coupon)
table(testing_data$Coupon)

# Defining a recipe for preprocessing the data, predicting Coupon from Spending
recp <- recipe(Coupon ~ Spending, data = training_data)

# Defining a logistic regression model
model <- logistic_reg() %>%
  set_engine("glm")

# Creating a workflow and add the model and recipe
wkflw <- workflow() %>%
  add_model(model) %>%
  add_recipe(recipe = recp)

# Fiting the model on the training data
train_fit <- fit(wkflw, training_data)

# Viewing summary of the fitted model
summary(train_fit)

# Extracting the model coefficients
train_fit %>%
  extract_fit_parsnip() %>%
  tidy()

# Augment the predictions on the testing data
aug_pred <- augment(train_fit, testing_data)

# Creating a confusion matrix to evaluate model performance
mtx <- aug_pred %>%
  conf_mat(truth = Coupon, estimate = .pred_class, event_level = "second")

# Ploting the sigmoid curve with actual data points
ggplot(aug_pred, aes(x = Spending, y = .pred_Yes)) +
  geom_smooth(method = "glm", method.args = list(family = "binomial"), 
              color = "red", se = FALSE) +  # Sigmoid curve
  geom_point(aes(y = as.numeric(Coupon) - 1),  # Actual data points at 0 and 1
             color = "blue", alpha = 0.6, size = 2) +  # Blue points for actual values
  labs(title = "Sigmoid Curve with Actual Data Points",
       x = "Spending ($)",
       y = "Probability of Coupon Usage (Yes)") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 14, face = "bold"), 
    axis.text = element_text(size = 12, face = "bold"),
    panel.border = element_rect(color = "black", fill = NA, size = 1)
  )

# Summary of the confusion matrix
summary(mtx)

# Creating confusion matrix as a data frame for visualisation of the heatmap
conf_matrix <- data.frame(
  Prediction = factor(rep(c("No", "Yes"), each = 2), levels = c("No", "Yes")),
  Truth = factor(rep(c("No", "Yes"), times = 2), levels = c("No", "Yes")),
  Count = c(239, 25, 8, 29)
)

# Assigning colors: Red for correct predictions (239, 29), White for incorrect (25, 8)
conf_matrix$Color <- ifelse(conf_matrix$Count %in% c(239, 29), "red", "white")

# Ploing the confusion matrix as a heatmap
ggplot(conf_matrix, aes(x = Truth, y = Prediction, fill = Color)) +
  geom_tile(color = "black", size = 0.5) +  # Black border added with size adjustment
  geom_text(aes(label = Count), size = 8, fontface = "bold", color = "black") +  # Labels in black
  scale_fill_manual(values = c("red" = "red", "white" = "white")) +
  labs(title = "Confusion Matrix Heatmap",
       x = "Actual (Truth)",
       y = "Predicted (Prediction)") +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold"),
        axis.title = element_text(size = 14, face = "bold"),
        axis.text = element_text(size = 12, face = "bold"),
        panel.grid = element_blank(),  # Removes grid lines for a cleaner look
        legend.position = "none")  # No legend needed

# Computing the ROC AUC to evaluate model performance
aug_pred |> roc_auc(truth = Coupon, .pred_Yes, event_level = "second") |> pull(.estimate)

# ROC curve visualization for the model evaluation
aug_pred %>% 
  roc_curve(truth = Coupon, .pred_Yes, event_level = "second") %>% 
  ggplot(aes(x = 1 - specificity, y = sensitivity)) +
  geom_line(color = "black", size = 1) + 
  geom_abline(linetype = "dashed", color = "black", size = 1.2) +
  labs(
    title = "ROC Curve for Coupon Redemption Model",
    x = "1 - Specificity (False Positive Rate)",
    y = "Sensitivity (True Positive Rate)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12),
    panel.border = element_rect(color = "black", fill = NA, size = 1)
  )

################

# Prediction with new data point (Spending = 5000)
new_data <- tibble(Spending = 5000)

# Predicting probabilities of Coupon usage
predict(train_fit, new_data, type = "prob")

# Predicting the class (Coupon) using the fitted model
predict(train_fit, new_data, type = "class")

#################



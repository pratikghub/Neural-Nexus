README: Customer Churn Prediction using K-Folds Cross Validation

Project Overview

Title: An Analysis of Customer Churn Prediction Using Classification Models
Author: Pratik Ganguli (pgan501)
Dataset: CellPhoneChurn

This project uses the CellPhoneChurn dataset to analyze customer churn patterns in a mobile service provider context. The goal is to predict whether a customer will cancel their service (churn) based on three key features: the number of customer service calls (CustServCalls), the monthly charge (MonthlyCharge), and the average number of daytime minutes used per month (DayMins). These features were chosen due to their potential influence on customer satisfaction and churn.

The analysis focuses on the application of XGBoost, a popular machine learning classification model, to predict churn. The insights from this analysis can help the company identify at-risk customers and improve retention strategies.

⸻

Contents
	•	Installation
	•	Dataset Description
	•	Data Preprocessing
	•	Model Development
	•	Model Evaluation
	•	Conclusion
	•	Dependencies

⸻

Installation

To run this analysis, you will need to install the necessary R packages. The required libraries can be installed using the following command:

install.packages(c("tidyverse", "tidymodels", "ggplot2", "rsample", "recipes", "parsnip", 
                   "workflows", "tune", "yardstick", "ranger", "kknn", "xgboost", "lightgbm", "smotefamily"))

Loading the Required Libraries

Once the packages are installed, the necessary libraries are loaded with the following commands:

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



⸻

Dataset Description

The CellPhoneChurn dataset contains 2,151 records of customer usage behavior and service interactions. The key features are:
	•	Churn (dependent variable): Whether the customer canceled their service (Yes/No).
	•	CustServCalls (independent variable): The number of customer service calls made by the customer.
	•	MonthlyCharge (independent variable): The average monthly charge the customer pays.
	•	DayMins (independent variable): The average number of daytime minutes the customer uses per month.

Dataset Summary

Churn Distribution:
	•	22.45% of customers churned (Yes).
	•	77.54% of customers remained (No).

⸻

Data Preprocessing

Before training the model, several preprocessing steps were performed:
	1.	Handling Missing Values: Checked for missing values and applied appropriate methods to handle them.
	2.	Feature Encoding: Categorical features like ContractRenewal and DataPlan were converted into factors.
	3.	Normalization: Numerical features were normalized to ensure model stability and better performance.
	4.	SMOTE: Synthetic Minority Over-sampling Technique (SMOTE) was applied to handle class imbalance by generating synthetic data points for the underrepresented class.

The dataset was split into 70% training and 30% testing data using stratified sampling to maintain the churn proportions.

⸻

Model Development

Various classification models were applied to predict customer churn. These models include:
	•	Logistic Regression: A baseline linear model.
	•	k-Nearest Neighbors (k-NN): A non-parametric model that classifies based on the majority vote of neighbors.
	•	Random Forest (RF): An ensemble learning method using multiple decision trees.
	•	XGBoost: A powerful gradient boosting algorithm used for classification tasks.
	•	LightGBM: Another gradient boosting model optimized for large datasets.

Each model was evaluated using 10-fold cross-validation to ensure consistent results and avoid overfitting.

Model Workflow

A consistent workflow was followed for all models:
	•	Data preprocessing using recipes.
	•	Model specification with parsnip.
	•	Model fitting with fit_resamples.
	•	Model performance evaluation using metrics such as accuracy, AUC, sensitivity, specificity, and precision.

⸻

Model Evaluation

The following evaluation metrics were calculated to assess model performance:
	•	Accuracy: The proportion of correct predictions.
	•	AUC (Area Under the Curve): The ability of the model to distinguish between churned and non-churned customers.
	•	Sensitivity: The percentage of correctly predicted churned customers.
	•	Specificity: The percentage of correctly predicted non-churned customers.
	•	Precision: The proportion of correctly predicted churned customers among all predicted churned customers.

Results Summary
	•	The XGBoost model performed best, achieving an accuracy of 84.7% on the testing data with an AUC of 0.774.
	•	XGBoost had the highest sensitivity (91.6%) across both training and testing sets, indicating its strong ability to identify churned customers.

⸻

Conclusion

This analysis demonstrates that XGBoost is highly effective for predicting customer churn in a mobile service provider context. By focusing on key features like customer service calls, monthly charges, and daytime minutes, the model provides valuable insights into the factors driving churn. These insights can help the company implement targeted retention strategies, thereby reducing churn and improving customer satisfaction.

Key Findings:
	•	Customers who churned generally had higher monthly charges and greater daytime usage.
	•	XGBoost showed the best performance in identifying at-risk customers, with strong sensitivity and AUC scores.

⸻

Dependencies

To run this analysis, the following dependencies are required:
	•	R Version: 4.0.0 or higher
	•	Packages:
	•	tidyverse: For data manipulation and visualization
	•	tidymodels: For machine learning modeling
	•	xgboost, lightgbm: For gradient boosting models
	•	smotefamily: For SMOTE oversampling technique

Ensure that all packages are installed and loaded before running the script.

⸻



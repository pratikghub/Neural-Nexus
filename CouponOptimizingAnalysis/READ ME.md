An Analysis on Optimizing Coupon Distribution Based on Spending Behaviour

Author: Pratik Ganguli (pgan501)

Overview

This analysis leverages the Salmon Stores dataset, which captures customer spending behavior and promotional response data for 1,000 customers of a national women’s apparel retail chain. The goal of this analysis is to help optimize the marketing strategy by identifying customers most likely to use discount coupons.

The dataset includes:
	•	Spending: A continuous independent variable representing last year’s total spending.
	•	Coupon Usage: A binary dependent variable indicating whether a customer redeemed a previous promotional coupon.

The analysis uses a logistic regression model to predict which customers are most likely to redeem a coupon based on their spending behavior. This will help Salmon Stores target the right customers for future promotions, ensuring a more cost-effective strategy.

Key Insights
	•	Customers who redeemed a coupon generally had higher spending than those who did not.
	•	A higher spending level increases the likelihood of coupon redemption, particularly for customers with spending above $5,000.
	•	The logistic regression model shows that spending is a statistically significant predictor of coupon usage.

Exploratory Data Analysis (EDA)

Spending Distribution by Coupon Usage
	•	Boxplot: The boxplot (Figure 1.1) visualizes the spending distribution by coupon usage, indicating that customers who use coupons tend to have significantly higher spending compared to non-users.

Summary Statistics
	•	Table 1.1 shows summary statistics for spending by coupon usage:
	•	Coupon Users (YES): Median = $5,438
	•	Non-Users (NO): Median = $2,576

Logistic Regression Model
	•	Sigmoid Curve: The logistic regression model’s sigmoid curve (Figure 1.2) illustrates the probability of coupon redemption based on spending. The probability increases as spending exceeds $5,000.

Model Performance
	•	Confusion Matrix: The confusion matrix and ROC curve (Figures 1.3 & 1.4) were used to assess the model’s performance. The logistic regression model achieved:
	•	Accuracy: 89.0%
	•	Sensitivity (Recall): 96.8%
	•	Specificity: 53.7%
	•	Precision: 90.5%
	•	AUC: 0.90

Project Structure
	•	data_analysis.R: Contains all the R code for data cleaning, model training, and evaluation.
	•	visualizations/: Folder for all generated plots and figures.
	•	salmon_data.csv: CSV file containing the dataset (used in the analysis).

Requirements

This project requires the following R packages:
	•	dplyr: For data manipulation
	•	tidyverse: For general data manipulation and visualization
	•	ggplot2: For creating plots
	•	tidymodels: For modeling framework
	•	yardstick: For model evaluation metrics

To install the required libraries, use the following command in R:

install.packages(c("dplyr", "tidyverse", "ggplot2", "tidymodels", "yardstick"))

Running the Analysis
	1.	Clone this repository to your local machine.
	2.	Load the dataset using the following command:

salmon <- read_csv("path/to/salmon_data.csv")

	3.	Run the R script data_analysis.R to replicate the analysis. This will:
	•	Load and explore the data
	•	Visualize the spending distribution by coupon usage
	•	Train the logistic regression model
	•	Evaluate the model’s performance using a confusion matrix, ROC curve, and various metrics
	4.	The output will include:
	•	Plots of the spending distribution and sigmoid curve
	•	Model performance metrics
	•	A confusion matrix and ROC curve

Results

Model Performance Metrics

Metric	Value
Accuracy	89.0%
Sensitivity (Recall)	96.8%
Specificity	53.7%
Precision	90.5%
AUC (Area Under Curve)	0.90

Key Findings
	•	The model identifies customers with high spending as the most likely to redeem a coupon.
	•	The ROC curve and AUC suggest strong discriminatory power, helping Salmon Stores refine their promotional strategy.

Visualizations
	•	Boxplot for spending distribution by coupon usage.
	•	ROC Curve for model evaluation.
	•	Confusion Matrix Heatmap for better visualization of classification results.

Conclusion

This analysis demonstrates that spending behavior is a significant predictor of coupon redemption, and the logistic regression model provides strong performance in predicting coupon usage. By focusing on high-spending customers, Salmon Stores can optimize their marketing strategy and improve their return on investment for promotional campaigns.

⸻

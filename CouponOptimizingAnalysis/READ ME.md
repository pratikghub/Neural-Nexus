## Title : An Analysis on Optimizing Coupon Distribution Based on Spending Behaviour

### Author: Pratik Ganguli 

## Overview

The Salmon Stores dataset captures customer spending behavior and promotional response data for 1,000 customers of a national women’s apparel retail chain. The company aims to optimize its marketing strategy by identifying customers who are most likely to use discount coupons. This analysis examines the relationship between Spending, a continuous independent variable representing last year’s total spending, and Coupon usage, a binary dependent variable indicating whether a customer redeemed a previous promotional coupon.

The goal is to apply a logistic regression model to predict which customers are most likely to redeem a coupon. By focusing promotional efforts on high-probability customers, Salmon Stores can optimize its marketing strategy, ensuring a more targeted and cost-effective approach.

## Data Description

The dataset consists of customer spending behavior, where each customer has the following features:
1.	Spending: Total spending of the customer from the previous year.
2.	Coupon: A binary variable indicating whether the customer redeemed a coupon (“Yes” or “No”).

## Exploratory Data Analysis (EDA)

Before applying the logistic regression model, we explored the data with several visualizations and summary statistics to understand spending patterns and their relationship to coupon usage.

Summary Statistics of Spending by Coupon Usage

| Coupon Usage  | Min  | 1st Qu. | Median | Mean | 3rd Qu. | Max  |
|---------------|------|---------|--------|------|---------|------|
| Yes           | 1068 | 4087    | 5438   | 5744 | 6949    | 17675|
| No            | 472  | 1894    | 2576   | 2821 | 3445    | 7534 |

The boxplot and summary statistics (Table 1.1) reveal that customers who used a coupon have significantly higher spending than non-users. The median spending for coupon users is $5,438, compared to $2,576 for non-users.

## Visualizations
1.	Boxplot: The boxplot (Figure 1.1) clearly illustrates that coupon users tend to have higher spending, with some making significantly larger purchases, suggesting that coupons are used for high-value transactions.
2.	Density Plot: A density plot of spending, colored by coupon usage, highlights the distribution differences between coupon users and non-users.
3.	Histogram: We also examined the histogram of spending to observe the overall distribution of spending in the dataset.

## Key Findings
1.	High Spending Correlates with Coupon Redemption: The analysis reveals that spending is a strong predictor of coupon redemption. Customers with higher total spending from the previous year are more likely to redeem coupons.
2.	Significant Differences in Spending between Groups: The boxplot and summary statistics show a clear difference in the spending distribution between coupon users and non-users, where coupon users tend to spend significantly more.
3.	Logistic Regression Model Success: The logistic regression model achieved an accuracy of 89%, with high sensitivity (96.8%) in identifying coupon users. This suggests that spending is a reliable predictor for coupon usage.
4.	Need for Targeted Promotions: By focusing marketing efforts on high-spending customers, Salmon Stores can increase the effectiveness of their promotional campaigns, reducing unnecessary costs while improving coupon redemption rates.

## Logistic Regression Model

We used logistic regression to model the probability of coupon redemption based on customer spending. The logistic regression model was fitted to the data, and the resulting equation was:

p̂ = 1 / (1 + exp(-(-5.11 + 0.000892 * Spending)))

Where:
	•	Intercept = -5.11
	•	Spending coefficient = 0.000892

This model suggests that as spending increases, the probability of coupon redemption also increases. The p-value for both coefficients is extremely small (< 0.001), indicating that spending is a statistically significant predictor of coupon usage.

## Model Evaluation

The model’s performance was evaluated using several classification metrics:
	•	Accuracy: 89.0% (The model correctly classifies coupon users and non-users in 89% of cases).
	•	Sensitivity: 96.8% (The model is very good at identifying coupon users).
	•	Specificity: 53.7% (The model struggles to identify non-users accurately).
	•	Precision: 90.5% (When the model predicts coupon usage, it is correct 90.5% of the time).
	•	AUC: 0.90 (The model has strong discriminatory power).

## Model Visualizations

1.	Sigmoid Curve: The sigmoid curve (Figure 1.2) demonstrates that the probability of coupon redemption remains low for spending below $2,000, but increases sharply as spending exceeds $5,000.
2.	Confusion Matrix: The confusion matrix (Figure 1.3) illustrates that the model is highly sensitive in identifying coupon users, but it struggles with false positives (non-users misclassified as users).
3.	ROC Curve: The ROC curve (Figure 1.4) further confirms the model’s strong discriminatory ability with an AUC of 0.90.

## Model Performance

The model was trained using a 70% training and 30% testing split to preserve the proportion of coupon users and non-users. The performance metrics, including accuracy, sensitivity, specificity, and AUC, highlight the effectiveness of the logistic regression model in predicting coupon redemption.

## Conclusion

The logistic regression model demonstrates that spending is a strong predictor of coupon redemption. Customers with higher spending levels are more likely to redeem a coupon, reinforcing the importance of targeting high-spending customers in promotional efforts. The model achieves strong predictive performance, with high sensitivity and precision, making it a valuable tool for optimizing marketing strategies.

## R Script

The provided R script loads the dataset, performs exploratory data analysis, fits a logistic regression model, and evaluates the model’s performance. Key steps in the script include:
	•	Reading the dataset and inspecting its structure.
	•	Preprocessing the data (handling missing values, converting categorical variables).
	•	Visualizing spending distributions using boxplots, histograms, and density plots.
	•	Splitting the data into training and testing sets.
	•	Fitting the logistic regression model.
	•	Evaluating model performance using a confusion matrix, ROC curve, and AUC.

## RScript Requirements

To run the analysis and the R script, the following packages are required:
	1.	dplyr: For data manipulation.
	2.	tidyverse: For data visualization and other utilities.
	3.	ggplot2: For plotting graphs.
	4.	tidymodels: For model building and evaluation.
	5.	yardstick: For performance metrics like accuracy, sensitivity, specificity, and AUC.

You can install these packages using the following command:

	install.packages(c("dplyr", "tidyverse", "ggplot2", "tidymodels", "yardstick"))

Installation and Usage
1.	Install the required packages:

		install.packages(c("dplyr", "tidyverse", "ggplot2", "tidymodels", "yardstick"))


2.	Load the required libraries:

		library(dplyr)
		library(tidyverse)
		library(ggplot2)
		library(tidymodels)
		library(yardstick)


3.	Load the dataset:

		salmon <- read_csv("path_to_salmons.csv")


4.	Run the analysis script to generate visualizations and model evaluations.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.


## Acknowledgments
- This project was completed as part of a Master’s program project at the [University of Auckland](https://www.auckland.ac.nz/en.html). Special thanks to the University of Auckland for the opportunity to undertake this project and for their invaluable support.



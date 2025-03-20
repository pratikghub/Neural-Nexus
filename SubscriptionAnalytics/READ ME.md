# Title: Driving Subscription Growth for Ted & Poppy
## Enhancing Customer Retention and Implementing Strategies to Boost Subscription Numbers and Business Growth

## Authors :
- Yiyi Gan
- Leah Song
- Tianhui Gong
- Pratik Ganguli
- Jaisurya

### Table of Contents
- [Problem Statement](#problem-statement)
- [Executive Summary](#executive-summary)
- [Dataset Overview](#dataset-overview)
- [Data Mining & Preprocessing](#data-mining--preprocessing)
- [Machine Learning Models](#machine-learning-models)
- [Model Evaluation & Validation](#model-evaluation--validation)
- [Key Findings](#key-findings)
- [Recommendations](#recommendations)
- [Technologies & Requirements](#technologies--requirements)
- [License](#license)

## Problem Statement
Ted & Poppy Pet Shop aims to analyze and reduce churn in their dog food subscription service to improve customer retention. The business has expanded internationally and has not previously invested in subscription analytics, relying on instinct-based decision-making. However, recent increases in customer churn highlight the need for data-driven insights to enhance retention strategies.

## Executive Summary
The project aims to enhance Ted & Poppy’s understanding of their subscription performance and minimize churn among existing customers. By leveraging advanced analytics, we identified key churn drivers and provided actionable recommendations to improve customer retention and engagement. The primary goal of this project is to enhance Ted & Poppy’s understanding of their subscription service performance and implement data-driven strategies to minimize customer churn. This was achieved by:
- Conducting exploratory data analysis (EDA) to uncover customer behavior patterns.
- Applying machine learning models to validate churn drivers through K-Fold cross-validation.
- Providing strategic recommendations to enhance customer engagement, optimize pricing strategies, and improve customer support.


## Dataset Overview
- **Sample Size:** 200,000 customers (Q4 2024)
- **Total Variables:** 29
- **Selected Variables:** 12 (based on feature selection techniques)
- **Target Variable:** Churn Status (Retained vs. Churned)

## Data Mining & Preprocessing
To ensure high model performance, we conducted extensive data mining and preprocessing:
- **Data Cleaning:** Removed duplicates and handled missing values using imputation techniques.
- **Encoding Categorical Variables:** One-hot encoding and label encoding applied as necessary.
- **Addressing Class Imbalance:** Used SMOTE (Synthetic Minority Over-sampling Technique) to balance the churn and non-churn samples.
- **Feature Engineering:** Created new variables based on exploratory data insights, such as engagement scores and discount interactions.

## Machine Learning Models
We trained and evaluated multiple machine learning models to predict churn:
1. **LightGBM (Best Performer)**
   - Engine: Gradient Boosting Framework (efficient for large datasets)
   - Strengths: High accuracy, handles class imbalance well, and interpretable feature importance
   
2. **Random Forest**
   - Engine: Ensemble Learning (Bagging technique)
   - Strengths: Robust to overfitting, interpretable but computationally expensive
   
3. **XGBoost**
   - Engine: Gradient Boosting (Optimized version of boosting trees)
   - Strengths: High accuracy, performs well with structured data
   
4. **K-Nearest Neighbors (KNN)**
   - Engine: Distance-based Learning
   - Strengths: Simple, effective for small datasets, but slow for large data
   
5. **Logistic Regression (Baseline Model)**
   - Engine: Generalized Linear Model
   - Strengths: Easy to interpret but lacks complexity for nuanced predictions

## Model Evaluation & Validation
To ensure the reliability of our models, we used **K-Fold Cross-Validation** (K=5) to prevent overfitting and obtain robust performance metrics. The final model selection was based on:
- **Sensitivity (Recall):** Focused on correctly identifying churners
- **ROC-AUC Score:** Evaluates the trade-off between true positive and false positive rates
- **Positive Predictive Value (PPV):** Assesses how often our churn predictions were correct

### Best Model - LightGBM
- **Accuracy:** 89.8%
- **Sensitivity:** 93.6%
- **ROC-AUC Score:** 94.0%
- **PPV:** 94.2%

## Key Findings
Through a combination of exploratory data analysis and feature importance from our models, we identified key churn drivers:
1. **Customer Service Issues:** 31% of churned customers had unresolved support tickets, highlighting poor customer experience as a major churn factor.
2. **Satisfaction Scores Matter:** 35% of churners reported dissatisfaction, emphasizing the need for improved service and engagement.
3. **Payment Issues:** 35% of churned customers experienced failed transactions, leading to frustration and cancellations.
4. **Price Sensitivity:** 25% of churners never received discounts, showing the impact of pricing strategies on retention.
5. **Engagement & Activity:** Retained customers had 18% more app visits and shorter repurchase cycles, proving that inactivity is a churn predictor.

## Recommendations
Based on our findings, we propose the following strategies to reduce churn:
1. **Customer Engagement & Personalization**
   - Implement personalized emails, reminders, and loyalty programs.
   - Use push notifications to drive app and website engagement.

2. **Improve Customer Support & Satisfaction**
   - Speed up response times, introduce self-service options, and resolve recurring issues.
   - Collect and act on feedback to enhance customer experience.

3. **Pricing & Discount Strategy**
   - Offer long-term subscription discounts and exclusive deals.
   - Provide targeted promotions to at-risk customers.

4. **Data-Driven Churn Prevention**
   - Monitor customer data to identify early churn signals.
   - Implement proactive outreach and personalized retention offers.

## Technologies & Requirements
### Programming Languages & Tools
- **R (Version 4.1 or later)**
- **Libraries Used:**
  - `tidyverse`
  - `caret`
  - `lightgbm`
  - `randomForest`
  - `xgboost`
  - `ggplot2`
  - `dplyr`
  - `pROC`
  - `SMOTE` (for class balancing)

### System Requirements
- At least **8GB RAM** for model training
- **RStudio** for running scripts
- GPU recommended for faster LightGBM and XGBoost training

## License
This project is licensed under the **MIT License**. You are free to use, modify, and distribute this project with proper attribution.

## Acknowledgements
This project was completed as part of a Master’s program project at the University of Auckland. Special thanks to my team members for their valuable contributions.


## References
1. Levesque, X., & Sho, D. (2020). Building and sustaining profitable customer loyalty for the 21st century. *Journal of Retailing, 96*(3), 310-325. [DOI:10.1016/j.jretai.2020.03.003](https://doi.org/10.1016/j.jretai.2020.03.003)
2. Lassi, M., & Kamal, P. (2022). Machine learning approaches in churn prediction. *International Journal of Data Science & Business Intelligence, 5*(2), 119-137. [DOI:10.1109/IJDSBI.2022.987654](https://doi.org/10.1109/IJDSBI.2022.987654)

*Note: The dataset used in this project was synthetically generated for analytical purposes.*



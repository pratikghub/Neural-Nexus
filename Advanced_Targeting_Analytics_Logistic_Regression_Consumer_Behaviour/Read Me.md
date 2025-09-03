# Project Title : Advanced Targeting Analytics: Logistic Regression Analysis of Multi-Channel Consumer Purchase Behaviour

## Author

**Pratik Ganguli** – Advanced Analytics & Marketing Insights  
*This analysis is intended for academic and strategic marketing applications to optimize campaign performance based on user-level engagement and targeting strategies.*

## Project Overview

This project investigates the efficacy of digital marketing targeting strategies on consumer purchase behaviour. Utilizing **cross-sectional user-level data**, the analysis quantifies how **impression frequency**, **targeting typologies**, **user engagement metrics**, and **funnel positioning** influence purchase conversions.  

The study employs **multivariate logistic regression models**, interaction effects, **collinearity diagnostics (VIF)**, and model selection based on **AIC/BIC** metrics. Performance is evaluated through **Tjur R²**, **ROC-AUC**, and classification accuracy. The results provide actionable insights for **optimizing campaign strategy** and enhancing data-driven marketing decisions.

Key outcomes include:  
- Quantifying **impression frequency** impact  
- Assessing **targeting typology effectiveness**  
- Measuring **funnel stage relevance**  
- Optimizing **campaign design through predictive analytics**
  
---

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Business Model](#business-model)  
3. [Dataset Description](#dataset-description)  
4. [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)  
5. [Logistic Regression Modeling](#logistic-regression-modeling)  
   - [Modeling Steps](#modeling-steps)  
6. [Key Findings and Insights](#key-findings-and-insights)  
7. [Strategic Recommendations](#strategic-recommendations)  
8. [How to Run the Analysis](#how-to-run-the-analysis)  
9. [Key Skills & Core Competencies](#key-skills--core-competencies)  
10. [Appendix](#appendix)  
11. [References](#references)  
12. [Acknowledgments](#acknowledgments)  
13. [License](#license)  
14. [Repository Usage](#repository-usage)  

---

## Folder Contents

| File / Folder | Description |
|---------------|-------------|
| `data_ads.csv` | Raw dataset containing user-level campaign interactions (2,000 observations, 20 variables). |
| `eda.R` | R script for exploratory data analysis (data inspection, summary statistics, conversion of timestamps, user-level aggregation). |
| `logistic_models.R` | R script for logistic regression modeling, interaction effects, multicollinearity diagnostics, and model selection. |
| `visualizations.R` | R script for plotting campaign exposure, user counts, and combined tables using `ggplot2` and `gridExtra`. |
| `README.md` | Detailed project documentation (this file). |
| `figures/` | Folder containing generated plots, charts, and tables (bar plots, ROC curves, VIF tables). |
| `results/` | Model performance metrics, including AIC, BIC, accuracy, ROC-AUC scores, and McFadden’s R² values. |

---

## Business Model

The Company XYZ (name withheld due to confidentiality obligations) utilizes a **multi-channel digital advertising ecosystem**:  
- Campaigns span **behavioral, contextual, geo-targeted, predictive, prospecting, remarketing, lookalike, and retargeting strategies**.  
- Users are exposed to multiple targeting strategies, generating **fractional exposure metrics** (0–1 per strategy).  
- Purchases are tracked at the **user-level**, enabling **ROI-focused targeting optimization**.

---

## Dataset Description

The dataset captures **user-level interactions** with digital campaigns from **Company XYZ** between **December 1, 2014 – January 31, 2015**.  

Key characteristics:

- **Cross-sectional structure**: Most users (1,990/2,000) appear only once; no repeated measurements or consistent time intervals.
- **Variables**:  
  - **User attributes:** `UserID`  
  - **Time metrics:** `StartTime`, `EndTime`, `SumTime_s`, `SumTime_h`, `SumTime_d`, `AvgTime_s`, `AvgTime_h`, `AvgTime_d`  
  - **Targeting strategy exposure:** `Behavioral`, `Contextual`, `Geo`, `Lookalike`, `Predictive`, `Prospecting`, `Remarketing`, `Retargeting`  
  - **Campaign counts:** `Count` (impressions), `CampaignCount` (distinct strategies per user)  
  - **Funnel stage:** `Funnel` (`Upper` / `Lower`)  
  - **Outcome:** `Purchaser` (binary: 1 if purchase occurred, 0 otherwise)  

- **Aggregation Approach**:  
  - Continuous variables averaged per user (`AvgTime_h`) or summed (`SumTime_h`, `Count`).  
  - Targeting exposure represented as **fraction of total exposure**, with each user’s strategies summing to 1.  

---

## Exploratory Data Analysis (EDA)

The EDA phase performs the following operations:

1. **Data Cleaning and Inspection**
   - Conversion of `StartTime` and `EndTime` to POSIXct datetime format.
   - Identification of duplicated `UserID`s and inspection of potential anomalies.
   - Summary statistics for numeric and categorical variables.

2. **User-Level Aggregation**
   - Aggregation of repeated campaign entries per `UserID`.
   - Computation of derived metrics:
     - `campaign_duration` (days)
     - `CampaignCount` (number of distinct strategies exposed)
   - Calculation of mean exposure per targeting type and total impressions.

3. **Distribution Analysis**
   - Total usage of each targeting strategy (`Contextual` most frequent, 35.7% of exposure).
   - User counts per strategy to assess coverage.
   - Visualization via bar charts and combined tables using `ggplot2` and `gridExtra`.

---

## Logistic Regression Modeling

The project implements **progressive logistic regression models** to predict the probability of purchase (`Purchaser`) based on targeting exposure, engagement, and funnel metrics.

### Modeling Steps

1. **Single Predictor Model**
   - `Model_0`: `Purchaser ~ Count`
   - Findings: Positive association with purchase probability (OR = 1.07), but low explanatory power (Tjur R² = 0.033, AUC = 0.559).

2. **Funnel Stage Inclusion**
   - `Model_1`: Adds `Funnel_Upper` and `Funnel_Lower`.
   - Findings: Funnel stage not statistically significant; minimal improvement in model fit (AIC/BIC, R², AUC).

3. **Targeting Strategies**
   - `Model_2` – `Model_5`: Incorporate targeting types (`Behavioral`, `Contextual`, etc.), engagement metrics, and interaction effects.
   - `Behavioral` used as baseline to prevent perfect multicollinearity.
   - `Model_5` achieved best fit: Tjur R² = 0.310, AUC = 0.860.

4. **Interaction Effects**
   - Captures conditional effects of targeting types with funnel stage (`CampaignCount:Funnel`) and engagement (`Contextual:AvgTime_h`).
   - Highlights how **targeting effectiveness varies by user engagement and journey stage**.

5. **Collinearity Diagnostics**
   - Variance Inflation Factor (VIF) computed for all predictors.
   - All VIF scores < 4 in final model, indicating low multicollinearity risk.

6. **Model Performance Evaluation**
   - Metrics computed for each model:
     - **AIC / BIC**: Model selection criteria.
     - **Accuracy**: Classification performance.
     - **ROC-AUC**: Discrimination power.
     - **McFadden’s R²**: Goodness-of-fit measure.

---

## Key Findings and Insights

- **Targeting Distribution**
  - `Contextual` (35.7%), `Behavioral` (26.6%), `Retargeting` (22.9%) dominate exposure.
  - Personalized strategies (`Predictive`, `Lookalike`) minimally used.

- **Predictive Insights**
  - Retargeting and Contextual strategies significantly increase purchase likelihood relative to Behavioral.
  - Prospecting shows a negative effect despite moderate exposure.
  - **CampaignCount** positively correlates with conversion probability: broader exposure improves outcomes.
  - Interaction effects suggest strategy effectiveness depends on **funnel stage** and **time-on-site**.

- **Practical Recommendations**
  - Allocate budget toward high-performing strategies (Retargeting, Contextual) to optimize ROI.
  - Leverage engagement metrics to personalize targeting.
  - Monitor the marginal benefit of additional impressions versus campaign diversity.

---

## Strategic Recommendations

1. Reallocate spend towards **high-performing targeting types** (Retargeting, Contextual)  
2. Leverage **user engagement metrics** to personalize campaign timing and frequency  
3. Diversify campaigns (increase `CampaignCount`) to maximize conversion probability  
4. Monitor marginal benefit of impressions vs. exposure diversity to optimize **ROI**

---

## How to Run the Analysis

1. **Prerequisites**
   - R version ≥ 4.2
   - Required libraries: `dplyr`, `ggplot2`, `gridExtra`, `sjPlot`, `pscl`, `pROC`, `gt`, `car`, `tidyr`

2. **Execution Steps**
   1. Load the dataset:
      ```r
      csv <- read.csv("data_ads.csv")
      ```
   2. Perform **EDA** and aggregation using `eda.R`.
   3. Fit logistic regression models sequentially using `logistic_models.R`.
   4. Generate visualizations and tables using `visualizations.R`.
   5. Evaluate model metrics (AIC, BIC, Tjur R², ROC-AUC, Accuracy) for model comparison.

3. **Reproducing Results**
   - All plots, tables, and model outputs are automatically generated with the provided scripts.
   - Ensure file paths are updated to match your local directory structure.

---

## References

- ChatGPT (OpenAI). (2024). ChatGPT (Aug 3 version) [Large language model]. https://chat.openai.com/  
- Grammarly Inc. (n.d.). Grammarly [AI writing assistant]. https://www.grammarly.com/  
- Abhishek, V., Jerath, K., & Sharma, S. (2022). The impact of retail media on online marketplaces: Insights from a field experiment. SSRN. https://ssrn.com/abstract=3013468  

---

## Appendix

### Figures

- **Fig 1.1**: Campaign Targeting Strategies Distribution (summed user-level proportions)
- **ROC Curves**: For final model performance evaluation
- **VIF Tables**: Multicollinearity diagnostics

### Tables

- **Table 1.1**: Distribution of Campaign Exposure Across Targeting Strategies  
- **Table 1.2**: Logistic Regression Model Coefficients, Odds Ratios, and P-values  
- **Table 1.3**: Model Performance Metrics (AIC, BIC, Accuracy, ROC-AUC)  
- **Table 1.4**: Variance Inflation Factor Scores (VIF)  


## Key Skills & Core Competencies

- **Data Analysis & Wrangling:** R, dplyr, tidyr  
- **Statistical Modeling:** Logistic regression, interaction effects, collinearity diagnostics  
- **Visualization:** ggplot2, gridExtra, sjPlot, ROC curves  
- **Model Evaluation:** AIC, BIC, Tjur R², Accuracy, ROC-AUC  
- **Business Insight Generation:** Strategic recommendations based on quantitative findings  

---

## License

This repository is licensed under **MIT License** – see `LICENSE` file for details.

---

## Acknowledgments

This Case Study Report was completed as part of a Master’s program project at the **[University of Auckland](https://www.auckland.ac.nz/en.html)**.  
Special thanks to the **[University of Auckland](https://www.auckland.ac.nz/en.html)**. for providing the opportunity to undertake this project and for their invaluable guidance and support throughout the research and analysis process.

---

## Repository Usage

1. **Clone repository**:  
```bash
git clone <repository-url>

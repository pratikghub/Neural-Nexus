# Project Title : Multivariate Analytics of Customer Engagement and Behavioural Dynamics in a Multichannel Gift Retail Ecosystem

Author: Pratik Ganguli
Date: August 7, 2025
University: University of Auckland

---

# Project Overview 
A report on multinomial predictive modelling, geographic trade area analysis, and customer segmentation to understand loyalty, gifting behavior, and off-season purchasing trends (2004–2007). 

The Multivariate Customer Behaviour Analysis project aims to explore and understand the purchasing patterns and preferences of customers in a multichannel retail environment. The dataset provided by the University of Auckland (with company details anonymized for privacy) contains detailed transactional and demographic information across multiple channels, offering a rich source of insights for data-driven decision-making.

The primary objectives of this analysis are:
	1.	Customer Profiling: Segmenting customers based on purchasing behavior, demographics, and engagement across multiple retail channels to identify distinct groups with shared characteristics.
	2.	Behavioral Insights: Understanding key factors influencing purchase frequency, transaction value, and channel preference, enabling targeted marketing strategies.
	3.	Multivariate Relationships: Examining the relationships between multiple variables, including age, income, channel usage, product categories, and purchasing patterns, to uncover complex patterns that may not be evident in univariate or bivariate analysis.
	4.	Predictive Insights: Identifying potential predictors of customer loyalty, repeat purchases, and high-value transactions to support strategic business planning and customer retention initiatives.
	5.	Visualization and Communication: Employing visual analytics to present findings in an interpretable and actionable manner for stakeholders, ensuring insights can inform operational and marketing decisions.

This project involves a structured analytical workflow including data cleaning, exploratory data analysis (EDA), multivariate analysis, customer segmentation, and result interpretation. Advanced techniques such as cluster analysis, factor analysis of mixed data (FAMD), and descriptive statistics are employed to provide a holistic view of customer behavior.

By integrating these methods, the project aims to deliver actionable insights that enhance understanding of customer interactions, inform marketing and product strategies, and support overall business growth in a competitive multichannel retail landscape.

---

## Table of Contents

- [Executive Summary](#executive-summary)
- [Statement of Problem](#statement-of-problem)
- [Research Questions](#research-questions)
- [General Approach to Solving It](#general-approach-to-solving-it)
- [Analysis and Results](#analysis-and-results)
  - [Research Question 1: Predicting Customer Channel Choice](#research-question-1-predicting-customer-channel-choice)
  - [Research Question 2: Store Distance Effects](#research-question-2-store-distance-effects)
  - [Research Question 3: Customer Segmentation in Christmas/Fall Gifting](#research-question-3-customer-segmentation-in-christmasfall-gifting)
  - [Research Question 4: Seasonal Purchase Patterns and Off-Season Strategy](#research-question-4-seasonal-purchase-patterns-and-off-season-strategy)
- [Conclusions](#conclusions)
- [Recommendations](#recommendations)
- [Appendix](#appendix)
- [Acknowledgement](#acknowledgement)

---

## Executive Summary

This project addresses key challenges in a nationally recognized multichannel gift retailer operating across **Retail, Internet, and Catalog channels**. The objectives are to:

1. Predict how a customer’s initial purchase channel influences future channel usage using **multinomial logistic regression**.
2. Evaluate **store trade area effects** to quantify how distance shapes purchasing behavior and demographic/psychographic composition.
3. Segment Christmas/Fall gifting customers to design **targeted retention and acquisition strategies**.
4. Explore **off-season purchasing trends**, particularly in Spring, and identify levers to generate year-round revenue.

Key insights include:

- **Channel Loyalty & Switching**: Retail exhibits the highest loyalty (88.3%), Internet shows moderate loyalty (74.8%), and Catalog customers switch more frequently, primarily between Catalog and Internet. Multinomial logistic regression confirms **state dependence**: past purchase channels strongly predict future channel choice, while store distance has a marginal but meaningful effect.
- **Trade Area Impact**: Customers closer to stores spend more in Retail and have higher overall RFM scores. Those farther from stores favor Catalog, and psychographic patterns shift toward outdoor, wellness, and pet ownership.
- **Customer Segmentation**: Four distinct Christmas/Fall gifting segments emerge: Casual Gifters, Internet-Dominant Gifters, Catalog-Dominant Gifters, and Omni-Channel VIP Gifters. Each segment differs in **transactional behaviour, demographics, and channel preference**, guiding targeted marketing.
- **Seasonality & Off-Season Opportunities**: Nearly half of the customer base purchases exclusively in Fall/Christmas, but one-third engage in Spring purchases. Multivariate logistic regression identifies **first purchase channel** and **store proximity** as the strongest predictors of Spring engagement.

These findings allow the company to develop **predictive, data-driven strategies** for loyalty, channel optimization, seasonal targeting, and high-value segment engagement.

---

## Statement of Problem

The retailer is highly dependent on the Fall/Christmas season, with sales concentrated in **three channels**. Key challenges include:

- Limited predictive insight into **channel loyalty or switching**.
- Reliance on **holiday-season revenue**, creating high seasonality risk.
- Underutilized customer data, with only basic segmentation applied.
- Need for **targeted, analytics-driven marketing strategies** based on customer behavior, demographics, psychographics, and geography.

The project aims to address these challenges using **advanced analytics**, particularly **multinomial logistic regression** for channel prediction, **RFM and ANOVA for behavioral analysis**, and **k-means clustering for segmentation**.

---

## Research Questions

1. **Channel Loyalty Prediction:** How does a customer’s first purchase channel influence their subsequent channel choice (Retail, Internet, Catalog)?
2. **Trade Area Analysis:** How does proximity to a store affect channel usage, spending behavior, and customer profiles?
3. **Customer Segmentation:** How can the company identify and differentiate Christmas/Fall gifting customer segments?
4. **Seasonal Purchase Strategy:** How can off-season (Spring) purchases be encouraged, and which factors predict Spring buying?

---

## General Approach to Solving It

1. **Data Preparation & Cleaning:** Address missing values using **tiered median imputation** for store distance, aggregate yearly spending across channels, and engineer key features (e.g., total spend, gift recipients, RFM scores).
2. **Descriptive Analysis:** Explore channel loyalty, trade area patterns, and seasonal behaviors.
3. **Predictive Modelling:** Use **multinomial logistic regression** to estimate probabilities of channel choice (RQ1) and Spring purchase likelihood (RQ4), including key predictors such as prior-year channels, first channel, StoreDist, AgeCode, and IncCode.
4. **Segmentation Analysis:** Apply **k-means clustering** on gifting variables to create actionable customer segments.
5. **Statistical Validation:** Use **ANOVA**, **Hand & Till multiclass AUC**, and **silhouette scores** to assess model robustness and segment separation.
6. **Integration for Business Strategy:** Translate insights into **STP-informed recommendations** for retention, acquisition, cross-channel marketing, and off-season growth.

---

## Analysis and Results

### Research Question 1: Predicting Customer Channel Choice

**Objective:** Identify whether a customer’s initial purchase channel predicts their 2007 channel and quantify the effect of distance to stores.

**Methodology:**

- **Step 1: Transition Matrix**
  - Tracks movements from 2004 to 2007.
  - Diagonal elements indicate loyalty; off-diagonal indicate switching.
  - Results: Retail 88.3% loyalty, Internet 74.8%, Catalog 78.1%. Largest migrations: Catalog → Internet (14.3%), Internet → Catalog (14.9%).

- **Step 2: Multinomial Logistic Regression**
  - Outcome: Final 2007 channel (Retail, Internet, Catalog).
  - Predictors: Primary channels for 2004, 2005, 2006; StoreDist.
  - **Model Insights:**
    - **State dependence**: Prior-year channels strongly predict final channel.
    - **Store distance**: Slight negative effect on Retail choice; distant customers favor Internet/Catalog.
  - **Model Performance:**
    - Hand & Till multiclass AUC: 0.947
    - Per-class AUCs: Catalog 0.950, Internet 0.936, Retail 0.966
    - Macro-average AUC: 0.951, Micro-average AUC: 0.957

**Interpretation:** The regression quantifies the impact of historical behavior and geographic factors on channel preference, providing **actionable predictions** for retention and cross-channel marketing.

---

### Research Question 2: Store Distance Effects

**Objective:** Examine how distance affects channel usage, spending, and customer profiles.

**Methodology:**

- Customers binned into 0–10 km, 11–20 km, 21–30 km, 31+ km.
- **RFM Analysis:** Weighted Recency (25), Frequency (25), Monetary (50) scores.
- **ANOVA:** Test statistical significance across distance groups.

**Findings:**

- Channel mix: Closer customers spend more in Retail; farther ones shift to Catalog; Internet stable.
- Psychographics: Outdoor, pet ownership, and wellness increase with distance.
- Demographics: Higher-income households closer to stores.
- RFM: Nearby customers highest engagement and spend; differences statistically significant (p < 0.001).

**Conclusion:** Distance shapes **spending patterns, channel preferences, and lifestyle profiles**, offering location-informed targeting opportunities.

---

### Research Question 3: Customer Segmentation in Christmas/Fall Gifting

**Objective:** Identify meaningful customer segments to guide targeted marketing.

**Methodology:**

- Features: Gift dollars, recipient counts, new recipients, Internet/Catalog order & line counts, StoreDist.
- Preprocessing: Log transformation, outlier capping, robust scaling.
- Clustering: **k-means**, silhouette score to select **k = 4**.

**Segments Identified:**

1. Casual Gifters – Low spend, few recipients.
2. Internet-Dominant Gifters – Younger, digital-oriented, growth potential.
3. Catalog-Dominant Gifters – Older, traditional, loyal to Catalog.
4. Omni-Channel VIP Gifters – High engagement across channels, premium spenders.

**Insights:** Segmentation enables **precision marketing**, increasing retention and cross-channel revenue.

---

### Research Question 4: Seasonal Purchase Patterns and Off-Season Strategy

**Objective:** Compare Fall/Christmas and Spring purchases, and identify drivers of Spring engagement.

**Methodology:**

- **STP Analysis:** Segment customers as Fall-only, Spring-only, Mixed (Fall-/Spring-leaning), No Spend.
- **Multivariate Logistic Regression:** Outcome: SpringBuyer; predictors: FirstChannel, StoreDist, AgeCode, IncCode.

**Key Findings:**

- FirstChannel strongest predictor: Retail and Internet first purchases → higher Spring likelihood.
- StoreDist: Closer → more likely to buy in Spring.
- Age: Slight positive effect; Income not significant.
- Channel use: Spring more Retail-oriented; Fall more balanced across channels.

**Conclusion:** Early engagement and proximity drive off-season purchases. Logistic regression provides **quantitative guidance** for targeting promotions and cross-season conversion strategies.

---

## Conclusions

- **Channel Loyalty:** Retail strongest; switching mainly between Catalog and Internet.
- **Predictive Modeling:** Multinomial logistic regression effectively forecasts channel choice and Spring buying, highlighting **state dependence** and geographic effects.
- **Customer Segmentation:** Four actionable gifting segments enable tailored strategies.
- **Seasonal Strategy:** Off-season revenue potential can be unlocked by targeting first-channel and nearby customers.

---

## Recommendations

1. **Enhance Retention:** Focus on high-loyalty Retail and Omni-Channel VIP segments.
2. **Channel Migration:** Encourage Catalog → Internet shifts through targeted digital campaigns.
3. **Off-Season Growth:** Promote Spring sales to Fall-only customers, emphasizing convenience for those near stores.
4. **Targeted Promotions:** Use segmentation to design personalized offers aligned with demographics, psychographics, and channel preferences.
5. **Predictive Analytics Integration:** Regularly update multinomial logistic regression models for channel and seasonal behavior forecasting.

---

## Appendix

- **Figures:** Transition matrices, AUC curves, silhouette scores, RFM/ANOVA charts, cluster feature profiles.
- **Data Description:** 100,051 customers, 184 variables, 2004–2007 purchase history.
- **Technical Notes:** 
  - Missing StoreDist imputed using tiered median back-off.
  - Features log-transformed and scaled for clustering.
  - Logistic regression coefficients interpreted as **log-odds** of selecting a channel or season.

---

## Acknowledgement

I would like to express my sincere gratitude to the **[University of Auckland (UOA)](https://www.auckland.ac.nz/en.html) for providing access to the dataset used in this analysis. The dataset has been invaluable in enabling the exploration of customer behavior, channel preferences, and seasonal purchasing trends.  

The company associated with the data has been kept confidential to maintain privacy and confidentiality. Their contribution to this project is greatly appreciated.  

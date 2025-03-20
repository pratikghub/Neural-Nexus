## Project Title: Customer Segmentation using Unsupervised Machine Learning
### Author: Pratik Ganguli 


## Overview
This project applies **unsupervised machine learning** techniques, particularly **two-step clustering**, to segment supermarket customers based on their demographic and purchasing behaviors. By understanding customer groups, the supermarket can tailor marketing strategies, optimize product offerings, and improve customer satisfaction and retention. This marketing-focused segmentation enables data-driven decision-making, enhancing customer engagement and business profitability.

## Table of Contents
- [Overview](#overview)
- [Dataset](#dataset)
- [Methodology](#methodology)
- [Key Findings](#key-findings)
- [Marketing Strategy Implications](#marketing-strategy-implications)
- [Technology Stack](#technology-stack)
- [Usage](#usage)
- [Results](#results)
- [Business Applications](#business-applications)
- [Conclusion](#conclusion)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Dataset
The dataset includes 2,150 customers and contains key variables such as:
- **Demographic attributes**: Age, income, family structure (presence of children/teenagers)
- **Purchasing behavior**: Number of online vs. in-store purchases, spending patterns
- **Engagement with promotions**: Campaign acceptance rates

## Methodology
This project employs a **two-step clustering** approach using **SPSS**, an unsupervised machine learning technique ideal for large datasets with both categorical and continuous variables. The methodology includes:

1. **Data Preprocessing**
   - Handling missing values and outliers (e.g., using boxplots for age distributions)
   - Normalization of numerical features for better clustering results
   - Removal of duplicate records
   
2. **Exploratory Data Analysis (EDA)**
   - **Univariate Analysis**: Understanding the distribution of each variable
   - **Bivariate Analysis**: Exploring correlations (e.g., between income and spending)
   - **Statistical Tests**: T-tests, ANOVA, Chi-square tests to validate relationships
   
3. **Two-Step Clustering in SPSS**
   - **Step 1**: Pre-clustering using log-likelihood distance
   - **Step 2**: Hierarchical clustering to refine group assignments
   - **Cluster Validation**: Silhouette score (~0.5) confirms reasonable cluster separation
   
4. **Cluster Profiling**
   - **Segmenting customers into four groups:**
     - **Moderate-Income Families with Young Children**
     - **Low-Income Budget-Conscious Families**
     - **High-Income Product Enthusiasts**
     - **Digitally-Driven Convenience Shoppers**
   - **Profiling clusters based on spending habits, store visits, and online activity**

## Key Findings
- **Higher income customers spend significantly more** and are more responsive to marketing campaigns.
- **Digitally-inclined shoppers prefer online purchases**, highlighting the need for an omnichannel strategy.
- **Budget-conscious families prioritize essential items**, requiring targeted discount strategies.
- **Family structure influences spending**, with households with children showing different purchasing behaviors.

## Marketing Strategy Implications
Customer segmentation using two-step clustering enables **highly targeted marketing campaigns**, ensuring businesses allocate resources effectively. Based on the cluster insights:
- **Moderate-Income Families with Young Children**: Bundle discounts, in-store promotions, and loyalty programs can enhance engagement.
- **Low-Income Budget-Conscious Families**: Essential product discounts, reward programs, and value-based marketing campaigns improve retention.
- **High-Income Product Enthusiasts**: Exclusive product launches, premium shopping experiences, and personalized offers drive higher sales.
- **Digitally-Driven Convenience Shoppers**: Omnichannel strategies, app-based promotions, and seamless shopping experiences increase brand loyalty.

## Technology Stack
- **SPSS Two-Step Clustering**: Efficient handling of mixed data types
- **Microsoft Excel**: Data cleaning and preprocessing

## Usage
1. Open the dataset in **SPSS**.
2. Perform **two-step clustering** using the predefined variables.
3. Analyze cluster results and interpret marketing implications.

## Results
- **Cluster Insights**: Customers are grouped into **four** meaningful segments, helping refine marketing and sales strategies.
- **Visualizations**: Boxplots and bar charts illustrate customer behavior differences.
- **Business Recommendations**:
  - **Personalized marketing** for high-income customers
  - **Loyalty programs** for budget-conscious families
  - **Omnichannel shopping experience** for digital shoppers

## Business Applications
By leveraging insights from customer segmentation:
- **Marketing teams** can create data-driven promotional campaigns tailored to each segment.
- **Retail managers** can optimize inventory and pricing strategies to align with purchasing behaviors.
- **E-commerce divisions** can refine digital marketing and customer engagement efforts.

## Conclusion
Two-step clustering using **SPSS** has proven effective in segmenting a diverse customer base, allowing for tailored marketing strategies that enhance engagement and profitability. This project provides valuable insights for supermarkets looking to optimize their customer interactions and improve revenue streams.

## License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
Special thanks to [IBM SPSS](https://www.ibm.com/spss) for providing an intuitive clustering tool and to OpenAI's ChatGPT for assisting in documentation.




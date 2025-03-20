An Analysis of Global CO₂ Emissions and the Impact of GDP and Working-Age Population in 2020

Author: Pratik Ganguli (pgan501)

Project Overview

This analysis investigates the relationship between CO₂ emissions per capita, GDP per capita, and the working-age population (WAP) using the wdi_2020 dataset from the World Bank’s World Development Indicators (WDI). The study aims to model CO₂ emissions as a function of GDP and WAP, providing insights into how economic and demographic factors contribute to environmental impacts.

Key steps in this analysis include:
	•	Data preprocessing (handling missing values and transformations)
	•	Exploratory Data Analysis (EDA)
	•	Correlation analysis
	•	Multiple linear regression modeling
	•	Residual analysis and model validation

Dataset Description

The dataset consists of 217 observations, capturing key global development metrics for the year 2020.
	•	Dependent Variable:
	•	CO₂ emissions per capita (metric tons)
	•	Independent Variables:
	•	GDP per capita (USD)
	•	Working-age population (% of total population, aged 15-64 years)

Data Preprocessing

To ensure consistency and accuracy in analysis:
	•	33 missing values in key variables were removed.
	•	Logarithmic transformations were applied to CO₂ and GDP to reduce skewness and improve model stability.

Exploratory Data Analysis (EDA)

Pairwise Correlation Analysis
	•	A strong correlation was observed between Log_GDP and Log_CO₂ (r = 0.850), suggesting economic growth significantly impacts emissions.
	•	Log_WAP also correlates positively with Log_CO₂ (r = 0.789), indicating industrial and urban expansion contributes to emissions.

Figures below illustrate the relationships before and after transformation:
	•	Figure 1.1: Pairwise correlation of all key factors
	•	Figure 1.2: Pairwise correlation for logarithmic variables

Regression Model and Findings

Multiple Linear Regression Model

The model predicts CO₂ emissions using the transformed variables with the equation:

Ŷ = -12.09 + 0.58 * log(GDP) + 5.65 * log(WAP)

Interpretation of Coefficients:
	•	Holding WAP constant, a 1% increase in GDP results in a 0.58% increase in CO₂ emissions.
	•	Holding GDP constant, a 1% increase in WAP leads to a 5.65% increase in CO₂ emissions.
	•	Statistical Significance: The model is highly significant (p < 2.2 × 10⁻¹⁶), indicating a strong relationship between the predictors and CO₂ emissions.
	•	Model Fit: Adjusted R² = 80.94%, meaning 80.94% of the variability in CO₂ emissions is explained by GDP and WAP.

Regression Model Summary

Coefficient	Estimate
Intercept	-12.09
Log_GDP_PerCapita	0.58
Log_Working	5.65
Adjusted R²	80.94%
p-value	< 2.2 × 10⁻¹⁶
Residual standard error	0.26

Table 1: Summary Statistics of the Linear Regression Model

Model Assumptions Validation

To ensure reliability, regression assumptions were tested:
	•	Linearity: The relationships between predictors and CO₂ appear linear.
	•	Homoscedasticity: Residual plots show random scatter, confirming constant variance.
	•	Normality: Histogram of residuals suggests a near-normal distribution.
	•	Multicollinearity: The variance inflation factor (VIF) was within an acceptable range, indicating no severe multicollinearity.

Figure 1.3: Residual Plot Assessing the Impact of Economic Factors on CO₂ Emissions

Key Findings
	1.	Economic growth (GDP per capita) has a substantial positive impact on CO₂ emissions.
	2.	The working-age population is a key driver of emissions, possibly due to increased industrialization and urbanization.
	3.	The logarithmic transformation improved model stability and interpretability.
	4.	The regression model is robust (R² = 80.94%) and statistically significant (p < 2.2 × 10⁻¹⁶).

Limitations and Future Research
	•	The model is limited to 2020 data and does not account for long-term trends or policy interventions.
	•	Further research could incorporate additional variables like renewable energy adoption or sector-wise emissions data.

Requirements
	•	R (Version 4.0 or later)
	•	Required libraries: tidyverse, ggplot2, dplyr, car, ggcorrplot, MASS

License

This project is licensed under the MIT License.

Extended Insights

Beyond numerical analysis, this study highlights the broader implications of economic policies on sustainability. Policymakers must balance economic growth with environmental considerations, emphasizing the importance of green energy initiatives.


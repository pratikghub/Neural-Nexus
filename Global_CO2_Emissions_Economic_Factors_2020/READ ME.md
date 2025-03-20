## An Analysis of Global CO₂ Emissions and the Impact of GDP and Working-Age Population in 2020

### Author: Pratik Ganguli 

## Overview

The analysis explores the relationship between global CO₂ emissions and economic and demographic factors, specifically focusing on GDP per capita and the working-age population (WAP) in 2020. The dataset used is wdi_2020, sourced from the World Bank’s World Development Indicators (WDI), which contains 217 observations of various global development factors.

This analysis focuses on predicting CO₂ emissions (CO₂ emissions per capita, in metric tons) as the dependent variable, using GDP (GDP per capita, in USD) and WAP (working-age population as a percentage of the total population aged 15 to 64 years) as independent variables.

## Dataset

The dataset wdi_2020.csv contains 217 observations, with the following columns relevant to this analysis:
	•	CO₂ Emissions per Capita: CO₂ emissions per capita in metric tons.
	•	GDP per Capita: Gross Domestic Product (GDP) per capita in USD.
	•	Working Age Population: Percentage of the total population aged 15 to 64 years.

## Data Cleaning

The original dataset had 33 missing values in key columns. These entries were removed to ensure a clean dataset for analysis.

## Data Transformation

To improve the interpretability of the data and enhance model performance, logarithmic transformations were applied to the CO₂ emissions, GDP per capita, and WAP variables. This transformation addressed the skewness in the data caused by extreme values, normalized the variables, and reduced the influence of outliers. This improved the distribution normality and standardized the variables, making the analysis more reliable.

## Analysis

### Correlation Analysis

The correlation analysis between the transformed variables revealed strong relationships:
	•	GDP and CO₂: A strong positive correlation of r = 0.850, indicating that higher economic output leads to higher CO₂ emissions.
	•	WAP and CO₂: A positive correlation of r = 0.789, suggesting that a larger workforce drives industrialization and urbanization, which in turn contributes to higher emissions.

Figures:
	•	Figure 1.1: Pairwise Correlation of All the Key Factors.
	•	Figure 1.2: Pairwise Correlation for Logarithmic Variables.

### Regression Model

A multiple linear regression model was built to predict CO₂ emissions using GDP and WAP as predictors. The regression equation is:

Ŷ = -12.09 + 0.58 * log(GDP) + 5.65 * log(WAP)

Where:
	•	x_1 represents GDP per capita.
	•	x_2 represents the working-age population.

Key findings from the model:
	•	Interpretation of Coefficients:
	•	Holding WAP constant, a 1% increase in GDP results in a 0.58% increase in CO₂ emissions.
	•	Holding GDP constant, a 1% increase in WAP leads to a 5.65% increase in CO₂ emissions.
	•	The model explains 80.94% of the variability in CO₂ emissions, with a p-value < 2.2 × 10⁻¹⁶ indicating strong statistical significance.
	•	Residual standard error: 0.26, suggesting a reliable fit.

Table:
	•	Table 1: Summary Statistics of the Linear Regression Model.

Figure:
	•	Figure 1.3: Residual Plot Assessing the Impact of Economic Factors on CO₂ Emissions.

### Assumptions of Linear Regression

The assumptions for linear regression were checked:
	•	Homoscedasticity: The residuals are randomly scattered around zero, confirming no patterns in variance.
	•	Normality: The residuals follow an approximately normal distribution, supporting the assumption of normality for valid statistical inference.
	•	Linearity: Scatterplots show a linear relationship between the independent variables, confirming the suitability of a linear regression model.

### Code Walkthrough

	# Installing and loading the required libraries for data manipulation, visualization, and modeling
	install.packages(c("dplyr", "ggplot2", "cowplot", "GGally"))
	library(dplyr)        # For data manipulation
	library(ggplot2)      # For creating plots
	library(cowplot)      # For combining plots
	library(GGally)       # For creating pairwise plots

	# Load the dataset into R
	ds <- read.csv("/Users/pratikganguli/Downloads/wdi_2020.csv")

	# Rename columns for clarity
	ds <- ds %>%
  	rename(
    Total_GDP = NY.GDP.MKTP.CD,
    GDP_per_Capita = NY.GDP.PCAP.CD,
    Working_Age_Population = SP.POP.1564.TO.ZS,
    CO2_Emissions_per_Capita = EN.ATM.CO2E.PC
  	)

	# Check dataset structure
	str(ds)

	# Data Cleaning - Removing missing values
	ds <- na.omit(ds)
	
	# Log transformation for key variables
	Log_CO2 <- log10(ds$CO2_Emissions_per_Capita)
	Log_Gdp_PerCapita <- log10(ds$GDP_per_Capita)
	Log_Working <- log10(ds$Working_Age_Population)
	
	# Adding transformed variables to dataset
	ds <- cbind(ds, Log_CO2 = Log_CO2, Log_Gdp_PerCapita = Log_Gdp_PerCapita, Log_Working = Log_Working)
	
	# Linear regression model
	llm <- lm(Log_CO2 ~ Log_Gdp_PerCapita + Log_Working, ds)
	summary(llm)

## Visualization

Pairwise Correlation Plots

The pairwise plots are used to visualize the relationships between CO₂ emissions, GDP, and WAP:
	•	Figure 1.1: Pairwise correlation of the original variables.
	•	Figure 1.2: Pairwise correlation after log transformation.

Residual Diagnostics

Diagnostic plots for residuals were created to assess the model’s assumptions:
	•	Residuals vs Fitted Values (Figure 1.3)
	•	Residuals vs Log(Working Population).
	•	Residuals vs Log(GDP per Capita).
	•	Distribution of Residuals.

These plots ensure that the regression model satisfies the assumptions of homoscedasticity, normality, and linearity.

Combined Diagnostic Plots

# Combining diagnostic plots for easy comparison 
			cowplot::plot_grid(p0, p1, p2, p3)

## Conclusion

The analysis demonstrates that both GDP per capita and the working-age population have a significant impact on CO₂ emissions. The multiple linear regression model explains 80.94% of the variability in CO₂ emissions, and the results suggest that economic development and workforce expansion contribute substantially to environmental challenges.

## Further Work

This analysis can be extended by incorporating additional factors, such as energy consumption or government policies, to provide a more comprehensive understanding of CO₂ emissions. Additionally, more advanced modeling techniques like machine learning could improve predictive accuracy.

## Requirements

To run this analysis, the following software and packages are required:

Software
	•	R (version 4.0.0 or higher)

## R Packages

The following R packages must be installed:
	•	dplyr (for data manipulation)
	•	ggplot2 (for creating plots)
	•	cowplot (for combining multiple plots)
	•	GGally (for pairwise correlation plots)

To install the required packages, run the following command in R:

	install.packages(c("dplyr", "ggplot2", "cowplot", "GGally"))

## License

This project is licensed under the MIT License - see the LICENSE file for details.


Extended Insights

Beyond numerical analysis, this study highlights the broader implications of economic policies on sustainability. Policymakers must balance economic growth with environmental considerations, emphasizing the importance of green energy initiatives.


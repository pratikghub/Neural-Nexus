## Project Title : The Analysis of Poverty Rates in United States Across Midwestern States

### Author : Pratik Ganguli 


## Overview

This analysis explores poverty rates across five Midwestern states—Illinois (IL), Indiana (IN), Michigan (MI), Ohio (OH), and Wisconsin (WI)—using the midwest dataset available in R. The dataset consists of 437 observations, offering detailed demographic and socio-economic data at the county level. The primary focus is the percentage of people living below the poverty line (percbelowpoverty) and how it varies across these states.


## Key Findings

1.	Poverty Rate Distribution
•	The median poverty rate is 11.82%, indicating that half of the counties have rates below this threshold.
•	The mean poverty rate is 12.51%, slightly higher than the median, signifying a right-skewed distribution.
•	This skewness is driven by counties with significantly high poverty rates, particularly in Wisconsin, where some counties exhibit extreme poverty levels exceeding 30% and even approaching 50%.

2.	Statewise Analysis
•	Illinois & Indiana: Concentrated poverty rates between 10%–15%, with narrow interquartile ranges (IQRs) and low standard deviations, indicating consistent poverty distributions.
•	Michigan & Ohio: Broader distributions with portions extending above 15%, suggesting greater variability in poverty levels.
•	Wisconsin: Shows the highest outliers, indicating extreme poverty in certain counties, as confirmed by a long-tailed boxplot.
	
3.	Density & Boxplot Analysis
•	The density curves show that most states cluster around 10%–15% poverty rates, but the long tails of Illinois and Wisconsin indicate significant disparities.
•	Boxplots highlight that Wisconsin has the most extreme cases, whereas Illinois and Indiana have more stable distributions.


## Dataset

The dataset used in this analysis is the midwest dataset, available in R. It contains the following relevant columns:
1.	state: State name
2.	percbelowpoverty: Percentage of people living below the poverty line


## Statistical Summary

Overall Poverty Rate Distribution

| Statistic          | Value  |
|--------------------|--------|
| Minimum           | 2.18%  |
| 1st Quartile (Q1) | 9.19%  |
| Median            | 11.82% |
| Mean              | 12.51% |
| 3rd Quartile (Q3) | 15.13% |
| Maximum           | 48.69% |


## State-wise Statistics

| State            | Min    | Q1    | Median  | Mean   | Q3    | Max    | IQR   | SD    |
|------------------|--------|-------|---------|--------|-------|--------|-------|-------|
| Illinois (IL)    | 2.71%  | 9.89% | 12.33%  | 13.07% | 15.55%| 32.24% | 5.65  | 5.28  |
| Indiana (IN)     | 3.59%  | 7.85% | 9.96%   | 10.31% | 12.38%| 19.43% | 4.52  | 3.32  |
| Michigan (MI)    | 4.13%  | 11.20%| 14.29%  | 14.22% | 17.09%| 26.41% | 5.89  | 4.62  |
| Ohio (OH)        | 4.89%  | 8.81% | 11.70%  | 13.03% | 16.14%| 28.67% | 7.32  | 5.70  |
| Wisconsin (WI)   | 2.18%  | 9.07% | 11.42%  | 11.89% | 13.94%| 48.69% | 4.87  | 5.78  |


## Visualizations

•	Density Plot (Fig 1.1): Shows the distribution of poverty rates across states, highlighting variations in concentration and extreme values.
•	Boxplot (Fig 1.2): Visualizes poverty rate distributions across states, identifying outliers and spread.

## R Code for Analysis

1. Loading Necessary Libraries & Dataset
        
        library(ggplot2)
        data(midwest)
        
        # View dataset structure
        head(midwest)
        str(midwest)
        colnames(midwest)
        View(midwest)
        table(midwest$state)

2. Summary Statistics

        summary(midwest$percbelowpoverty)   # Summary statistics for overall poverty rates
        by(midwest$percbelowpoverty, factor(midwest$state), summary)    # Summary by state

3. Spread & Variability

        by(midwest$percbelowpoverty, factor(midwest$state), sd)   # Standard deviation
        tapply(midwest$percbelowpoverty, factor(midwest$state), IQR)    # IQR by state
        tapply(midwest$percbelowpoverty, factor(midwest$state), range)    # Range by state

4. Visualizing Data

Density Plot

    ggplot(midwest, aes(x = percbelowpoverty, fill = state)) + 
      geom_density(alpha = 0.5, color = "black", size = 0.7) +
      labs(title = "Density Distribution of Poverty Percentage by States",
           x = "Percentage Below Poverty", 
           y = "Density") +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
        axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 12)
      )

Boxplot
    
    ggplot(midwest, aes(x = factor(state), y = percbelowpoverty, fill = state)) + 
      geom_boxplot(alpha = 0.5, color = "black", size = 0.7, outlier.colour = "red", outlier.size = 3) +
      labs(title = "Poverty Percentage by States",
           x = "States", 
           y = "Percentage of People Below Poverty") +
      theme_minimal() +
      theme(
        plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
        axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 12)
      )

Histogram

    ggplot(midwest, aes(x = percbelowpoverty)) +
      geom_histogram(binwidth = 1, fill = "skyblue", color = "black", alpha = 0.7) +
      labs(title = "Histogram of Percentage Below Poverty", 
           x = "Percentage Below Poverty", 
           y = "Frequency") +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))

5. Outlier Detection

        ggplot(midwest, aes(y = percbelowpoverty)) +
          geom_boxplot(fill = "lightblue", color = "black", outlier.colour = "red", outlier.size = 2) +
          labs(title = "Boxplot of Percentage Below Poverty", 
               y = "Percentage Below Poverty") +
          theme_minimal() +
          theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))

## Requirements
	•	R version 4.0+
	•	ggplot2 package

## License

This project is licensed under the MIT License. You are free to use, modify, and distribute the code with proper attribution to the author.

## Title: Analyzing the Socioeconomic Impact of Airbnb in London Using Python
### Author: Pratik Ganguli

## Overview

This project investigates the potential impact of Airbnb listings on housing market indicators and urban well-being in London. The analysis integrates various datasets, including detailed Airbnb listings and regional statistics, to explore patterns and correlations between Airbnb activity and socioeconomic metrics such as property prices, income inequality, and rental stress.

The study follows a structured pipeline involving data wrangling, merging, cleaning, analysis, and visualization. The objective is to derive actionable insights using robust Python-based data analysis techniques.

## Table of Contents
1. [Dataset Overview](#1-dataset-overview)
2. [Data Wrangling and Preprocessing](#2-data-wrangling-and-preprocessing)
3. [Feature Engineering](#3-feature-engineering)
4. [Data Analysis and Modeling](#4-data-analysis-and-modeling)
5. [Key Findings](#5-key-findings)
6. [Visualizations](#6-visualizations)
7. [Conclusion](#7-conclusion)
8. [Requirements](#8-requirements)
9. [License](#9-license)
10. [Acknowledgments](#10-acknowledgments)

---

## 1. Dataset Overview

Multiple public datasets were used in this project, including:

- **Airbnb Listings (`listings1.csv`)**: Contains detailed records of Airbnb properties in London, including price, location, room type, host status, reviews, and availability.
- **Housing Price Data**: Provides borough-level housing price indices over time.
- **Wellbeing Dataset**: Captures social and economic wellbeing indicators by borough.
- **Merged Metadata**: All datasets were merged by common regional identifiers such as `borough` and `LSOA`.

---

## 2. Data Wrangling and Preprocessing
This project involved intensive data wrangling using Python to clean, harmonize, and transform multiple disparate datasets into a unified analytical framework. Using `pandas`, `numpy`, and `geopandas`, we performed complex joins, handled inconsistent regional identifiers, normalized financial values, and engineered high-level features required for modeling and visualization. The wrangling process was central to unlocking meaningful relationships in the data.
The preprocessing pipeline included:

1. **Missing Value Treatment**:
   - Dropped or imputed non-informative columns like `license`, `calendar_updated`, `scrape_id`.
   - Price and review counts were cleaned and converted to usable numeric types.

2. **Data Cleaning**:
   - Converted currency strings to floats, parsed date formats.
   - Removed outliers (e.g., listings priced over £2000).

3. **Normalization and Aggregation**:
   - Listings were grouped by borough to calculate averages (price, reviews) and counts (total listings, host type ratios).

4. **Join Operations**:
   - Merged Airbnb data with socioeconomic indicators using standardized borough names.

---

## 3. Feature Engineering

Several derived variables were constructed to enrich the analysis:

- **Listing Density**: Listings per 1000 residents in a borough.
- **Superhost Ratio**: Share of hosts with Superhost status.
- **Mean Price per Room Type**: Calculated for private, shared, and entire homes.
- **Host Experience Duration**: Time since first review as a proxy for tenure.

---

## 4. Data Analysis and Modeling

The project employed descriptive and inferential techniques:

- **Correlation Analysis**: Investigated relationships between Airbnb activity and rent pressure, income inequality, and property prices.
- **Borough Comparisons**: Tracked boroughs with high Airbnb activity and mapped them against housing affordability metrics.
- **Data Visualization**: Used Seaborn, Plotly, and Matplotlib to generate intuitive visuals (heatmaps, box plots, bar charts, and interactive maps).
- **Simple Regression Models**: Linear regression was used to examine how Airbnb listing density influences median house prices.

---

## 5. Key Findings

- Boroughs with higher Airbnb activity tend to have:
  - Higher median house prices.
  - Greater private room availability.
  - Lower levels of housing affordability for residents.
- Listings are heavily concentrated in boroughs like Westminster, Camden, and Kensington & Chelsea.
- A negative correlation was observed between Airbnb density and well-being scores in certain boroughs.

---

## 6. Visualizations

The following visuals were created to support the findings:

- **Choropleth Maps**: Airbnb density, price per night, and superhost distribution.
- **Box Plots**: Price distribution by room type.
- **Bar Charts**: Borough-wise listing counts and host characteristics.
- **Heatmaps**: Correlation matrices for merged datasets.
- **Time Series Plots**: Housing price trends by borough.

---

## 7. Conclusion

This project demonstrates that Airbnb has a visible footprint on London's housing market. High Airbnb activity correlates with both rising rental prices and lower housing availability in specific boroughs. These insights can inform public policy and urban planning decisions.

While correlation does not imply causation, the results point to the need for targeted interventions and regulatory oversight in high-impact zones.

---

## 8. Requirements

The analysis was performed using Python 3.8+ and the following libraries:

```bash
pip install pandas numpy matplotlib seaborn plotly geopandas scikit-learn

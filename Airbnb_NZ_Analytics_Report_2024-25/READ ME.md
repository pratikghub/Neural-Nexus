# Project Title :Optimizing Airbnb Performance in New Zealand: Pricing, Segmentation, and Guest Insights
### Leveraging unbalanced panel data, k-prototypes clustering, and lexicon-driven sentiment analysis to uncover price determinants, identify distinct market segments in Auckland and Queenstown, and quantify guest perceptions—delivering actionable strategies for revenue optimisation, targeted promotions, and enhanced guest satisfaction.



**Author:**  
Pratik Ganguli

---

## Table of Contents
1. [Introduction](#introduction)  
2. [Data Overview](#data-overview)  
3. [Literature Review](#literature-review)  
4. [Research Questions & Analytical Insights](#research-questions--analytical-insights)  
   - **RQ1:** Panel Data Regression – Price Drivers  
   - **RQ2:** Segmentation – Auckland & Queenstown  
   - **RQ3:** Sentiment & Emotion Analysis – Guest Reviews  
5. [Limitations](#limitations)  
6. [Conclusion](#conclusion)  
7. [References](#references)  
8. [Appendix: Key Figures](#appendix-key-figures)

---

## Introduction

Airbnb has solidified its position as a disruptive player in New Zealand’s short-term accommodation sector, catering to a diverse mix of domestic and international travellers. The platform’s success depends not just on listing quantity but also on understanding price determinants, distinct market segments, and guest sentiments to drive revenue and occupancy.

This project employs advanced marketing analytics to uncover actionable insights that can inform host pricing strategies, optimise property offerings, and enhance guest experiences. By combining panel data regression, mixed-method segmentation, and lexicon-based text analytics, the study connects data-driven insights to business decision-making.

**Core Research Questions:**
1. What drives Airbnb listing prices in New Zealand, and how can hosts leverage these factors for revenue optimisation?  
2. How can properties in Auckland and Queenstown be segmented to reveal distinct market clusters?  
3. What sentiments and emotions are expressed in guest reviews, and how do they influence perception and loyalty?  

---

## Data Overview

The analysis draws on InsideAirbnb NZ data covering July 2024 – June 2025, containing:  
- **Rows:** 576,621 property-month observations  
- **Columns:** 86 attributes (~49.6 million recorded values)  
- **Missing Values:** Low at 1.16%  

Data is structured as unbalanced and irregular panel data, meaning:  
- Properties are observed at different intervals, not uniformly across time.  
- Some listings are highly frequent, while others appear only sporadically.  
- This structure allows tracking property-level changes over time, capturing dynamic pricing, review activity, and availability patterns.

**Focus regions:** Auckland (largest urban market) and Queenstown (tourism-centric market).  

---

## Literature Review

**Key research insights guiding methodology:**

1. **Price Determinants:**  
   - Wang & Nicolau (2017) highlighted host characteristics, property features, and seasonality as primary pricing drivers.  
   - Supports the use of panel data regression to capture cross-sectional and temporal effects.  

2. **Market Segmentation:**  
   - Gunter & Önder (2018) used clustering to segment Airbnb properties by location, price, and review characteristics, uncovering differentiated market niches.  
   - Applying K-prototypes clustering in NZ allows mixed numeric/categorical segmentation, identifying meaningful clusters in Auckland and Queenstown.  

3. **Guest Review Sentiment:**  
   - Xie et al. (2014) demonstrated that online reviews influence customer decision-making.  
   - Lexicon-based sentiment and emotion analysis can extract trust, joy, and dissatisfaction cues, informing service improvements.  

---

## Research Questions & Analytical Insights

### RQ1: Panel Data Regression – Price Drivers

**Objective:** Identify the primary factors influencing Airbnb prices and quantify their impact.

**Descriptive Overview:**  
- Panel included listings present in ≥9 months to ensure stability.  
- Price Distribution: Highly skewed (median NZD 203 vs mean NZD 394); log-transformation applied.  
- Typical listing: 4 guests, 2 bedrooms, 1 bathroom.  
- Review activity concentrated: median lifetime reviews = 26.  
- Ratings concentrated at the top (average 4.83/5).  
- Availability patterns indicate strategic host management (median 17 nights next month, 210 nights/year).  

**Analytical Methodology:**  
- Fixed Effects (FE) vs Random Effects (RE) panel regression.  
- FE controls for time-invariant traits like location and property type.  
- RE assumes these unobserved factors are uncorrelated with measured variables.  
- Hausman test: FE preferred (χ² = 17,643, p < 0.001).  
- Variables: bedrooms, guest capacity, review scores (accuracy, communication, value), review activity, availability, interactions.  

**Key Insights:**  
- Structural effects: Extra bedrooms/guest capacity increase price with diminishing returns.  
- Quality effects: 0.1-point increase in review accuracy/communication → 5–7% higher price.  
- Activity/Availability: High review frequency = higher pricing power; open nights slightly increase price.  
- Model Performance: Adjusted R² (within) = 0.42 (~42% of month-to-month variation).  

**Business Translation:**  
- Early-stage improvements (extra bedroom, better cleanliness/accuracy) yield strongest ROI.  
- Consistent review activity builds trust and premium pricing.  
- Calendar management: limited availability sustains higher rates; broader availability boosts occupancy.  

---

### RQ2: Segmentation – Auckland & Queenstown

**Objective:** Identify distinct Airbnb market clusters for targeted strategies.

**Descriptive Overview:**  
- Auckland: 13,944 unique listings; Queenstown: 7,258.  
- Price trends: Queenstown consistently higher, peaks in December; Auckland peaks in October.  

**Analytical Methodology:**  
- Data Cleaning: Missing values imputed per listing (numerical → mean, categorical → mode).  
- Feature Engineering: Amenities count, description length, review activity.  
- Clustering: K-prototypes with Gower distance for mixed data.  
- Optimal Cluster Selection: Silhouette scores (0.57 Auckland; 0.46 Queenstown).  

**Auckland Segments:**  
1. **Family-Friendly Homes:** Entire homes, 4 guests, NZD 327/night, high amenities/reviews.  
2. **Budget Private Rooms:** Private rooms, 2 guests, NZD 111/night, fewer amenities.  
3. **Ultra-Luxury Retreats:** Rare high-end homes, NZD 35,000/night, minimal reviews, short stays.  

**Queenstown Segments:**  
1. **Reliable Comfort:** Superhost entire homes, NZD 536/night, high amenities & reviews.  
2. **Standard Hosts:** Non-Superhost entire homes, NZD 472/night, moderate amenities/reviews.  
3. **High-Value Superhosts:** Instant-bookable premium, NZD 665/night, high trust & convenience.  
4. **Budget-Friendly Private Rooms:** Superhost private rooms, NZD 182/night, high service quality.  
5. **Signature Stays:** Ultra-luxury, NZD 36,000/night, limited amenities/reviews.  

**Managerial Implications:**  
- Auckland: Target family stays, competitive budget offerings, niche ultra-luxury collaborations.  
- Queenstown: Multi-tier strategy; premium clusters leverage service quality + convenience; budget clusters highlight Superhost reliability; ultra-luxury focuses on exclusivity.  

---

### RQ3: Sentiment & Emotion Analysis – Guest Reviews

**Objective:** Extract guest perceptions, emotional cues, and service insights from review text.

**Descriptive Overview:**  
- Dataset: 33,948,195 reviews (2011–2025); focus July 2024–June 2025.  
- Review volume peaked Nov 2024 (~510,000 reviews), reflecting tourism seasonality.  

**Analytical Methodology:**  
- Lexicon-based analysis: Bing (positive/negative) and NRC (10 emotions + sentiment).  
- Tokenisation: Transform reviews into structured word lists for sentiment/emotion mapping.  
- Emotion Quantification: Count occurrences, calculate percentages.  

**Key Insights:**  
- Bing Sentiment: 94.38% positive, 5.62% negative; net positivity 88.76%.  
- NRC Emotions: Positive (29.99%), Trust (19.17%), Joy (18.84%), Anticipation (13.19%).  
- Negative emotions rare (anger 1.11%, disgust 0.82%).  
- Word Clouds: Positive = clean, comfortable, beautiful; Negative = cold, noise, problem.  

**Business Translation:**  
- Guests highly value cleanliness, comfort, visual appeal.  
- Address minor concerns (temperature, maintenance, noise) to maintain loyalty.  
- Seasonal review peaks offer opportunities for targeted promotions and pricing strategies.  

---

## Limitations

1. **Unbalanced/Irregular Panels:** Reduced precision; mitigated by filtering listings ≥9 months.  
2. **ID Formatting Issues:** Large numeric IDs converted to character to avoid truncation errors.  
3. **Cluster Selection:** Elbow method unsuitable for mixed numeric-categorical data; silhouette scores used.  
4. **Lexicon-Based Sentiment:** Context-insensitive; may misclassify idiomatic expressions. Advanced NLP could improve insights.  

---

## Conclusion

1. **Pricing Strategy:** Focus investments on high-ROI property improvements, maintain strong review activity, manage availability strategically.  
2. **Segmentation:** Distinct tiers exist in Auckland (3 segments) and Queenstown (5 segments), guiding targeted pricing and marketing strategies.  
3. **Sentiment Insights:** Positive, trustful, joyful reviews dominate; addressing minor negative feedback improves overall experience.  

**Integrated Recommendation:** Align pricing, amenities, and marketing with segment-specific expectations, maintain service quality, and proactively manage availability and promotions to maximise both revenue and guest satisfaction year-round.  

---

## References

- Gunter, U., & Önder, I. (2018). Determinants of Airbnb demand in Vienna. *Tourism Economics, 24*(3), 270–293.  
- Inside Airbnb. (n.d.). Get the data. Retrieved August 31, 2025, from https://insideairbnb.com/get-the-data/  
- RStudio Team. (2023). *RStudio IDE (Version 2023.06.1)*. Posit Software, PBC.  
- Wang, D., & Nicolau, J. L. (2017). Price determinants of sharing economy-based accommodation rental. *Int. J. of Hospitality Management, 62*, 120–131.  
- Xie, K. L., Zhang, Z., & Zhang, Z. (2014). The business value of online consumer reviews. *Int. J. of Hospitality Management, 43*, 1–12.  

---

## Appendix: Key Figures

- **Figure 1.1:** Monthly Average Airbnb Prices  
- **Figure 1.2:** Hausman Test Results (FE vs RE)  
- **Figure 1.3:** Fixed Effects Regression – Price Drivers  
- **Figure 1.4:** Top Five NZ Regions by Airbnb Listings  
- **Figure 1.5:** Seasonal Price Trends – Auckland vs Queenstown  
- **Figure 1.6:** Nightly Price Distribution – Auckland vs Queenstown  
- **Figure 1.7:** Auckland Segmentation – Key Characteristics  
- **Figure 1.8:** Queenstown Segmentation – Key Characteristics  
- **Figure 1.9:** Monthly Guest Review Counts  
- **Figure 1.10–1.12:** Sentiment & Emotion Distribution  
- **Figure 1.13–1.14:** Positive/Negative Word Clouds  
- **Figure 1.15–1.17:** Price by Month & Room Type  
- **Figure 1.18:** Sentiment & Emotion Distribution  
- **Figure 1.19–1.20:** 3D Cluster Visualisations (Auckland & Queenstown)  

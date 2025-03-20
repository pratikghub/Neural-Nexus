An Analysis on NOAA Atlantic Storm Frequencies and Intensities Over Time

Author: Pratik Ganguli (pgan501)

Overview

The storms dataset, available in R, provides historical storm track data from 1975 to 2022, sourced from the NOAA Atlantic hurricane database (HURDAT).
This study examines how storm frequency and intensity have changed over time by analyzing variations in:
	•	Wind speed (knots)
	•	Atmospheric pressure (mb)
	•	Storm classifications (Tropical, Extratropical, Subtropical, Hurricane)

By identifying shifts in storm characteristics, this study seeks to uncover climate change patterns and provide insights into storm preparedness strategies.

⸻

Key Findings
	1.	Storm occurrences have risen significantly over time.
	•	In the late 1970s and early 1980s, storm counts fluctuated between 200 and 300 annually.
	•	From the 1990s onward, storm frequency increased sharply, with several years exceeding 500 storms.
	•	2005 and 2020 recorded over 800 storms, likely influenced by rising global temperatures and ocean warming.
	2.	Storm intensity trends show shifting distributions rather than a uniform increase.
	•	Lower pressures correspond to stronger storms, as expected.
	•	Maximum wind speeds have remained relatively stable over time.
	•	Minimum pressure values have dropped significantly (as low as 882 mb in the 2000s), indicating that some storms are reaching greater intensities.
	3.	Tropical and extratropical storms exhibit different trends.
	•	Extratropical storms have become more frequent.
	•	Tropical storms and depressions show greater variability in their occurrences.

These findings highlight growing storm unpredictability, reinforcing the need for stronger disaster preparedness measures.

⸻

Data Source
	•	Dataset: storms (available in R)
	•	Source: NOAA Atlantic hurricane database (HURDAT)
	•	Time Period: 1975 – 2022
	•	Total Observations: 19,537
	•	Key Variables:
	•	wind: Wind speed in knots
	•	pressure: Atmospheric pressure in mb
	•	status: Storm classification (Tropical, Extratropical, Subtropical, Hurricane)
	•	year: Year of occurrence

⸻

Summary Statistics by Decade (1970-2020)

Decade	Min Wind Speed (Knots)	Mean Wind Speed (Knots)	Max Wind Speed (Knots)	Min Pressure (mb)	Mean Pressure (mb)	Max Pressure (mb)
1970s	15	50.9	150	924	995	1015
1980s	10	51.0	165	888	994	1018
1990s	10	51.4	155	905	993	1020
2000s	10	49.9	160	882	993	1024
2010s	15	49.0	160	908	994	1021
2020s	15	48.6	140	917	994	1018



⸻

Visualization Highlights

Annual Storm Frequency Over Time (1975-2022)

Figure 1.1 reveals a sharp increase in annual storm counts over time.
	•	Storm frequency has risen dramatically since the 1990s.
	•	2005 and 2020 exceeded 800 storms, marking peak years.

Wind Speed vs. Pressure Across Decades (1970-2020)

Figure 1.2 confirms the inverse relationship between wind speed and atmospheric pressure.
	•	Lower pressures correspond to stronger storms.
	•	Extreme storms (160+ knots) have persisted across multiple decades.
	•	While maximum wind speeds remain stable, minimum pressures are dropping.

⸻

Technical Implementation

1. Required Libraries

Ensure these libraries are installed before running the code:

	install.packages("tidyverse")   # Install if not already installed
	library(ggplot2)                # For data visualization
	library(dplyr)                  # For data manipulation

2. Load and Explore the Data
	
		data(storms)         # Load the built-in 'storms' dataset
		summary(storms)      # Summary statistics
		colnames(storms)     # Check column names
		str(storms)          # Structure of the dataset
		print(head(storms, 3), width = Inf)  # View first 3 rows

3. Check for Missing Values
	
		sum(is.na(storms))       # Total missing values
		colSums(is.na(storms))   # Missing values per column
		storms1 <- na.omit(storms)  # Remove missing values

4. Calculate Annual Storm Frequency

		freq_storms <- storms %>%
		  group_by(year) %>%
		  summarise(count = n()) %>%
		  select(year, count)

5. Visualize Annual Storm Frequency
		
		ggplot(freq_storms, aes(x = year, y = count)) +
		  geom_line(color = "steelblue", size = 1.2) + 
		  geom_smooth(method = "loess", color = "darkred", linetype = "dashed", size = 0.8, se = FALSE) +
		  labs(
		    title = "Annual Storm Frequency Over Time",
		    x = "Year",
		    y = "Number of Storms",
		    caption = "Source: NOAA Atlantic hurricane | Visualization by Pratik Ganguli"
		  ) +
		  theme_classic()

6. Summary of Storm Intensity by Decade
		
		storms %>% 
		  mutate(decade = floor(year / 10) * 10) %>%
		  group_by(decade) %>%
		  summarise(
		    min_wind = min(wind, na.rm = TRUE),
		    mean_wind = mean(wind, na.rm = TRUE),
		    max_wind = max(wind, na.rm = TRUE),
		    min_pressure = min(pressure, na.rm = TRUE),
		    mean_pressure = mean(pressure, na.rm = TRUE),
		    max_pressure = max(pressure, na.rm = TRUE)
		  ) -> summary_decade
		
		print(summary_decade, width = Inf)

7. Visualize Wind vs. Pressure Across Decades
		
		ggplot(storms, aes(x = wind, y = pressure, colour = status)) +
		  geom_point(alpha = 0.8, size = 1.4) + 
		  labs(
		    title = "Wind Speed vs. Pressure Across Decades",
		    x = "Wind Speed (knots)",
		    y = "Pressure (mb)",
		    colour = "Storm Status"
		  ) +
		  theme_classic() +
		  facet_wrap(~ decade, scales = "free") 



⸻

Conclusion

This study highlights a significant increase in storm frequency over the past decades, with severe storms occurring frequently.
	•	Storms have become more frequent and intense in certain metrics (lower pressure values).
	•	Maximum wind speeds have remained stable, but storm intensity is evolving rather than uniformly increasing.
	•	Storm unpredictability is rising, emphasizing the need for improved preparedness strategies.

Future work could explore climate-related drivers such as sea surface temperature anomalies, ENSO cycles, and regional storm patterns.

⸻

License

This project is licensed under the MIT License.

⸻

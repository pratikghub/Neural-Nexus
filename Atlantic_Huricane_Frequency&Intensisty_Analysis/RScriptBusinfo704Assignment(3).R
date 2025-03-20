# ======================= #
# Title: An Analysis on Storm Frequencies and Intensities Over Time
# Author: Pratik Ganguli (pgan501)
# ======================= #

# Required Libraries and Packages
install.packages("tidyverse")
library(ggplot2)    # For data visualization
library(dplyr)      # For data manipulation

# ======================= #
# 1. Load and Explore the Data
# ======================= #

data(storms)        # Loaded the built-in 'storms' dataset
?storms             # Views the documentation for the dataset
summary(storms)     # Displays summary statistics of the dataset
colnames(storms)    # For checking the column names
str(storms)         # View the structure of the dataset
range(storms$year)  # Get the range of years in the dataset

# Displays the first 3 rows of the dataset with all columns
print(head(storms, 3), width = Inf)

# Explores unique values in specific columns
unique(storms$name)   # Unique storm names
unique(storms$status) # Unique storm statuses

# Checks for missing values
sum(is.na(storms))      # Total missing values
colSums(is.na(storms))  # Missing values per column

# Removes rows with missing values
storms1 <- na.omit(storms)
sum(is.na(storms1))     # Verifies no missing values remain

# ======================= #
# 2. Frequency of Storms Over the Years
# ======================= #

# Calculating the annual frequency of storms
freq_storms <- storms %>%
  group_by(year) %>%
  summarise(count = n()) %>%
  select(year, count)

# ======================= #
# 3. Visualizing the Annual Storm Frequency
# ======================= #

ggplot(freq_storms, aes(x = year, y = count)) +
  geom_line(color = "steelblue", size = 1.2) +                # Line plot
  geom_point(aes(color = count), size = 3, position = position_jitter(width = 0, height = 0.5)) +  # Points with gradient color
  geom_smooth(method = "loess", color = "darkred", linetype = "dashed", size = 0.8, se = FALSE) +  # Trendline without confidence interval
  labs(
    title = "Annual Storm Frequency Over Time",
    subtitle = "Tracking Storm Activity By Year",
    x = "Year",
    y = "Number of Storms",
    caption = "Source: NOAA Atlantic hurricane | Visualization by [Pratik Ganguli]"
  ) +
  theme_classic(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"), 
    plot.subtitle = element_text(hjust = 0.5, size = 14, margin = margin(b = 10)),
    axis.title = element_text(size = 15, face = "bold"),
    axis.text = element_text(size = 12, angle = 45, hjust = 1, face = "bold"),
    plot.caption = element_text(size = 10, margin = margin(t = 10)),
    plot.margin = margin(20, 20, 20, 20),
    legend.position = "none",
    panel.border = element_rect(color = "black", fill = NA, size = 1)
  ) +
  scale_x_continuous(
    breaks = seq(min(freq_storms$year), 2022, by = 5),
    limits = c(min(freq_storms$year), 2022)
  ) +
  scale_y_continuous(
    limits = c(0, max(freq_storms$count) + 20),
    expand = c(0, 0)
  ) +
  scale_color_viridis_c(option = "C", direction = -1, name = "Frequency")

# ======================= #
# 4. Decade-Wise Summary of Storm Intensity
# ======================= #

# Adds a 'decade' column to the dataset
data <- storms %>% 
  mutate(decade = floor(year / 10) * 10)

View(data)  # Views the modified dataset
print(data, width = Inf, n = 20)  # Print the dataset with all columns

# Summarizes the wind and pressure statistics for each decade
summary_decade <- data %>%
  group_by(decade) %>%
  summarise(
    min_wind = min(wind, na.rm = TRUE),
    mean_wind = mean(wind, na.rm = TRUE),
    max_wind = max(wind, na.rm = TRUE),
    min_pressure = min(pressure, na.rm = TRUE),
    mean_pressure = mean(pressure, na.rm = TRUE),
    max_pressure = max(pressure, na.rm = TRUE)
  )

# Views the summarized data
print(summary_decade, width = Inf)

# ======================= #
# 5. Visualizes Wind vs. Pressure Across Decades to Analyse Storm Intensity Across Decades
# ======================= #

ggplot(data, aes(x = wind, y = pressure, colour = status)) +
  geom_point(alpha = 0.8, size = 1.4) + 
  labs(
    title = "Wind Speed vs. Pressure Across Decades",
    subtitle = "An Analysis of Storm Intensity by Decade",
    x = "Wind Speed (knots)",
    y = "Pressure (mb)",
    colour = "Storm Status",
    caption = "Source: NOAA Atlantic hurricane | Visualization by [Pratik Ganguli]"
  ) +
  theme_classic(base_size = 14) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 18, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, size = 14, margin = margin(b = 10)),
    axis.title = element_text(size = 15,  face = "bold"),
    axis.text = element_text(size = 12),
    legend.position = "bottom",
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 10),
    strip.text = element_text(size = 14, face = "bold", margin = margin(b = 5)),
    panel.border = element_rect(color = "black", fill = NA, size = 1)
  ) +
  scale_color_viridis_d(option = "C") +
  facet_wrap(~ decade, scales = "free", strip.position = "top") +
  scale_x_continuous(expand = expansion(mult = c(0.05, 0.05))) +
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.05))) +
  guides(colour = guide_legend(override.aes = list(size = 6)))

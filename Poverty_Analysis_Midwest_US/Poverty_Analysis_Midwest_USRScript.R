######## R Script For Businfo704 Assignment 2 (pgan501) ########


# Loading necessary library and dataset
library(ggplot2)
data(midwest)

# Viewing the structure of the 'midwest' dataset
?midwest
head(midwest) # Shows first few rows
str(midwest) # Displays the structure of the dataset
colnames(midwest) # Lists column names
View(midwest) # Opens the dataset in a spreadsheet view
table(midwest$state)

# Position Analysis: Measures for central tendency 
summary(midwest$percbelowpoverty)   # Summary statistics for 'percbelowpoverty'

prop.table(table(midwest$state)) * 100    # Proportional distribution of states as percentages

barplot(table(midwest$state))   # Barplot showing the distribution of states

by(midwest$percbelowpoverty, factor(midwest$state), summary)    # Summary of 'percbelowpoverty' by state


# Spread Analysis: Measures of variability or dispersion

by(midwest$percbelowpoverty, factor(midwest$state), sd)   # Standard deviation of 'percbelowpoverty' by state

boxplot(percbelowpoverty ~ factor(state), midwest)  # Boxplot to visualize the distribution and compare across states

tapply(midwest$percbelowpoverty, factor(midwest$state), IQR)    # Interquartile Range (IQR) of 'percbelowpoverty' by state

tapply(midwest$percbelowpoverty, factor(midwest$state), range)    # Range of 'percbelowpoverty' by state


# Shape Analysis: Distributional characteristics of data

# Density plot to visualize the distribution of 'percbelowpoverty' by state

ggplot(midwest, aes(x = percbelowpoverty, fill = state)) + 
  geom_density(alpha = 0.5, color = "black", size = 0.7) + # Adding black border and thickness to the curves
  scale_x_continuous(name = "Percentage Of People Below Poverty") + # X-axis label
  scale_y_continuous(name = "Density") + # Y-axis label
  labs(title = "Density Distribution of Poverty Percentage by States") + # Title
  theme_minimal() + # Clean theme with minimal gridlines
  theme(
    legend.title = element_blank(), # Remove legend title
    legend.text = element_text(size = 12), # Increase legend text size for better readability
    axis.title = element_text(size = 12, face = "bold"), # Axis title size
    axis.text = element_text(size = 12), # Axis text size
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5), # Bold plot title
    panel.grid = element_blank() # Remove grid lines for a cleaner plot
  )+
  theme(panel.border = element_rect(colour = "black",fill=NA,size=1))


# Boxplot to visualize the distribution and compare across states

ggplot(midwest, aes(x = factor(state), y = percbelowpoverty, fill = state)) + 
  geom_boxplot(alpha = 0.5, color = "black", size = 0.7, outlier.colour = "red", outlier.size = 3) + # Red outliers and size adjustment
  # Custom colors for states
  scale_x_discrete(name = "States") + # X-axis label
  scale_y_continuous(name = "Percentage of People Below Poverty") + # Y-axis label
  labs(title = "Poverty Percentage by States") + # Plot title
  theme_minimal() + # Clean theme with minimal gridlines
  theme(
    legend.title = element_blank(), # Remove legend title
    legend.text = element_text(size = 12), # Increase legend text size for better readability
    axis.title = element_text(size = 12, face = "bold"), # Axis title size
    axis.text = element_text(size = 12), # Axis text size
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5), # Bold plot title and center align it
    panel.grid = element_blank() # Remove grid lines for a cleaner plot
  ) +
  theme(panel.border = element_rect(colour = "black", fill = NA, size = 1)) # Add black border around the plot


# Histogram of 'percbelowpoverty' for overall distribution view
ggplot(midwest, aes(x = percbelowpoverty)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Percentage Below Poverty", 
       x = "Percentage Below Poverty", 
       y = "Frequency") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        axis.title = element_text(size = 12))


# Special Features / Outliers: Identifying and visualizing outliers

# Boxplot to identify outliers in the 'percbelowpoverty' data
ggplot(midwest, aes(y = percbelowpoverty)) +
  geom_boxplot(fill = "lightblue", color = "black", outlier.colour = "red", outlier.size = 2) +
  labs(title = "Boxplot of Percentage Below Poverty", 
       y = "Percentage Below Poverty") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        axis.title.y = element_text(size = 12))


colSums(is.na(midwest))



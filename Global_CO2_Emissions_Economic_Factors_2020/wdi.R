# ~ Author: Pratik Ganguli (pgan501)
# Installing and loading the required libraries for data manipulation, visualization, and modeling
install.packages(c("dplyr", "ggplot2", "cowplot", "GGally"))

library(dplyr)        # For data manipulation
library(ggplot2)      # For creating plots
library(cowplot)      # For combining plots
library(GGally)       # For creating pairwise plots

# Load the dataset into R
ds <- read.csv("/Users/pratikganguli/Downloads/wdi_2020.csv")

# Rename columns for clarity, making the dataset more understandable
ds <- ds %>%
  rename(
    Total_GDP = NY.GDP.MKTP.CD,
    GDP_per_Capita = NY.GDP.PCAP.CD,
    Working_Age_Population = SP.POP.1564.TO.ZS,
    Children_Population = SP.POP.0014.TO.ZS,
    Elderly_Population = SP.POP.65UP.TO.ZS,
    Female_Population = SP.POP.TOTL.FE.ZS,
    Male_Population = SP.POP.TOTL.MA.ZS,
    Total_Population = SP.POP.TOTL,
    Poverty_Gap_Low_Income = SI.POV.GAPS,
    Poverty_Gap_Mid_Income = SI.POV.UMIC.GP,
    Measles_Immunization = SH.IMM.MEAS,
    Diphtheria_Immunization = SH.IMM.IDPT,
    Women_in_Parliament = SG.GEN.PARL.ZS,
    CO2_Emissions_per_Capita = EN.ATM.CO2E.PC,
    Methane_Emissions_kt = EN.ATM.METH.KT.CE,
    Greenhouse_Gas_Emissions_kt = EN.ATM.GHGT.KT.CE,
    Access_to_Clean_Water = SH.H2O.SMDW.ZS,
    Urban_Clean_Water_Access = SH.H2O.SMDW.UR.ZS,
    Rural_Basic_Water = SH.H2O.BASW.RU.ZS
  )

# Checks the structure of the dataset 
str(ds)
sum(is.na(ds))  # Calculates the number of missing values in the entire dataset

# Displays summary statistics for key variables: GDP per capita and CO2 emissions per capita
summary(ds$GDP_per_Capita)
summary(ds$CO2_Emissions_per_Capita)

###########################################
# CO2 ~ GDP_percapita + Working Age Population -----> LINEAR MODEL 
###########################################

# Selects relevant columns for further analysis
colnames(ds)

# Creates a new dataset (tabl2) containing only the selected variables for modeling
tabl2 <- ds %>%
  select(CO2_Emissions_per_Capita, GDP_per_Capita, Working_Age_Population)

# Checks for missing values in the new dataset
sum(is.na(tabl2))
colSums(is.na(tabl2))

# Removes rows with missing values (NA) to ensure clean data
tabl2 <- na.omit(tabl2)

# Applies log transformation to the CO2 emissions, GDP per capita, and working-age population
Log_CO2 <- log10(tabl2$CO2_Emissions_per_Capita)
Log_Gdp_PerCapita <- log10(tabl2$GDP_per_Capita)
Log_Working <- log10(tabl2$Working_Age_Population)

# Adds the log-transformed variables to the dataset
tabl2 <- cbind(tabl2, Log_CO2 = Log_CO2, Log_Gdp_PerCapita = Log_Gdp_PerCapita, Log_Working = Log_Working)

# Displays summary statistics for the log-transformed variables
summary(tabl2$CO2_Emissions_per_Capita)
summary(tabl2$GDP_per_Capita)
summary(tabl2$Working_Age_Population)

# Checks correlations between the original variables
cor(tabl2$CO2_Emissions_per_Capita, tabl2$GDP_per_Capita)
cor(tabl2$CO2_Emissions_per_Capita, tabl2$Working_Age_Population)
cor(tabl2$GDP_per_Capita, tabl2$Working_Age_Population)

# Creates a pairwise plot to visualize relationships between CO2 emissions, GDP, and working-age population
ggpairs(
  tabl2, 
  columns = c("CO2_Emissions_per_Capita", "GDP_per_Capita", "Working_Age_Population"),
  title = "Exploring the Relationship Between CO2 Emissions, GDP, and Working-Age Population"
) +
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5), # Bold title
    axis.title = element_text(face = "bold", size = 12),  # Bold axis labels
    axis.text = element_text(face = "bold", size = 10),   # Bold axis text
    panel.border = element_rect(color = "black", fill = NA, size = 1) # Border around panels
  )

# Displays summary statistics for the log-transformed variables
summary(tabl2$Log_CO2)
summary(tabl2$Log_Gdp_PerCapita)
summary(tabl2$Log_Working)

# Checks correlations between the log-transformed variables
cor(tabl2$Log_CO2, tabl2$Log_Gdp_PerCapita)
cor(tabl2$Log_CO2, tabl2$Log_Working)
cor(tabl2$Log_Gdp_PerCapita, tabl2$Log_Working)

# Creates a pairwise plot for the log-transformed variables
ggpairs(
  tabl2[, c("Log_CO2", "Log_Gdp_PerCapita", "Log_Working")],
  title = "Impact of Log-transformed Economic Factors on CO2 Emissions"
) +
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5), # Bold title
    axis.title = element_text(face = "bold", size = 12),  # Bold axis labels
    axis.text = element_text(face = "bold", size = 10),   # Bold axis text
    panel.border = element_rect(color = "black", fill = NA, size = 1) # Border around panels
  )


# Builds a linear regression model to predict log-transformed CO2 emissions based on GDP per capita and working-age population
llm <- lm(Log_CO2 ~ Log_Gdp_PerCapita + Log_Working, tabl2)

# Displays the model summary to evaluate its performance
summary(llm)

# Creates diagnostic plots to assess the model's residuals
p0 <- ggplot(llm, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  theme_bw() +
  theme(
    text = element_text(face = "bold", size = 14),
    panel.border = element_rect(colour = "black", fill = NA, linewidth = 1.5)
  ) +
  labs(title = "Residuals vs Fitted Values", x = "Fitted Values", y = "Residuals") 

# Adds residuals to the dataset for further visualization
resid <- cbind(tabl2, residual = llm$residuals)

# Plots residuals against the working-age population
p1 <- ggplot(resid, aes(x = Log_Working, y = residual)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  theme_bw() +
  theme(
    text = element_text(face = "bold", size = 14),
    panel.border = element_rect(colour = "black", fill = NA, linewidth = 1.5)
  ) +
  labs(title = "Residuals vs Log(Working Population)", x = "Log(Working Age Population)", y = "Residuals")

# Plots residuals against the log-transformed GDP per capita
p2 <- ggplot(resid, aes(x = Log_Gdp_PerCapita, y = residual)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  theme_bw() +
  theme(
    text = element_text(face = "bold", size = 14),
    panel.border = element_rect(colour = "black", fill = NA, linewidth = 1.5)
  ) +
  labs(title = "Residuals vs Log(GDP per Capita)", x = "Log(GDP per Capita)", y = "Residuals") 

# Plots the distribution of residuals
p3 <- ggplot(resid, aes(x = residual)) +
  geom_histogram(bins = 10, fill = "grey", color = "black") +
  theme_bw() +
  theme(
    text = element_text(face = "bold", size = 14),
    panel.border = element_rect(colour = "black", fill = NA, linewidth = 1.5)
  ) +
  labs(title = "Distribution of Residuals", x = "Residuals", y = "Count") 

# Combines all the diagnostic plots into one grid for easy comparison
cowplot::plot_grid(p0, p1, p2, p3)


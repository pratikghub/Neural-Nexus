#~ AUTHOR : PRATIK GANGULI
##################################################################################################
#                                     E D A                                                      #
##################################################################################################

csv1<-read.csv("/Users/pratikganguli/Downloads/data_ads.csv")
str(csv1)

csv<-read.csv("/Users/pratikganguli/Downloads/data_ads.csv")

colnames(csv)
head(csv)
tail(csv,15)

str(csv)
table(csv$Funnel)

summary((csv))

# Convert StartTime and EndTime to POSIXct datetime
csv$StartTime <- as.POSIXct(csv$StartTime, format = "%m/%d/%y %H:%M")
csv$EndTime <- as.POSIXct(csv$EndTime, format = "%m/%d/%y %H:%M")

min(csv$StartTime)

max(csv$EndTime)

length(unique(csv$UserID))

any(duplicated(csv))

length(unique(csv$UserID))
dup_ids <- csv$UserID[duplicated(csv$UserID)]
unique(dup_ids)        


csv %>% 
  filter(UserID %in% dup_ids)


library(dplyr)


csv_user_summary <- csv %>%
  arrange(UserID, EndTime) %>%
  mutate(
    campaign_duration = as.numeric(difftime(EndTime, StartTime, units = "days"))
  ) %>%
  group_by(UserID) %>%
  summarise(
    # Dates
    first_start = min(StartTime, na.rm = TRUE),
    last_end = max(EndTime, na.rm = TRUE),
    
    # Adjusted campaign days (actual active days only)
    campaign_days = sum(campaign_duration, na.rm = TRUE),
    
    # Time totals
    SumTime_s = sum(SumTime_s, na.rm = TRUE),
    SumTime_h = sum(SumTime_h, na.rm = TRUE),
    SumTime_d = sum(SumTime_d, na.rm = TRUE),
    
    # Impressions count
    Count = sum(Count, na.rm = TRUE),
    
    # Time averages
    AvgTime_s = mean(AvgTime_s, na.rm = TRUE),
    AvgTime_h = mean(AvgTime_h, na.rm = TRUE),
    AvgTime_d = mean(AvgTime_d, na.rm = TRUE),
    
    # Campaign strategy proportions
    Behavioral = mean(Behavioral, na.rm = TRUE),
    Contextual = mean(Contextual, na.rm = TRUE),
    Geo = mean(Geo, na.rm = TRUE),
    Lookalike = mean(Lookalike, na.rm = TRUE),
    Predictive = mean(Predictive, na.rm = TRUE),
    Prospecting = mean(Prospecting, na.rm = TRUE),
    Remarketing = mean(Remarketing, na.rm = TRUE),
    Retargeting = mean(Retargeting, na.rm = TRUE),
    
    # Funnel: final stage
    Funnel = last(Funnel),
    
    # Purchaser: 1 if purchased at least once
    Purchaser = as.integer(any(Purchaser == 1)),
    
    .groups = "drop"
  )

csv_user_summary <- csv_user_summary %>%
  mutate(CampaignCount = rowSums(across(c(Behavioral, Contextual, Geo, Lookalike,
                                          Predictive, Prospecting, Remarketing, Retargeting), ~ . > 0)))
head(csv_user_summary)
str(csv_user_summary)
print(csv_user_summary, width = Inf)
summary(csv_user_summary)

table(csv_user_summary$Funnel)
table(csv_user_summary$Purchaser)

any(duplicated(csv_user_summary$UserID))


##################################################################################################
 #                                     QUESTIONS 2                                                 #
##################################################################################################


library(dplyr)
library(tidyr)
library(ggplot2)

# Select only the targeting type columns
targeting_cols <- csv_user_summary[, c("Behavioral", "Contextual", "Geo", "Lookalike", 
                          "Predictive", "Prospecting", "Remarketing", "Retargeting")]

# Sum column-wise to get total usage of each targeting type
total_usage <- colSums(targeting_cols)

# Convert to a data frame for plotting
usage_df <- data.frame(
  TargetingType = names(total_usage),
  TotalUsage = as.numeric(total_usage)
)

# Optional: reorder by usage
usage_df <- usage_df[order(-usage_df$TotalUsage), ]

# Plot
library(ggplot2)
ggplot(usage_df, aes(x = reorder(TargetingType, -TotalUsage), y = TotalUsage)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Total Usage of Each Targeting Type",
       x = "Targeting Type", y = "Aggregate Usage (Proportional Sum)") +
  theme_minimal()

#######
library(dplyr)
library(ggplot2)

# Extract targeting columns
targeting_cols <- csv_user_summary[, c("Behavioral", "Contextual", "Geo", "Lookalike", 
                                       "Predictive", "Prospecting", "Remarketing", "Retargeting")]

# Sum proportional usage for each targeting type
total_usage <- colSums(targeting_cols, na.rm = TRUE)

# Create a data frame for plotting
usage_df <- data.frame(
  TargetingType = names(total_usage),
  TotalUsage = as.numeric(total_usage)
)

# Calculate percentage of total usage
usage_df <- usage_df %>%
  arrange(desc(TotalUsage)) %>%
  mutate(Percentage = round(TotalUsage / sum(TotalUsage) * 100, 1))

# Plotting
ggplot(usage_df, aes(x = reorder(TargetingType, -Percentage), y = Percentage)) +
  geom_bar(stat = "identity", fill = "#2C3E50", color = "black", width = 0.7) +
  geom_text(aes(label = paste0(Percentage, "%")), 
            vjust = -0.5, size = 4.2, fontface = "bold") +
  labs(
    title = "Distribution of Campaign Targeting Types",
    subtitle = "Distribution of Targeting Types Based on Summed User-Level Proportions (n = 19,990)",
    x = "Targeting Type",
    y = "Percentage of Total Usage (%)",
    caption = "Source: data_ads.csv"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12, color = "gray40"),
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),
    axis.text.y = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold", margin = margin(r = 10)),
    plot.caption = element_text(size = 9, face = "italic", hjust = 1),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()
  )


############################ C - O - U - N - T ############################################################

# Count how many users were exposed (proportion > 0) to each targeting type
exposure_count <- colSums(targeting_cols > 0, na.rm = TRUE)

# Convert to data frame for inspection
exposure_df <- data.frame(
  TargetingType = names(exposure_count),
  UserCount = as.integer(exposure_count)
)

print(exposure_df)

# Convert exposure_count into a data frame
exposure_df <- data.frame(
  TargetingType = names(exposure_count),
  UserCount = as.numeric(exposure_count)
)

# Plotting
ggplot(exposure_df, aes(x = reorder(TargetingType, -UserCount), y = UserCount)) +
  geom_bar(stat = "identity", fill = "#18BC9C", color = "black", width = 0.7) +
  geom_text(aes(label = UserCount), 
            vjust = -0.5, size = 4.2, fontface = "bold") +
  labs(
    title = "User Exposure by Campaign Targeting Type",
    subtitle = "Number of Users Exposed to Each Targeting Type (proportion > 0)",
    x = "Targeting Type",
    y = "User Count",
    caption = "Source: data_ads.csv"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12, color = "gray40"),
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),
    axis.text.y = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold", margin = margin(r = 10)),
    plot.caption = element_text(size = 9, face = "italic", hjust = 1),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()
  )



library(gridExtra)
library(grid)
library(dplyr)

# Step 1: Merge both data frames by TargetingType
combined_df <- merge(usage_df, exposure_df, by = "TargetingType")

# Step 2: Convert Percentage to numeric (if it's character)
combined_df$Percentage <- as.numeric(combined_df$Percentage)

# Step 3: Reorder by Percentage (descending)
combined_df <- combined_df %>%
  arrange(desc(Percentage)) %>%
  dplyr::select(TargetingType, TotalUsage, Percentage, UserCount)

# Step 4: Create and draw the table
tg <- tableGrob(combined_df, rows = NULL)
grid.newpage()
grid.draw(tg)


##################################################################################################
#                                     QUESTIONS 3                                                 #
##################################################################################################


# Fit logistic regression model
model_0 <- glm(Purchaser ~ Count, data = csv_user_summary, family = binomial)

# View model summary
summary(model_0)

# Get predicted probabilities
pred_probs <- predict(model, type = "response")

# Convert to class predictions (threshold = 0.5)
pred_class <- ifelse(pred_probs > 0.5, 1, 0)

# Get actual values
actual <- csv_user_summary$Purchaser

# Calculate accuracy
accuracy <- mean(pred_class == actual)

# Print it
print(paste("Accuracy:", round(accuracy, 3)))




##################################################################################################
#                                     QUESTIONS 4                                                 #
##################################################################################################


csv_user_summary <- csv_user_summary %>%
  mutate(
    Funnel_Upper = ifelse(Funnel == "Upper", 1, 0),
    Funnel_Lower = ifelse(Funnel == "Lower", 1, 0)
  )

model_1 <- glm(Purchaser ~ Count + Funnel_Upper + Funnel_Lower, 
              family = binomial, data = csv_user_summary)

summary(model_1)

vif(model_1)


##################################################################################################
#                                     QUESTIONS 5                                                 #
##################################################################################################


model_2 <- glm(Purchaser ~ Count + Behavioral + Contextual + Geo + Lookalike + 
                 Predictive + Prospecting + Remarketing + Retargeting, 
               data = csv_user_summary, family = "binomial")
summary(model_2)


model3 <- glm(Purchaser ~ Count * (Contextual + Geo + Lookalike + 
                                     Predictive + Prospecting + Remarketing + Retargeting), 
              family = binomial, data = csv_user_summary)
summary(model3)


model4 <- glm(Purchaser ~ Count + Behavioral + Contextual + Geo + Lookalike + 
                Predictive + Prospecting + Remarketing + Retargeting + campaign_days +
                SumTime_h + AvgTime_h + Funnel + CampaignCount, 
              data = csv_user_summary, family = "binomial")
summary(model4)


model5 <- glm(Purchaser ~ Count + Contextual + Geo + Lookalike + 
                Predictive + Prospecting + Remarketing + Retargeting + campaign_days +
                SumTime_h + AvgTime_h + Funnel + CampaignCount, 
              data = csv_user_summary, family = "binomial")
summary(model5)


model6 <- glm(Purchaser ~ Count + Contextual + Geo + Lookalike + 
                Predictive + Prospecting + Remarketing + Retargeting +
                 + AvgTime_h + Funnel + CampaignCount, 
              data = csv_user_summary, family = "binomial")
summary(model6)


model7 <- glm(Purchaser ~ Count + Contextual + Geo + Lookalike + 
                Predictive + Prospecting + Remarketing + Retargeting +
                AvgTime_h + CampaignCount +
                CampaignCount:Funnel,
              data = csv_user_summary, family = "binomial")
summary(model7)


model8 <- glm(Purchaser ~ Count + AvgTime_h + CampaignCount + Funnel + Contextual + + Geo + Lookalike + 
                Predictive + Prospecting + Remarketing + Retargeting 
                 + Contextual*Funnel + Geo*Funnel + 
                Lookalike*Funnel + Predictive*Funnel + Prospecting*Funnel + 
                Remarketing*Funnel + Retargeting*Funnel,
              data = csv_user_summary, family = binomial)
summary(model8)


model9 <- glm(Purchaser ~ Count + Contextual + Geo + Lookalike + 
                Predictive + Prospecting + Remarketing + Retargeting +
                AvgTime_h + CampaignCount +
                CampaignCount:Funnel + Count:Funnel, 
              data = csv_user_summary, family = "binomial")
summary(model9)


model10 <- glm(Purchaser ~ Count + Contextual + Geo + Lookalike 
                  + Prospecting + Remarketing + Retargeting +
                 AvgTime_h + CampaignCount + Prospecting:Count +
               Predictive:Count + 
                 CampaignCount:Funnel + Count:Funnel, 
               data = csv_user_summary, family = "binomial")
summary(model10)

model99 <- glm(Purchaser ~ Contextual + Geo + Lookalike + 
                Predictive + Prospecting + Remarketing + Retargeting +
                AvgTime_h + CampaignCount +
                CampaignCount:Funnel +  Funnel:Retargeting + Contextual:AvgTime_h + Prospecting:AvgTime_h ,
              data = csv_user_summary, family = "binomial")
summary(model99)
vif(model99)


model11 <- glm(Purchaser ~ Contextual + Geo + Lookalike + 
                 Predictive + Prospecting + Remarketing + Retargeting +
                 AvgTime_h + CampaignCount + 
                 CampaignCount:Funnel +  Funnel:Retargeting + Contextual:AvgTime_h + 
                 Prospecting:AvgTime_h ,
               data = csv_user_summary, family = "binomial")
summary(model11)
vif(model11)


vif(model6)
vif(model7)
vif(model9)

vif(model10)




##################################################################################################################
#                           S J S     P L O T                                                                   #
##################################################################################################################


# Install if not installed
install.packages("sjPlot")
install.packages("sjmisc")


library(sjPlot)

tab_model(model_0, model_1, model6, model9, model10, model11,
          show.ci = FALSE,
          show.se = TRUE,
          show.stat = TRUE,
          show.icc = FALSE,
          show.re.var = FALSE,
          show.aic = TRUE,
          show.r2 = TRUE,      # includes McFadden's R2
          show.loglik = TRUE,  # helps interpret fit
          dv.labels = c("Model_0", "Model_1", "Model_2", "Model_3", "Model_4", "Model_5"),
          title = "Logistic Regression Models: Targeting Types and Purchase Probability")



# Install if not already
install.packages("pscl")
library(pscl)

# McFadden's R²
pR2(model11)





# Get predicted probabilities
pred_probs <- predict(model11, type = "response")

# Convert to binary class using a 0.5 threshold
pred_class <- ifelse(pred_probs >= 0.5, 1, 0)

# Actual values
actual <- csv_user_summary$Purchaser  # Replace with your actual dataset variable

# Confusion Matrix
table(Predicted = pred_class, Actual = actual)

# Accuracy
mean(pred_class == actual)


# Install if not installed
install.packages("pROC")
library(pROC)

# Create ROC object
roc_obj <- roc(actual, pred_probs)

# Plot ROC curve
plot(roc_obj, col = "blue", main = "ROC Curve for Model 11")

# AUC score
auc(roc_obj)





##################################################################################################################
#                            A I C    -     B I C   -   AUC   -   ACCURACY                                      #
##################################################################################################################


library(gt)
library(pscl)
library(pROC)
library(dplyr)

get_logit_metrics <- function(model, model_name, actual) {
  pred_probs <- predict(model, type = "response")
  pred_class <- ifelse(pred_probs > 0.5, 1, 0)
  roc_obj <- roc(actual, pred_probs)
  
  data.frame(
    Model = model_name,
    AIC = round(AIC(model), 1),
    BIC = round(BIC(model), 1),
    Accuracy = round(mean(pred_class == actual), 3),
    AUC = round(auc(roc_obj), 3)
  )
}

# Replace `actual` with your actual outcome variable used in the models
model_metrics <- bind_rows(
  get_logit_metrics(model_0, "Model_0", actual),
  get_logit_metrics(model_1, "Model_1", actual),
  get_logit_metrics(model6, "Model_2", actual),
  get_logit_metrics(model9, "Model_3", actual),
  get_logit_metrics(model10, "Model_4", actual),
  get_logit_metrics(model11, "Model_5", actual)
)

# Show in Viewer pane with formatting
model_metrics %>%
  gt() %>%
  tab_header(title = "Logistic Regression Model Comparison") %>%
  fmt_number(columns = 2:5, decimals = 3)









library(car)
library(gt)
library(dplyr)

vif_df <- vif(model11) %>%
  { if (is.matrix(.)) data.frame(Predictor = rownames(.), VIF = .[,1]) else data.frame(Predictor = names(.), VIF = .) } %>%
  mutate(Risk = case_when(
    VIF > 10 ~ "Severe",
    VIF > 5 ~ "High",
    VIF > 2.5 ~ "Moderate",
    TRUE ~ "Low"
  )) %>%
  arrange(desc(VIF))

vif_df %>%
  gt() %>%
  tab_header(title = "VIF Table for model11") %>%
  fmt_number(columns = VIF, decimals = 3)


library(car)
library(gt)
library(dplyr)

vif_df <- vif(model11) %>%
  { if (is.matrix(.)) data.frame(Predictor = rownames(.), VIF = .[,1]) else data.frame(Predictor = names(.), VIF = .) } %>%
  mutate(Risk = case_when(
    VIF > 10 ~ "Severe",
    VIF > 5 ~ "High",
    VIF > 4 ~ "Moderate",
    TRUE ~ "Low"
  )) %>%
  arrange(desc(VIF))

vif_df %>%
  gt() %>%
  tab_header(title = md("**Variance Inflation Factor Table (VIF) for `Model_5`**")) %>%
  fmt_number(columns = VIF, decimals = 3) %>%
  cols_label(
    Predictor = md("**Variable**"),
    VIF = md("**VIF Score**"),
    Risk = md("**Multicollinearity Risk**")
  )








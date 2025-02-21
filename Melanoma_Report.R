# Survival from Malignant Melanoma

# Import melanoma data
melanoma_data <- read.csv("melanoma.csv")
#Load library
library(dplyr)

#Question (i)
# Summary statistics for relevant variables
summary_stats <- melanoma_data %>%
  summarise(
    Median_Survival_Time = median(time, na.rm = TRUE),
    Proportion_Dead_Melanoma = mean(status == 1, na.rm = TRUE),
    Proportion_Alive = mean(status == 2, na.rm = TRUE),
    Proportion_Dead_Other_Causes = mean(status == 3, na.rm = TRUE),
    Proportion_Male = mean(sex == 1, na.rm = TRUE),
    Median_Age = median(age, na.rm = TRUE),
    Mean_Year_Operation = mean(year, na.rm = TRUE),
    Mean_Thickness = mean(thickness, na.rm = TRUE),
    Median_Thickness = median(thickness, na.rm = TRUE),
    Proportion_Ulcerated = mean(ulcer == 1, na.rm = TRUE)
  )

# Display the summary statistics
print(summary_stats)

#Question (ii)
library(ggplot2)
# Survival Time Histogram
ggplot(melanoma_data, aes(x = time)) +
  geom_histogram(binwidth = 100, fill = "blue", color = "black") +
  labs(title = "Distribution of Survival Time", x = "Survival Time (days)", y = "Frequency")

# Status Bar Plot
ggplot(melanoma_data, aes(x = factor(status))) +
  geom_bar(fill = "lightblue") +
  labs(title = "Patient Status Distribution", x = "Status (1=Dead from Melanoma, 2=Alive, 3=Dead from Other Causes)", y = "Count")

# Gender Bar Plot
ggplot(melanoma_data, aes(x = factor(sex))) +
  geom_bar(fill = "green") +
  labs(title = "Gender Distribution", x = "Sex (1=Male, 0=Female)", y = "Count")

# Gender Bar Plot
ggplot(melanoma_data, aes(x = factor(sex))) +
  geom_bar(aes(fill = factor(sex))) +
  scale_fill_manual(values = c("0" = "pink", "1" = "blue"), 
                    labels = c("0" = "Female", "1" = "Male")) +
  labs(title = "Gender Distribution", x = "Sex (1=Male, 0=Female)", y = "Count") +
  theme_minimal()

# Age Histogram
ggplot(melanoma_data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "purple", color = "black") +
  labs(title = "Age Distribution", x = "Age at Operation", y = "Frequency")

# Year of Operation Histogram
ggplot(melanoma_data, aes(x = year)) +
  geom_histogram(binwidth = 1, fill = "orange", color = "black") +
  labs(title = "Year of Operation", x = "Year", y = "Frequency")

# Tumour Thickness Boxplot
ggplot(melanoma_data, aes(y = thickness)) +
  geom_boxplot(fill = "red") +
  labs(title = "Tumour Thickness", y = "Thickness (mm)")

# Ulceration Status Bar Plot
ggplot(melanoma_data, aes(x = factor(ulcer))) +
  geom_bar(fill = "pink") +
  labs(title = "Ulceration Status", x = "Ulceration (1=Present, 0=Absent)", y = "Count")

# Question (iii)

# 1. Regression Analysis and Correlation for time ~ thickness
# Linear regression model
model_time_thickness <- lm(time ~ thickness, data = melanoma_data)
summary(model_time_thickness)

# Correlation computation
cor_time_thickness <- cor(melanoma_data$time, melanoma_data$thickness, use = "complete.obs")
print(paste("Correlation between time and thickness:", round(cor_time_thickness, 2)))

# Scatter plot with regression line
ggplot(melanoma_data, aes(x = thickness, y = time)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Regression Analysis: Time vs. Thickness", x = "Thickness (mm)", y = "Survival Time (days)")

# 2. Regression Analysis and Correlation for time ~ age
# Linear regression model
model_time_age <- lm(time ~ age, data = melanoma_data)
summary(model_time_age)

# Correlation computation
cor_time_age <- cor(melanoma_data$time, melanoma_data$age, use = "complete.obs")
print(paste("Correlation between time and age:", round(cor_time_age, 2)))

# Scatter plot with regression line
ggplot(melanoma_data, aes(x = age, y = time)) +
  geom_point(color = "green") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Regression Analysis: Time vs. Age", x = "Age (years)", y = "Survival Time (days)")

# 3. Regression Analysis and Correlation for thickness ~ age
# Linear regression model
model_thickness_age <- lm(thickness ~ age, data = melanoma_data)
summary(model_thickness_age)

# Correlation computation
cor_thickness_age <- cor(melanoma_data$thickness, melanoma_data$age, use = "complete.obs")
print(paste("Correlation between thickness and age:", round(cor_thickness_age, 2)))

# Scatter plot with regression line
ggplot(melanoma_data, aes(x = age, y = thickness)) +
  geom_point(color = "purple") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Regression Analysis: Thickness vs. Age", x = "Age (years)", y = "Thickness (mm)")

#Question (v)

# Check for normality using Shapiro-Wilk test for each variable by gender
shapiro_time_male <- shapiro.test(melanoma_data$time[melanoma_data$sex == 1])
shapiro_time_female <- shapiro.test(melanoma_data$time[melanoma_data$sex == 0])

shapiro_thickness_male <- shapiro.test(melanoma_data$thickness[melanoma_data$sex == 1])
shapiro_thickness_female <- shapiro.test(melanoma_data$thickness[melanoma_data$sex == 0])

shapiro_age_male <- shapiro.test(melanoma_data$age[melanoma_data$sex == 1])
shapiro_age_female <- shapiro.test(melanoma_data$age[melanoma_data$sex == 0])

# Two-sample tests for normal distributions: Use t-test if normal, otherwise use Wilcoxon test
#(shapiro_time_male$p.value > 0.05 & shapiro_time_female$p.value > 0.05)

# 1. Two-sample significance test for time grouped by gender
# T-test as groups are normally distributed
test_time_gender <- t.test(time ~ sex, data = melanoma_data)
print(test_time_gender)

# 2. Two-sample significance test for thickness grouped by gender
# Wilcoxon test as the are skewed 
test_thickness_gender <- wilcox.test(thickness ~ sex, data = melanoma_data)
print(test_thickness_gender)

# 3. Two-sample significance test for age grouped by gender
# T-test as groups are normally distributed
test_age_gender <- t.test(age ~ sex, data = melanoma_data)
print(test_age_gender)
library(grid)
#Question (vi)
# Generate QQ plots for a variable grouped by gender
create_qq_plot <- function(data, variable, title) {
  ggplot(data, aes(sample = !!sym(variable))) +
    geom_qq() +
    geom_qq_line() +
    facet_wrap(~ sex, labeller = as_labeller(c(`0` = "Female", `1` = "Male"))) +
    labs(title = title, x = "Theoretical Quantiles", y = "Sample Quantiles") +
    theme_minimal()}
# Generate QQ-plots for 'time', 'thickness', and 'age' grouped by gender
qq_plot_time <- create_qq_plot(melanoma_data, "time", "QQ Plot of Survival Time by Gender")
qq_plot_thickness <- create_qq_plot(melanoma_data, "thickness", "QQ Plot of Tumour Thickness by Gender")
qq_plot_age <- create_qq_plot(melanoma_data, "age", "QQ Plot of Age by Gender")

# Convert ggplot objects to grobs (graphical objects)
grob_time <- ggplotGrob(qq_plot_time)
grob_thickness <- ggplotGrob(qq_plot_thickness)
grob_age <- ggplotGrob(qq_plot_age)

# Create a grid layout with 3 rows and 1 column
grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 1))) 

# print each grob in the specified layout position
print_grob <- function(grob, row) {
  pushViewport(viewport(layout.pos.row = row, layout.pos.col = 1))
  grid.draw(grob)
  popViewport()}
# Print the grobs 
print_grob(grob_time, 1)
print_grob(grob_thickness, 2)
print_grob(grob_age, 3)

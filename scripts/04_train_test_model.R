# Dividing dataset into training data and testing data.
set.seed(123)

train_index <- createDataPartition(
  salary_data$salary,
  p = 0.80,
  list = FALSE
)
# Create training data
train_data <- salary_data[train_index, ]

# Create testing data
test_data <- salary_data[-train_index, ]

# Checking the dimension for both train and test
dim(train_data)
dim(test_data)
dim(salary_data)

# Building linear regression model
salary_model <- lm(
  salary ~ edu + startsal + prevexp + jobtime + jobcat,
  data = train_data
)

summary(salary_model)

# Saving the model
saveRDS(salary_model, "models/salary_model.rds")

# Generate predictions
predicted_salary <- predict(
  salary_model,
  newdata = test_data
)

# Compare actual salaries with predicted salaries
comparison <- data.frame(
  Actual_Salary = test_data$salary,
  Predicted_Salary = round(predicted_salary, 2),
  Difference = round(test_data$salary - predicted_salary, 2)
)

head(comparison, 10)

# Calculate MAE
mae <- mean(abs(
  test_data$salary - predicted_salary
))

mae

# Calculate RMSE
rmse <- sqrt(mean(
  (test_data$salary - predicted_salary)^2
))

rmse

# Calculate test R-squared
ss_total <- sum(
  (test_data$salary - mean(test_data$salary))^2
)

ss_residual <- sum(
  (test_data$salary - predicted_salary)^2
)

r_squared <- 1 - (ss_residual / ss_total)

r_squared

cat("MAE:", mae, "\n")
cat("RMSE:", rmse, "\n")
cat("Test R-squared:", r_squared, "\n")

# Visualising model performance
ggplot(comparison, aes(
  x = Actual_Salary,
  y = Predicted_Salary
)) +
  geom_point(size = 2, alpha = 0.7) +
  geom_abline(
    intercept = 0,
    slope = 1,
    linetype = "dashed"
  ) +
  labs(
    title = "Actual Salary vs Predicted Salary",
    subtitle = paste0(
      "MAE: $", round(mae, 2),
      " | RMSE: $", round(rmse, 2),
      " | R-squared: ", round(r_squared * 100, 2), "%"
    ),
    x = "Actual Salary ($)",
    y = "Predicted Salary ($)",
    caption = "Dashed line represents perfect predictions."
  ) +
  theme_minimal()

# Save the graph
ggsave(
  "plots/actual_vs_predicted.png",
  width = 10,
  height = 6,
  dpi = 300
)

# Create a residual plot
residual_data <- data.frame(
  Predicted_Salary = predicted_salary,
  Residuals = test_data$salary - predicted_salary
)

ggplot(residual_data, aes(
  x = Predicted_Salary,
  y = Residuals
)) +
  geom_point(alpha = 0.7) +
  geom_hline(
    yintercept = 0,
    linetype = "dashed"
  ) +
  labs(
    title = "Residual Plot",
    x = "Predicted Salary ($)",
    y = "Residuals ($)"
  ) +
  theme_minimal()

saveRDS(
  salary_model,
  "models/salary_model.rds"
)

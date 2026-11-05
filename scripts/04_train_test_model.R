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

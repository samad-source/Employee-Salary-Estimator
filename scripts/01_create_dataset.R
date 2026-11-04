#Installing and loading Simultaneous Threshold Interaction Modeling Algorithm
install.packages("stima") 
library(stima)

#Loading the dataset
data("employee")

# Save our dataset locally
write.csv(
  employee,
  "data/employee_salary.csv",
  row.names = FALSE
)
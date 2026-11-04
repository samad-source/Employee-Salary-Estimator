#Exploring dataset
head(employee)

#Checking the dimension
dim(employee)

#Display the column names
names(employee)

# Understanding the structure
str(employee)

#Calculating basic statistics
summary(employee)

summary(employee$jobtime)

summary(employee$salary)

summary(employee$jobcat)

colSums(is.na(employee))

#Checking for duplicate records
sum(duplicated(employee))

summary(employee[c("salary","age","edu","startsal","jobtime","prevexp")])

# Creating the dependent variables
salary_data <- employee[, c(
  "salary",
  "edu",
  "startsal",
  "prevexp",
  "jobtime",
  "jobcat"
)]

head(salary_data)

str(salary_data)

dim(salary_data)

#Compare starting salary with current salary
ggplot(salary_data,aes(x=startsal,y= salary))+
         geom_point(color="tomato",fill= "white",shape = 21,size = 2)+
         labs(
           title = "Starting Salary VS Current Salary",
           x = "Starting Salary ($)",
           y = "Current Salary ($)"
         )

# Compare previous experience with salary
ggplot(salary_data,aes(x=prevexp,y=salary))+
  geom_point(color="#f89880",fill="#e42a2a",shape=21,size = 2)+
  labs(
    title = "Previous Experience VS Current Salary",
    x = "Prevoius Experience (Months)",
    y = "Current Salary ($)"
  )

#Compare education with salary
ggplot(salary_data, aes(x = edu, y = salary)) +
  geom_point(color="#606c38",fill="#283618",shape =21,size =2) +
  labs(
    title = "Education vs Salary",
    x = "Years of Education",
    y = "Current Salary ($)"
  )

# Compare job categories with salary
ggplot(salary_data, aes(x = jobcat, y = salary)) +
  geom_boxplot() +
  labs(
    title = "Salary Distribution by Job Category",
    x = "Job Category",
    y = "Current Salary ($)"
  )

# Relationship between salary and edu,startsal,prevexp,jobtime
correlation_data <- salary_data[, c(
  "salary",
  "edu",
  "startsal",
  "prevexp",
  "jobtime"
)]

cor(correlation_data)

# Correlation matrix
correlation_matrix <- cor(correlation_data)

correlation_matrix["salary", ]

# Visualizing the correlation matrix
corrplot(
  correlation_matrix,
  method = "color",
  type = "upper",
  addCoef.col = "black"
)


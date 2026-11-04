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
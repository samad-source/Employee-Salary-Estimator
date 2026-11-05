
library(shiny)

# USER INTERFACE
ui <- fluidPage(
  
  titlePanel("Employee Salary Estimator"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      h3("Enter Employee Information"),
      
      numericInput(
        "edu",
        "Years of Education:",
        value = 12,
        min = 0
      ),
      
      numericInput(
        "startsal",
        "Starting Salary ($):",
        value = 15000,
        min = 0
      ),
      
      numericInput(
        "prevexp",
        "Previous Work Experience (Months):",
        value = 24,
        min = 0
      ),
      
      numericInput(
        "jobtime",
        "Time in Current Job (Months):",
        value = 72,
        min = 0
      ),
      
      selectInput(
        "jobcat",
        "Job Category:",
        choices = c(
          "Clerical",
          "Custodial",
          "manager"
        )
      ),
      
      actionButton(
        "predict",
        "Predict Salary"
      )
    ),
    
    mainPanel(
      
      h3("Salary Prediction"),
      
      textOutput("salary_result")
    )
  )
)


# SERVER
server <- function(input, output) {
  
  # Load trained model
  salary_model <- readRDS(
    "C:/Users/CDT WO AZEEZ SAMAD/Downloads/Employee_Salary_Estimator/Employee_Salary_Estimator/models/salary_model.rds"
  )
  
  # Predict when button is clicked
  observeEvent(input$predict, {
    
    new_employee <- data.frame(
      
      edu = input$edu,
      
      startsal = input$startsal,
      
      prevexp = input$prevexp,
      
      jobtime = input$jobtime,
      
      jobcat = factor(
        input$jobcat,
        levels = c("Clerical", "Custodial", "manager")
      )
    )
    
    prediction <- predict(
      salary_model,
      newdata = new_employee
    )
    
    output$salary_result <- renderText({
      
      paste(
        "Estimated Salary: $",
        format(round(prediction, 2), big.mark = ",")
      )
      
    })
    
  })
  
}


# RUN APPLICATION
shinyApp(
  ui = ui,
  server = server
)

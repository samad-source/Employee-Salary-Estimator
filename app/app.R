library(shiny)

# USER INTERFACE
ui <- fluidPage(
  
  # Application title
  titlePanel("Employee Salary Estimator"),
  
  # Main layout
  sidebarLayout(
    
    # Input section
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
    
    # Output section
    mainPanel(
      
      h3("Salary Prediction"),
      
      textOutput("salary_result")
    )
  )
)

# SERVER
server <- function(input, output) {
  
  # Load the trained machine learning model
  salary_model <- readRDS("models/salary_model.rds")
  
  # Run prediction when the button is clicked
  observeEvent(input$predict, {
    
    # Collect information entered by the user
    new_employee <- data.frame(
      edu = input$edu,
      startsal = input$startsal,
      prevexp = input$prevexp,
      jobtime = input$jobtime,
      jobcat = factor(
        input$jobcat,
        levels = levels(train_data$jobcat)
      )
    )
    
    # Predict salary
    prediction <- predict(
      salary_model,
      newdata = new_employee
    )
    
    # Display prediction
    output$salary_result <- renderText({
      
      paste(
        "Estimated Salary: $",
        round(prediction, 2)
      )
      
    })
    
  })
  
}

# RUN THE SHINY APPLICATION
shinyApp(
  ui = ui,
  server = server
)

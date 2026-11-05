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
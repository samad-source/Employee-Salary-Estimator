
library(shiny)
library(bslib)

# =====================================
# 1. LOAD THE TRAINED MODEL
# =====================================

model_path <- file.path("..", "models", "salary_model.rds")

if (!file.exists(model_path)) {
  model_path <- file.path("models", "salary_model.rds")
}

salary_model <- readRDS(model_path)


# =====================================
# 2. USER INTERFACE
# =====================================

ui <- page_fluid(
  
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    primary = "#2563EB",
    bg = "#F5F7FB",
    fg = "#172033"
  ),
  
  tags$head(
    tags$style(HTML("

      * {
        box-sizing: border-box;
      }

      body {
        font-family: Inter, 'Segoe UI', Arial, sans-serif;
        background: #F5F7FB;
        color: #172033;
      }

      .app-shell {
        max-width: 1380px;
        margin: auto;
        padding: 28px 18px 35px;
      }

      /* HEADER */

      .app-header {
        background: linear-gradient(120deg, #102B59, #2563EB);
        color: white;
        padding: 30px 34px;
        border-radius: 18px;
        margin-bottom: 28px;
        box-shadow: 0 8px 24px rgba(30, 64, 175, 0.14);
      }

      .header-label {
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 2px;
        color: #BFDBFE;
        font-weight: 700;
        margin-bottom: 10px;
      }

      .app-header h1 {
        font-size: clamp(25px, 3vw, 36px);
        font-weight: 800;
        margin: 0 0 9px;
      }

      .app-header p {
        color: #DBEAFE;
        margin: 0;
        font-size: 15px;
      }

      /* DASHBOARD GRID */

      .dashboard-grid {
        display: grid;
        grid-template-columns: minmax(300px, 0.85fr)
                               minmax(0, 1.5fr);
        gap: 24px;
        align-items: start;
      }

      /* CARDS */

      .panel-card {
        background: #FFFFFF;
        border: 1px solid #E5EAF2;
        border-radius: 16px;
        padding: 26px;
        box-shadow: 0 5px 18px rgba(15, 23, 42, 0.045);
        min-width: 0;
      }

      .panel-heading {
        font-size: 19px;
        font-weight: 750;
        color: #172B4D;
        margin: 0 0 7px;
      }

      .panel-description {
        color: #8290A5;
        font-size: 13px;
        margin-bottom: 25px;
      }

      /* INPUTS */

      .form-group {
        margin-bottom: 19px;
      }

      .control-label {
        font-size: 13px;
        font-weight: 650;
        color: #34445E;
        margin-bottom: 8px;
      }

      .form-control, .form-select {
        width: 100%;
        min-height: 45px;
        border: 1px solid #DCE3ED;
        border-radius: 9px;
        background: #FBFCFE;
        box-shadow: none;
        padding: 10px 13px;
      }

      .form-control:focus, .form-select:focus {
        border-color: #2563EB;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.10);
      }

      .btn-predict {
        width: 100%;
        min-height: 49px;
        background: #2563EB;
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 700;
        margin-top: 7px;
        transition: 0.2s ease;
      }

      .btn-predict:hover {
        background: #1D4ED8;
        color: white;
        transform: translateY(-1px);
      }

      /* RESULT */

      .result-label {
        color: #64748B;
        font-size: 13px;
        font-weight: 650;
        margin-bottom: 9px;
      }

      .result-card {
        background: #ECFDF3;
        border: 1px solid #BBF7D0;
        border-radius: 14px;
        padding: 27px;
        margin-top: 20px;
        margin-bottom: 25px;
      }

      .salary-value {
        color: #15803D;
        font-size: clamp(30px, 4vw, 43px);
        font-weight: 800;
        letter-spacing: -1.5px;
        overflow-wrap: anywhere;
      }

      .result-note {
        color: #568166;
        font-size: 13px;
        margin-top: 8px;
      }

      .empty-state {
        background: #F8FAFC;
        border: 1px dashed #CBD5E1;
        border-radius: 14px;
        padding: 38px 20px;
        text-align: center;
        color: #64748B;
        margin-top: 20px;
        margin-bottom: 25px;
      }

      /* INSIGHTS */

      .insights-heading {
        font-size: 16px;
        font-weight: 750;
        margin: 28px 0 16px;
        color: #172B4D;
      }

      .insights-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 13px;
      }

      .insight-card {
        background: #F3F7FF;
        border: 1px solid #E0EAFE;
        border-radius: 12px;
        padding: 19px 10px;
        text-align: center;
        min-width: 0;
      }

      .insight-value {
        color: #1D4ED8;
        font-size: 21px;
        font-weight: 800;
        overflow-wrap: anywhere;
      }

      .insight-label {
        color: #64748B;
        font-size: 12px;
        margin-top: 6px;
      }

      .disclaimer {
        font-size: 12px;
        color: #94A3B8;
        line-height: 1.6;
        margin-top: 25px;
      }

      /* FOOTER */

      .app-footer {
        text-align: center;
        color: #94A3B8;
        font-size: 12px;
        padding: 25px 10px 5px;
        margin-top: 12px;
      }

      /* MOBILE RESPONSIVENESS */

      @media (max-width: 850px) {
        .dashboard-grid {
          grid-template-columns: 1fr;
        }
      }

      @media (max-width: 500px) {
        .app-shell {
          padding: 16px 10px;
        }

        .panel-card {
          padding: 19px;
        }

        .insights-grid {
          grid-template-columns: 1fr;
        }

        .app-header {
          padding: 24px 20px;
        }
      }

    "))
  ),
  
  div(
    class = "app-shell",
    
    # HEADER
    div(
      class = "app-header",
      
      div(
        class = "header-label",
        "MACHINE LEARNING PROJECT"
      ),
      
      h1("Employee Salary Estimator"),
      
      p("Estimate employee salaries using data-driven predictions.")
    ),
    
    # MAIN DASHBOARD
    div(
      class = "dashboard-grid",
      
      # LEFT: EMPLOYEE FORM
      div(
        class = "panel-card",
        
        h3(
          class = "panel-heading",
          "Employee Information"
        ),
        
        p(
          class = "panel-description",
          "Enter the employee details below."
        ),
        
        numericInput(
          "edu",
          "Years of Education",
          value = 12,
          min = 8,
          max = 21
        ),
        
        numericInput(
          "startsal",
          "Starting Salary ($)",
          value = 15000,
          min = 9000,
          max = 79980
        ),
        
        numericInput(
          "prevexp",
          "Previous Experience (Months)",
          value = 24,
          min = 0,
          max = 476
        ),
        
        numericInput(
          "jobtime",
          "Time in Current Job (Months)",
          value = 72,
          min = 63,
          max = 98
        ),
        
        selectInput(
          "jobcat",
          "Job Category",
          choices = c(
            "Clerical",
            "Custodial",
            "manager"
          )
        ),
        
        actionButton(
          "predict",
          "Predict Salary",
          icon = icon("calculator"),
          class = "btn-predict"
        )
      ),
      
      # RIGHT: RESULTS
      div(
        class = "panel-card",
        
        h3(
          class = "panel-heading",
          "Prediction Overview"
        ),
        
        p(
          class = "panel-description",
          "Your estimated salary and employee details."
        ),
        
        div(
          class = "result-label",
          "ESTIMATED ANNUAL SALARY"
        ),
        
        uiOutput("salary_result"),
        
        h4(
          class = "insights-heading",
          "Employee Summary"
        ),
        
        div(
          class = "insights-grid",
          
          div(
            class = "insight-card",
            div(
              class = "insight-value",
              textOutput("education_value")
            ),
            div(
              class = "insight-label",
              "Years of Education"
            )
          ),
          
          div(
            class = "insight-card",
            div(
              class = "insight-value",
              textOutput("experience_value")
            ),
            div(
              class = "insight-label",
              "Previous Experience"
            )
          ),
          
          div(
            class = "insight-card",
            div(
              class = "insight-value",
              textOutput("jobtime_value")
            ),
            div(
              class = "insight-label",
              "Current Job Time"
            )
          )
        ),
        
        p(
          class = "disclaimer",
          "This estimate is generated by a Linear Regression model ",
          "trained on historical employee salary data. ",
          "It is for educational demonstration only."
        )
      )
    ),
    
    # FOOTER
    div(
      class = "app-footer",
      "EMPLOYEE SALARY ESTIMATOR  |  POWERED BY R & SHINY"
    )
  )
)



# =====================================
# 3. SERVER
# =====================================

server <- function(input, output, session) {
  
  # Generate prediction when button is clicked
  prediction <- eventReactive(input$predict, {
    
    # Validate the user's inputs
    validate(
      need(
        !is.null(input$edu) &&
          input$edu >= 8 && input$edu <= 21,
        "Education must be between 8 and 21 years."
      ),
      
      need(
        !is.null(input$startsal) &&
          input$startsal >= 9000 &&
          input$startsal <= 79980,
        "Starting salary must be between $9,000 and $79,980."
      ),
      
      need(
        !is.null(input$prevexp) &&
          input$prevexp >= 0 &&
          input$prevexp <= 476,
        "Previous experience must be between 0 and 476 months."
      ),
      
      need(
        !is.null(input$jobtime) &&
          input$jobtime >= 63 && input$jobtime <= 98,
        "Job time must be between 63 and 98 months."
      )
    )
    
    # Prepare employee information
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
    
    # Generate prediction
    predict(salary_model, newdata = new_employee)
  })
  
  
  # Display the predicted salary
  output$salary_result <- renderUI({
    
    if (input$predict == 0) {
      return(
        div(
          class = "empty-state",
          h4("Your prediction will appear here"),
          p("Complete the employee form and click Predict Salary.")
        )
      )
    }
    
    div(
      class = "result-card",
      div(
        class = "salary-value",
        paste0(
          "$",
          format(
            round(prediction(), 2),
            big.mark = ",",
            nsmall = 2
          )
        )
      ),
      p(
        class = "result-note",
        "Estimated salary based on the information provided."
      )
    )
  })
  
  
  # Display education
  output$education_value <- renderText({
    input$edu
  })
  
  
  # Display previous experience
  output$experience_value <- renderText({
    paste(input$prevexp, "months")
  })
  
  
  # Display current job time
  output$jobtime_value <- renderText({
    paste(input$jobtime, "months")
  })
  
}


# =====================================
# 4. RUN APPLICATION
# =====================================

shinyApp(
  ui = ui,
  server = server
)


# =====================================
# 4. RUN APPLICATION
# =====================================

shinyApp(
  ui = ui,
  server = server
)

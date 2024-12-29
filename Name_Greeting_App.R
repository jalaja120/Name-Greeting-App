library(shiny)

# Define the User Interface
ui <- fluidPage(
  titlePanel("Name Greeting App"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("name", "Enter your name:", value = ""),
      actionButton("greet", "Get Greeting")
    ),
    
    mainPanel(
      h3("Greeting:"),
      textOutput("greetingMessage")
    )
  )
)

# Define the Server Logic
server <- function(input, output) {
  observeEvent(input$greet, {
    # Check if a name is entered
    if (input$name == "") {
      message <- "Please enter your name to receive a greeting!"
    } else {
      # Get the current hour
      current_hour <- as.numeric(format(Sys.time(), "%H"))
      
      # Generate a greeting based on the time of day
      if (current_hour >= 5 & current_hour < 12) {
        time_based_greeting <- paste("Good morning,", input$name, "!")
      } else if (current_hour >= 12 & current_hour < 18) {
        time_based_greeting <- paste("Good afternoon,", input$name, "!")
      } else {
        time_based_greeting <- paste("Good evening,", input$name, "!")
      }
      
      # Randomly select an additional message
      extra_messages <- c(
        "Hope you have a fantastic day!",
        "You're amazing, keep shining!",
        "Stay positive and keep smiling!",
        "Wishing you all the best today!",
        "Remember, you're capable of great things!"
      )
      random_message <- sample(extra_messages, 1)
      
      # Combine the greetings
      message <- paste(time_based_greeting, random_message)
    }
    
    # Output the greeting
    output$greetingMessage <- renderText({ message })
  })
}

# Combine UI and Server to create the Shiny app
shinyApp(ui = ui, server = server)

library(shiny)

shinyUI(fluidPage(
  titlePanel("Car Dataset Explorer", windowTitle = "Car Data Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("xVar", "X-axis Variable", choices = names(mtcars)),
      selectInput("yVar", "Y-axis Variable", choices = names(mtcars)),
      radioButtons("plotType", "Plot Type",
                   choices = list("Scatter Plot" = "scatter",
                                  "Box Plot" = "box",
                                  "Bar Chart" = "bar"))
    ),
    mainPanel(
      plotOutput("mainPlot"),
      hr(),  # Horizontal line separator
      verbatimTextOutput("summary")
    )
  ),
  # Adding some custom styling
  tags$head(
    tags$style(HTML("
            .shiny-output-error { color: red; }
            .shiny-output-error-validation { color: green; }
            body { background-color: #f3f3f3; }
            .well { background-color: #ebf5fb; }
            .sidebar { background-color: #aed6f1; }
        "))
  )
))

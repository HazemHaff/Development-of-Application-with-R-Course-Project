library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
  output$mainPlot <- renderPlot({
    # Check if the same variable is selected for both axes
    if(input$xVar == input$yVar) {
      return()
    }
    
    # Preparing the data based on input variables
    data <- mtcars
    xVar <- input$xVar
    yVar <- input$yVar
    plotType <- input$plotType
    
    # Base plot initialization
    p <- ggplot(data, aes_string(x = xVar))
    
    # Adjusting plot based on plot type selection
    if(plotType == "scatter") {
      p <- p + geom_point(aes_string(y = yVar, color = "factor(cyl)")) +
        labs(title = paste("Scatter Plot of", xVar, "vs", yVar))
    } else if(plotType == "box") {
      p <- p + geom_boxplot(aes_string(y = yVar, fill = "factor(cyl)")) +
        labs(title = paste("Box Plot of", xVar, "vs", yVar))
    } else if(plotType == "bar") {
      # For bar plot, xVar is used for grouping
      p <- p + geom_bar(aes(fill = factor(cyl)), position = "dodge") +
        labs(title = paste("Bar Plot of", xVar))
    }
    
    # Adding themes and labels
    p + theme_minimal() + theme(plot.background = element_rect(fill = "white", colour = "gray90"),
                                panel.background = element_rect(fill = "gray95")) +
      labs(x = xVar, y = yVar, fill = 'Cylinders', color = 'Cylinders')
  })
  
  output$summary <- renderPrint({
    if(input$xVar == input$yVar) {
      return("Please select different variables for X and Y axes.")
    }
    summary(mtcars[, c(input$xVar, input$yVar)])
  })
})

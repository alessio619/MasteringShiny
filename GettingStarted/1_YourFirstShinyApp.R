
# Takeaways: =========================================================================

## The basic workflow of Shiny app development is to write some code, start the app, play with the app, write some more code, and repeat. 
## Three parts: Layout function, Input controls, Output controls. They’re all just fancy ways to generate HTML
## The left-hand side of the assignment operator (<-), output$ID, indicates that you’re providing the recipe for the Shiny output with that ID. The right-hand side of the assignment uses a specific render function to wrap some code that you provide. Each render{Type} function is designed to produce a particular type of output (e.g. text, tables, and plots), and is often paired with a {type}Output function.
## You create a reactive expression by wrapping a block of code in reactive({...}) and assigning it to a variable, and you use a reactive expression by calling it like a function. But while it looks like you’re calling a function, a reactive expression has an important difference: it only runs the first time it is called and then it caches its result until it needs to be updated.
 

# Shiny App ==========================================================================

## Packages ----------------------------------------------------------------

library(shiny)


## Adding UI controls ------------------------------------------------------

ui <- fluidPage(
     selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
     verbatimTextOutput("summary"),
     tableOutput("table")
)



## Adding Behavior ---------------------------------------------------------

server <- function(input, output, session) {
     
### Reducing duplication with reactive expressions -------------------
     
     # Create a reactive expression
     dataset <- reactive({
          get(input$dataset, "package:datasets")
     })
     
     output$summary <- renderPrint({
          # Use a reactive expression by calling it like a function
          summary(dataset())
     })
     
     output$table <- renderTable({
          dataset()
     })
}


## Execute App -------------------------------------------------------------

shinyApp(ui, server)



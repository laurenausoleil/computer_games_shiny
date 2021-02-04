#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

# reactive environment for filtered sales        
    filtered_sales <- reactive({
        sales %>% 
        filter(
            genre == input$genre,
            publisher == input$publisher,
            platform == input$platform
        ) %>% 
            group_by(year) %>% 
            summarise(avg_sales = mean(sales),
                      avg_comb_reviews = mean(avg_reviews))
    })    
    
# sales plot
    output$sales <- renderPlot({
      filtered_sales() %>% 
            ggplot() +
            aes(x = year, y = avg_sales) +
            geom_line()
            
    })
    
# reviews plot
    output$reviews <- renderPlot({
        filtered_sales() %>% 
            ggplot() +
            aes(x = year, y = avg_comb_reviews) +
            geom_line()
    })
    
# numbers plot
    output$numbers <- renderPlot(
        sales %>% 
            filter(year > 1995) %>% 
            ggplot() +
            aes(x = year) +
            geom_histogram() +
            theme_linedraw()
    )

# end shiny server and function
})


# a plot of sales by year, where we can filter by the genre, publisher and console of interest

# a plot of critic and user reviews over time showing where critics agree and disagree, we can then filter by genre, publisher and console of interest
library(shiny)
library(here)
library(shinyWidgets)
library(shinythemes)

source(here("global.R"))

shinyUI(fluidPage(
    theme = shinytheme("darkly"),
    sidebarLayout(
        
# Sidebar - top stats, 5 wellpanels
        sidebarPanel(
# top seller
            wellPanel(
                tags$h5("Best Selling Game:"),
                top_seller
            ),
# Highest rated title ever (combine user and critic)
            wellPanel(
                tags$h5("Highest rated game:"),
                top_rated
            ),
# Total sales this year
            wellPanel(
                tags$h5("2016 sales to date:"),
                sales_2016
            ),
# Most popular genre for critics
            wellPanel(
                tags$h5("Most popular genre with critics:"),
                top_genre_critics
            ),
# Most popular genre for users
            wellPanel(
                tags$h5("Most popular genre with users:"),
                top_genre_users
            )
# end sidebar panel    
        ),

# main panel - 3 rows
        mainPanel(
# row one - dropdowns
            fluidRow(
# genre dropdown
                column(4,
                multiInput(inputId = "genre", 
                           label = "Genre", 
                           choices = list_genre, 
                           selected = "Action",
                           options = list(
                               enable_search = FALSE,
                               non_selected_header = "Options",
                               selected_header = "Selected"
                           )
                )),
# platform dropdown
                column(4,
                multiInput(inputId = "platform", 
                           label = "Platform", 
                           choices = list_platform, 
                           selected = list_platform,
                           options = list(
                               enable_search = FALSE,
                               non_selected_header = "Options",
                               selected_header = "Selected"
                           )
                )),
# publisher dropdown
                column(4,
                multiInput(inputId = "publisher", 
                           label = "Publisher", 
                           choices = list_publisher, 
                           selected = list_publisher,
                           options = list(
                               enable_search = FALSE,
                               non_selected_header = "Options",
                               selected_header = "Selected"
                           )
                ))
# end row one     
            ),
            
# row two - 2 x graphs, 6 cols each
            fluidRow(
# column one, graph sales
                column(6,
                    plotOutput("sales")
                ),
# column two, graph reviews
                column(6,
                    plotOutput("reviews")
                )
# end row two
            ),
# row three - plot of num games published each year - for visual more than info
            fluidRow(
                plotOutput("numbers",
                           width = "100%",
                           height = "100px")
# end row three                
            )
# end main panel
        )
# end sidebar layout
    )
# end shinyUI and fluidpage
))

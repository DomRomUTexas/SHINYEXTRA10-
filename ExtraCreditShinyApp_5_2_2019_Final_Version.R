library(shiny)
library(shinyWidgets)
library(DT)
library(tidyverse)
library(ggplot2)

A <- read.csv("~/Desktop/R-Data-Analysis/primateshiny.csv")

ui <- fluidPage(
  titlePanel(h1("Primate Morphology in Relation to Tree Hollow Inhabitance")),
  sidebarLayout(sidebarPanel(img(src = "lepitree.png", width="100%"),
  selectInput("TreeHollow", label = "Choose a variable to plot....", choices = c("Head_Body_Length_mm", "Body_Mass_g")),
  checkboxInput("checkbox1", label = "Use the checkbox to see which variable you've plotted.", value=FALSE),
  checkboxInput("checkbox2",label = "Check this box if you liked my app!", value=FALSE),
  checkboxInput("checkbox3",label = "If you want any info from the developer, check out his webpage by clicking the checkbox and following the link", value=FALSE),
  textOutput("check1"), textOutput("check2"), textOutput("check3")), mainPanel(dataTableOutput("datatable"), plotOutput("plot"))))


server <- function(input, output) {
  
  output$check1 <- renderText({ 
    if (input$checkbox1==TRUE)
      {input$TreeHollow}
    else
    NULL })
    
  output$check2 <- renderText({ 
      if (input$checkbox2==TRUE)
      {"Wow, thanks!"}
      else
      NULL })
    
  output$check3 <- renderText({ 
      if (input$checkbox3==TRUE)
      {"Copy and Paste: https://liberalarts.utexas.edu/anthropology/graduate/profile.php?id=dmr3363"}
      else
        NULL
  
  })
  output$datatable <- renderDataTable(A, options = list(paging = TRUE, 
  lengthMenu = list(c(10, 20, 30, 40, 50, 235), c('10', '20', '30','40', '50', 'ALL')), pageLength = 10))
  output$plot <- renderPlot({
  boxplot(A[,input$TreeHollow], 
  main=input$Head_Body_Length_mm) })
  output$plot <- renderPlot({
  boxplot(A[,input$TreeHollow], 
  main=input$Body_Mass_g)
  })}

shinyApp(ui = ui, server = server)
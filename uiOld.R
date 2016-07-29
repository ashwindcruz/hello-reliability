library(shiny)

shinyUI(fluidPage(
  titlePanel("Checking samples against a class"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose file to upload',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
      )
    ),
    mainPanel(
      p("Original Class:"),
      br(),
      p("Type = Normal Distribution"),
      p("Mean", span(HTML("&mu;")), "= 50"),
      p("Variance", span(HTML("&sigma;")), "= 100"),
      br(),
      p(span(HTML("&alpha;"))," Value: 0.05"),
      textOutput('contents'),
      div(textOutput('good'),style="color:green"),
      div(textOutput('bad'),style="color:red")
    )
  )
))

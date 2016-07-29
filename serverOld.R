library(shiny)

# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 9MB.
options(shiny.maxRequestSize = 9*1024^2)

shinyServer(function(input, output) {
  output$contents <- renderText({
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    classSet <- rnorm(100, 50, 10)
    
    inputData <- read.csv(inFile$datapath)
    values <- inputData[,2]
    holder <- t.test(classSet,values)
    
    if(holder[[3]]<0.05){
      output$bad<-renderText({"Sample is significantly different"})
      output$good<-renderText({""})
    }
    else{
      output$bad<-renderText({""})
      output$good<-renderText({"Sample is not significantly different"})
    }
    
    roundedPValue <- round(holder[[3]],digits = 4)
    
    result <- paste("p Value", roundedPValue, sep = " ")
    
  })
  
  
})
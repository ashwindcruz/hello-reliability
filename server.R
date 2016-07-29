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
    
    popMean <- 50
    popRangeMean <- 40
    
    #Set the upper and lower limits
    lsl <- 40
    usl <- 60
    
    #Read in the new sample
    inputData <- read.csv(inFile$datapath)
    newSample <- inputData[,2]
    
    #Calculate the stats associated with the new sample
    sampleMean <- mean(newSample)
    sampleSize <- length(newSample)
    sampleRange <- diff(range(newSample))
    stDevOptions <- c(NaN,1.128,1.693,2.059,2.326,2.534,2.704,2.847,2.970,3.078)
    sampleStDev <- stDevOptions[sampleSize]    
                      
    #Update the population stats
    popMean <- (popMean + sampleMean)/2
    popRangeMean <- (popRangeMean + sampleRange)/2
    
    #Calculate the process capability indices
    cpl <- (popMean - lsl)/(3 * sampleStDev)
    cul <- (usl - popMean)/(3 * sampleStDev)
    cpk <- min(cpl,cul)
    
    print("popMean")
    print(popMean)
    print("lsl")
    print(lsl)
    print("usl")
    print(usl)
    
    print("sampleMean")
    print(sampleMean)
    print("sampleStDev")
    print(sampleStDev)
    
    #Tell the user if defective material is being made or not
    if(cpk<1){
      displayMessage <- paste("Your process capability is",cpk,"so defective materials are being made",sep = " ")
      output$bad <- renderText({displayMessage})
      output$good <- renderText({""})
    }
    else{
      displayMessage <- paste("Your process capability value is",cpk,"so defective materials are not being made",sep = " ")
      output$good <- renderText({displayMessage})
      output$bad <- renderText({""})
    }
    
    #Calculate the defective material percentage
    upperArea <- pnorm(usl, mean = sampleMean, sampleStDev, lower.tail = FALSE, log.p = FALSE)
    lowerArea <- pnorm(lsl, mean = sampleMean, sampleStDev, lower.tail = TRUE, log.p = FALSE)
    totalAreaPercentage <- (upperArea + lowerArea) * 100
    
    defPercentageMessage <- paste("The probability of obtaining a defective item:", totalAreaPercentage,"%",sep = " ")
    output$defPercentage <- renderText({defPercentageMessage})
    
    contentsMessage <- ""
               
               
    #use p norm
    #for usl, lower tail false
    #for lsl, lower tail true
    
  })
  
  
})
library('MASS')

#Randomly generate 100 numbers assuming a normal distribution of mean 50 and std dev 100
 class <- rnorm(100, 50, 10)

#Fit a Gaussian to our class. It should be very close to mean 50 and std dev 10
classFit <- fitdistr(class, "normal")

#Randomly generate 100 numbers. Uniform distribution used here between 20 and 80, exclusive
sample <- runif(25, 40, 200)
 
#Fit a Gaussian to our sample
sampleFit <- fitdistr(sample, "normal")

#Where are your cutoff points
#binBreaks = c(0,10,20,30,40,50,60,70,80,90,100)

#How many values in each bin? 
#classOccurence <- table(cut(class,binBreaks))
#sampleOccurence <- table(cut(sample,binBreaks))

#What is the frequency of each bin in the class? 
#classFrequency <- classOccurence/100

#Calculate Chi goodness of fit
#chisq.test(sampleOccurence, classFrequency)

t.test(class, sample)

#Shiny IO...
rsconnect::setAccountInfo(name='battapp',
                          token='9F6510AAB0C2ED14DBE92ADAB40A370C',
                          secret='9zn2V5v1LmLfTvrjF6G8wgsB6ov5iK7t+FE1zLUt')

# Detection-of-outliers

Outlier detection is an important research problem in data mining that aims to find objects that are considerably dissimilar, exceptional and inconsistent with respect to the majority data in an input database . Outlier detection, also known as anomaly detection in some literatures, has become the enabling underlying technology for a wide range of practical applications in industry, business, security and engineering.

METHODOLOGY
For Outlier detection I used R script,in R script we have many function to detect outliers but I use  boxplot.stats(x)$out function because box-plot is the visualization where we can see how the data is distributed along with if there are any outliers or not  and  rosnerTest()  because perform Rosner's generalized extreme Studentized deviate test for up to k potential outliers in a dataset and cooks.distance() is to estimate of the influence data point it takes both the x value and y value of the observation.
The most commonly used method to detect outliers is visualization of the data, through boxplot, histogram, or scatterplot.
First we read the file using read.csv() command and save it in a variable
Code
ozoneData <- read.csv("ozone.csv", stringsAsFactors=FALSE)

Detect Outlier in the Univariate Continuous Variable:
Code:
outlier_values <- boxplot.stats(ozoneData$pressure_height)$out
boxplot(ozoneData$pressure_height, main="Pressure Height", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)
outlier_values[which(outlier_values %in% boxplot.stats(ozoneData$pressure_height)$out)]



Detect Outliers in Bivariate Categorical Variable 
CODE
boxplot(ozone_reading ~ Month, data=ozoneData, main="Ozone reading across months")

 

Detect Outlier in Multivariate 
Code
mod <- lm(ozone_reading ~ ., data=ozoneData)
cooksd <- cooks.distance(mod)
plot(cooksd, pch="*", cex=2, main="Influential Observation by Cooks distance")
abline(h = 4*mean(cooksd, na.rm=T), col="red")  
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T),names(cooksd),""), col="red")
influential <- as.numeric(names(cooksd)[(cooksd > 4*mean(cooksd, na.rm=T))]) 
head(ozoneData[influential, ])







library(EnvStats)
library(grDevices)
ozoneData <- read.csv("ozone.csv", stringsAsFactors=FALSE)

#Detect outlier in the univariate continous variable
outlier_values <- boxplot.stats(ozoneData$pressure_height)$out
boxplot(ozoneData$pressure_height, main="Pressure Height", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)
outlier_values[which(outlier_values %in% boxplot.stats(ozoneData$pressure_height)$out)]

#Detect outliers in bivariate categorical variable
boxplot(ozone_reading ~ Month, data=ozoneData, main="Ozone reading across months")

#Detect outlier in multivariate 
mod <- lm(ozone_reading ~ ., data=ozoneData)
cooksd <- cooks.distance(mod)
plot(cooksd, pch="*", cex=2, main="Influential Observation by Cooks distance")
abline(h = 4*mean(cooksd, na.rm=T), col="red")  
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T),names(cooksd),""), col="red")


#Removal of Outliers
#Imutation
impute_outliers <- function(x,removeNA = TRUE){
  quantiles <- quantile( x, c(.05, .95 ),na.rm = removeNA )
  x[ x < quantiles[1] ] <- mean(x,na.rm = removeNA )
  x[ x > quantiles[2] ] <- median(x,na.rm = removeNA )
  x
}
 imputed_data <- impute_outliers(ozoneData$pressure_height)
 par(mfrow = c(1, 2))
 
 boxplot(ozoneData$pressure_height, main="Pressure Height having Outliers", boxwex=0.3)
 outlier_values[which(outlier_values %in% boxplot.stats(ozoneData$pressure_height)$out)]
 
 boxplot(imputed_data, main="Pressure Height with imputed data", boxwex=0.3)
 outlier_values[which(outlier_values %in% boxplot.stats(imputed_data)$out)]
 
 #Clapping
 replace_outliers <- function(x, removeNA = TRUE) {
   pressure_height <- x
   qnt <- quantile(pressure_height, probs=c(.25, .75), na.rm = removeNA)
   caps <- quantile(pressure_height, probs=c(.05, .95), na.rm = removeNA)
   H <- 1.5 * IQR(pressure_height, na.rm = removeNA)
   pressure_height[pressure_height < (qnt[1] - H)] <- caps[1]
   pressure_height[pressure_height > (qnt[2] + H)] <- caps[2]
   pressure_height
 }
 
  capped_pressure_height <- replace_outliers(ozoneData$pressure_height) 
 
   par(mfrow = c(1, 2))
  
  boxplot(ozoneData$pressure_height, main="Pressure Height with Outliers", boxwex=0.1)
  rosnerTest(ozoneData$pressure_height,k=10,warn = F)
 boxplot(capped_pressure_height, main="Pressure Height without Outliers", boxwex=0.1)
rosnerTest(capped_pressure_height,k=10,warn = F)


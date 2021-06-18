# Detection-of-outliers

Outlier detection is an important research problem in data mining that aims to find objects that are considerably dissimilar, exceptional and inconsistent with respect to the majority data in an input database . Outlier detection, also known as anomaly detection in some literatures, has become the enabling underlying technology for a wide range of practical applications in industry, business, security and engineering.

METHODOLOGY


For Outlier detection I used R script,in R script we have many function to detect outliers but I use  boxplot.stats(x)$out function because box-plot is the visualization where we can see how the data is distributed along with if there are any outliers or not  and  rosnerTest()  because perform Rosner's generalized extreme Studentized deviate test for up to k potential outliers in a dataset and cooks.distance() is to estimate of the influence data point it takes both the x value and y value of the observation.
The most commonly used method to detect outliers is visualization of the data, through boxplot, histogram, or scatterplot.
First we read the file using read.csv() command and save it in a variable





Detect Outlier in the Univariate Continuous Variable:







Detect Outliers in Bivariate Categorical Variable 





Detect Outlier in Multivariate 








####ENVIRONMENT SETUP

#install.packages("xlsx")      ## only do once
#install.packages("QuantPsyc") ## only do once: allows beta to be easily produced
#install.packages("car")       ## only do once: allows you to check for multicollinearity
#install.packages("olsrr")     ## only do once:does a lot of assumption checks

library(QuantPsyc)            ##pull package up - do it each time you run open the script 
library(readxl)               ##pull package up - do it each time you run open the script 
library(olsrr)                ##pull package up - do it each time you run open the script
library(car)                  ##pull package up - do it each time you run open the script
library(readxl)               ##pull package up - do it each time you run open the script
library(xlsx)                 ##pull package up - do it each time you run open the script

####DATA CLEANSING 

#import excel file

mydata = read.xlsx2("/Users/stann-omar.jones/Downloads/ENB2012_data.xlsx", sheetIndex = 1)
#View(mydata)
head(mydata, n = 10)
dim(mydata) #we have 1296 but 768 observations so we have to remove empty rows

#drop rows

mydata2 <- mydata %>% 
  slice(-c(769:1296))
tail(mydata2, n = 10) #check last 10 observations
View(mydata2)

sapply(mydata2,class) #vectors are character variables so
                      #we need to convert them to numeric
                      #for regression analysis

#install.packages("hablar") ## only do once: allows you to 
                            ##easily convert variable classes

library(hablar) 
mydata2 <- mydata2 %>% #convert dataframe to numeric
  convert(num(X1:Y2))

sapply(mydata2,class) #vectors converted to numeric

#Change column names to create more readable variable names 

names(mydata2)[1] <- 'rel_compact'
names(mydata2)[2] <- 'surf_area'
names(mydata2)[3] <- 'wall_area'
names(mydata2)[4] <- 'roof_area'
names(mydata2)[5] <- 'height'
names(mydata2)[6] <- 'orientation'
names(mydata2)[7] <- 'glaz_area'
names(mydata2)[8] <- 'glaz_area_dist'
names(mydata2)[9] <- 'heating_load'
names(mydata2)[10] <- 'cooling_load'

str(mydata2) #check dataframe

####REGRESSION #1

#Have we satisfied the linear regression assumptions? 

#Linearity: The relationship between X and the mean of Y is linear.
#Homoscedasticity: The variance of residual is the same for any value of X.
#Independence: Observations are independent of each other.
#Normality: For any fixed value of X, Y is normally distributed.

#install.packages("lmtest")
library(lmtest)
library(tidyverse)

model1 = lm(mydata2$heating_load~
              mydata2$roof_area + 
              mydata2$surf_area + 
              mydata2$glaz_area,
            data = mydata2)
summary(model1)
qf(0.99, 3, 764) #get critical value. 
                 #if F is greater than critical value, 
                 #then reject H0. and determine that at 
                 #least one x variable is a significant
                 #determinant of y. 
par(mfrow=c(2,2))  # Change the panel layout to 2 x 2
plot(model1)
ols_plot_resid_hist(model1) #shows a normal distribution
vif(model1) #check for multicollinearity

#Residuals vs fitted - if points roughly fit on a central line of 0, it indicates a linear fit.

#Residuals should have a normal distribution. Residuals should follow the diagonal line in the QQ graph but if there is moderate devation at 
#the bottom of the line, this is to be expected.

#Scale-location: If there is evidence of homoscedacity, residuals are not equally spread across predictors.

#No influential cases should have strong influence on regression line.Check this on the residuals vs leverage plot.

model2 = lm(mydata2$cooling_load~
              mydata2$glaz_area +
              mydata2$height +
              mydata2$wall_area, 
            data = mydata2)
summary(model2)
qf(0.99, 3, 764) #get critical value. 
par(mfrow=c(2,2))  # Change the panel layout to 2 x 2
plot(model2)
ols_plot_resid_hist(model2) #shows a normal distribution
vif(model2) #no multicollinearity

#P-values for Breusch Pagan test are less than 0.05, 
#so null hypothesis is rejected, and we conclude that 
#heteroscedasticity is present in the regression model.

#Test for normality 

#install.packages("pastecs")
library(pastecs)
stat.desc(mydata2[, c("rel_compact", 
                      "surf_area", 
                      "wall_area", 
                      "roof_area", 
                      "height", 
                      "orientation", 
                      "glaz_area", 
                      "glaz_area_dist", 
                      "heating_load", 
                      "cooling_load")], basic = FALSE, norm = TRUE)

#Variables are not significant in normtest.p 
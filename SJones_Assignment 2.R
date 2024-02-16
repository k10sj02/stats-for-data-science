####PART ONE

#load iris dataset

iris
library(tidyverse)
##install.packages("GGally")
library(GGally)

dim(iris) #see number of rows and columns
#View(iris)
str(iris)
summary(iris)

##help(plot)

#plot petal length against petal width

plot(iris$Petal.Length, iris$Petal.Width, main="Scatterplot",
     xlab="Petal Length", ylab="Petal Width", pch=19)

abline(reg = lm(iris$Petal.Width ~ iris$Petal.Length))

# Method 1
# Scatter plot matrix in base R

pairs(~ Sepal.Length + Sepal.Width + Petal.Length +  Petal.Width, data = iris, 
      lower.panel = panel.smooth)


# Method 2
# Scatter plot matrix with GGally
ggpairs(iris, columns = 
            c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                 upper = list(continuous = wrap('cor', size = 8)))


#create correlation matrix of all quantitative variables 
#Method 1
cor_matrix <- iris[1:4] #subset dataset to exclude categorical variables
print(cor_matrix)
cor(cor_matrix)

#Method 2 - visualize correlation matrix of all quantitative variables 

##install.packages("corrplot")
library(corrplot)
corrplot(cor(cor_matrix), 
         order="AOE", 
         method = "circle", 
         tl.col = "black",  #make text on axis black rather than red
         addCoef.col = "gray")  #add coefficients within circles

#Lsfit command

lsfit(iris$Sepal.Length, iris$Petal.Width)
?lsfit

#plot petal width against sepal length

plot(iris$Petal.Width, iris$Sepal.Length, main="Scatterplot",
     xlab="Petal Width", ylab="Sepal Length", pch=19)

#plot line of fit using abline command

abline(reg = lm(iris$Sepal.Length ~ iris$Petal.Width))

#regression models

summary(lm(formula = Petal.Width ~ Petal.Length, data = iris))
summary(lm(formula = Sepal.Length ~ Sepal.Width, data =iris))

####PART TWO - A

#METHOD ONE - USING A FUNCTION

# m1, m2: the sample means
# s1, s2: the sample standard deviations
# n1, n2: the same sizes
# m0: the null value for the difference in means to be tested for. Default is 0. 
# equal.variance: whether or not to assume equal variance. Default is FALSE. 

t.test2 <- function(m1,m2,s1,s2,n1,n2,m0=0,equal.variance=FALSE)
{
  if( equal.variance==FALSE ) 
  {
    se <- sqrt( (s1^2/n1) + (s2^2/n2) )
    # welch-satterthwaite df
    df <- ( (s1^2/n1 + s2^2/n2)^2 )/( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1) )
  } else
  {
    # pooled standard deviation, scaled by the sample sizes
    se <- sqrt( (1/n1 + 1/n2) * ((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2) ) 
    df <- n1+n2-2
  }      
  t <- (m1-m2-m0)/se 
  dat <- c(m1-m2, se, t, 2*pt(-abs(t),df))    
  names(dat) <- c("Difference of means", "Std Error", "t", "p-value")
  return(dat) 
}

set.seed(0)
x1 <- rnorm(90, mean = 8.4, sd = 0.6)
x2 <- rnorm(100, mean = 8.5, sd = 0.5)
(tt2 <- t.test2(mean(x1), mean(x2), sd(x1), sd(x2), length(x1), length(x2)))

#METHOD TWO

(tt <- t.test(x1, x2))

#pvalue is 0.267. This is greater than 0.05 so we cannot 
#conclude that there is a significant difference in mean time 
#to completion of medical school between women and men.

####PART TWO - B

#z=pnorm(x,mean,std dev)
(z=pnorm(85,75,8)) #P(Z<85)
(x=1-z) #P(Z>85)=1-P(Z<85)

#There is a 10.5% probability that a randomly selected
#woman will have a pulse over 85.

####PART THREE

#two-sided 95% confidence interval for mu

#install.packages("TeachingDemos")
library(TeachingDemos)
IQ=c(121,98,95,94,102,106,112,120,108,109)
boxplot(IQ)
qnorm(0.05,lower.tail=F)

z.test(IQ,mu=100,stdev=sqrt(102),alt="g") #To test H0:mu=100 ag. H1:mu>100, 
                                          #where population SD is known

#Since p-value < 0.05, we reject H0 and conclude that the 
#IQ of the students have improved significantly after the 
#special training.

t.test(IQ,mu=100,alt="g") # To test H0:mu=100 ag. H1:mu>100, 
                          # where population SD is unknown

#Since p-value < 0.05, we reject H0 and conclude that the IQ 
#of the students have improved significantly after the special training.

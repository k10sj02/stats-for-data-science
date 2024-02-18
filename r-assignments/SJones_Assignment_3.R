
#create vector of weight gain from group 1

hi_pro <- c(134,146,104,119,124,161,107,83,113,129,97,12)
mean(hi_pro)
sd(hi_pro)

#create vector of weight gain from group 2

lo_pro <- c(70,118,101,85,107,132,94)
mean(lo_pro)
sd(lo_pro)

#perform two sample t-test

t.test(hi_pro, lo_pro, var.equal = TRUE, alternative = "two.sided")

#initialize MASS and immer
library(MASS)
View(immer)

data("immer", package = "MASS")
head(immer, 3)

#check for normality - despite the fact that we are assuming
#normality, the data sample did show negative/leftward skew

boxplot(immer$Y1, immer$Y2)

hist(immer$Y1) #left skew
hist(immer$Y2) #slight left skew

shapiro.test(immer$Y1) #skew confirmed by Shapiro test
shapiro.test(immer$Y2) #no skew based on Shapiro test

plot(immer$Y1,immer$Y2)
abline(a=0, b=1) #Draw Line with Intercept & Slope Using abline Function

#H0: Mean difference is 0. 
#H1: Mean difference is not 0.
#two-sided t-test

ttest <- t.test(immer$Y1, immer$Y2,
       alternative = "two.sided",
       mu = 0, 
       paired = TRUE,   
       var.equal = TRUE,
       conf.level = 0.95)
ttest
names(ttest)

#store p-value 

pvalue <- c(names(ttest)[3], ttest$p.value)
pvalue

#store statistic 

st <- c(names(ttest)[1], ttest$statistic)
st

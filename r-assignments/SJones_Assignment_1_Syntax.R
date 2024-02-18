#Find working directory
getwd()

#Install and initialize packages 
##install.packages("readr")
library(readr)

##install.packages("xlsx")
library(xlsx)

##install.packages("readxl")
library(readxl)

library(tidyverse)

#Load and name the dataset
data_assignment1 <- read_xlsx("~/Downloads/Assignment_1_Data.xlsx")
View(data_assignment1)

#Calculating number of men and women 
sum(data_assignment1$Gender == 'Male')
sum(data_assignment1$Gender == 'Female')

#Average Age 
mean(data_assignment1$Age)

#Counting number of grad and undergrad students 

sum(data_assignment1$`Student Status` == 'Graduate')
sum(data_assignment1$`Student Status` == 'Undergraduate')

mean(data_assignment1$SAT)


aggregate(x = data_assignment1$SAT,                # Specify data column
          by = list(data_assignment1$`Student Status`),              # Specify group indicator
          FUN = mean)                           # Specify function (i.e. mean)

aggregate(x = data_assignment1$`Newspaper readership (times/wk)`,                # Specify data column
          by = list(data_assignment1$Gender),              # Specify group indicator
          FUN = mean)                           # Specify function (i.e. mean)

summary(data_assignment1)


Age <- c(22, 25, 18, 20)
Age
Name <- c("James", "Mathew", "Olivia", "Stella") 
Name
Gender <- c("M", "M", "F", "F")
Gender

combined <- data.frame(Age, Name, Gender)
combined
combined[combined$Gender=="M", ]

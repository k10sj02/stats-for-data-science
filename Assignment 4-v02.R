# The datasets package needs to be loaded to access our data 
# For a full list of these datasets, type library(help = "datasets")
#library(dplyr)
#library(caret)
#library(datasets)
#save to dataset to new object 
ir_data<- iris
summary(ir_data)
#View(ir_data)

#print number of columns and rows
dim(ir_data)

## there are 5 columns and 150 rows

#count species
str(ir_data)

##there are three species
                    
 # Create random training, validation, and test sets
 
 # Set some input variables to define the splitting.
 # Input 1. The data frame that you want to split into training, validation, and test.
 ir_data <- iris
 
 # Input 2. Set the fractions of the dataframe you want to split into training, 
 # validation, and test.
 fractionTraining   <- 0.60
 fractionValidation <- 0.20
 fractionTest       <- 0.20
 
 # Compute sample sizes.
 sampleSizeTraining   <- floor(fractionTraining   * nrow(ir_data))
 sampleSizeValidation <- floor(fractionValidation * nrow(ir_data))
 sampleSizeTest       <- floor(fractionTest       * nrow(ir_data))
 
 # Create the randomly-sampled indices for the dataframe. Use setdiff() to
 # avoid overlapping subsets of indices.
 indicesTraining    <- sort(sample(seq_len(nrow(ir_data)), size=sampleSizeTraining))
 indicesNotTraining <- setdiff(seq_len(nrow(ir_data)), indicesTraining)
 indicesValidation  <- sort(sample(indicesNotTraining, size=sampleSizeValidation))
 indicesTest        <- setdiff(indicesNotTraining, indicesValidation)
 
 # Finally, output the three dataframes for training, validation and test.
 dfTraining   <- ir_data[indicesTraining, ]
 dfValidation <- ir_data[indicesValidation, ]
 dfTest       <- ir_data[indicesTest, ]
 
 str(dfTraining)
 str(dfValidation)
 str(dfTest)
 
 #The test and validation datasets have 30 observations respectively. 
 #The training dataset has 90 observations.
 
 data.frame(table(dfTraining$Species))
 #there are 27 cases of setosa, 34 cases of versicolor 
 #and 29 cases of virginica in the training dataset

 summary(dfValidation)
 data.frame(table(dfValidation$Species))
 
 #there are 11 cases of setosa, 8 cases of versicolor 
 #and 11 cases of virginica in the validation dataset
 
 summary(dfTest)
 data.frame(table(dfTest$Species))
 
 #there are 12 cases of setosa, 8 cases of versicolor 
 #and 10 cases of virginica in the test dataset
 
#data partitioning using caret package 

library(caret)
summary(ir_data$Species)
ir_data$Species <- as.factor(ir_data$Species)
str(ir_data)
set.seed(1)
#create training dataset
myIndex <- createDataPartition(ir_data$Species, p = 0.66, list = FALSE)
head(myIndex)
trainSet <- ir_data[myIndex, ]
head(trainSet)
summary(trainSet)

#creating validation dataset
validationSet <- ir_data[-myIndex, ]
head(validationSet)
summary(validationSet)
summary(trainSet)

str(validationSet)
str(trainSet)

#The validation dataset has 60 observations while the training set has 90 observations.

data.frame(table(trainSet$Species))

#there are 30 cases of setosa, 30 cases of versicolor 
#and 30 cases of virginica in the training dataset

data.frame(table(validationSet$Species))

#there are 20 cases of setosa, 20 cases of versicolor 
#and 20 cases of virginica in the training dataset

##BUSINESS OPTIMIZATION CASE

#install.packages("lpSolveAPI")
library(lpSolveAPI)

##Let’s try to solve the problem again using lpSolveAPI:
        
# Set 0 constraints and 2 decision variables
# Constraints are added later
lprec <- make.lp(nrow=0, ncol=2) #WHY????
# Set the type of problem we are trying to solve
lp.control(lprec, sense="max")

# Set objective function coefficients vector C
set.objfn(lprec, c(600,300))

# Add constraints

# x >= 1000 (minimum of 1000 laptops required)
add.constraint(lprec, c(1, 0), ">=", 1000) 
# x <= 2000 (maximum of 2000 laptops required)
add.constraint(lprec, c(1, 0), "<=", 2000) 
# y >= 800 (minimum of 800 laptops required)
add.constraint(lprec, c(0, 1), ">=", 800)
# y <= 1700 (maximum of 1700 desktops required)
add.constraint(lprec, c(0, 1), "<=", 1700)
# x + y <=2000: Contractual agreements
add.constraint(lprec, c(1, 1), "<=", 2000)
#x >= 0: Non-negative restrictions 
add.constraint(lprec, c(1, 0), ">=", 0)
#y >= 0: Non-negative restrictions 
add.constraint(lprec, c(0, 1), ">=", 0)
# Set type of decision variables
set.type(lprec, 1:2, type=c("integer"))
# Let's have a look at the LP problem that we have defined
lprec
# Solve problem
solve(lprec)
# Getting the optimized profit value
get.objective(lprec)
# Finally get the value for how many computers and desktops need to be produced
get.variables(lprec)
# Note that the default boundaries on the decision variable are c(0, 0, 0) and c(Inf, Inf, Inf)
get.bounds(lprec)
# Boundaries can be set with following function
lpSolveAPI::set.bounds(lprec)

#Thus, to achieve the maximum profit ($960,000), 
#the factory should produce 1200 laptops and 800 desktops per day.

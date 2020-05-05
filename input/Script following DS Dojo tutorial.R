setwd("~/OneDrive/Additional Courses/Titanic02/input")

titanic.train <- read.csv(file = "train.csv", stringsAsFactors = FALSE, header = TRUE)
titanic.test <- read.csv(file = "test.csv", stringsAsFactors = FALSE, header = TRUE)

# combine files to clean; Boolean and line up
titanic.train$IsTrainSet <- TRUE
titanic.test$IsTrainSet <- FALSE

titanic.test$Survived <- NA

titanic.full <- rbind(titanic.train, titanic.test)

#str(titanic.full)
# gives the structure of the set

# cleaning data 11:48

titanic.full[titanic.full$Embarked == "","Embarked"] <- "S" # replacing no embarked with the mode, "S"

age.median <- median(titanic.full$Age, na.rm = TRUE)
titanic.full[is.na(titanic.full$Age), "Age"] <- age.median

fare.median <- median(titanic.full$Fare, na.rm = TRUE)
titanic.full[is.na(titanic.full$Fare), "Fare"] <- fare.median

# categorical casting
titanic.full$Pclass <- as.factor(titanic.full$Pclass)
titanic.full$Sex <- as.factor(titanic.full$Sex)
titanic.full$Embarked <- as.factor(titanic.full$Embarked)


# data clean and categorized, may be split back

titanic.train<-titanic.full[titanic.full$IsTrainSet == TRUE,]
titanic.test<-titanic.full[!titanic.full$IsTrainSet == TRUE,]

# need to categorize this as well, to make the prediction 
titanic.train$Survived <- as.factor(titanic.train$Survived)

# formula for prediction
survived.equation <- "Survived ~ Pclass + Sex + Age + SibSp + Parch" 
survived.formula <- as.formula(survived.equation)
install.packages("randomForest")
library(randomForest)

#tutorial skipped 70/30 split and cross validation. This model is no good.

randomForest(formula = survided.formula, data = titanic.train)


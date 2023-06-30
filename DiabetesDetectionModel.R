rm(list= ls())

# Load the required libraries
library(caret)
# Read the Diabetes dataset from UCI repository
#url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data"

#Or read the data already saved on your PC
diabetes_data <- read.csv("diabetes.csv", header = T)


# Preprocess the dataset
diabetes_data$Outcome <- factor(diabetes_data$Outcome)
diabetes_data[,"Glucose"] <- ifelse(diabetes_data[,"Glucose"]==0, NA, diabetes_data[,"Glucose"])
diabetes_data[,"BloodPressure"] <- ifelse(diabetes_data[,"BloodPressure"]==0, NA, diabetes_data[,"BloodPressure"])
diabetes_data[,"SkinThickness"] <- ifelse(diabetes_data[,"SkinThickness"]==0, NA, diabetes_data[,"SkinThickness"])
diabetes_data[,"Insulin"] <- ifelse(diabetes_data[,"Insulin"]==0, NA, diabetes_data[,"Insulin"])
diabetes_data[,"BMI"] <- ifelse(diabetes_data[,"BMI"]==0, NA, diabetes_data[,"BMI"])
diabetes_data <- na.omit(diabetes_data)

# Split the dataset into training and testing sets
set.seed(73)
train_indices <- createDataPartition(diabetes_data$Outcome, p = 0.7, list = FALSE)
train_data <- diabetes_data[train_indices, ]
test_data <- diabetes_data[-train_indices, ]

# Build the predictive model using logistic regression
model <- train(Outcome ~ ., data = train_data, method = "glm", family = "binomial")

# Make predictions on the test set
predictions <- predict(model, newdata = test_data)

# Evaluate the model
confusionMatrix(predictions, test_data$Outcome)


This project was done to get a better understanding of the topic by doing the work practically. So, there might be mistakes or misinterpretations. Feel free to point them out. Thank you!
## Diabetes Detection Model


### 1. Packages

```{r eval =TRUE, warning = FALSE, message = FALSE}
library(caret)
```

### 2. Data Description

This project uses the Pima Indians Diabetes problem taken from Machine Learning Repository UCI: https://archive.ics.uci.edu/ml/datasets/pima+indians+diabetes This problem is comprised of 768 observations of medical details for Pima Indian Patients.


#### 2.1 Loading Data

```{r comment = ""}
#Read the Diabetes dataset from UCI repository
#url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data"

#Or read the data already saved on your PC
diabetes_data <- read.csv("diabetes.csv", header = T)
```
##### 2.1.1 Preprocessing the data
```{r}
diabetes_data$Outcome <- factor(diabetes_data$Outcome)
diabetes_data[,"Glucose"] <- ifelse(diabetes_data[,"Glucose"]==0, NA, diabetes_data[,"Glucose"])
diabetes_data[,"BloodPressure"] <- ifelse(diabetes_data[,"BloodPressure"]==0, NA, diabetes_data[,"BloodPressure"])
diabetes_data[,"SkinThickness"] <- ifelse(diabetes_data[,"SkinThickness"]==0, NA, diabetes_data[,"SkinThickness"])
diabetes_data[,"Insulin"] <- ifelse(diabetes_data[,"Insulin"]==0, NA, diabetes_data[,"Insulin"])
diabetes_data[,"BMI"] <- ifelse(diabetes_data[,"BMI"]==0, NA, diabetes_data[,"BMI"])
diabetes_data <- na.omit(diabetes_data)

```
### 3. Modeling
#### 3.1 Split the dataset into training and testing sets
```{r}
set.seed(73)
train_indices <- createDataPartition(diabetes_data$Outcome, p = 0.7, list = FALSE)
train_data <- diabetes_data[train_indices, ]
test_data <- diabetes_data[-train_indices, ]
```
#### 3.2 Logistic Model
```{r}
model <- train(Outcome ~ ., data = train_data, method = "glm", family = "binomial")
predictions <- predict(model, newdata = test_data)

```
#### 3.3 Confusion Matrix
```{r comment ="" }
confusionMatrix(predictions, test_data$Outcome)
```
```
Confusion Matrix and Statistics

          Reference
Prediction  0  1
         0 67 11
         1 11 28
                                          
               Accuracy : 0.812           
                 95% CI : (0.7293, 0.8782)
    No Information Rate : 0.6667          
    P-Value [Acc > NIR] : 0.0003634       
                                          
                  Kappa : 0.5769          
                                          
 Mcnemar's Test P-Value : 1.0000000       
                                          
            Sensitivity : 0.8590          
            Specificity : 0.7179          
         Pos Pred Value : 0.8590          
         Neg Pred Value : 0.7179          
             Prevalence : 0.6667          
         Detection Rate : 0.5726          
   Detection Prevalence : 0.6667          
      Balanced Accuracy : 0.7885          
                                          
       'Positive' Class : 0               

```
Interpretation of the result of the Confusion Matrix-

**Accuracy:**
Accuracy measures the overall correctness of the model's predictions.
It is calculated as the proportion of correct predictions to the total number of instances.
Here accuracy is 0.812, indicating that the model achieved an accuracy of 81.2%. 

**95% Confidence Interval (CI):**
The 95% confidence interval is (0.7293, 0.8782) means that we can be 95% confident that the true accuracy lies within this interval.

**No Information Rate (NIR):**
The no information rate represents the accuracy achieved by a naive model that always predicts the most prevalent class.
In this case, the no information rate is 0.6667, indicating that if we always predicted class 0 (the most prevalent class),
we would achieve an accuracy of 66.7%.

**Kappa:**
Kappa is a statistic that measures the agreement between the predicted and actual classes,
considering the agreement that could be expected by chance alone. A kappa value of 0.5769 suggests a moderate level of agreement beyond chance.

**Sensitivity, Specificity, Positive Predictive Value, Negative Predictive Value:**
These measure the model's performance in terms of correctly identifying positive and negative instances.

Sensitivity represents the proportion of actual positive instances correctly predicted as positive (0.8590).
Specificity is the proportion of actual negative instances correctly predicted as negative (0.7179).
Positive Predictive Value (PPV) is the proportion of predicted positive instances that are actually positive (0.8590),
and Negative Predictive Value (NPV) is the proportion of predicted negative instances that are actually negative (0.7179).

**Prevalence, Detection Rate, Detection Prevalence:**
Prevalence refers to the proportion of instances belonging to the positive class (0.6667).
Detection Rate is the proportion of actual positive instances correctly identified as positive (0.5726),
and Detection Prevalence is the proportion of instances predicted as positive (0.6667).

**Balanced Accuracy:**
Balanced Accuracy is the average of sensitivity and specificity and provides an overall measure of classification performance.
Here the balanced accuracy is 0.7885.

**'Positive' Class:**
The label 'Positive' refers to class 0 in this context.

Overall, the results indicate that the model achieved relatively good accuracy,
with better sensitivity (ability to detect positive instances) than specificity (ability to detect negative instances).
However, further analysis and consideration of the specific context and requirements are needed to fully interpret the performance and determine the suitability of the model.





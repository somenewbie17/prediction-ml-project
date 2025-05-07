# Prediction Assignment R Script

library(caret)
library(randomForest)

# Load data
training <- read.csv("pml-training.csv", na.strings=c("NA", "", "#DIV/0!"))
testing <- read.csv("pml-testing.csv", na.strings=c("NA", "", "#DIV/0!"))

# Clean data
training <- training[, colSums(is.na(training)) == 0]
training <- training[, -(1:7)]
training$classe <- as.factor(training$classe)

# Partition data
set.seed(1234)
inTrain <- createDataPartition(training$classe, p=0.7, list=FALSE)
training_set <- training[inTrain,]
testing_set <- training[-inTrain,]

# Train model
set.seed(1234)
model_rf <- train(classe ~ ., data=training_set, method="rf")

# Predict
predictions <- predict(model_rf, testing_set)
confusionMatrix(predictions, testing_set$classe)

# Final prediction
final_predictions <- predict(model_rf, testing)
final_predictions


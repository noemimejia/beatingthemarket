#Artificial Neural Network
library(neuralnet)
f <- as.formula(`Next Close` ~ Open + High + Low + Close)
ann_ <- neuralnet(f, train_, hidden= c(50,50), threshold = 0.01, err.fct = "sse", act.fct = "logistic", linear.output = F)
predicted.nn <- compute(ann_,test_[,c("Open", "High", "Low", "Close")])
df2 <- as.numeric(data[,5])
predicted.nn_ <- predicted.nn$net.result

#Support Vector Machine
library(e1071)
f <- as.formula(`Next Close` ~ Open*High*Low*Close)
svm_ <- svm(f, train_)
predictedtraining <- predict(svm_, train_)
predictedtest <- predict(svm_, test_)
finetuned <- tune(svm, f, data=test_, ranges=list(epsilon=seq(0,1,0.1)))
bestfit <- finetuned$best.model
predictedtest2 <- predict(bestfit, test_)

#Sentiment Analysis
library(randomForest)
library(e1071)
formula <- as.formula(`Next Close` ~ score*Close)
sa_ <- randomForest(formula, train_)
predicted <- predict(sa_, test_)
bestpredicted <- tuneRF(test_, predicted, doBest = TRUE)
predicted_ <- bestpredicted$predicted

#Artificial Neural Network - Sentiment Analysis
library(neuralnet)
f <- as.formula(`Next Close` ~ Open + High + Low + Close + Score)
ann_ <- neuralnet(f, train_, hidden= c(50,50), threshold = 0.01, err.fct = "sse", act.fct = "logistic", linear.output = F)
predicted.nn <- compute(ann_,test_[,c("Open", "High", "Low", "Close", "Score")])
df2 <- as.numeric(data[,5])
predicted.nn_ <- predicted.nn$net.result

#Support Vector Machine - Sentiment Analysis
library(e1071)
f <- as.formula(`Next Close` ~ Open*High*Low*Close*Score)
svm_ <- svm(f, train_)
predictedtraining <- predict(svm_, train_)
predictedtest <- predict(svm_, test_)
finetuned <- tune(svm, f, data=test_, ranges=list(epsilon=seq(0,1,0.1)))
bestfit <- finetuned$best.model
predictedtest2 <- predict(bestfit, test_)

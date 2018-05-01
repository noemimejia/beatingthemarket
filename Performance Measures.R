library (readxl)
library(MLmetrics)

#MSE and Rsquared
all <- read_excel("Data/ALL.xlsx")
actual <- all$Actual
ann <- all$ANN
MSE(ann, actual)
R2_Score(ann, actual)
annsa <- all$`ANN-SA`
MSE(annsa, actual)
R2_Score(annsa, actual)
svm <- all$SVM
MSE(svm, actual)
R2_Score(svm, actual)
svmsa <- all$`SVM-SA`
MSE(svmsa, actual)
R2_Score(svmsa, actual)
sa <- all$SA
MSE(sa, actual)
R2_Score(sa, actual)

#Directional Accuracy
upordown <- matrix(ncol = 6, nrow = length(actual))
colnames(upordown) <- c("Actual", "ANN", "SVM", "SA", "ANN-SA", "SVM-SA")
for(i in 2:length(actual)-1)
{
  if ((actual[i+1] - ann[i]) > 0)
  {upordown[i+1,1] = "Up"} else 
    upordown[i+1,1] = "Down"
}
for(i in 2:length(actual)-1)
{
  if ((ann[i+1] - ann[i]) > 0)
  {upordown[i+1,2] = "Up"} else 
    upordown[i+1,2] = "Down"
}
correct = 0
for(i in 2:nrow(upordown))
{
  if (upordown[i,1] == upordown[i,2])
  {correct = correct + 1}
}
directionalaccuracy = correct/(length(ann) - 1)
directionalaccuracy

for(i in 2:length(actual)-1)
{
  if ((svm[i+1] - svm[i]) > 0)
  {upordown[i+1,3] = "Up"} else 
    upordown[i+1,3] = "Down"
}
correct = 0
for(i in 2:nrow(upordown))
{
  if (upordown[i,1] == upordown[i,3])
  {correct = correct + 1}
}
directionalaccuracy = correct/(length(svm) - 1)
directionalaccuracy

for(i in 2:length(actual)-1)
{
  if ((sa[i+1] - sa[i]) > 0)
  {upordown[i+1,4] = "Up"} else 
    upordown[i+1,4] = "Down"
}
correct = 0
for(i in 2:nrow(upordown))
{
  if (upordown[i,1] == upordown[i,4])
  {correct = correct + 1}
}
directionalaccuracy = correct/(length(sa) - 1)
directionalaccuracy

for(i in 2:length(actual)-1)
{
  if ((annsa[i+1] - annsa[i]) > 0)
  {upordown[i+1,5] = "Up"} else 
    upordown[i+1,5] = "Down"
}
correct = 0
for(i in 2:nrow(upordown))
{
  if (upordown[i,1] == upordown[i,5])
  {correct = correct + 1}
}
directionalaccuracy = correct/(length(annsa) - 1)
directionalaccuracy

for(i in 2:length(actual)-1)
{
  if ((svmsa[i+1] - svmsa[i]) > 0)
  {upordown[i+1,6] = "Up"} else 
    upordown[i+1,6] = "Down"
}
correct = 0
for(i in 2:nrow(upordown))
{
  if (upordown[i,1] == upordown[i,6])
  {correct = correct + 1}
}
directionalaccuracy = correct/(length(svmsa) - 1)
directionalaccuracy

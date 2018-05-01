library('readxl')
set.seed(500)
PSEI <- read_excel("C:/Users/Noemi Mejia/Documents/4TH YEAR/RESEARCH DUMP/Data/PSEI.xlsx")

dates <- as.Date(PSEI$Date, "%Y-%m-%d")
dates <- as.data.frame.Date(dates)
data <- data.matrix(PSEI[2:6])
n <- nrow(data)
train_index <- 1:round(0.70*n)
test_index <- (round(0.70*n) + 1):n

#Scaling the Data
maxs <- apply(data, 2, max)    
mins <- apply(data, 2, min)
df <- scale(data, center = mins, scale = maxs - mins)

#Splitting into 70/30
train_ <- df[train_index,]
train_ <- as.data.frame(train_)
test_ <- df[test_index,]
test_ <- as.data.frame(test_)
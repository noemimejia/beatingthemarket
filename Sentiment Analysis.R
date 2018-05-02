library(tidyverse)      
library(stringr)        
library(tidytext)       
library(readxl)
library(xlsx)

scores <- matrix(ncol = 2)
temp <- matrix(nrow = 1, ncol = 2)
datetoday <- ""

for (year in 2012:2017)
{
	for (month in 1:12)
	{
		month = 11
		year = 2017
		for (day in 1:15)
		{
		  dd_ <- day
		  mm <- month
		  yy <- year
		  #Open file
      day <- read_excel(paste("Data/News/", year, "/", month, "-", day, "-", year, ".xlsx", sep = ""))
      #Store news articles in a data frame
      text_tb <- tibble(text = day$X3)
      
      summary <- tibble()
      n = nrow(day)
      
      for(i in 1:n) 
      {
        #Tokenize articles into words
        clean <- text_tb[i,] %>% unnest_tokens(word, text) 
        #Put all tokenized articles in one column in a new data frame
        summary <- rbind(summary, clean)
      }
      #Remove all stop words from the data frame
      cleanedsummary <- anti_join(summary, stop_words)
      
      #Gets all words with corresponding sentiment and scores regardless of repetition/frequency
      sentiment <- inner_join(cleanedsummary, get_sentiments("afinn"))
      
      #Sums up all the scores to get the overall sentiment for one day
      overallsentiment <- sum(sentiment$score)
      
      datetoday <- paste(mm, "-", dd_, "-", yy, sep = "")
      datetoday <- as.character(datetoday)
      temp[1,1] <- datetoday
      temp[1,2] <- overallsentiment
      scores <- rbind(scores, temp)
		}
	}
  write.xlsx(scores, paste("Data/Sentiment Score/", year, ".xlsx", sep = ""))
}

aggregate <- matrix(ncol = 3)
tablelabel <- c("number", "date", "score")
colnames(aggregate) <- tablelabel
for (year in 2012:2017)
{
  scores <- read_excel(paste("Data/Sentiment Score/", year, ".xlsx", sep = ""))
  colnames(scores) <- tablelabel
  aggregate <- rbind(aggregate, scores)
}
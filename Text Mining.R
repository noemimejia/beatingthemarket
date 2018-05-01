library('rvest')
library('RCurl')
library('XML')
library('xlsx')
library('readxl')

#collect URLs of articles from article index

links <- matrix(nrow = webpagelength - 756, ncol = 1)

for (year in 2012:2017)
{
  for (month in 1:12)
  {
    if (month == 2)
    {dd = 28} else 
      if (month == 1 | 3 | 5 | 7 | 8 | 10 | 12)
      {
        dd = 31
      } else
      {
        dd = 30
      } 
    for (day in 1:dd)
    {
      url <- paste('http://www.inquirer.net/article-index?d=', year, '-', month, '-',day, sep = "")
      
      #Reading the HTML code from the website
      
      webpage <- readLines(url)
      
      #Get URL
      
      webpagelength <- length(webpage)
      
      #Save links in a matrix
      
      links <- webpage[756:webpagelength]
      
      #Save matrix into an Excel file
      
      write.xlsx(links, paste("Data/Links/", month, '-', day, '-', year, ".xlsx", sep = ""))
      
    }
  }
}

#Cleaning data to get only the URLs

for (year in 2012:2017)
{
  
  for (month in 1:12)
  {
    if (month == 2)
    {dd = 28} else 
      if (month == 1 | 3 | 5 | 7 | 8 | 10 | 12)
      {
        dd = 31
      } else
      {
        dd = 30
      } 
    for (day in 1:dd)
    {
      links <- read_excel(paste("Data/Links/", year, "/", month, "-", day, "-", year, ".xlsx", sep = ""))
      links <- na.omit(links)
      write.xlsx(links, paste("Data/Links/", year, "/", month, "-", day, "-", year, ".xlsx", sep = ""))
      
    }
    
    tablelength <- nrow(links)
    lastlinkindex = which(grepl("div class=", links2$x))
    for (i in 1:tablelength)
    {
      if (grepl("http://", links[i,2]) == 0)
      {
        links[i,2] <- NA
      }
    }
    links <- na.omit(links)
    tablelength <- nrow(links)
    for (i in 1:tablelength)
    {
      links[i,2] <- gsub('.*a href=', '', links[i,2])
      links[i,2] <- gsub('rel.*', '', links[i,2])
      links[i,2] <- gsub('rel', '', links[i,2])
    }
    tablelength <- nrow(links)
    for (i in 1:tablelength)
    {
      if (grepl("<", links[i,2]) > 0)
      {
        links[i,2] <- NA
      }
    }
    write.xlsx(links, paste("Links/", year, "/", month, "-", day, "-", year, ".xlsx", sep = ""))
    
  }
}

#Article extraction

for (year in 2012:2017)
{
  year = 2017
  for (month in 10:12)
  {
    if (month == 2)
    {dd = 28} else 
      if (month == 1 | 3 | 5 | 7 | 8 | 10 | 12)
      {
        dd = 31
      } else
      {
        dd = 30
      } 
    for (day in 1:dd) 
    {
      file <- read_excel(paste("Links/", year, "/", month, "-", day, "-", year, ".xlsx", sep = ""))
      n = nrow(file)
      print(paste("Total: ", n, sep = ""))
      data <- matrix(nrow = n, ncol = 3)
      for (row in 1:n)
      {
        url <- file[row, 4]
        lengthofchar <- nchar(url, type = "char")
        url <- substr(url, 2, lengthofchar - 1)
        download.file(url, destfile = "scrapedpage.html", quiet=TRUE)
        content <- read_html("scrapedpage.html")
        #Reading the HTML code from the website
        webpage <- read_html(url)
        
        #Get Title
        title <- html_nodes(webpage,'.entry-title')
        title_ <- html_text(title)
        data[row, 1] <- title_[1]
        
        #Get Date
        datepublished <- html_nodes(webpage,'#art_plat')
        datepublished_ <- html_text(datepublished)
        data[row, 2] <- datepublished_
        
        #Get Article
        article <- html_nodes(webpage,'p')
        article_ <- html_text(article)
        article_ <- toString(article_)
        data[row, 3] <- article_
      }
      write.xlsx(data, paste("C:/Users/Noemi Mejia/Documents/4TH YEAR/RESEARCH DUMP/Data/News/", year, "/", month, "-", day, "-", year, ".xlsx", sep = ""))
    }                                                                    
  }
}
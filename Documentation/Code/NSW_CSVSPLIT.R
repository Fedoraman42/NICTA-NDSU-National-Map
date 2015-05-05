# Name: NSW_CSVSPLIT
# Creation Date: 3/10/2015
# Author: Sean Luthjohn
# Description: Splits the csv based on a keyword in the file. The purpose is to help us get visualizations set up
# specifically for one survey type. After the split is done each survey is written out to a file with the survey name.


data <- read.csv(file = "C:/Users/Sean/Google Drive/NICTA Capstone/NSW_DATA/NSWComplete.csv", header = F, fill = T)
keyWords = list()

keyWordsPortion = c()

skip = 4
index = 1
size = 1
i <- 1
x <- 0
for (type in data$V1)
{
  if (i > skip)
  {
    if(type != "")
    {
    size <- 1
    x <- x + 1
    keyWords[x] <- type
    }
    else
    {
      size <- size + 1
      keyWordsPortion[x] <-  size
    }
    
  }
  i <- i + 1
}

ii <- 1
for (row in 1:dim(data)[1])
{
  if (data[row, 1] %in% keyWords)
  {
    break
  }
  ii <- ii + 1
}
xx <- 1
y <- 1
df <- data.frame()

for (row in ii:dim(data)[1])
{
  print(keyWords[y])
  
  if(xx <= keyWordsPortion[y])
  {
    df <- rbind(data[row, ], df)
    print(xx)
    xx <- xx + 1
  }
  else
  {    
    data$V1 <- NULL
    df$V1 <- NULL
    df <- rbind(data[skip, ], df)
    df = t(df)
    colnames(df) = df[1, ]
    df = df[-1, ]
    write.csv(df, file = paste("C:/Users/Sean/Google Drive/NICTA Capstone/NSW_DATA/", keyWords[y], ".csv", sep=""), row.names = F)
    y <- y + 1
    df <- data.frame()
    
    #bind next row so it's not skipped for the next section
    #increment xx by 1 so each section handles the correct portion
    xx  <- 2
    df <- rbind(data[row, ], df)
  }
  
  
  if(row == dim(data)[1])
  {
    data$V1 <- NULL
    df$V1 <- NULL
    df <- rbind(data[skip, ], df)
    df = t(df)
    colnames(df) = df[1, ]
    df = df[-1, ]
    write.csv(df, file = paste("C:/Users/Sean/Google Drive/NICTA Capstone/NSW_DATA/", keyWords[y], ".csv", sep = ""), row.names = F)
  }
  
  
}

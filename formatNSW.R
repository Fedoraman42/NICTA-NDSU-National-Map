#Name: formatScript
#Creation Date: 3/10/2015
#Author: Sean Lutjohn
#Description: Formats the NSW data file so it can be joined to the dataset that has coordinates
# Compares each LGA with the LGA's in the formatted file and if its a match, the unformatted file takes the 
# name of the formatted file.

data<- read.csv("LGAComplete.csv",fill = T,header = T)
data <- t(data)
joinD <- read.csv("Australia.csv", fill =T, header = T)
joinD$LGA_NAME11 <- as.character(joinD$LGA_NAME11)

row <-1
xx <-1

for(row in 3:dim(data)[1])
{
  for(xx in 1:dim(joinD)[1])
  {
    if(data[row,3] == substring(joinD[xx,2],1,nchar(joinD[xx,2])-4))
    {
      data[row,3] <- joinD[xx,2]
    }
  }
}
data = data[-1,]
data = data[, -1:-2]

write.table(data, file = "NSW.csv",row.names=FALSE,col.names = FALSE,sep = ',')


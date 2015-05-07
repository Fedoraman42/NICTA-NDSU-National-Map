# Name: formatScript
# Creation Date: 3/10/2015
# Author: Sean Luthjohn
# Description: Formats the NSW data file so it can be joined to the dataset that has coordinates
# Compares each LGA with the LGA's in the formatted file and if it's a match, the unformatted file takes the 
# name of the formatted file.

data 				<- read.csv ( "C:/Users/Sean/Documents/GitHub/NICTA-NDSU-National-Map/Raw Data/LGAData - Complete.csv", fill = T, header = T )
data 				<- t ( data )
joinD 				<- read.csv( "C:/Users/Sean/Desktop/joinTo.csv", fill = T, header = T )
joinD$LGA_NAME11 	<- as.character ( joinD$LGA_NAME11 )

row 	<- 1
xx		<- 1

for ( row in 3:dim ( data ) [ 1 ] )
{
	for ( xx in 1:dim ( joinD ) [ 1 ] ) 
	{
		if ( data[ row, 3 ] == substring ( joinD [ xx, 2 ], 1, nchar ( joinD[ xx, 2 ] ) - 4 ) )
		{
			data [ row, 3 ] <- joinD [ xx, 2 ]
		}
	}
}

write.csv ( t ( data ) , file = "C:/Users/Sean/Google Drive/NICTA Capstone/NSW_DATA/NSWComplete.csv", row.names = FALSE)
 
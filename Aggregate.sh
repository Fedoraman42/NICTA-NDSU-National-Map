#!/bin/sh

#Formats the NSW data, removes headers, same structure as the Victoria data
Rscript formatNSW.R

#Build Victoria Tables
sudo -u postgres psql < BuildTables2.sql

#Build NSW Table
sudo -u postgres psql < NSW.sql

#Import Data
sudo -u postgres psql < import.sql

#Calculate Totals
sudo -u postgres psql < VictoriaLGA_Totals_Insert.sql

#Aggregate for Victoria
sudo -u postgres psql < AggregateVictoria.sql

#Export Victoria to CSV
sudo -u postgres psql < Export.sql

#Move file to current directory
cp /tmp/VictoriaFormatted.csv .

#Integrate the tables
sudo -u postgres psql < Integration.sql

#Export to CSV
sudo -u postgres psql < Export_Full.sql

#move file to current directory
cp /tmp/Integrated.csv .


#Not neccesary
#Rscript formatScript.R

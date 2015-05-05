# NICTA-NDSU-National-Map

File ready to be imported to the map

-NSWVIC_Headers.kml


Aggregated Victoria dataset in the format of New South Wales

- Base formatting: NSWComplete.csv

- Victoria aggregated with same formatting: VictoriaFormatted.csv

- Both regions together formatted: Australia.csv


Instructions for building the integrated New South Wales and Victoria Data sets

1. Clone repository

git clone https://github.com/Fedoraman42/NICTA-NDSU-National-Map.git

2. Install Prerequisites
PostgreSQL-9.4
R-Base

apt-get install postgresql-9.4 R-base
- may change based on versions and operating system

3. Run script Aggregate.sh

sudo sh ./Aggregate.sh

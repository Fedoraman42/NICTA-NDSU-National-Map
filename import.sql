\connect victoria

--Import Data
--Update paths before running!!

COPY "VictoriaLGA" FROM '/home/erkrenz/NICTA-NDSU-National-Map/LGA_2007_2011.csv' DELIMITER ',' CSV HEADER;
COPY "H_Vista" FROM '/home/erkrenz/NICTA-NDSU-National-Map/H_VISTA09_v2_AURIN_HTS.csv' DELIMITER ',' CSV HEADER;
COPY "T_Vista" FROM '/home/erkrenz/NICTA-NDSU-National-Map/T_VISTA09_v2_AURIN_HTS.csv' DELIMITER ',' CSV HEADER;
COPY "V_Vista" FROM '/home/erkrenz/NICTA-NDSU-National-Map/V_VISTA09_v2_AURIN_HTS.csv' DELIMITER ',' CSV HEADER;

--NSW
COPY "NewSouthWales" FROM '/home/erkrenz/NICTA-NDSU-National-Map/NSW.csv' DELIMITER ',' CSV HEADER;

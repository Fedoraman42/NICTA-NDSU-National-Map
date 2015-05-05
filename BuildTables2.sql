drop database if exists victoria;
drop role if exists victoria;

-- create the requested sinfonifry user

create user victoria createdb createuser password 'victoria';

-- create a sinfonifry database
create database victoria owner victoria;

GRANT usage on schema public to victoria;

\connect victoria

DROP TABLE IF EXISTS "VictoriaLGA";

CREATE TABLE "VictoriaLGA"
(
  "CODE" character varying(10) NOT NULL,
  "LGA" character varying(30),
  CONSTRAINT "VictoriaLGA_pkey" PRIMARY KEY ("CODE")
)
WITH (
  OIDS = FALSE
);
ALTER TABLE "VictoriaLGA"
  OWNER TO postgres;
  
-- Table: "H_Vista"

DROP TABLE IF EXISTS "H_Vista";

CREATE TABLE "H_Vista"
(
  "HHID" character varying(10) NOT NULL,
  "HHSIZE" numeric(10, 0),
  "VISITORS" numeric(10, 0),
  "HHSTRUCTURE" character varying(11),
  "DWELLTYPE" character varying(9),
  "OWNDWELL" character varying(8),
  "YEARSLIVED" numeric(10, 0),
  "MONTHSLIVED" numeric(10, 0),
  "ADULTBIKES" numeric(10, 0),
  "KIDSBIKES" numeric(10, 0),
  "TOTALBIKES" numeric(10, 0),
  "ADULTBIKESUSED" numeric(10, 0),
  "KIDSBIKESUSED" numeric(10, 0),
  "TOTALBIKESUSED" numeric(10, 0),
  "CARS" numeric(10, 0),
  "FOURWDS" numeric(10, 0),
  "UTES" numeric(10, 0),
  "VANS" numeric(10, 0),
  "TRUCKS" numeric(10, 0),
  "MBIKES" numeric(10, 0),
  "OTHERVEHS" numeric(10, 0),
  "TOTALVEHS" numeric(10, 0),
  "HOMESLA" character varying(9),
  "HOMELGA" character varying(7),
  "ADHHWGT" numeric(10, 2),
  "WDHHWGT" character varying(7),
  "WEHHWGT" character varying(7),
  "HOMEREGION" character varying(10),
  "STATIONPROX" character varying(11),
  "DAY_TYPE" character varying(5),
  "SURVEY_PERIOD" character varying(13),
  "HHINC_QUINTILE" character varying(14),
  CONSTRAINT "H_Vista_pkey" PRIMARY KEY ("HHID")
)
WITH (
  OIDS = FALSE
);
ALTER TABLE "H_Vista"
  OWNER TO postgres;
  
-- Table: "V_Vista"

DROP TABLE IF EXISTS "V_Vista";

CREATE TABLE "V_Vista"
(
  "HHID" character varying(10),
  "VEHID" character varying(20) NOT NULL,
  "VEHNO" character varying(5),
  "VEHTYPE" character varying(7),
  "VEHYEAR" character varying(7),
  "PETROL" character varying(6),
  "DIESEL" character varying(6),
  "GAS" character varying(3),
  "ELECTRIC" character varying(8),
  "CYLINDERS" character varying(9),
  "RUNNINGCOST" character varying(12),
  "ADHHWGT" numeric(10, 2),
  "WDHHWGT" numeric(10, 2),
  "WEHHWGT" numeric(10, 2),
  CONSTRAINT "V_Vista_pkey" PRIMARY KEY ("VEHID")
)
WITH (
  OIDS = FALSE
);
ALTER TABLE "V_Vista"
  OWNER TO postgres;

-- Table: "T_Vista"

DROP TABLE IF EXISTS "T_Vista";

CREATE TABLE "T_Vista"
(
  "HHID" character varying(10) NOT NULL,
  "PERSID" character varying(13) NOT NULL,
  "TRIPID" character varying(16) NOT NULL,
  "TRIPNO" character varying(10),
  "STARTHOUR" character varying(9),
  "STARTTIME" character varying(9),
  "ORIGLGA" character varying(7),
  "ORIGPLACE1" character varying(10),
  "ORIGPLACE2" character varying(10),
  "ORIGPURP1" numeric(10,0),
  "ORIGPURP2" numeric(10,0),
  "ARRHOUR" character varying(7),
  "ARRTIME" character varying(7),
  "DESTLGA" character varying(7),
  "DESTPLACE1" character varying(10),
  "DESTPLACE2" character varying(10),
  "DESTPURP1" numeric(10, 0),
  "DESTPURP2" numeric(10, 0),
  "CUMDIST" numeric(10, 0),
  "DEPHOUR" character varying(7),
  "DEPTIME" character varying(7),
  "LINKMODE" character varying(8),
  "TRIPTIME" numeric(10, 0),
  "TRAVTIME" character varying(8),
  "WAITIME" character varying(7),
  "DURATION" character varying(8),
  "MODE1" character varying(5),
  "MODE2" character varying(5),
  "MODE3" character varying(5),
  "MODE4" character varying(5),
  "MODE5" character varying(5),
  "MODE6" character varying(5),
  "MODE7" character varying(5),
  "MODE8" character varying(5),
  "MODE9" character varying(5),
  "TIME1" character varying(5),
  "TIME2" character varying(5),
  "TIME3" character varying(5),
  "TIME4" character varying(5),
  "TIME5" character varying(5),
  "TIME6" character varying(5),
  "TIME7" character varying(5),
  "TIME8" character varying(5),
  "TIME9" character varying(5),
  "DIST1" numeric(10, 2),
  "DIST2" numeric(10, 2),
  "DIST3" numeric(10, 2),
  "DIST4" numeric(10, 2),
  "DIST5" numeric(10, 2),
  "DIST6" numeric(10, 2),
  "DIST7" numeric(10, 2),
  "DIST8" numeric(10, 2),
  "DIST9" numeric(10, 2),
  "TRAVELPERIOD" character varying(12),
  "TRIPPURP" character varying(8),
  "DIST_GRP" character varying(8),
  "TIME_GRP" character varying(8),
  "ADTRIPWGT" numeric(10, 2),
  "WDTRIPWGT" numeric(10, 2),
  "WETRIPWGT" numeric(10, 2),
  "HOMEREGION" character varying(10),
  "HB_PURPOSE" character varying(10),
  CONSTRAINT "T_Vista_pkey" PRIMARY KEY ("TRIPID")
)
WITH (
  OIDS = FALSE
);
ALTER TABLE "T_Vista"
  OWNER TO postgres;

 -- Table: "VictoriaLGA_Totals"

DROP TABLE IF EXISTS "VictoriaLGA_Totals";

CREATE TABLE "VictoriaLGA_Totals"
(
  "Code" character varying(10) NOT NULL,
  "ModeTrips" numeric(10, 0),
  "PurposeTrips" numeric(10, 2),
  "ModeDistance" numeric(10, 2),
  "PurposeDistance" numeric(10, 2),
  CONSTRAINT "VictoriaLGA_Totals_pkey" PRIMARY KEY ("Code")
)
WITH (
  OIDS = FALSE
);
ALTER TABLE "VictoriaLGA_Totals"
  OWNER TO postgres;


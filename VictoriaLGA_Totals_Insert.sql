\connect victoria;

insert into "VictoriaLGA_Totals"
(
  "Code"
  ,"ModeTrips"
  ,"PurposeTrips"
  ,"ModeDistance"
  ,"PurposeDistance"
)

select 
lga."CODE" Code
, ((round(sum(case when t."MODE1" = '1' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE2" = '1' then t."ADTRIPWGT"  else 0 end) + sum(case when t."MODE3" = '1' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE4" = '1' then t."ADTRIPWGT" else 0 end) +  sum(case when t."MODE5" = '1' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE6" = '1' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE7"  = '1' then t."ADTRIPWGT" else 0 end) +  sum(case when t."MODE8" = '1' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE9" = '1' then t."ADTRIPWGT" else 0 end), -3)) +
 
 (round(sum(case when t."MODE1" = '2' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE2" = '2' then t."ADTRIPWGT"  else 0 end) + sum(case when t."MODE3" = '2' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE4" = '2' then t."ADTRIPWGT" else 0 end) +  sum(case when t."MODE5" = '2' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE6" = '2' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE7"  = '2' then t."ADTRIPWGT" else 0 end) +  sum(case when t."MODE8" = '2' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE9" = '2' then t."ADTRIPWGT" else 0 end), -3)) +

 (round(sum(case when t."MODE1" = '4' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE2" = '4' then t."ADTRIPWGT"  else 0 end) + sum(case when t."MODE3" = '4' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE4" = '4' then t."ADTRIPWGT" else 0 end) +  sum(case when t."MODE5" = '4' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE6" = '4' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE7"  = '4' then t."ADTRIPWGT" else 0 end) +  sum(case when t."MODE8" = '4' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE9" = '4' then t."ADTRIPWGT" else 0 end), -3)) +

 (round(sum(case when t."MODE1" = '7' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE2" = '7' then t."ADTRIPWGT"  else 0 end) + sum(case when t."MODE3" = '7' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE4" = '7' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE5" = '7' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE6" = '7' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE7" = '7' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE8" = '7' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE9" = '7' then t."ADTRIPWGT" else 0 end), -3)) +

 (round(sum(case when t."MODE1" = '9' or t."MODE1" = '10' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE2" = '9' or t."MODE2" = '10' then t."ADTRIPWGT"  else 0 end) + sum(case when t."MODE3" = '9' or t."MODE3" = '10' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE4" = '9' or t."MODE4" ='10' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE5" = '9' or t."MODE5" = '10' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE6" = '9' or t."MODE6" = '10' then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE7" = '9' or t."MODE7" ='10' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE8" = '9' or t."MODE8" = '10' then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE9" = '9' or t."MODE9" = '10' then t."ADTRIPWGT" else 0 end), -3)) +
 
 (round(sum(case when t."MODE1" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE2" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT"  else 0 end) + sum(case when t."MODE3" not in('-2', '1', '2', '4', '7', '9', '10')  then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE4" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE5" not in('-2', '1', '2', '4', '7', '9', '10')  then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE6" not in('-2', '1', '2', '4', '7', '9', '10')  then t."ADTRIPWGT" else 0 end) + 
 sum(case when t."MODE7" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE8" not in('-2', '1', '2', '4', '7', '9', '10')  then t."ADTRIPWGT" else 0 end) + sum(case when t."MODE9" not in('-2', '1', '2', '4', '7', '9', '10')  then t."ADTRIPWGT" else 0 end), -3))) as ModeTrips

,sum(t."ADTRIPWGT") PurposeTrips

,((round(sum(case when t."MODE1" = '1' then (t."DIST1" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE2" = '1' then (t."DIST2" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE3" = '1' then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE4" = '1' then (t."DIST4" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE5" = '1' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE6" = '1' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE7" = '1' then (t."DIST7" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE8" = '1' then (t."DIST8" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE9" = '1' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) +
 
 (round(sum(case when t."MODE1" = '2' then (t."DIST1" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE2" = '2' then (t."DIST2" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE3" = '2' then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE4" = '2' then (t."DIST4" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE5" = '2' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE6" = '2' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE7" = '2' then (t."DIST7" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE8" = '2' then (t."DIST8" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE9" = '2' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) +

 (round(sum(case when t."MODE1" = '4' then (t."DIST1" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE2" = '4' then (t."DIST2" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE3" = '4' then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE4" = '4' then (t."DIST4" * t."ADTRIPWGT") else 0 end) +  sum(case when t."MODE5" = '4' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE6" = '4' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE7" = '4' then (t."DIST7" * t."ADTRIPWGT") else 0 end) +  sum(case when t."MODE8" = '4' then (t."DIST8" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE9" = '4' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) +

 (round(sum(case when t."MODE1" = '7' then (t."DIST1" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE2" = '7' then (t."DIST2" * t."ADTRIPWGT")  else 0 end) + sum(case when t."MODE3" = '7' then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE4" = '7' then (t."DIST4" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE5" = '7' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE6" = '7' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE7" = '7' then (t."DIST7" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE8" = '7' then (t."DIST8" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE9" = '7' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) +

 (round(sum(case when t."MODE1" = '9' or t."MODE1" = '10' then (t."DIST1" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE2" = '9' or t."MODE2" = '10' then (t."DIST2" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE3" = '9' or t."MODE3" = '10' then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE4" = '9' or t."MODE4" ='10' then (t."DIST4" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE5" = '9' or t."MODE5" = '10' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE6" = '9' or t."MODE6" = '10' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE7" = '9' or t."MODE7" ='10' then (t."DIST7" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE8" = '9' or t."MODE8" = '10' then (t."DIST8" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE9" = '9' or t."MODE9" = '10' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) +

 (round(sum(case when t."MODE1" not in('-2', '1', '2', '4', '7', '9', '10')then (t."DIST1" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE2" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST2" * t."ADTRIPWGT")  else 0 end) + sum(case when t."MODE3" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE4" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST4" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE5" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST5" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE6" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
 sum(case when t."MODE7" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST7" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE8" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST8" * t."ADTRIPWGT") else 0 end) + sum(case when t."MODE9" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3))) as ModeDistance


,((round(sum(case when (t."ORIGPURP1" = 6 or t."ORIGPURP1" = 7 or t."DESTPURP1" = 6 or t."DESTPURP1" = 7) and (t."ORIGPURP2" = 61 or t."ORIGPURP2" = 62 or t."ORIGPURP2" = 63 or t."ORIGPURP2" = 71 or t."DESTPURP2" = 61 or t."DESTPURP2" = 62 or t."DESTPURP2" = 63 or t."DESTPURP2" = 71) then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) +
 (round(sum(case when (t."ORIGPURP1" = 7 or t."DESTPURP1" = 7) and (t."DESTPURP2" != 71) then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) +
 (round(sum(case when (t."ORIGPURP1" = 6 or t."ORIGPURP1" = 9 or t."DESTPURP1" = 6 or t."DESTPURP1" = 9) and ((t."ORIGPURP2" != 61 and t."ORIGPURP2" != 62 and t."ORIGPURP2" != 63 and t."DESTPURP2" != 61 and t."DESTPURP2" != 62 and "DESTPURP2" != 63) or t."DESTPURP2" = 91) then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) +
 (round(sum(case when (t."ORIGPURP1" = 3 or t."DESTPURP1" = 3) then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) +
 (round(sum(case when ((t."ORIGPURP1" = 9 or t."DESTPURP1" = 9) and (t."ORIGPURP2" != 91 and t."DESTPURP2" != 91)) then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) +
 (round(sum(case when (t."ORIGPURP1" = 9 or t."ORIGPURP1" = 10 or t."DESTPURP1" = 9 or t."DESTPURP1" = 10) then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) +
 (round(sum(case when (t."ORIGPURP1" = 5 or t."DESTPURP1" = 5) then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) +
 (round(sum(case when (t."ORIGPURP1" not in ('3', '5', '6', '7', '9', '10') and t."DESTPURP1" not in ('3', '5', '6', '7', '9', '10')) then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3))) as PurposeDistance

from "H_Vista" h
join "VictoriaLGA" lga on (lga."CODE" = h."HOMELGA") 
join "T_Vista" t on (t."HHID" = h."HHID") 
group by lga."CODE"
/*
Name: AggregateVictoria
Creation Date: 5/02/2015
Author: Sean Lutjohn
Description: Aggregates the victoria data and inserts it into a new table
*/

﻿\connect victoria;

DROP TABLE IF EXISTS "Vic_Formatted";

select 

--Begin columns
 
 lga."LGA" as LGA,
 
 --Population
 round("hh"."POPULATION", -3) as Population,
 
 round("hh"."HOUSEHOLDS", -3) as No_of_households,
 
 round("hh"."avgH", 1) as Average_household_size,
 
 --Total Travel
 round(sum(t."WDTRIPWGT"))  as Trips_av_weekday,
 
 round(sum(t."WETRIPWGT")) as Trips_av_weekend,
 
 round(sum(t."WDTRIPWGT") / "hh"."POPULATION",1) as Trips_per_person_weekday,
 
 round(sum(t."WETRIPWGT") / "hh"."POPULATION",1) as Trips_per_person_weekend,
 
 round(sum(t."WDTRIPWGT") / "hh"."HOUSEHOLDS",1) as Trips_per_household_weekday,
 
 round(sum(t."WETRIPWGT") / "hh"."HOUSEHOLDS",1) as Trips_per_household_weekend,

 --Purpose of travel (trips)
 (round(sum(case when (t."ORIGPURP1" = 6
						or t."ORIGPURP1" = 7 
						or t."DESTPURP1" = 6 
						or t."DESTPURP1" = 7)
					and (t."ORIGPURP2" = 61
						or t."ORIGPURP2" = 62 
						or t."ORIGPURP2" = 63 
						or t."ORIGPURP2" = 71 
						or t."DESTPURP2" = 61 
						or t."DESTPURP2" = 62 
						or t."DESTPURP2" = 63
						or t."DESTPURP2" = 71) 
					then t."ADTRIPWGT" else 0 end), -3)) as Commute1,
				 
 (round(sum(case when (t."ORIGPURP1" = 7
						or t."DESTPURP1" = 7) 
					and (t."DESTPURP2" != 71) 
					then t."ADTRIPWGT" else 0 end), -3)) as Work_related_business1,
			
 (round(sum(case when (t."ORIGPURP1" = 6 
						or t."ORIGPURP1" = 9 
						or t."DESTPURP1" = 6 
						or t."DESTPURP1" = 9) 
					and ((t."ORIGPURP2" != 61 
							and t."ORIGPURP2" != 62 
							and t."ORIGPURP2" != 63 
							and t."DESTPURP2" != 61 
							and t."DESTPURP2" != 62 
							and "DESTPURP2" != 63) 
						or t."DESTPURP2" = 91) 
					then t."ADTRIPWGT" else 0 end), -3)) as Education_child_care1,
				
 (round(sum(case when (t."ORIGPURP1" = 3 
						or t."DESTPURP1" = 3)
					then t."ADTRIPWGT" else 0 end), -3)) as Shopping,
					   
 (round(sum(case when ((t."ORIGPURP1" = 9 
							or t."DESTPURP1" = 9) 
						and (t."ORIGPURP2" != 91 
							and t."DESTPURP2" != 91)) 
					then t."ADTRIPWGT" else 0 end), -3)) as Personal_business1,
					 
 (round(sum(case when (t."ORIGPURP1" = 9
						or t."ORIGPURP1" = 10 
						or t."DESTPURP1" = 9 
						or t."DESTPURP1" = 10) 
					then t."ADTRIPWGT" else 0 end), -3)) as Social_recreation1,
					   
 (round(sum(case when (t."ORIGPURP1" = 5 
						or t."DESTPURP1" = 5) 
					then t."ADTRIPWGT" else 0 end), -3)) as Serve_passenger1,
					   
 (round(sum(case when (t."ORIGPURP1" not in ('3', '5', '6', '7', '9', '10') 
						and t."DESTPURP1" not in ('3', '5', '6', '7', '9', '10')) 
					then t."ADTRIPWGT" else 0 end), -3)) as Other,

 --Mode of travel (trips)
 (round(sum(case when t."MODE1" = '1' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE2" = '1' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE3" = '1' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE4" = '1' then t."ADTRIPWGT" else 0 end) +  
		sum(case when t."MODE5" = '1' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE6" = '1' then t."ADTRIPWGT" else 0 end) +
		sum(case when t."MODE7" = '1' then t."ADTRIPWGT" else 0 end) +  
		sum(case when t."MODE8" = '1' then t."ADTRIPWGT" else 0 end) +
		sum(case when t."MODE9" = '1' then t."ADTRIPWGT" else 0 end), -3)) as Vehicle_driver1,
 
 (round(sum(case when t."MODE1" = '2' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE2" = '2' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE3" = '2' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE4" = '2' then t."ADTRIPWGT" else 0 end) +  
		sum(case when t."MODE5" = '2' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE6" = '2' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE7" = '2' then t."ADTRIPWGT" else 0 end) +  
		sum(case when t."MODE8" = '2' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE9" = '2' then t."ADTRIPWGT" else 0 end), -3)) as Vehicle_passenger1,

 (round(sum(case when t."MODE1" = '7' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE2" = '7' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE3" = '7' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE4" = '7' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE5" = '7' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE6" = '7' then t."ADTRIPWGT" else 0 end) +  
		sum(case when t."MODE7" = '7' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE8" = '7' then t."ADTRIPWGT" else 0 end) +
		sum(case when t."MODE9" = '7' then t."ADTRIPWGT" else 0 end), -3)) as Train1,

 (round(sum(case when t."MODE1" = '9' 
		    or t."MODE1" = '10' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE2" = '9' 
			or t."MODE2" = '10' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE3" = '9' 
			or t."MODE3" = '10' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE4" = '9' 
			or t."MODE4" = '10' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE5" = '9' 
			or t."MODE5" = '10' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE6" ='9' 
			or t."MODE6" = '10' then t."ADTRIPWGT" else 0 end) +
		sum(case when t."MODE7" = '9' 
			or t."MODE7" = '10' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE8" = '9'
			or t."MODE8" = '10' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE9" = '9' 
			or t."MODE9" = '10' then t."ADTRIPWGT" else 0 end), -3)) as Bus1,

 (round(sum(case when t."MODE1" = '4' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE2" = '4' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE3" = '4' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE4" = '4' then t."ADTRIPWGT" else 0 end) +  
		sum(case when t."MODE5" = '4' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE6" = '4' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE7" = '4' then t."ADTRIPWGT" else 0 end) +  
		sum(case when t."MODE8" = '4' then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE9" = '4' then t."ADTRIPWGT" else 0 end), -3)) as Walk_only1,			
 
 (round(sum(case when t."MODE1" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE2" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) +
		sum(case when t."MODE3" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE4" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE5" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE6" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) +
		sum(case when t."MODE7" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE8" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end) + 
		sum(case when t."MODE9" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" else 0 end), -3)) as Other_modes1,

 --Purpose of travel (distance)
 (round(sum(case when (t."ORIGPURP1" = 6 
						or t."ORIGPURP1" = 7 
						or t."DESTPURP1" = 6 
						or t."DESTPURP1" = 7) 
					and (t."ORIGPURP2" = 61 
						or t."ORIGPURP2" = 62 
						or t."ORIGPURP2" = 63 
						or t."ORIGPURP2" = 71 
						or t."DESTPURP2" = 61 
						or t."DESTPURP2" = 62 
						or t."DESTPURP2" = 63 
						or t."DESTPURP2" = 71) 
					then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) as Commute2,
					
 (round(sum(case when (t."ORIGPURP1" = 7 
						or t."DESTPURP1" = 7) 
					and (t."DESTPURP2" != 71) 
					then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) as Work_related_business2,
 
 (round(sum(case when (t."ORIGPURP1" = 6 
						or t."ORIGPURP1" = 9 
						or t."DESTPURP1" = 6 
						or t."DESTPURP1" = 9) 
					and ((t."ORIGPURP2" != 61 
							and t."ORIGPURP2" != 62 
							and t."ORIGPURP2" != 63 
							and t."DESTPURP2" != 61 
							and t."DESTPURP2" != 62 
							and "DESTPURP2" != 63) 
						or t."DESTPURP2" = 91) 
					then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) as Education_child_care2,
 
 (round(sum(case when (t."ORIGPURP1" = 3 
						or t."DESTPURP1" = 3) 
					then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) as Shopping2,
					
 (round(sum(case when ((t."ORIGPURP1" = 9 
							or t."DESTPURP1" = 9) 
						and (t."ORIGPURP2" != 91 
							and t."DESTPURP2" != 91)) 
					then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) as Personal_business2,
 
 (round(sum(case when (t."ORIGPURP1" = 9 
						or t."ORIGPURP1" = 10 
						or t."DESTPURP1" = 9 
						or t."DESTPURP1" = 10) 
					then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) as Social_recreation2,
 
 (round(sum(case when (t."ORIGPURP1" = 5 
						or t."DESTPURP1" = 5) 
					then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) as Serve_passenger2,
 
 (round(sum(case when (t."ORIGPURP1" not in ('3', '5', '6', '7', '9', '10') 
						and t."DESTPURP1" not in ('3', '5', '6', '7', '9', '10')) 
					then t."CUMDIST" * t."ADTRIPWGT" else 0 end), -3)) as Other2,

 --Mode of travel (distance)
 (round(sum(case when t."MODE1" = '1' then (t."DIST1" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE2" = '1' then (t."DIST2" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE3" = '1' then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE4" = '1' then (t."DIST4" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE5" = '1' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE6" = '1' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE7" = '1' then (t."DIST7" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE8" = '1' then (t."DIST8" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE9" = '1' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) as Vehicle_driver2,
 
 (round(sum(case when t."MODE1" = '2' then (t."DIST1" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE2" = '2' then (t."DIST2" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE3" = '2' then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE4" = '2' then (t."DIST4" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE5" = '2' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE6" = '2' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE7" = '2' then (t."DIST7" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE8" = '2' then (t."DIST8" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE9" = '2' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) as Vehicle_passenger2,

 (round(sum(case when t."MODE1" = '7' then (t."DIST1" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE2" = '7' then (t."DIST2" * t."ADTRIPWGT")  else 0 end) + 
		sum(case when t."MODE3" = '7' then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE4" = '7' then (t."DIST4" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE5" = '7' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE6" = '7' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE7" = '7' then (t."DIST7" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE8" = '7' then (t."DIST8" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE9" = '7' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) as Train2,

 (round(sum(case when t."MODE1" = '9' or t."MODE1" ='10' then (t."DIST1" * t."ADTRIPWGT") else 0 end) +
		sum(case when t."MODE2" = '9' or t."MODE2" ='10' then (t."DIST2" * t."ADTRIPWGT") else 0 end) +
		sum(case when t."MODE3" = '9' or t."MODE3" ='10' then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE4" = '9' or t."MODE4" ='10' then (t."DIST4" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE5" = '9' or t."MODE5" ='10' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE6" = '9' or t."MODE6" ='10' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE7" = '9' or t."MODE7" ='10' then (t."DIST7" * t."ADTRIPWGT") else 0 end) +
		sum(case when t."MODE8" = '9' or t."MODE8" ='10' then (t."DIST8" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE9" = '9' or t."MODE9" ='10' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) as Bus2,

 (round(sum(case when t."MODE1" = '4' then (t."DIST1" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE2" = '4' then (t."DIST2" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE3" = '4' then (t."DIST3" * t."ADTRIPWGT") else 0 end) +  
		sum(case when t."MODE4" = '4' then (t."DIST4" * t."ADTRIPWGT") else 0 end) +  
		sum(case when t."MODE5" = '4' then (t."DIST5" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE6" = '4' then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE7" = '4' then (t."DIST7" * t."ADTRIPWGT") else 0 end) +  
		sum(case when t."MODE8" = '4' then (t."DIST8" * t."ADTRIPWGT") else 0 end) +
		sum(case when t."MODE9" = '4' then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) as Walk_only2,

 (round(sum(case when ((t."MODE1" != '4' and t."MODE1" != '-2') and (t."MODE2" = '4') and (t."MODE3" != '4' and t."MODE3" != '-2')) then (t."DIST2" * t."ADTRIPWGT") else 0 end) + 
		sum(case when ((t."MODE2" != '4' and t."MODE2" != '-2') and (t."MODE3" = '4') and (t."MODE4" != '4' and t."MODE4" != '-2')) then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
		sum(case when ((t."MODE3" != '4' and t."MODE3" != '-2') and (t."MODE4" = '4') and (t."MODE5" != '4' and t."MODE5" != '-2')) then (t."DIST4" * t."ADTRIPWGT") else 0 end) + 
		sum(case when ((t."MODE4" != '4' and t."MODE4" != '-2') and (t."MODE5" = '4') and (t."MODE6" != '4' and t."MODE6" != '-2')) then (t."DIST5" * t."ADTRIPWGT") else 0 end) +  
		sum(case when ((t."MODE5" != '4' and t."MODE5" != '-2') and (t."MODE6" = '4') and (t."MODE7" != '4' and t."MODE7" != '-2')) then (t."DIST6" * t."ADTRIPWGT") else 0 end) +
		sum(case when ((t."MODE6" != '4' and t."MODE6" != '-2') and (t."MODE7" = '4') and (t."MODE8" != '4' and t."MODE8" != '-2')) then (t."DIST7" * t."ADTRIPWGT") else 0 end) + 
		sum(case when ((t."MODE7" != '4' and t."MODE7" != '-2') and (t."MODE8" = '4') and (t."MODE9" != '4' and t."MODE9" != '-2')) then (t."DIST8" * t."ADTRIPWGT") else 0 end))) as Walk_Linked5_2,

 (round(sum(case when t."MODE1" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST1" * t."ADTRIPWGT") else 0 end) +
		sum(case when t."MODE2" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST2" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE3" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST3" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE4" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST4" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE5" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST5" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE6" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST6" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE7" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST7" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE8" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST8" * t."ADTRIPWGT") else 0 end) + 
		sum(case when t."MODE9" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST9" * t."ADTRIPWGT") else 0 end), -3)) as Other_modes2,

--Purpose of travel (trips %)
(round(sum(case when (t."ORIGPURP1" = 6 
						or t."ORIGPURP1" = 7 
						or t."DESTPURP1" = 6 
						or t."DESTPURP1" = 7) 
					and (t."ORIGPURP2" = 61 
						or t."ORIGPURP2" = 62 
						or t."ORIGPURP2" = 63 
						or t."ORIGPURP2" = 71 
						or t."DESTPURP2" = 61 
						or t."DESTPURP2" = 62 
						or t."DESTPURP2" = 63 
						or t."DESTPURP2" = 71) 
					then t."ADTRIPWGT" / totals."PurposeTrips" else 0 end), 2)) as Commute3,
 
 (round(sum(case when (t."ORIGPURP1" = 7 
						or t."DESTPURP1" = 7) 
					and (t."DESTPURP2" != 71) 
					then t."ADTRIPWGT" / totals."PurposeTrips" else 0 end), 2)) as Work_related_business3,
 
 (round(sum(case when (t."ORIGPURP1" = 6 
						or t."ORIGPURP1" = 9 
						or t."DESTPURP1" = 6 
						or t."DESTPURP1" = 9) 
					and ((t."ORIGPURP2" != 61 
							and t."ORIGPURP2" != 62
							and t."ORIGPURP2" != 63 
							and t."DESTPURP2" != 61 
							and t."DESTPURP2" != 62 
							and "DESTPURP2" != 63) 
						or t."DESTPURP2" = 91) 
					then t."ADTRIPWGT" / totals."PurposeTrips" else 0 end), 2)) as Education_child_care3,
 
 (round(sum(case when (t."ORIGPURP1" = 3 
						or t."DESTPURP1" = 3) 
					then t."ADTRIPWGT" / totals."PurposeTrips" else 0 end), 2)) as Shopping3,

 (round(sum(case when ((t."ORIGPURP1" = 9
							or t."DESTPURP1" = 9) 
						and (t."ORIGPURP2" != 91 
							and t."DESTPURP2" != 91)) 
					then t."ADTRIPWGT" / totals."PurposeTrips" else 0 end), 2)) as Personal_business3,

 (round(sum(case when (t."ORIGPURP1" = 9 
						or t."ORIGPURP1" = 10 
						or t."DESTPURP1" = 9 
						or t."DESTPURP1" = 10) 
					then t."ADTRIPWGT" / totals."PurposeTrips" else 0 end), 2)) as Social_recreation3,
 
 (round(sum(case when (t."ORIGPURP1" = 5 
						or t."DESTPURP1" = 5) 
					then t."ADTRIPWGT" / totals."PurposeTrips" else 0 end), 2)) as Serve_passenger3,
 
 (round(sum(case when (t."ORIGPURP1" not in ('3', '5', '6', '7', '9', '10') 
					   and t."DESTPURP1" not in ('3', '5', '6', '7', '9', '10')) 
					   then t."ADTRIPWGT" / totals."PurposeTrips" else 0 end), 2)) as Other3,

 --Mode of travel (trips %)
(round(sum(case when t."MODE1" = '1' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
	   sum(case when t."MODE2" = '1' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
	   sum(case when t."MODE3" = '1' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
	   sum(case when t."MODE4" = '1' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +  
       sum(case when t."MODE5" = '1' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
       sum(case when t."MODE6" = '1' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
       sum(case when t."MODE7" = '1' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +  
       sum(case when t."MODE8" = '1' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
       sum(case when t."MODE9" = '1' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end), 2)) as Vehicle_driver3,
 
 (round(sum(case when t."MODE1" = '2' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE2" = '2' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +
		sum(case when t."MODE3" = '2' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE4" = '2' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +  
		sum(case when t."MODE5" = '2' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +
		sum(case when t."MODE6" = '2' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE7" = '2' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +  
		sum(case when t."MODE8" = '2' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE9" = '2' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end), 2)) as Vehicle_passenger3,

 (round(sum(case when t."MODE1" = '7' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE2" = '7' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE3" = '7' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE4" = '7' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE5" = '7' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE6" = '7' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +
		sum(case when t."MODE7" = '7' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE8" = '7' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE9" = '7' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end), 2)) as Train3,

 (round(sum(case when t."MODE1" = '9' 
		    or t."MODE1" = '10' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE2" = '9' 
			or t."MODE2" = '10' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE3" = '9' 
		    or t."MODE3" = '10' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
        sum(case when t."MODE4" = '9' 
		    or t."MODE4" = '10' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE5" = '9' 
		    or t."MODE5" = '10' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE6" = '9'
		    or t."MODE6" = '10' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
        sum(case when t."MODE7" = '9' 
		    or t."MODE7" = '10' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE8" = '9' 
	        or t."MODE8" = '10' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE9" = '9' 
		    or t."MODE9" = '10' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end), 2)) as Bus3,

 (round(sum(case when t."MODE1" = '4' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +
		sum(case when t."MODE2" = '4' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE3" = '4' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE4" = '4' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +  
		sum(case when t."MODE5" = '4' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE6" = '4' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE7" = '4' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE8" = '4' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) +
		sum(case when t."MODE9" = '4' then t."ADTRIPWGT" / totals."ModeTrips" else 0 end), 2)) as Walk_only3,
 
 (round(sum(case when t."MODE1" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE2" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE3" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE4" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE5" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE6" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE7" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE8" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" / totals."ModeTrips" else 0 end) + 
		sum(case when t."MODE9" not in('-2', '1', '2', '4', '7', '9', '10') then t."ADTRIPWGT" / totals."ModeTrips" else 0 end), 2)) as Other_modes3,

--Purpose of travel (distance %)
(round(sum(case when (t."ORIGPURP1" = 6 
						or t."ORIGPURP1" = 7 
						or t."DESTPURP1" = 6 
						or t."DESTPURP1" = 7) 
					and (t."ORIGPURP2" = 61 
						or t."ORIGPURP2" = 62 
						or t."ORIGPURP2" = 63 
						or t."ORIGPURP2" = 71 
						or t."DESTPURP2" = 61 
						or t."DESTPURP2" = 62 
						or t."DESTPURP2" = 63 
						or t."DESTPURP2" = 71) 
					then (t."CUMDIST" * t."ADTRIPWGT") / totals."PurposeDistance" else 0 end), 2)) as Commute4,

 (round(sum(case when (t."ORIGPURP1" = 7 
						or t."DESTPURP1" = 7) 
					and (t."DESTPURP2" != 71) 
					then (t."CUMDIST" * t."ADTRIPWGT") / totals."PurposeDistance" else 0 end), 2)) as Work_related_business4,

 (round(sum(case when (t."ORIGPURP1" = 6 
						or t."ORIGPURP1" = 9 
						or t."DESTPURP1" = 6 
						or t."DESTPURP1" = 9) 
					and ((t."ORIGPURP2" != 61 
						    and t."ORIGPURP2" != 62 
						    and t."ORIGPURP2" != 63 
						    and t."DESTPURP2" != 61 
						    and t."DESTPURP2" != 62 
						    and "DESTPURP2" != 63) 
						or t."DESTPURP2" = 91) 
					then (t."CUMDIST" * t."ADTRIPWGT") / totals."PurposeDistance" else 0 end), 2)) as Education_child_care4,
					
 (round(sum(case when (t."ORIGPURP1" = 3 
						or t."DESTPURP1" = 3) 
					then (t."CUMDIST" * t."ADTRIPWGT") / totals."PurposeDistance" else 0 end), 2)) as Shopping4,

 (round(sum(case when ((t."ORIGPURP1" = 9 
							or t."DESTPURP1" = 9) 
						and (t."ORIGPURP2" != 91 
							and t."DESTPURP2" != 91)) 
					then t."CUMDIST" * t."ADTRIPWGT" / totals."PurposeDistance" else 0 end), 2)) as Personal_business4,
					
 (round(sum(case when (t."ORIGPURP1" = 9 
						or t."ORIGPURP1" = 10 
						or t."DESTPURP1" = 9 
						or t."DESTPURP1" = 10) 
					then (t."CUMDIST" * t."ADTRIPWGT") / totals."PurposeDistance" else 0 end), 2)) as Social_recreation4,
					
 (round(sum(case when (t."ORIGPURP1" = 5 
						or t."DESTPURP1" = 5) 
					then (t."CUMDIST" * t."ADTRIPWGT") / totals."PurposeDistance" else 0 end), 2)) as Serve_passenger4,
					
 (round(sum(case when (t."ORIGPURP1" not in ('3', '5', '6', '7', '9', '10') 
						and t."DESTPURP1" not in ('3', '5', '6', '7', '9', '10')) 
					then (t."CUMDIST" * t."ADTRIPWGT") / totals."PurposeDistance" else 0 end), 2)) as Other4,

--Mode of travel (distance %)
 (round(sum(case when t."MODE1" = '1' then (t."DIST1" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE2" = '1' then (t."DIST2" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE3" = '1' then (t."DIST3" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE4" = '1' then (t."DIST4" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE5" = '1' then (t."DIST5" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE6" = '1' then (t."DIST6" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE7" = '1' then (t."DIST7" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE8" = '1' then (t."DIST8" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE9" = '1' then (t."DIST9" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end), 2)) as Vehicle_driver4,
 
 (round(sum(case when t."MODE1" = '2' then (t."DIST1" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when t."MODE2" = '2' then (t."DIST2" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE3" = '2' then (t."DIST3" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE4" = '2' then (t."DIST4" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when t."MODE5" = '2' then (t."DIST5" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE6" = '2' then (t."DIST6" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when t."MODE7" = '2' then (t."DIST7" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when t."MODE8" = '2' then (t."DIST8" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE9" = '2' then (t."DIST9" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end), 2)) as Vehicle_passenger4,

 (round(sum(case when t."MODE1" = '7' then (t."DIST1" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE2" = '7' then (t."DIST2" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE3" = '7' then (t."DIST3" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE4" = '7' then (t."DIST4" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE5" = '7' then (t."DIST5" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when t."MODE6" = '7' then (t."DIST6" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +  
		sum(case when t."MODE7" = '7' then (t."DIST7" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE8" = '7' then (t."DIST8" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE9" = '7' then (t."DIST9" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end), 2)) as Train4,

 (round(sum(case when t."MODE1" = '9' or t."MODE1" ='10' then (t."DIST1" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE2" = '9' or t."MODE2" ='10' then (t."DIST2" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE3" = '9' or t."MODE3" ='10' then (t."DIST3" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when t."MODE4" = '9' or t."MODE4" ='10' then (t."DIST4" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE5" = '9' or t."MODE5" ='10' then (t."DIST5" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE6" = '9' or t."MODE6" ='10' then (t."DIST6" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE7" = '9' or t."MODE7" ='10' then (t."DIST7" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE8" = '9' or t."MODE8" ='10' then (t."DIST8" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when t."MODE9" = '9' or t."MODE9" ='10' then (t."DIST9" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end), 2)) as Bus4,

 (round(sum(case when t."MODE1" = '4' then (t."DIST1" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE2" = '4' then (t."DIST2" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE3" = '4' then (t."DIST3" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE4" = '4' then (t."DIST4" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +  
		sum(case when t."MODE5" = '4' then (t."DIST5" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when t."MODE6" = '4' then (t."DIST6" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE7" = '4' then (t."DIST7" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +  
		sum(case when t."MODE8" = '4' then (t."DIST8" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE9" = '4' then (t."DIST9" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end), 2)) as Walk_only4,

 (round(sum(case when ((t."MODE1" != '4' and t."MODE1" != '-2') and (t."MODE2" = '4') and (t."MODE3" != '4' and t."MODE3" != '-2')) then (t."DIST2" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when ((t."MODE2" != '4' and t."MODE2" != '-2') and (t."MODE3" = '4') and (t."MODE4" != '4' and t."MODE4" != '-2')) then (t."DIST3" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when ((t."MODE3" != '4' and t."MODE3" != '-2') and (t."MODE4" = '4') and (t."MODE5" != '4' and t."MODE5" != '-2')) then (t."DIST4" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when ((t."MODE4" != '4' and t."MODE4" != '-2') and (t."MODE5" = '4') and (t."MODE6" != '4' and t."MODE6" != '-2')) then (t."DIST5" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +  
		sum(case when ((t."MODE5" != '4' and t."MODE5" != '-2') and (t."MODE6" = '4') and (t."MODE7" != '4' and t."MODE7" != '-2')) then (t."DIST6" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when ((t."MODE6" != '4' and t."MODE6" != '-2') and (t."MODE7" = '4') and (t."MODE8" != '4' and t."MODE8" != '-2')) then (t."DIST7" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when ((t."MODE7" != '4' and t."MODE7" != '-2') and (t."MODE8" = '4') and (t."MODE9" != '4' and t."MODE9" != '-2')) then (t."DIST8" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end), 4)) as Walk_Linked5_4,

 (round(sum(case when t."MODE1" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST1" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE2" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST2" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE3" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST3" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +  
		sum(case when t."MODE4" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST4" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE5" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST5" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE6" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST6" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) +
		sum(case when t."MODE7" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST7" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE8" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST8" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end) + 
		sum(case when t."MODE9" not in('-2', '1', '2', '4', '7', '9', '10') then (t."DIST9" * t."ADTRIPWGT") / totals."ModeDistance" else 0 end), 2)) as Other_modes4,

 --Vehicles
 round("vv"."VEHICLES", -3) as Private_vehicles,
 
 round(("vv"."AVG"), 1) as Vehicles_per_household,

 --Distance (kms)
 round(sum(t."ADTRIPWGT"), -3) as Total_travel,
 
 round(sum(t."ADTRIPWGT") / sum(h."HHSIZE"), 1) as Total_travel_per_capita,
 
 round(sum(t."ADTRIPWGT") / sum(t."ADTRIPWGT"), 1) as Av_trip_length,
 
 round(sum(
	(case when t."MODE1" = '1' then t."DIST1" else 0 end) + 
	(case when t."MODE2" = '1' then t."DIST2" else 0 end) + 
	(case when t."MODE3" = '1' then t."DIST3" else 0 end))) as "Vehicle_travel_(VKT)",

 round(sum(
	(case when t."MODE1" = '1' then t."DIST1" else 0 end) + 
	(case when t."MODE2" = '1' then t."DIST2" else 0 end) + 
	(case when t."MODE3" = '1' then t."DIST3" else 0 end)) / sum(h."HHSIZE"),1) as VKT_per_capita,

 --Travel Time (Mins)
 round(sum(case when (t."ORIGPURP1" = 7 or t."DESTPURP1" = 7) then (t."TRIPTIME" * t."ADTRIPWGT") end) 
 	/ sum(case when (t."ORIGPURP1" = 7 or t."DESTPURP1" = 7) then t."ADTRIPWGT" end)) as Av_work_trip_duration,
 
 round(sum(case when (t."ORIGPURP1" != 7 and t."DESTPURP1" != 7) then (t."TRIPTIME" * t."ADTRIPWGT") end)
 	/ sum(case when (t."ORIGPURP1" != 7 and t."DESTPURP1" != 7) then t."ADTRIPWGT" end)) as Av_non_work_trip_duration,
	
 round(sum(t."TRIPTIME" * t."ADTRIPWGT") / sum(t."ADTRIPWGT")) as Av_Trip_duration_all_purposes,
 
 round(sum(t."TRIPTIME" * t."ADTRIPWGT") / "hh"."POPULATION") as Daily_travel_time_per_capita
 
 --End columns
 
 INTO "Vic_Formatted"
 
 from "H_Vista" h
 
 join "VictoriaLGA" lga on (lga."CODE" = h."HOMELGA")

 join (select h."HOMELGA" as "CODE"
			 ,sum(h."ADHHWGT") as "HOUSEHOLDS"
			 ,(sum(h."HHSIZE" * h."ADHHWGT")) as "POPULATION"
			 ,(sum(h."HHSIZE" * h."ADHHWGT") / sum(h."ADHHWGT")) as "avgH" 
		from "H_Vista" h 
		group by h."HOMELGA"
		order by h."HOMELGA") "hh" 
 on "hh"."CODE" = lga."CODE"
	
 join "T_Vista" t on (t."HHID" = h."HHID") 

 left join (select h."HOMELGA"
				   ,sum("v"."VEHICLES") "VEHICLES" 
	               ,sum("v"."VEHICLES") / sum(h."ADHHWGT") "AVG"
			from "H_Vista" h 
			join "VictoriaLGA" lga 
			on lga."CODE" = h."HOMELGA"
			left join (select v."HHID" "HHID"
					          ,sum(v."ADHHWGT") "VEHICLES" 
				       from "V_Vista" v group by v."HHID"
					  ) "v" 
			on "v"."HHID" = h."HHID"
			join "T_Vista" t 
			on (t."HHID" = h."HHID")
			group by h."HOMELGA"
			order by h."HOMELGA"
		   ) "vv" 
 on "vv"."HOMELGA" = h."HOMELGA"

 join "VictoriaLGA_Totals" totals 
 on totals."Code" = h."HOMELGA"
 
 group by lga."CODE"
		,"hh"."HOUSEHOLDS"
		,"hh"."POPULATION"
		,"hh"."avgH"
		,"vv"."VEHICLES"
		,"vv"."AVG"
 order by lga."CODE";

ALTER TABLE "Vic_Formatted" 
  ADD CONSTRAINT "Pk_Vic_Formatted"
  PRIMARY KEY (LGA);

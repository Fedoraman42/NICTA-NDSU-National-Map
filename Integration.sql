\connect victoria;

DROP TABLE IF EXISTS "Australia";

SELECT * INTO "Australia" FROM 
(
  SELECT * FROM "Vic_Formatted"

  UNION

  SELECT * FROM "NewSouthWales"

  ORDER BY lga
)AS A;


ALTER TABLE "Australia"
  OWNER TO postgres;
  

ALTER TABLE "Australia" 
  ADD CONSTRAINT "Pk_Australia"
PRIMARY KEY (lga);
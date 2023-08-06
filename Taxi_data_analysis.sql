CREATE TABLE public.feb_tripdata_2020_cleaned(
  tpep_pickup_datetime TIMESTAMP,
  tpep_dropoff_datetime TIMESTAMP,
  passenger_count int,
  trip_distance DOUBLE PRECISION,
  PULocationID varchar,
  DOLocationID varchar,
  payment_type varchar,
  fare_amount DOUBLE PRECISION,
  tip_amount DOUBLE PRECISION,
  tolls_amount DOUBLE PRECISION,
  total_amount DOUBLE PRECISION,
  duration DOUBLE PRECISION,
  trip_pickup_hour varchar,
  trip_dropoff_hour varchar,
  trip_day varchar,
  trip_date date,
  total_taxes DOUBLE PRECISION);
  
  SELECT * FROM public.feb_tripdata_2020_cleaned
  
  CREATE TABLE public.june_tripdata_2020_cleaned(
  tpep_pickup_datetime TIMESTAMP,
  tpep_dropoff_datetime TIMESTAMP,
  passenger_count int,
  trip_distance DOUBLE PRECISION,
  PULocationID varchar,
  DOLocationID varchar,
  payment_type varchar,
  fare_amount DOUBLE PRECISION,
  tip_amount DOUBLE PRECISION,
  tolls_amount DOUBLE PRECISION,
  total_amount DOUBLE PRECISION,
  duration DOUBLE PRECISION,
  trip_pickup_hour varchar,
  trip_dropoff_hour varchar,
  trip_day varchar,
  trip_date date,
  total_taxes DOUBLE PRECISION);
  
 --Query to display all coloumns of the dataset--
 SELECT * FROM feb_tripdata_2020_cleaned
 
--Query to display only the selected coloumns of the dataset--
SELECT PULocationID,
         DOLocationID,
          payment_type
		  FROM feb_tripdata_2020_cleaned
		  

 --Query to display all coloumns of the dataset limited to first 10 rows--
 SELECT * FROM feb_tripdata_2020_cleaned
  LIMIT 10
  
 --Query to display all coloumns subjet to filter condition of total_amount less than 0--
 SELECT * FROM feb_tripdata_2020_cleaned
  WHERE total_amount<0
  
--Query to display all coloumns subject to filter condition of payment_type not of Credit_card--
SELECT * FROM feb_tripdata_2020_cleaned
  WHERE payment_type != 'Credit_card'
  
/* Query to display all coloumns subject to filter condition of payment_typeof Cash and Dispute
only, and re-arranging data as per increasing order of passenger_count*/
SELECT * FROM feb_tripdata_2020_cleaned
  WHERE payment_type IN ('Cash','Dispute')
  ORDER BY passenger_count
  
/* Query to display all coloumns subject to filter condition of payment_typeof Cash and Dispute
only, and re-arranging data as per decreasing order of passenger_count*/
SELECT * FROM feb_tripdata_2020_cleaned
  WHERE payment_type IN ('Cash','Dispute')
  ORDER BY passenger_count DESC
 
/*To apply an aggregation function 'COUNT' to count the number of records
in a particular filed as for example 'payment_type'*/
SELECT COUNT(payment_type)
FROM feb_tripdata_2020_cleaned

/* To find the minimum and maximum number of passengers in a trip as recorded
in the 'passenger_count' filed */
SELECT MIN(passenger_count) AS min_count,
       MAX(passenger_count) AS max_count
	     FROM feb_tripdata_2020_cleaned   

/* To find the average of 'total_amount' with a condition to exclude the records
with 0 as total_amount */
SELECT AVG(total_amount) FROM feb_tripdata_2020_cleaned
  WHERE total_amount IS NOT NULL
  
/* for the fields which contain categorical records; applying
GROUP BY to find out COUNTS */
SELECT payment_type,
       passenger_count,
	   COUNT (*) AS count
	   FROM feb_tripdata_2020_cleaned
	   GROUP BY payment_type, passenger_count
	   ORDER BY payment_type, passenger_count

/* For the same above query; lets us use HAVING function which
filters records based on aggregated filed condition */ 
SELECT payment_type,
       passenger_count,
	   MAX (total_amount) AS max_total_amount
	   FROM feb_tripdata_2020_cleaned
	   GROUP BY payment_type, passenger_count
	   HAVING MAX (total_amount)>0
	   ORDER BY payment_type, passenger_count
	   
/* Applying CASE statement for a categorical field 'payment_type' so as to create a new field 
by name 'payment_code' and enter the records with pre-defined codes (1,2,3 and 4) */
SELECT payment_type,
       CASE WHEN payment_type = 'Cash' THEN '1'
	        WHEN payment_type = 'Credit_card' THEN '2'
			WHEN payment_type = 'Dispute' THEN '3'
			ELSE '4' END AS payment_code
			FROM feb_tripdata_2020_cleaned


/* Applying aggregation function COUNT in combination with CASE statement */
SELECT COUNT(CASE WHEN payment_type = 'Cash' THEN '1' ELSE NULL END) AS cash_count,
	   COUNT(CASE WHEN payment_type = 'Credit_card' THEN '2' ELSE NULL END) AS Creditcard_count,
	   COUNT(CASE WHEN payment_type = 'Dispute' THEN '3' ELSE NULL END) AS Dispute_count,
	   COUNT(CASE WHEN payment_type = 'No_charge' THEN '4' ELSE NULL END) AS NoCharge_count
		FROM feb_tripdata_2020_cleaned
		
/* Applying the combination of CASE statement with GROUP BY */
SELECT payment_type,
       CASE WHEN payment_type = 'Cash' THEN '1'
	        WHEN payment_type = 'Credit_card' THEN '2'
			WHEN payment_type = 'Dispute' THEN '3'
			ELSE '4' END AS payment_code
	FROM feb_tripdata_2020_cleaned
	GROUP BY payment_type	


/* Applying DISTINCT function to figure out the unique elements
in the categorical coloumns */ 
SELECT DISTINCT passenger_count,pulocationid,dolocationid,payment_type
FROM feb_tripdata_2020_cleaned
ORDER BY passenger_count

/* Using INNER JOINS; Join the datasets through the field 'pulocationid' and 
display the fields 'passenger count' of both datasets using the field headers as
feb_passenger and june_passenger respectively */
SELECT feb.passenger_count AS feb_passenger,
       june.passenger_count AS june_passenger
      FROM feb_tripdata_2020_cleaned feb
	  JOIN june_tripdata_2020_cleaned june
	  ON feb.pulocationid = june.pulocationid
	  
/* Using LEFT JOINS; Join the datasets through the field 'pulocationid' and 
display the fields 'total_amount' of both datasets using the field headers as
feb_total_amount and june_total_amount respectively and a WHERE condition of
total_amounts greater than 0 */
SELECT feb.total_amount AS feb_total_amount,
       june.total_amount AS june_total_amount
      FROM feb_tripdata_2020_cleaned feb
	  LEFT JOIN june_tripdata_2020_cleaned june
	  ON feb.pulocationid = june.pulocationid
	  WHERE feb.total_amount > 0 AND june.total_amount >0
	  
/* Using RIGHT JOINS; Join the datasets through the field 'pulocationid' and 
display the fields 'total_amount' and 'payment_type' of both datasets using the 
field headers as feb_total_amount,feb_pay_mode, june_total_amount and june_pay_mode
respectively and a WHERE condition of total_amounts greater than 0 */	  
SELECT feb.total_amount AS feb_total_amount,
       feb.payment_type AS feb_pay_mode,
       june.total_amount AS june_total_amount,
	   june.payment_type AS june_pay_mode
      FROM feb_tripdata_2020_cleaned feb
	  RIGHT JOIN june_tripdata_2020_cleaned june
	  ON feb.pulocationid = june.pulocationid
	  WHERE feb.total_amount > 0 AND june.total_amount >0
	  
/* Using FULL OUTER JOINS; Join the datasets through the field 'pulocationid' and 
display the fields 'total_amount' and 'payment_type' of both datasets using the 
field headers as feb_total_amount,feb_pay_mode, june_total_amount and june_pay_mode
respectively */	  
SELECT feb.total_amount AS feb_total_amount,
       feb.payment_type AS feb_pay_mode,
       june.total_amount AS june_total_amount,
	   june.payment_type AS june_pay_mode
      FROM feb_tripdata_2020_cleaned feb
	  FULL OUTER JOIN june_tripdata_2020_cleaned june
	  ON feb.pulocationid = june.pulocationid

/* Using UNION function to display uncommon records from both datasets */
SELECT * FROM feb_tripdata_2020_cleaned 
       UNION june_tripdata_2020_cleaned
	   

/* Using UNION function to display both common and  uncommon records from both datasets */
SELECT * FROM feb_tripdata_2020_cleaned 
       UNION ALL june_tripdata_2020_cleaned
	   
/* Joining on multiple fields/keys: In this case JOIN is operated on two fields
namely 'pulocationid' and 'dolocationid' through AND logical operator */
SELECT feb.total_amount AS feb_total_amount,
       june.total_amount AS june_total_amount
      FROM feb_tripdata_2020_cleaned feb
	  LEFT JOIN june_tripdata_2020_cleaned june
	  ON feb.pulocationid = june.pulocationid
	  AND feb.dolocationid = june.dolocationid
	  WHERE feb.total_amount > 0 AND june.total_amount >0

/* Provide a subquery to extract all fields subject to select 'Monday' 
as a condition for 'trip_day'. Then referring to the subquery extract all 
fields where the payment_type is Cash */
SELECT subqry.*
 FROM (
       SELECT * FROM feb_tripdata_2020_cleaned
       WHERE trip_day = 'Monday'
       ) subqry
WHERE subqry.payment_type = 'Cash'


SELECT subqry.passenger_count,
       subqry.payment_type,
	   COUNT(subqry.payment_type) AS paytype_count
 FROM (
       SELECT passenger_count,
              payment_type,
              AVG(trip_distance) AS avg_trip_distance
	          FROM feb_tripdata_2020_cleaned
              GROUP BY passenger_count, payment_type
      ) subqry
GROUP BY subqry.passenger_count, subqry.payment_type

/* Provide a query where inner table consists of multiple results. 
In refernce to the inner query, the resultant table should also display all fields   */
SELECT *  FROM feb_tripdata_2020_cleaned
WHERE passenger_count IN ( SELECT passenger_count
                           FROM feb_tripdata_2020_cleaned
                           GROUP BY passenger_count
	                       ORDER BY passenger_count DESC
	                      )

/* Applying the window function OVER clause on the field 'trip_distance' */
SELECT passenger_count ,
       payment_type,
SUM(trip_distance) OVER () AS total_trip_distance
FROM feb_tripdata_2020_cleaned


/* Applying PARTITION BY and ORDER BY within OVER clause so as to 
enable vertical slicing of the 'total_trip_distance' fieled in 
relation with categorical fields payment_type and passenger_count  */
SELECT *,
SUM(trip_distance) OVER (PARTITION BY payment_type ORDER BY passenger_count) AS total_trip_distance
FROM feb_tripdata_2020_cleaned


/* A query to choose selected fields and apply ROW_NUMBER for the resultant table  */
SELECT
   ROW_NUMBER() OVER (
       ORDER BY passenger_count) row_num,
	   payment_type,
	   passenger_count,
	   trip_distance,
	   pulocationid
	   FROM feb_tripdata_2020_cleaned
	   
/* Create a Common Table Expression by name 'cte' and apply a 
filter condition on the resultant table so as to display output 
with row_numbers within specified limits. This is also called 'PAGINATION'*/	   
WITH cte AS (
      SELECT
      ROW_NUMBER() OVER (
       ORDER BY passenger_count) row_num,
	   payment_type,
	   passenger_count,
	   trip_distance,
	   pulocationid
	   FROM feb_tripdata_2020_cleaned
     )	   
SELECT * FROM cte
WHERE row_num>10 AND row_num<=35

/* Apply RANK and DENSE RANK function over the field 'pulocationid'  */
SELECT pulocationid,
       RANK() OVER(
	   ORDER BY pulocationid)myrank,
	   DENSE_RANK() OVER(
	   ORDER BY pulocationid)my_dense_rank
	   FROM feb_tripdata_2020_cleaned
/*Result Interpretation: For pulocationid values '1' and '10'; myrank are 1 and 101,
which means there are 100 counts of pulocationid '1' and 352 counts of pulocation id '10'

For pulocationid values '1' and '10'; my_dense_rank are 1 and 2 respectively */


/* Application of DENSE_RANK in combination with PARTITION BY */
WITH cte AS (
   SELECT passenger_count,
          payment_type,
          pulocationid,
         DENSE_RANK() OVER(
		        PARTITION BY passenger_count
		        ORDER BY payment_type)dense_rank_coloumn
     FROM feb_tripdata_2020_cleaned 
     )
SELECT passenger_count,
          payment_type,
          pulocationid
		  FROM cte  WHERE dense_rank_coloumn IN ('1','2','3')

/* Applying NTILE function to divide total rows of the dataset into
required equal number divisions/groups under the field name as 'buckets' */
SELECT pulocationid,
       passenger_count,
	   payment_type,
       NTILE (100) OVER (
	   ORDER BY pulocationid)buckets
	   FROM feb_tripdata_2020_cleaned

/* A query to apply Nth_value to find the third highest  passenger_count value
for the given dataset table infront of each row  */
SELECT passenger_count,
       payment_type,
	   trip_distance,
	   NTH_VALUE(passenger_count,3) OVER(
	   ORDER BY payment_type RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	   )third_lowest_payment_type
	 FROM feb_tripdata_2020_cleaned
	   

/* Applying LAG function to find the previous_trip_distance for 
categorical field 'pulocationid' inconsonance with PARTITION BY and 
ORDER BY applied on other fields like 'trip_distance' and 'payment_type' */
	SELECT pulocationid,
	       trip_distance,
		   payment_type,
		   LAG(trip_distance) OVER(
		   PARTITION BY pulocationid
		   ORDER BY trip_distance) previous_distance
		   FROM feb_tripdata_2020_cleaned

SELECT pulocationid,
	     dolocationid,
		 trip_distance,
		  LEAD(pulocationid,1) OVER(
		   ORDER BY pulocationid) next_pulocation_id
		   FROM feb_tripdata_2020_cleaned;
		   
		   


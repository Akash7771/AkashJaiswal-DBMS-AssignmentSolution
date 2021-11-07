CREATE SCHEMA TravelOnTheGo;

Use TravelOnTheGo;
-- 1. Create two table PASSENGER AND PRICE.  
CREATE TABLE PASSENGER (
	Passenger_name VARCHAR (50),
	Category VARCHAR (10),
	Gender VARCHAR(10),
	Boarding_City VARCHAR (50),
	Destination_City VARCHAR (50),
	Distance INT ,
	Bus_Type VARCHAR (10)
);

CREATE TABLE PRICE(
	Bus_Type VARCHAR(10),
	Distance INT,
	Price INT 
); 

-- 2. Insert the following data.
INSERT INTO PASSENGER (Passenger_name , Category , Gender , Boarding_City , Destination_City , Distance , Bus_Type) 
VALUES ("Sejal" , "AC", "F" , "Bengaluru" , "Chennai" , 350 , "Sleeper" ),
("Anmol" , "Non-AC", "M" , "Mumbai" , "Hyderabad" , 700 , "Sitting" ),
("Pallavi" , "AC", "F" , "Panaji" , "Bengaluru" , 600 , "Sleeper" ),
("Khusboo" , "AC", "F" , "Chennai" , "Mumbai" , 1500 , "Sleeper" ),
("Udit" , "Non-AC", "M" , "Trivandrum" , "Panaji" , 1000 , "Sleeper" ),
("Ankur" , "AC", "M" , "Nagpur" , "Hyderabad" , 500 , "Sitting" ),
("Hemant" , "Non-AC", "M" , "Panaji" , "Mumbai" , 700 , "Sleeper" ),
("Manish" , "Non-AC", "M" , "Hyderabad" , "Bengaluru" , 500 , "Sitting" ),
("Piyush" , "AC", "M" , "Pune" , "Nagpur" , 700 , "Sitting" );


INSERT INTO PRICE (Bus_Type , Distance , Price) 
VALUES ("Sleeper",350,770),
("Sleeper",500,1100),
("Sleeper",600,1320),
("Sleeper",700,1540),
("Sleeper",1000,2200),
("Sleeper",1200,2640),
("Sitting",350,434),
("Sitting",500,620),
("Sitting",500,620),
("Sitting",600,744),
("Sitting",700,868),
("Sitting",1000,1240),
("Sitting",1200,1488),
("Sitting",1500,1860);



-- 3. 
SELECT 
    COUNT(1) AS PASSENGER_COUNT, Gender GENDER
FROM
    PASSENGER
WHERE
    Distance >= 600
GROUP BY Gender;

-- 4. 
SELECT 
    MIN(PRICE) MIN_TICKET_PRICE
FROM
    PRICE
WHERE
    Bus_Type = 'Sleeper';

-- 5.
SELECT 
    Passenger_name PASSENGER_NAME
FROM
    PASSENGER
WHERE
    Passenger_name LIKE 'S%';

-- 6.
SELECT 
    P.Passenger_name PASSANGER_NAME,
    P.Boarding_City BOARDING_CITY,
    P.Destination_City DESTINATION_CITY,
    P.Bus_Type BUS_TYPE,
    C.Price PRICE
FROM
    PASSENGER P
        JOIN
    PRICE C ON P.Bus_Type = C.Bus_Type
        AND P.Distance = C.Distance;

-- 7.
-- COMMENT 
-- CANT FIND ANY RECORD PASSENGER WHO TRAVELLED 1000KM IN SITTING BUS_TYPE

SELECT 
    P.Passenger_name PASSENGER_NAME, C.Price PRICE
FROM
    PASSENGER P
        JOIN
    PRICE C ON P.Bus_Type = C.Bus_Type
        AND P.Distance = C.Distance
WHERE
    P.Bus_Type = 'Sitting'
        AND C.Distance = 1000;

-- FOUND A PASSANGER WITH SLEEPER AND 1000KM
SELECT 
    P.Passenger_name PASSENGER_NAME, C.Price PRICE
FROM
    PASSENGER P
        JOIN
    PRICE C ON P.Bus_Type = C.Bus_Type
        AND P.Distance = C.Distance
WHERE
    P.Bus_Type = 'Sleeper'
        AND C.Distance = 1000;

-- 8. 
-- COMMENT 
-- Prices is not dependent on customer. 
-- Assuming Distance from Panaji to Bangaluru OR Bangaluru to Panaji will be same. 
-- Assuming PRICES FROM Panaji to Bangaluru OR Bangaluru to Panaji will be same.

SELECT 
    C.Bus_Type BUS_TYPE,
    'BANGALURU' BOARDING_CITY,
    'PANAJI' DESTINATION_CITY,
    C.Distance DISTANCE,
    C.Price PRICE
FROM
    PRICE C
WHERE
    C.Distance IN (SELECT DISTINCT
            P.Distance
        FROM
            PASSENGER P
        WHERE
            (P.Boarding_City = 'Panaji'
                AND P.Destination_City = 'Bengaluru')
                OR (P.Boarding_City = 'Bengaluru'
                AND P.Destination_City = 'Panaji'))
        AND C.Bus_Type IN ('Sitting' , 'Sleeper');


-- 9. 
-- APPROACH 1
SELECT DISTINCT
    Distance
FROM
    PASSENGER
ORDER BY 1 DESC;

-- APPROACH 2
SELECT 
    Distance
FROM
    PASSENGER
GROUP BY Distance
ORDER BY 1 DESC;

-- 10. 
-- COMMENT 
-- 
SELECT 
    P.Passenger_name PASSENGER_NAME,
    (P.Distance / (Q.TOTAL_DISTANCE - P.Distance)) * 100 PASSENGER_TRAVEL_PERCENTAGE_WITOUT_HIS_VARIABLE
FROM
    PASSENGER P
        JOIN
    (SELECT 
        SUM(Distance) TOTAL_DISTANCE
    FROM
        PASSENGER) Q ;

-- 11. 

SELECT 
    Distance, Price,
    CASE
        WHEN Price > 1000 THEN 'Expensive'
        WHEN Price BETWEEN 500 AND 1000 THEN 'Average Cost'
        ELSE 'Cheap'
    END AS CATEGORY
FROM
    PRICE;
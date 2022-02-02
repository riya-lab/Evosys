CREATE TABLE CUSTOMERS    (
		CUSTOMER_ID NUMBER(2) CONSTRAINT PK_CUST PRIMARY KEY,
		NAME VARCHAR2(14),
        ADDRESS VARCHAR2(50),
        WEBSITE VARCHAR2(50),
		CREDIT_LIMIT INT
	) ;
    
INSERT INTO CUSTOMERS VALUES 	(01,'Riya','Vadodara', 'www.google.com', '100');
	INSERT INTO CUSTOMERS VALUES 	(02,'Seema','Ahmedabad', 'www.gmail.com', '100');
	INSERT INTO CUSTOMERS VALUES 	(03,'Yogesh','Surat', 'www.youtube.com', '100');
	INSERT INTO CUSTOMERS VALUES 	(04,'Nishit','Vadodara', 'www.google.com', '100');
	INSERT INTO CUSTOMERS VALUES 	(05,'Bhavin','Mumbai', 'www.youtube.com', '100');
	INSERT INTO CUSTOMERS VALUES 	(06,'Honey','Delhi', 'www.google.com', '100');
    
SELECT * FROM CUSTOMERS;

SELECT
  name
FROM
  customers;
  
SELECT
    customer_id,
    name,
    credit_limit
FROM
    customers;
    
SELECT
    customer_id,
    name,
    address,
    website,
    credit_limit
FROM
    customers;
    
SELECT
    name,
    address,
    credit_limit
FROM
    customers
ORDER BY
    name ASC;
    
SELECT
    name,
    address,
    credit_limit
FROM
    customers
ORDER BY
    name DESC;
--  Sorting rows by multiple columns example    
SELECT
	name,
	address
FROM
	customers
ORDER BY
	name,
	address DESC;
--Sorting rows with NULL values examples    
SELECT
    country_id,
    city,
    state
FROM
    locations
ORDER BY
    city,
    state;
    
SELECT
    country_id,
    city,
    state
FROM
    locations
ORDER BY
    state ASC NULLS FIRST;

SELECT 
   country_id, 
   city, 
   state 
FROM 
   locations 
ORDER BY 
   state 
ASC NULLS LAST;

SELECT
	customer_id,
	name
FROM
	customers
ORDER BY
	UPPER( name );
    
SELECT 
   order_id, 
   customer_id, 
   status, 
   order_date
FROM 
   orders
ORDER BY 
   order_date DESC;
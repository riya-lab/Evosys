--The following statement creates a new view named cars_master:

CREATE VIEW cars_master AS 
SELECT
    car_id,
    car_name
FROM
    cars;
    
--It’s possible to delete a row from the cars table via the cars_master view, for example:

DELETE
FROM
    cars_master
WHERE
    car_id = 1;
    
--And you can update any column values exposed to the cars_master view:

UPDATE
    cars_master
SET
    car_name = 'Audi RS7 Sportback'
WHERE
    car_id = 2;
    
--insert a new row into the cars table via the cars_master view is not possible. Because the cars table has a not null column ( brand_id) without a default value.
--this will through error
INSERT INTO cars_master
VALUES('Audi S1 Sportback');

--Let’s create a join view named all_cars based on the cars and brands tables.

CREATE VIEW all_cars AS 
SELECT
    car_id,
    car_name,
    c.brand_id,
    brand_name
FROM
    cars c
INNER JOIN brands b ON
    b.brand_id = c.brand_id; 
    
--The following statement inserts a new row into the cars table via the call_cars view:

INSERT INTO all_cars(car_name, brand_id )
VALUES('Audi A5 Cabriolet', 1);

--The following statement deletes all Honda cars from the cars table via the all_cars view:

DELETE
FROM
    all_cars
WHERE
    brand_name = 'Honda';
    
--To find which column can be updated, inserted, or deleted, you use the user_updatable_columns view. The following example shows which column of the all_cars view is updatable, insertable, and deletable:

SELECT
    *
FROM
    USER_UPDATABLE_COLUMNS
WHERE
    TABLE_NAME = 'ALL_CARS';
--Oracle finds the stored query associated with the name customer_credits and executes the following query:

SELECT
    *
FROM
    (
        SELECT
            name,
            credit_limit
        FROM
            customer
    );  
    
--The following query returns sales amount by the customer by year:

SELECT
    name AS customer,
    SUM( quantity * unit_price ) sales_amount,
    EXTRACT(
        YEAR
    FROM
        order_date
    ) YEAR
FROM
    orders
INNER JOIN order_items
        USING(order_id)
INNER JOIN customer
        USING(customer_id)
WHERE
    status = 'Shipped'
GROUP BY
    name,
    EXTRACT(
        YEAR
    FROM
        order_date
    );
    
--you can create a view based on this query:

CREATE OR REPLACE VIEW customer_sales AS 
SELECT
    name AS customer,
    SUM( quantity * unit_price ) sales_amount,
    EXTRACT(
        YEAR
    FROM
        order_date
    ) YEAR
FROM
    orders
INNER JOIN order_items
        USING(order_id)
INNER JOIN customers
        USING(customer_id)
WHERE
    status = 'Shipped'
GROUP BY
    name,
    EXTRACT(
        YEAR
    FROM
        order_date
    );
    
--you can easily retrieve the sales by the customer in 2017 with a more simple query:

SELECT
    customer,
    sales_amount
FROM
    customer_sales
WHERE
    YEAR = 2017
ORDER BY
    sales_amount DESC;
--The following statement creates a view named employee_yos based on the employees table. The view shows the employee id, name and years of service:
CREATE VIEW employee_yos AS
SELECT
    employee_id,
    first_name || ' ' || last_name full_name,
    FLOOR( months_between( CURRENT_DATE, hire_date )/ 12 ) yos
FROM
    employees;
--The following query returns employees whose years of service are 5:    
SELECT
    *
FROM
    employee_yos
WHERE
    yos = 5
ORDER BY
    full_name; 
--read only view The view contains three columns: customer id, customer name and credit limit:  
CREATE OR REPLACE VIEW customer_credits(
        customer_id,
        name,
        credit
    ) AS 
SELECT
        customer_id,
        name,
        credit_limit
    FROM
        customers WITH READ ONLY;
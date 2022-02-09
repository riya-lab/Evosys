CREATE VIEW salesman AS 
SELECT
    *
FROM
    employees
WHERE
    job_title = 'Sales Representative';
    
SELECT
    *
FROM
    salesman;
    
--The following statement creates another view named salesman_contacts based on the salesman view:

CREATE VIEW salesman_contacts AS 
SELECT
    first_name,
    last_name,
    email,
    phone
FROM
    salesman;
    
--The salesman_contacts view returns the only name, email, and phone of the salesman:

SELECT
    *
FROM
    salesman_contacts;
    
--To drop the salesman view, you use the following statement:

DROP VIEW salesman;

--You can check the status of a view by querying data from the user_objects view. Note that the object name must be in uppercase.

SELECT
    object_name,
    status
FROM
    user_objects
WHERE
    object_type = 'VIEW'
    AND object_name = 'SALESMAN_CONTACTS';
    
--To drop the salesman_contacts view, you use the following DROP VIEW statement:

DROP VIEW salesman_contacts;
--Get a list of latest order IDs for all customers by using the max function on Order_ID column
SELECT
    CUSTOMERID,
    MAX( ORDERID )
FROM
    CUSTOMERS
INNER JOIN ORDERS
        USING(CUSTOMERID)
GROUP BY 
   CUSTOMERID
ORDER BY
    MAX(ORDERID) DESC;
    
--Find suppliers who sell more than one product to Northwind Trader
SELECT s.supplierid,s.companyname
FROM suppliers s
INNER JOIN products p
ON s.supplierid=p.supplierid
WHERE p.supplierid > (SELECT count(productid) FROM products GROUP BY supplierid HAVING count(productid)>1 order by count(productid));

--  Create a function to get latest order date for entered customer_id

CREATE OR REPLACE FUNCTION latest_order_date (customer_id NUMBER)
RETURN DATE
IS
l_orderdate orders.orderdate%TYPE;
BEGIN
SELECT orderdate INTO l_orderdate
FROM orders
ORDER BY orderdate DESC
FETCH FIRST 1 ROW ONLY;

RETURN l_orderdate;
END;

--###calling function

DECLARE
order_date orders.orderdate%TYPE
BEGIN
customer_id=latest_order_date('BONAP')
DBMS_OUTPUT.PUT_LINE(orderdate)
END;

--Get the top 10 most expensive products.
SELECT * FROM
(
    SELECT DISTINCT ProductName as EXPENSIVE_PRODUCTS, 
           UnitPrice
    from Products
    order by UnitPrice desc
)
FETCH NEXT 10 ROWS ONLY;

--  Rank products by the number of units in stock in each product category

SELECT DENSE_RANK() OVER(PARTITION BY categoryid 
                        ORDER BY unitsinstock) productrank,productid,productname,categoryid,unitsinstock 
FROM products;

--  Rank customers by the total sales amount within each order date

SELECT DENSE_RANK() OVER(PARTITION BY o.orderdate ORDER BY (ord.unitprice*ord.quantity) DESC),o.orderdate from customers c INNER JOIN orders o
USING (customerid) INNER JOIN orderdetails ord USING (orderid) ;

--For each order, calculate a subtotal for each Order (identified by OrderID)
select OrderID, 
    to_char(sum(UnitPrice * Quantity * (1 - Discount)), '$99,999.99') as Subtotal
from OrderDetails
group by OrderID
order by OrderID;

--Sales by Year for each order. Hint: Get 
--Subtotal as sum(UnitPrice * Quantity * (1 - Discount)) for every order_id then join with orders table
select distinct a.ShippedDate, 
    a.OrderID, 
    b.Subtotal, 
    to_char(a.ShippedDate,'YYYY') as "Year"
from Orders a 
inner join
(
    -- Get subtotal for each order
    select distinct OrderID, 
        to_char(sum(UnitPrice * Quantity * (1 - Discount)), '$99,999.99') as Subtotal
    from OrderDetails
    group by OrderID    
) b on a.OrderID = b.OrderID
where a.ShippedDate is not null
    and a.ShippedDate between to_date('24/12/1996', 'DD/MM/YYYY') 
                               and to_date('30/09/1997', 'DD/MM/YYYY')
order by a.ShippedDate;

--Get Employee sales by country names
select distinct a.Country, 
    a.LastName, 
    a.FirstName, 
    b.ShippedDate, 
    b.OrderID, 
    c.Subtotal as Sale_Amount
from Employees a
inner join Orders b on b.EmployeeID = a.EmployeeID
inner join 
(
    -- Get subtotal for each order
    select distinct OrderID, 
        to_char(sum(UnitPrice * Quantity * (1 - Discount)), '$99,999.99') as Subtotal
    from OrderDetails
    group by OrderID    
) c on b.OrderID = c.OrderID
where b.ShippedDate between to_date('24/12/1996', 'DD/MM/YYYY') 
                             and to_date('30/09/1997', 'DD/MM/YYYY')
order by a.LastName, a.FirstName, a.Country, b.ShippedDate;

--Alphabetical list of products
select distinct b.*, a.CategoryName
from Categories a 
inner join Products b on a.CategoryID = b.CategoryID
where b.Discontinued = 0
order by b.ProductName;

--Display the current Productlist 
--Hint: Discontinued='N'
select ProductID, ProductName
from Products
where Discontinued = 0
order by ProductName;

--Calculate sales price for each order after discount is applied.
select distinct y.OrderID, 
    y.ProductID, 
    x.ProductName, 
    y.UnitPrice, 
    y.Quantity, 
    y.Discount, 
    y.UnitPrice * y.Quantity * (1 - y.Discount) as Extendedprice
from Products x
inner join OrderDetails y on x.ProductID = y.ProductID
order by y.OrderID;

--Sales by Category: For each category, we get the list of products sold and the total sales amount.
select distinct a.CategoryID, 
    a.CategoryName, 
    b.ProductName, 
    sum(c.ExtendedPrice) as ProductSales
from Categories a 
inner join Products b on a.CategoryID = b.CategoryID
inner join 
(
    select distinct y.OrderID, 
        y.ProductID, 
        x.ProductName, 
        y.UnitPrice, 
        y.Quantity, 
        y.Discount, 
        y.UnitPrice * y.Quantity * (1 - y.Discount) as ExtendedPrice
    from Products x
    inner join OrderDetails y on x.ProductID = y.ProductID
    order by y.OrderID
) c on c.ProductID = b.ProductID
inner join Orders d on d.OrderID = c.OrderID
where d.OrderDate between to_date('1/1/1997', 'DD/MM/YYYY') 
                           and to_date('31/12/1997', 'DD/MM/YYYY')
group by a.CategoryID, a.CategoryName, b.ProductName
order by a.CategoryName, b.ProductName, ProductSales;

-- Sales by Category: For each category, we get the list of products sold and the total sales amount.
SELECT c.categoryid,c.categoryname,p.productname
FROM categories c
INNER JOIN products p
ON c.categoryid=p.categoryid;

-- Displays products(productname,unitprice) whos price is greater than avg(price)

CREATE OR REPLACE VIEW vwproducts_above_averageprice
AS
SELECT productname,unitprice
FROM products
WHERE unitprice >(
SELECT AVG(unitprice)
FROM products)
ORDER BY unitprice;

-- Display product(productname), customers(companyname), orders(orderyear)

CREATE OR REPLACE VIEW vwquarterly_ordersby_product
AS
SELECT p.productname,c.companyname,EXTRACT(YEAR FROM o.orderdate) orderyear
FROM customers c
INNER JOIN orders o
ON c.customerid=o.customerid
INNER JOIN orderdetails ord
ON o.orderid=ord.orderid
INNER JOIN products p
ON ord.productid=p.productid;

-- Display Supplier Continent wise sum of unitinstock.

CREATE OR REPLACE VIEW vwunitsinstock
AS
SELECT SUM(p.unitprice) as totalprice,'UK' AS continent 
from suppliers s
INNER JOIN products p
USING (supplierid)
WHERE s.country IN ('UK','Spain','Sweden','Germany','Norway','Denmark','Netherlands','Finland','Italy','France') 
UNION
SELECT SUM(p.unitprice) as totalprice,'America' AS continent 
from suppliers s
INNER JOIN products p
USING (supplierid)
WHERE s.country IN ('USA','Canada','Brazil','Asia-Pacific');

-- Display top 10 expensive products

CREATE OR REPLACE VIEW vw10most_expensive_products
AS
SELECT productid,productname,unitprice 
FROM products 
ORDER BY unitprice DESC 
FETCH FIRST 10 ROWS;

-- Display customer supplier by city

CREATE OR REPLACE VIEW vwcustomer_supplier_bycity
AS
SELECT city,companyname,contactname,'suppliers' as relationship
FROM suppliers
UNION
SELECT city,companyname,contactname,'customers' as relationship
FROM customers;


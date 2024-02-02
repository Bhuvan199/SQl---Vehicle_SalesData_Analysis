-- querry 1- compute total order value for each customer

select 
customerNumber,c.customerName,
sum(quantityOrdered*priceEach) as "totalvalue"
from orderdetails od
join orders o
using(orderNumber)
join customers c
using(customerNumber)
group by customerNumber;


-- querry 2 - compute total order value for each unique order sorted by total order value
select o.orderNumber,
sum(quantityOrdered * priceEach) as "total_value"
from orders o
join orderdetails od
using(orderNumber)
group by orderNumber
order by  total_value desc;

-- querry3 - compute value of each unique order with customer details sorted by total order value

select o.orderNumber,
customerNumber,c.customerName,
c.country,
o.orderDate,
sum(quantityOrdered*priceEach) as "total_value"
from orderdetails od
join orders o
using(orderNumber)
join customers c
using(customerNumber)
group by orderNumber
order by total_value desc;

-- queery 4 - value of each unique order , its customer , and sales employee associated with it sorted by order values

select orderNumber,
c.customerNumber,
c.customerName,
e.firstName as "employee_name",
sum(quantityOrdered * priceEach) as "total_value"
 from orderdetails od
join orders o 
using(orderNumber)
join customers c
using(customerNumber)
join employees e
on c.salesRepEmployeeNumber  = e.employeeNumber
group by orderNumber
order by total_value desc;

-- querry 5 - number of orders by each customer
select c.customerNumber,
c.customerName,
count(*) as"total_orders" 
from orders o
join customers c
using(customerNumber)
group by customerNumber;

-- querry 6 - count of orders through each sales representatives

select employeeNumber,
e.firstName,
e.lastName,
count(*) as "total_orders" from orders o 
join customers c
using(customerNumber)
join employees e
on c.salesRepEmployeeNumber = e.employeeNumber
group by employeeNumber;

-- querry 7 -- country wise orders

select country,
count(*) as "total_orders"
from orders o
join customers c
using(customerNumber)
group by country;

-- querry 8 - customer with min order values from france

select c.customerNumber,c.customerName,c.country,
sum(quantityOrdered*priceEach) as "total_order_value"
from orderdetails od
join orders o 
using (orderNumber)
join customers c
using(customerNumber)
where country = "France"
group by customerNumber
order by total_order_value
limit 1;

-- querry 9 - customers who have never placed any order(subquery and joins)
select distinct c.customerNumber,
c.customername,
o.orderNumber
from orders o 
right join customers c
using(customerNumber)
where orderNumber is null;


-- with subquerry

select customerNumber from customers
where customerNumber not in 
(select distinct customerNumber 
from orders);

-- querry 10 - find out cars that are costlier than avg cost of all cars

select productName,productLine,MSRP from products
where productLine regexp "^cars|cars$" and MSRP >
(select avg(MSRP) from products
where productLine regexp "^cars|cars$");

-- querry 11- find all products that are costlier than the max price of all trucks
select productName,productLine,MSRP
from products
where MSRP >
(select max(MSRP) from products
where productLine regexp "^trucks|trucks$");

-- queery 12- find products whose msrp is more than avg(msrp) in there corresponding productline

select productName,productLine,MSRP 
from products p
where MSRP>
(select avg(MSRP) from products
where productLine = p.productLine);
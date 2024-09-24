--Creating database & using it
create database Ecommerce
use Ecommerce

--Creating tables as per schema given
create table customers (
    customer_id int primary key,
    first_name varchar(100) not null,
	last_name varchar(100) not null,
    email varchar(100) not null unique,
    password varchar(255) not null,
	address varchar(255) not null
);
create table products (
    product_id int primary key,
    product_name varchar(100) not null,
    description text,
	price decimal(10, 2) not null,
    stock_quantity int not null
);
create table cart (
    cart_id int primary key,
    customer_id int not null,
    product_id int not null,
    quantity int not null,
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id)
);
create table orders (
    order_id int primary key,
    customer_id int not null,
    order_date date not null,
    total_amount decimal(10, 2) not null,
    shipping_address varchar(255) not null,
    foreign key (customer_id) references customers(customer_id)
);
create table order_items (
    order_item_id int primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null,
	item_amount int not null,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

--Inserting data into table as per sample data given
insert into products (product_id, product_name, description, price, stock_quantity) values
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

insert into customers (customer_id, first_name, last_name, email, password, address) values
(1, 'John', 'Doe', 'johndoe@example.com', 'password123', '123 Main St, City'),
(2, 'Jane', 'Smith', 'janesmith@example.com', 'password456', '456 Elm St, Town'),
(3, 'Robert', 'Johnson', 'robert@example.com', 'password789', '789 Oak St, Village'),
(4, 'Sarah', 'Brown', 'sarah@example.com', 'password101', '101 Pine St, Suburb'),
(5, 'David', 'Lee', 'david@example.com', 'password234', '234 Cedar St, District'),
(6, 'Laura', 'Hall', 'laura@example.com', 'password567', '567 Birch St, County'),
(7, 'Michael', 'Davis', 'michael@example.com', 'password890', '890 Maple St, State'),
(8, 'Emma', 'Wilson', 'emma@example.com', 'password321', '321 Redwood St, Country'),
(9, 'William', 'Taylor', 'william@example.com', 'password432', '432 Spruce St, Province'),
(10, 'Olivia', 'Adams', 'olivia@example.com', 'password765', '765 Fir St, Territory');

insert into orders (order_id, customer_id, order_date, total_amount, shipping_address)
select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.total_amount,
    c.address
from
    (values
        (1, 1, '2023-01-05', 1200.00),
        (2, 2, '2023-02-10', 900.00),
        (3, 3, '2023-03-15', 300.00),
        (4, 4, '2023-04-20', 150.00),
        (5, 5, '2023-05-25', 1800.00),
        (6, 6, '2023-06-30', 400.00),
        (7, 7, '2023-07-05', 700.00),
        (8, 8, '2023-08-10', 160.00),
        (9, 9, '2023-09-15', 140.00),
        (10, 10, '2023-10-20', 1400.00)
    ) as o(order_id, customer_id, order_date, total_amount)
join customers c on o.customer_id = c.customer_id;

insert into order_items (order_item_id, order_id, product_id, quantity, item_amount) values
(1, 1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00);

insert into cart (cart_id, customer_id, product_id, quantity) values
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);

--Queries
--1. Update refrigerator product price to 800.

update products
set price = 800
where product_name = 'Refrigerator';

--------------------------------------------------------------------------------
--2. Remove all cart items for a specific customer. (Let's take eg. customer 3)

delete from cart
where customer_id = 3;

--------------------------------------------------
--3. Retrieve Products Priced Below $100.

select * from products
where price < 100;

--Output
--product_id  product_name  description  price   stock_quantity
--6	Coffee Maker	Automatic coffee maker	50.00	25
--8	Microwave Oven	Countertop microwave	80.00	15
--9	Blender	High-speed blender	70.00	20

----------------------------------------------------------
--4. Find Products with Stock Quantity Greater Than 5.

select * from products
where stock_quantity > 5;

--Output
--product_id   product_name   description   price   stock_quantity
--1	Laptop	High-performance laptop	800.00	10
--2	Smartphone	Latest smartphone	600.00	15
--3	Tablet	Portable tablet	300.00	20
--4	Headphones	Noise-canceling	150.00	30
--6	Coffee Maker	Automatic coffee maker	50.00	25
--7	Refrigerator	Energy-efficient	800.00	10
--8	Microwave Oven	Countertop microwave	80.00	15
--9	Blender	High-speed blender	70.00	20
--10	Vacuum Cleaner	Bagless vacuum cleaner	120.00	10

-----------------------------------------------------------------
--5. Retrieve Orders with Total Amount Between $500 and $1000.

select * from orders
where total_amount between 500 and 1000;

--Output
--order_id customer_id order_date total_amount  shipping_address 
--2	2	2023-02-10	900.00	456 Elm St, Town
--7	7	2023-07-05	700.00	890 Maple St, State

------------------------------------------------------
--6. Find Products which name end with letter ‘r’.

select * from products
where product_name like '%r';

--Output
--product_id  product_name  description  price stock_quantity
--6	Coffee Maker	Automatic coffee maker	50.00	25
--7	Refrigerator	Energy-efficient	800.00	10
--9	Blender	High-speed blender	70.00	20
--10	Vacuum Cleaner	Bagless vacuum cleaner	120.00	10

-----------------------------------------------
--7. Retrieve Cart Items for Customer 5.

select * from cart
where customer_id = 5;

--Output
--cart_id customer_id product_id quantity
--7	5	1	1

-------------------------------------------------
--8. Find Customers Who Placed Orders in 2023.

select distinct c.*
from customers c
join orders o on c.customer_id = o.customer_id
where year(o.order_date) = 2023;

--Output
--customer_id first_name last_name email  password   address
--1	John	Doe	johndoe@example.com	password123	123 Main St, City
--2	Jane	Smith	janesmith@example.com	password456	456 Elm St, Town
--3	Robert	Johnson	robert@example.com	password789	789 Oak St, Village
--4	Sarah	Brown	sarah@example.com	password101	101 Pine St, Suburb
--5	David	Lee	david@example.com	password234	234 Cedar St, District
--6	Laura	Hall	laura@example.com	password567	567 Birch St, County
--7	Michael	Davis	michael@example.com	password890	890 Maple St, State
--8	Emma	Wilson	emma@example.com	password321	321 Redwood St, Country
--9	William	Taylor	william@example.com	password432	432 Spruce St, Province
--10	Olivia	Adams	olivia@example.com	password765	765 Fir St, Territory

----------------------------------------------------------------------
--9. Determine the Minimum Stock Quantity for Each Product Category.

select product_name, min(stock_quantity) as min_stock
from products
group by product_name;

--Output
--product_name min_stock
--Blender	20
--Coffee Maker	25
--Headphones	30
--Laptop	10
--Microwave Oven	15
--Refrigerator	10
--Smartphone	15
--Tablet	20
--TV	5
--Vacuum Cleaner	10

-------------------------------------------------------------
--10. Calculate the Total Amount Spent by Each Customer.

select c.customer_id, c.first_name, c.last_name, sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name;

--Output
--customer_id first_name last_name total_spent
--1	John	Doe	1200.00
--2	Jane	Smith	900.00
--3	Robert	Johnson	300.00
--4	Sarah	Brown	150.00
--5	David	Lee	1800.00
--6	Laura	Hall	400.00
--7	Michael	Davis	700.00
--8	Emma	Wilson	160.00
--9	William	Taylor	140.00
--10	Olivia	Adams	1400.00

----------------------------------------------------------
--11. Find the Average Order Amount for Each Customer.

select c.customer_id, c.first_name, c.last_name, avg(o.total_amount) as avg_order_amount
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name;

--Output
--customer_id first_name last_name avg_order_amount
--1	John	Doe	1200.000000
--2	Jane	Smith	900.000000
--3	Robert	Johnson	300.000000
--4	Sarah	Brown	150.000000
--5	David	Lee	1800.000000
--6	Laura	Hall	400.000000
--7	Michael	Davis	700.000000
--8	Emma	Wilson	160.000000
--9	William	Taylor	140.000000
--10	Olivia	Adams	1400.000000

--------------------------------------------------------------
--12. Count the Number of Orders Placed by Each Customer.

select c.customer_id, c.first_name, c.last_name, count(o.order_id) as num_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name;

--Output
--customer_id first_name last_name num_orders
--1	John	Doe	1
--2	Jane	Smith	1
--3	Robert	Johnson	1
--4	Sarah	Brown	1
--5	David	Lee	1
--6	Laura	Hall	1
--7	Michael	Davis	1
--8	Emma	Wilson	1
--9	William	Taylor	1
--10	Olivia	Adams	1

----------------------------------------------------------
--13. Find the Maximum Order Amount for Each Customer.

select c.customer_id, c.first_name, c.last_name, max(o.total_amount) as max_order_amount
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name;

--Output
--customer_id first_name last_name max_order_amount
--1	John	Doe	1200.00
--2	Jane	Smith	900.00
--3	Robert	Johnson	300.00
--4	Sarah	Brown	150.00
--5	David	Lee	1800.00
--6	Laura	Hall	400.00
--7	Michael	Davis	700.00
--8	Emma	Wilson	160.00
--9	William	Taylor	140.00
--10	Olivia	Adams	1400.00

--------------------------------------------------------------
--14. Get Customers Who Placed Orders Totaling Over $1000.

select c.customer_id, c.first_name, c.last_name, sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name
having sum(o.total_amount) > 1000;

--Output
--customer_id first_name last_name total_spent
--1	John	Doe	1200.00
--5	David	Lee	1800.00
--10	Olivia	Adams	1400.00

-------------------------------------------------------
--15. Subquery to Find Products Not in the Cart.

select * from products
where product_id not in (select product_id from cart);

--Output
--product_id product_name description price stock_quantity
--4	Headphones	Noise-canceling	150.00	30
--5	TV	4K Smart TV	900.00	5
--8	Microwave Oven	Countertop microwave	80.00	15

--------------------------------------------------------------
--16. Subquery to Find Customers Who Haven't Placed Orders.

--Inserting additional customer who hasn't placed an order

insert into customers (customer_id, first_name, last_name, email, password, address) values
(11, 'David', 'Thomas', 'davidthomas@example.com', 'password456', '456 St, New York')

select * from customers
where customer_id not in (select customer_id from orders);

----------------------------------------------------------------------------
--17. Subquery to Calculate the Percentage of Total Revenue for a Product.

select p.product_id, p.product_name, 
       round(((select sum(item_amount) from order_items where product_id = p.product_id) 
	   * 100.0 /(select sum(item_amount) from order_items)), 2) as revenue_percentage
from products p;

--Output
--product_id product_name revenue_percentage
--1	Laptop	27.90
--2	Smartphone	34.88
--3	Tablet	3.48
--4	Headphones	6.97
--5	TV	20.93
--6	Coffee Maker	0.58
--7	Refrigerator	NULL
--8	Microwave Oven	NULL
--9	Blender	2.44
--10	Vacuum Cleaner	2.79

----------------------------------------------------
--18. Subquery to Find Products with Low Stock.

select * from products
where stock_quantity < 5;

--Output
--Empty Table

---------------------------------------------------------------------
--19. Subquery to Find Customers Who Placed High-Value Orders.

select c.*
from customers c
join (
    select customer_id, sum(total_amount) as total_spent
    from orders
    group by customer_id
    having sum(total_amount) > 1000
) o on c.customer_id = o.customer_id;
--------------------------------------------------------------------------------
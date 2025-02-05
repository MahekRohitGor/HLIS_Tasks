create database db_30;
use db_30;

create table tbl_user(
	user_id bigint primary key auto_increment,
    username varchar(128),
    mobile_number char(16),
    roles enum('Customer', 'Supplier'),
    is_active boolean,
    updatedate datetime,
    insertdate datetime
);

create table tbl_product(
	product_id bigint primary key auto_increment,
    product_name varchar(128),
    supplier_id bigint references tbl_user(user_id),
    quantity int,
    price int,
    is_active boolean,
    updatedate datetime,
    insertdate datetime
);

create table tbl_order(
	id bigint primary key auto_increment,
    order_id char(7),
    cust_id bigint references tbl_user(user_id),
    product_id bigint references tbl_product(product_id),
    shipper_id bigint references tbl_user(user_id),
    order_date datetime,
    status_ enum('Pending', 'Cancelled', 'Delivered'),
    is_active boolean,
    updatedate datetime,
    insertdate datetime
);

-- drop table tbl_order;
-- drop table tbl_user;
-- drop table tbl_product;

INSERT INTO tbl_user (username, mobile_number, roles, is_active, updatedate, insertdate) VALUES
('tanisha', '9876544553', 'Customer', TRUE, '2024-01-01 10:30:00', '2023-12-31 09:00:00');

INSERT INTO tbl_user (username, mobile_number, roles, is_active, updatedate, insertdate) VALUES
('JohnDoe', '9876543210', 'Customer', TRUE, '2024-01-01 10:30:00', '2023-12-31 09:00:00'),
('JaneSmith', '8765432109', 'Supplier', TRUE, '2024-01-02 11:00:00', '2023-12-30 08:45:00'),
('AliceBrown', '7654321098', 'Customer', FALSE, '2024-01-03 12:15:00', '2023-12-29 10:20:00'),
('BobWhite', '6543210987', 'Supplier', TRUE, '2024-01-04 14:00:00', '2023-12-28 11:50:00'),
('CharlieBlack', '5432109876', 'Customer', TRUE, '2024-01-05 15:30:00', '2023-12-27 07:30:00'),
('DavidGreen', '4321098765', 'Supplier', TRUE, '2024-01-06 16:45:00', '2023-12-26 06:40:00'),
('EvaBlue', '3210987654', 'Customer', TRUE, '2024-01-07 17:10:00', '2023-12-25 12:10:00'),
('FrankYellow', '2109876543', 'Supplier', FALSE, '2024-01-08 18:20:00', '2023-12-24 09:50:00'),
('GraceRed', '1098765432', 'Customer', TRUE, '2024-01-09 19:05:00', '2023-12-23 08:20:00'),
('HenryPink', '1987654321', 'Supplier', TRUE, '2024-01-10 20:40:00', '2023-12-22 07:45:00'),
('IvyCyan', '9876543211', 'Customer', TRUE, '2024-01-11 21:55:00', '2023-12-21 10:10:00'),
('JackSilver', '8765432101', 'Supplier', FALSE, '2024-01-12 22:30:00', '2023-12-20 12:15:00'),
('KateGold', '7654321091', 'Customer', TRUE, '2024-01-13 23:15:00', '2023-12-19 13:30:00'),
('LeoPlatinum', '6543210981', 'Supplier', TRUE, '2024-01-14 09:45:00', '2023-12-18 14:00:00'),
('MiaDiamond', '5432109871', 'Customer', TRUE, '2024-01-15 10:10:00', '2023-12-17 16:20:00'),
('NickPearl', '4321098761', 'Supplier', FALSE, '2024-01-16 11:30:00', '2023-12-16 17:50:00'),
('OliviaRuby', '3210987651', 'Customer', TRUE, '2024-01-17 12:05:00', '2023-12-15 18:30:00'),
('PaulEmerald', '2109876541', 'Supplier', TRUE, '2024-01-18 13:15:00', '2023-12-14 19:45:00'),
('QuincyTopaz', '1098765431', 'Customer', TRUE, '2024-01-19 14:50:00', '2023-12-13 21:10:00'),
('RachelSapphire', '1987654322', 'Supplier', FALSE, '2024-01-20 15:20:00', '2023-12-12 23:00:00'),
('SteveOpal', '9876543222', 'Customer', TRUE, '2024-01-21 16:30:00', '2023-12-11 09:30:00'),
('TinaAmethyst', '8765432112', 'Supplier', TRUE, '2024-01-22 17:10:00', '2023-12-10 11:15:00'),
('UmaGarnet', '7654321102', 'Customer', TRUE, '2024-01-23 18:45:00', '2023-12-09 12:40:00'),
('VictorOnyx', '6543210992', 'Supplier', FALSE, '2024-01-24 19:55:00', '2023-12-08 13:50:00'),
('WendyJade', '5432109882', 'Customer', TRUE, '2024-01-25 20:20:00', '2023-12-07 15:30:00'),
('XanderCoral', '4321098772', 'Supplier', TRUE, '2024-01-26 21:40:00', '2023-12-06 16:45:00'),
('YaraLapis', '3210987662', 'Customer', TRUE, '2024-01-27 22:50:00', '2023-12-05 17:50:00'),
('ZanePeridot', '2109876552', 'Supplier', FALSE, '2024-01-28 23:10:00', '2023-12-04 19:00:00'),
('AdamSpinel', '1098765442', 'Customer', TRUE, '2024-01-29 09:15:00', '2023-12-03 21:30:00'),
('BellaQuartz', '1987654332', 'Supplier', TRUE, '2024-01-30 10:25:00', '2023-12-02 22:45:00');

INSERT INTO tbl_product (product_name, supplier_id, quantity, price, is_active, updatedate, insertdate) VALUES
('Product A', 2, 50, 100, TRUE, '2024-01-01 11:00:00', '2023-12-31 09:30:00'),
('Product B', 4, 30, 200, TRUE, '2024-01-02 12:00:00', '2023-12-30 08:50:00'),
('Product C', 6, 20, 150, FALSE, '2024-01-03 13:15:00', '2023-12-29 10:10:00'),
('Product D', 8, 25, 180, TRUE, '2024-01-04 14:30:00', '2023-12-28 11:30:00'),
('Product E', 10, 40, 250, TRUE, '2024-01-05 15:45:00', '2023-12-27 07:45:00'),
('Product F', 12, 60, 300, TRUE, '2024-01-06 16:20:00', '2023-12-26 06:20:00'),
('Product G', 14, 10, 350, FALSE, '2024-01-07 17:30:00', '2023-12-25 12:00:00'),
('Product H', 16, 80, 400, TRUE, '2024-01-08 18:10:00', '2023-12-24 09:10:00'),
('Product I', 18, 15, 450, TRUE, '2024-01-09 19:25:00', '2023-12-23 08:30:00'),
('Product J', 20, 35, 500, TRUE, '2024-01-10 20:30:00', '2023-12-22 07:10:00'),
('Product K', 22, 55, 550, FALSE, '2024-01-11 21:40:00', '2023-12-21 10:30:00'),
('Product L', 24, 75, 600, TRUE, '2024-01-12 22:50:00', '2023-12-20 12:20:00'),
('Product M', 26, 85, 650, TRUE, '2024-01-13 23:15:00', '2023-12-19 13:00:00'),
('Product N', 28, 95, 700, FALSE, '2024-01-14 09:45:00', '2023-12-18 14:10:00'),
('Product O', 30, 45, 750, TRUE, '2024-01-15 10:10:00', '2023-12-17 16:20:00'),
('Product P', 2, 25, 800, TRUE, '2024-01-16 11:30:00', '2023-12-16 17:50:00'),
('Product Q', 4, 35, 850, FALSE, '2024-01-17 12:05:00', '2023-12-15 18:30:00'),
('Product R', 6, 45, 900, TRUE, '2024-01-18 13:15:00', '2023-12-14 19:45:00'),
('Product S', 8, 55, 950, TRUE, '2024-01-19 14:50:00', '2023-12-13 21:10:00'),
('Product T', 10, 65, 1000, FALSE, '2024-01-20 15:20:00', '2023-12-12 23:00:00'),
('Product U', 12, 75, 1050, TRUE, '2024-01-21 16:30:00', '2023-12-11 09:30:00'),
('Product V', 14, 85, 1100, TRUE, '2024-01-22 17:10:00', '2023-12-10 11:15:00'),
('Product W', 16, 95, 1150, TRUE, '2024-01-23 18:45:00', '2023-12-09 12:40:00'),
('Product X', 18, 100, 1200, FALSE, '2024-01-24 19:55:00', '2023-12-08 13:50:00'),
('Product Y', 20, 110, 1250, TRUE, '2024-01-25 20:20:00', '2023-12-07 15:30:00'),
('Product Z', 22, 120, 1300, TRUE, '2024-01-26 21:40:00', '2023-12-06 16:45:00'),
('Product AA', 24, 130, 1350, TRUE, '2024-01-27 22:50:00', '2023-12-05 17:50:00'),
('Product BB', 26, 140, 1400, FALSE, '2024-01-28 23:10:00', '2023-12-04 19:00:00'),
('Product CC', 28, 150, 1450, TRUE, '2024-01-29 09:15:00', '2023-12-03 21:30:00'),
('Product DD', 30, 160, 1500, TRUE, '2024-01-30 10:25:00', '2023-12-02 22:45:00');

INSERT INTO tbl_order (order_id, cust_id, product_id, shipper_id, order_date, status_, is_active, updatedate, insertdate) VALUES
('ORD034', 3, 1, 2, '2024-01-01 10:30:00', 'Pending', TRUE, '2024-01-02 09:00:00', '2024-01-01 08:00:00');

INSERT INTO tbl_order (order_id, cust_id, product_id, shipper_id, order_date, status_, is_active, updatedate, insertdate) VALUES
('ORD001', 1, 1, 2, '2024-01-01 10:30:00', 'Pending', TRUE, '2024-01-02 09:00:00', '2024-01-01 08:00:00'),
('ORD002', 3, 2, 4, '2024-01-03 11:00:00', 'Delivered', TRUE, '2024-01-04 09:30:00', '2024-01-03 07:30:00'),
('ORD003', 5, 3, 6, '2024-01-05 12:15:00', 'Cancelled', FALSE, '2024-01-06 10:00:00', '2024-01-05 06:50:00'),
('ORD004', 7, 4, 8, '2024-01-07 13:45:00', 'Pending', TRUE, '2024-01-08 12:00:00', '2024-01-07 09:30:00'),
('ORD005', 9, 5, 10, '2024-01-09 14:20:00', 'Delivered', TRUE, '2024-01-10 10:45:00', '2024-01-09 07:20:00'),
('ORD006', 11, 6, 12, '2024-01-11 15:10:00', 'Cancelled', FALSE, '2024-01-12 11:00:00', '2024-01-11 06:45:00'),
('ORD007', 13, 7, 14, '2024-01-13 16:30:00', 'Pending', TRUE, '2024-01-14 09:00:00', '2024-01-13 08:30:00'),
('ORD008', 15, 8, 16, '2024-01-15 17:40:00', 'Delivered', TRUE, '2024-01-16 08:45:00', '2024-01-15 07:15:00'),
('ORD009', 17, 9, 18, '2024-01-17 18:50:00', 'Cancelled', FALSE, '2024-01-18 07:30:00', '2024-01-17 06:20:00'),
('ORD010', 19, 10, 20, '2024-01-19 19:15:00', 'Pending', TRUE, '2024-01-20 12:20:00', '2024-01-19 09:10:00'),
('ORD011', 21, 11, 22, '2024-01-21 20:25:00', 'Delivered', TRUE, '2024-01-22 11:30:00', '2024-01-21 10:00:00'),
('ORD012', 23, 12, 24, '2024-01-23 21:40:00', 'Cancelled', FALSE, '2024-01-24 09:50:00', '2024-01-23 08:15:00'),
('ORD013', 25, 13, 26, '2024-01-25 22:55:00', 'Pending', TRUE, '2024-01-26 07:30:00', '2024-01-25 06:45:00'),
('ORD014', 27, 14, 28, '2024-01-27 09:30:00', 'Delivered', TRUE, '2024-01-28 06:15:00', '2024-01-27 04:30:00'),
('ORD015', 29, 15, 30, '2024-01-29 10:50:00', 'Cancelled', FALSE, '2024-01-30 05:20:00', '2024-01-29 03:10:00'),
('ORD016', 2, 16, 1, '2024-01-31 12:10:00', 'Pending', TRUE, '2024-02-01 07:45:00', '2024-01-31 06:25:00'),
('ORD017', 4, 17, 3, '2024-02-02 13:25:00', 'Delivered', TRUE, '2024-02-03 08:50:00', '2024-02-02 05:50:00'),
('ORD018', 6, 18, 5, '2024-02-04 14:40:00', 'Cancelled', FALSE, '2024-02-05 09:15:00', '2024-02-04 07:40:00'),
('ORD019', 8, 19, 7, '2024-02-06 15:55:00', 'Pending', TRUE, '2024-02-07 10:10:00', '2024-02-06 06:30:00'),
('ORD020', 10, 20, 9, '2024-02-08 17:15:00', 'Delivered', TRUE, '2024-02-09 12:00:00', '2024-02-08 09:50:00'),
('ORD021', 12, 21, 11, '2024-02-10 18:30:00', 'Cancelled', FALSE, '2024-02-11 10:40:00', '2024-02-10 07:20:00'),
('ORD022', 14, 22, 13, '2024-02-12 19:45:00', 'Pending', TRUE, '2024-02-13 11:50:00', '2024-02-12 08:00:00'),
('ORD023', 16, 23, 15, '2024-02-14 21:00:00', 'Delivered', TRUE, '2024-02-15 13:10:00', '2024-02-14 09:30:00'),
('ORD024', 18, 24, 17, '2024-02-16 22:15:00', 'Cancelled', FALSE, '2024-02-17 14:20:00', '2024-02-16 10:45:00'),
('ORD025', 20, 25, 19, '2024-02-18 23:30:00', 'Pending', TRUE, '2024-02-19 15:30:00', '2024-02-18 12:00:00'),
('ORD026', 22, 26, 21, '2024-02-20 09:45:00', 'Delivered', TRUE, '2024-02-21 16:40:00', '2024-02-20 13:15:00'),
('ORD027', 24, 27, 23, '2024-02-22 11:00:00', 'Cancelled', FALSE, '2024-02-23 17:50:00', '2024-02-22 14:30:00'),
('ORD028', 26, 28, 25, '2024-02-24 12:15:00', 'Pending', TRUE, '2024-02-25 18:55:00', '2024-02-24 16:00:00'),
('ORD029', 28, 29, 27, '2024-02-26 13:30:00', 'Delivered', TRUE, '2024-02-27 19:30:00', '2024-02-26 17:15:00'),
('ORD030', 30, 30, 29, '2024-02-28 14:45:00', 'Pending', TRUE, '2024-02-29 20:10:00', '2024-02-28 18:30:00');

-- 1) 2nd highest price product with subquery 
select max(price) as second_max from tbl_product where price not in (select max(price) from tbl_product);

-- 2. Product details with supplier detsils 
select p.*, u.* from tbl_product as p inner join tbl_user as u on p.supplier_id = u.user_id where supplier_id in (select user_id from tbl_user where roles = "Supplier");

-- 3. Order details with customer name and shipper name
-- select o.*, u.username from tbl_order as o inner join tbl_user as u on o.cust_id = u.user_id where cust_id in (select user_id from tbl_user where roles = "Customer");
select o.*, (select username from tbl_user u where u.user_id = o.cust_id) as username from tbl_order as o where cust_id in (select user_id from tbl_user where roles = "Customer");

-- 4. Product wise order count query 
select count(*), product_id from tbl_order where product_id in (select product_id from tbl_product) group by product_id;
select count(*), product_id from tbl_order group by product_id;

-- 5. Get list of order whose status not in Cancelled 
select * from tbl_order where status_ not in (select status_ from tbl_order where status_ = "Cancelled");
select * from tbl_order where status_ != "Cancelled";

-- 6. Get list of customer with total number of order 
select count(order_id) as total_order, (select username from tbl_user as u where u.user_id = o.cust_id) as username from tbl_order as o where cust_id in (select user_id from tbl_user where roles = "Customer") group by cust_id;

-- 7. Get list of customer with total number of order and count greater than 5 
select count(order_id) as total_order, (select username from tbl_user as u where u.user_id = o.cust_id) as username from tbl_order as o where cust_id in (select user_id from tbl_user where roles = "Customer") group by cust_id having total_order>5;
 
-- 8.Get the customer who has placed the highest number of orders
select count(order_id) as total_order, (select username from tbl_user as u where u.user_id = o.cust_id) as username from tbl_order as o where cust_id in (select user_id from tbl_user where roles = "Customer") group by cust_id order by total_order desc limit 1;

-- 9.Find the suppliers who have provided products but haven't received any orders yet
select user_id, username, mobile_number from tbl_user where user_id not in (select distinct shipper_id from tbl_order) and roles = "Supplier";

-- 10.Get the total revenue generated by each supplier by summing up the prices of their products that have been ordered
select sum(price) as revenue, supplier_id from tbl_product where supplier_id in (select distinct shipper_id from tbl_order) group by supplier_id;

-- 11.Retrieve all orders and categorize them into "Recent Order" or "Old Order" using case condition
select *, 
	case
		when order_date >= date_sub(current_date(), interval 30 day) then "Recent Order"
		else "Old Order"
	end as order_category
from tbl_order;

-- 12.Fetch all orders and classify them into "High Value", "Medium Value", or "Low Value"
select o.*, p.price,
case
when p.price > 1000 then "High Value"
when p.price >500 then "Medium Valued"
else "Low Valued"
end as price_cat
from tbl_order as o inner join tbl_product as p on p.product_id = o.product_id order by o.id;

-- 13. Retrieve suppliers who supply at least one product with a price greater than 500
select count(product_id) as cnt_pro, (select username from tbl_user as u where u.user_id = p.supplier_id) as username 
from tbl_product as p where supplier_id in (select supplier_id from tbl_product) and price > 500 group by supplier_id 
having cnt_pro >=1;

-- 14.Get the list of customers who have never placed an order
-- select (select username from tbl_user as u where u.user_id = o.cust_id)as username from tbl_order as o where cust_id not in (select distinct cust_id from tbl_order );
select * from tbl_user where user_id not in (select distinct cust_id from tbl_order) and roles="Customer";

-- 15. Find the total revenue generated by each product
select sum(price*quantity) as total_revenue, product_id from tbl_product group by product_id;

-- 16. Retrieve all orders placed in the last 7 days 
select * from tbl_order where order_date >= date_sub(current_date(), interval 7 day);

-- 18.Find the most frequently ordered product
SELECT product_id, (select product_name from tbl_product as p where p.product_id = o.product_id) as productname,COUNT(*) AS order_count
FROM tbl_order as o 
GROUP BY product_id
ORDER BY order_count DESC
LIMIT 1;

select product_name, product_id from tbl_product 
where product_id = (
	select product_id from tbl_order 
    group by product_id 
    order by count(*) desc 
    limit 1
);

-- 19.Retrieve the latest order placed by each customer
select * from tbl_order o where order_date = (
	SELECT MAX(order_date) 
    FROM tbl_order 
    WHERE cust_id = o.cust_id
);
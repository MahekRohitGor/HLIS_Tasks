create database db_48;
use db_48;

create table tbl_user(
	user_id bigint primary key auto_increment,
    email_id varchar(64) unique,
    fname varchar(64),
    lname varchar(64),
    passwords varchar(64),
    dob date,
    user_interested_in enum("Men", "Women"),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_product(
	product_id bigint primary key auto_increment,
    product_name varchar(128),
    quantity_in_warehouse bigint,
    product_price float(10,2),
    currency enum("Rupees", "Dollars"),
    descriptions text,
    terms_condititions text,
    size_id bigint references tbl_size(size_id),
    gender enum("Men", "Women", "Unisex", "Other"),
    brand_id bigint references tbl_brand(brand_id),
    avg_rating float(5,2),
    sub_category_id bigint references tbl_sub_category(sub_category_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_size(
	size_id bigint primary key auto_increment,
    size_group_id bigint references tbl_size_group(size_group_id),
    size char(8),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_size_group(
	size_group_id bigint primary key auto_increment,
    size_group varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_image(
	image_id bigint primary key auto_increment,
    image_name varchar(64),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_image_product_relation(
	product_id BIGINT NOT NULL,
    image_id BIGINT NOT NULL,
    is_active BOOLEAN DEFAULT 1,
    is_deleted BOOLEAN DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id, image_id),
    FOREIGN KEY (product_id) REFERENCES tbl_product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (image_id) REFERENCES tbl_image(image_id) ON DELETE CASCADE
);

create table tbl_product_color(
	product_color_id bigint primary key auto_increment,
    product_id BIGINT NOT NULL,
    product_color_name varchar(64),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    FOREIGN KEY (product_id) REFERENCES tbl_product(product_id) ON DELETE CASCADE
);

create table tbl_brand(
	brand_id bigint primary key auto_increment,
    brand_name varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_rating(
	rating_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    product_id bigint references tbl_product(product_id),
    rating float(5,2),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_fav_of_users(
	fav_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    product_id bigint references tbl_product(product_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_save_by_users(
	save_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    product_id bigint references tbl_product(product_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_main_category(
	main_category_id bigint primary key auto_increment,
    main_category_name varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_sub_category(
	sub_category_id bigint primary key auto_increment,
    sub_category_name varchar(128),
	main_category_id bigint references tbl_main_category(main_category_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_order(
	order_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    payment_type enum ("COD", "Paypal", "Wallet", "Card"),
    total_quantity bigint,
    total_price bigint,
    order_status enum("Pending", "Placed", "Cancelled", "Delivery_to_Shipping", "Shipped", "Delivered"),
    order_date datetime,
    address_id bigint references tbl_address(address_id),
    tracking_number char(16),
    promo_code_id bigint references tbl_promo_code(promo_code_id),
    delivery_charge bigint,
    payment_status enum("Failed", "Success"),
    order_number bigint,
    shipping_id bigint references tbl_shipping(shipping_id),
    grand_total bigint,
    delivery_to_shipping_time datetime,
    shipped_time datetime,
    delivered_time datetime,
    placed_time datetime,
	is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_order_item(
	order_item_id bigint primary key auto_increment,
    order_id bigint references tbl_order(order_id),
    product_id bigint references tbl_product(product_id),
    quantity bigint,
    market_price bigint,
    offer_price bigint,
    discount int,
    final_price bigint,
    product_details text,
	is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

ALTER TABLE tbl_order 
MODIFY COLUMN total_price DECIMAL(10,2),
MODIFY COLUMN grand_total DECIMAL(10,2),
MODIFY COLUMN delivery_charge DECIMAL(10,2);

ALTER TABLE tbl_order_item 
MODIFY COLUMN market_price DECIMAL(10,2),
MODIFY COLUMN offer_price DECIMAL(10,2),
MODIFY COLUMN final_price DECIMAL(10,2);

create table tbl_shipping(
	shipping_id bigint primary key auto_increment,
    shipping_add text,
    shipping_name varchar(128),
    shipping_options enum("Express", "Free", "Expressplus"),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_address(
	address_id bigint primary key auto_increment,
    address text,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_promo_code(
	promo_code_id bigint primary key auto_increment,
    max_amt bigint,
    discount bigint,
    promocode varchar(16),
    total_usage bigint,
    total_used bigint,
    start_date datetime,
    end_date datetime,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

alter table tbl_promo_code
modify column max_amt decimal(10,2);

create table tbl_credit_debit_card(
	id bigint auto_increment Primary key ,
    user_id bigint ,
    card_number varchar(32) not null,
    expiry_date date ,
    type enum('credit','debit'),
    name_of_bank varchar(128) ,
    name_on_card varchar(128) ,
    is_active bool default 1,
    is_deleted bool default 0,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp ,
    FOREIGN KEY (user_id) REFERENCES 
    tbl_user(user_id)
 ON DELETE CASCADE
);

create table tbl_order_cnt(
	order_cnt_id bigint primary key auto_increment,
	product_id bigint,
    order_cnt bigint default 0,
    is_active bool default 1,
    is_deleted bool default 0,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    foreign key (product_id) references tbl_product(product_id)
);

insert into tbl_order_cnt (product_id) values (11), (12);

select * from tbl_order_cnt;

ALTER TABLE tbl_order
ADD COLUMN credit_debit_card_id BIGINT,
ADD CONSTRAINT fk_credit_debit_card FOREIGN KEY (credit_debit_card_id) 
REFERENCES tbl_credit_debit_card(id) ON DELETE SET NULL;


INSERT INTO tbl_user (email_id, fname, lname, passwords, dob, user_interested_in) VALUES
('user1@example.com', 'John', 'Doe', 'hashed_pass1', '1990-01-01', 'Women'),
('user2@example.com', 'Alice', 'Smith', 'hashed_pass2', '1992-02-02', 'Men'),
('user3@example.com', 'Bob', 'Brown', 'hashed_pass3', '1994-03-03', 'Women'),
('user4@example.com', 'Charlie', 'Johnson', 'hashed_pass4', '1996-04-04', 'Men'),
('user5@example.com', 'Emma', 'Davis', 'hashed_pass5', '1998-05-05', 'Women'),
('user6@example.com', 'Frank', 'White', 'hashed_pass6', '2000-06-06', 'Women'),
('user7@example.com', 'Grace', 'Miller', 'hashed_pass7', '2002-07-07', 'Men'),
('user8@example.com', 'Henry', 'Wilson', 'hashed_pass8', '2004-08-08', 'Women'),
('user9@example.com', 'Ivy', 'Moore', 'hashed_pass9', '2006-09-09', 'Men'),
('user10@example.com', 'Jack', 'Taylor', 'hashed_pass10', '2008-10-10', 'Women');

select * from tbl_size;

INSERT INTO tbl_image (image_name) VALUES
('image1.jpg'), ('image2.jpg'), ('image3.jpg'), ('image4.jpg'), ('image5.jpg'),
('image6.jpg'), ('image7.jpg'), ('image8.jpg'), ('image9.jpg'), ('image10.jpg');

INSERT INTO tbl_brand (brand_name) VALUES
('Nike'), ('Adidas'), ('Puma'), ('Reebok'), ('Under Armour'),
('Gucci'), ('Prada'), ('Levis'), ('Zara'), ('H&M');

INSERT INTO tbl_product_color (product_id, product_color_name) VALUES
(1, 'Red'), (1, 'Blue'), (2, 'Green'), (2, 'Yellow'), (2, 'Black'),
(3, 'White'), (3, 'Purple'), (4, 'Orange'), (4, 'Gray'), (4, 'Pink');

INSERT INTO tbl_size_group (size_group) VALUES
('Bottomwear'), ('General'), ('Shoes'), ('Belts');

INSERT INTO tbl_size (size_group_id, size) VALUES
(1, 'S'), (1, 'M'), (1, 'L'), (2, 'M'), (2, 'XL'),
(3, '42'), (3, '43'), (4, 'One Size'), (4, 'Free'), (2, 'Medium');

INSERT INTO tbl_main_category (main_category_name) VALUES
('Clothing'), ('Footwear'), ('Accessories'), ('Electronics');

INSERT INTO tbl_sub_category (sub_category_name, main_category_id) VALUES
('T-Shirts', 1), ('Jeans', 1), ('Sneakers', 2), ('Belts', 3), ('Headphones', 4);

INSERT INTO tbl_product (product_name, quantity_in_warehouse, product_price, currency, descriptions, terms_condititions, size_id, gender, brand_id, avg_rating, sub_category_id) VALUES
('Slim Fit T-Shirt', 100, 499.99, 'Rupees', 'Cotton T-Shirt', 'No return after 7 days', 21, 'Men', 1, 4.5, 1),
('Denim Jeans', 80, 999.99, 'Rupees', 'Regular fit jeans', 'No exchange after wash', 22, 'Men', 2, 4.3, 2),
('Running Shoes', 60, 1999.99, 'Rupees', 'Breathable sports shoes', 'Warranty for 6 months', 23, 'Unisex', 3, 4.6, 3),
('Leather Belt', 50, 799.99, 'Rupees', 'Genuine leather belt', 'Warranty for 1 year', 24, 'Men', 4, 4.2, 4),
('Wireless Headphones', 40, 2999.99, 'Rupees', 'Noise-canceling headphones', 'Warranty for 1 year', NULL, 'Other', 5, 4.8, 5);

INSERT INTO tbl_product (product_name, quantity_in_warehouse, product_price, currency, descriptions, terms_condititions, size_id, gender, brand_id, avg_rating, sub_category_id) VALUES
('Off White Dress', 20, 799.99, 'Rupees', 'Cotton', 'No return', 21, 'Women', 1, 4.5, 1);

select * from tbl_product;

INSERT INTO tbl_image_product_relation (product_id, image_id) VALUES
(11, 1), (12, 2), (13, 3), (13, 4), (13, 5),
(14, 6), (14, 7), (15, 8), (15, 9), (15, 10);

INSERT INTO tbl_rating (user_id, product_id, rating) VALUES
(1, 11, 4.5), (2, 12, 4.0), (3, 13, 5.0), (4, 14, 4.2), (5, 15, 4.8);

drop table tbl_fav_of_user;

INSERT INTO tbl_fav_of_users (user_id, product_id) VALUES
(1, 13), (2, 11), (3, 15), (4, 12), (5, 14);

INSERT INTO tbl_save_by_users (user_id, product_id) VALUES
(1, 11), (2, 13), (3, 12), (4, 15), (5, 14), (1,12), (1,15);

select * from tbl_user;

INSERT INTO tbl_address (address) VALUES
('123 Main Street, New York, NY'),
('456 Elm Street, Los Angeles, CA'),
('789 Oak Avenue, Chicago, IL'),
('321 Maple Road, Houston, TX'),
('654 Pine Lane, San Francisco, CA');

INSERT INTO tbl_shipping (shipping_add, shipping_name, shipping_options) VALUES
('123 Main Street, New York, NY', 'John Doe', 'Express'),
('456 Elm Street, Los Angeles, CA', 'Alice Smith', 'Free'),
('789 Oak Avenue, Chicago, IL', 'Bob Brown', 'Expressplus');

INSERT INTO tbl_promo_code (max_amt, discount, promocode, total_usage, total_used, start_date, end_date) VALUES
(5000, 500, 'DISCOUNT500', 100, 10, '2024-01-01', '2024-12-31'),
(1000, 100, 'SAVE100', 200, 30, '2024-02-01', '2024-12-31');

INSERT INTO tbl_credit_debit_card (user_id, card_number, expiry_date, type, name_of_bank, name_on_card) VALUES
(1, '1234567812345678', '2026-12-31', 'credit', 'Bank of America', 'John Doe'),
(2, '9876543219876543', '2025-11-30', 'debit', 'Wells Fargo', 'Alice Smith'),
(3, '5678123456781234', '2027-10-31', 'credit', 'Chase', 'Bob Brown');

select * from tbl_order_item;

ALTER TABLE tbl_order ADD COLUMN card_id BIGINT REFERENCES tbl_credit_debit_card(id);

INSERT INTO tbl_order (user_id, payment_type, total_quantity, total_price, order_status, order_date, address_id, tracking_number, promo_code_id, delivery_charge, payment_status, order_number, shipping_id, grand_total, delivery_to_shipping_time, shipped_time, delivered_time, placed_time, credit_debit_card_id) VALUES
(1, 'Card', 2, 2499, 'Placed', '2024-08-01 10:00:00', 1, 'TRK12345678', 1, 100, 'Success', 10001, 1, 2599, '2024-08-02 12:00:00', '2024-08-03 15:00:00', '2024-08-04 18:00:00', '2024-08-01 10:05:00', 1),
(2, 'Wallet', 1, 999, 'Shipped', '2024-08-05 14:30:00', 2, 'TRK87654321', NULL, 50, 'Success', 10002, 2, 1049, '2024-08-06 16:00:00', '2024-08-07 18:00:00', NULL, '2024-08-05 14:35:00', 2);

INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, offer_price, discount, final_price, product_details) VALUES
(1, 11, 1, 499, 449, 10, 449, 'Slim Fit T-Shirt'),
(1, 13, 1, 1999, 1799, 10, 1799, 'Running Shoes'),
(2, 12, 1, 999, 899, 10, 899, 'Denim Jeans');

-- Triggers --
-- Update total_quantity
DELIMITER $$
CREATE TRIGGER trg_update_total_quantity
AFTER INSERT ON tbl_order_item
FOR EACH ROW
BEGIN
    UPDATE tbl_order 
    SET total_quantity = (SELECT SUM(quantity) FROM tbl_order_item WHERE order_id = NEW.order_id)
    WHERE order_id = NEW.order_id;
END $$
DELIMITER ;


-- Update Final price and offer price
DELIMITER $$
CREATE TRIGGER trg_update_prices_new2
BEFORE INSERT ON tbl_order_item
FOR EACH ROW
BEGIN
	SET NEW.offer_price = NEW.market_price - NEW.discount;
    SET NEW.final_price = NEW.quantity * NEW.offer_price;
END $$
DELIMITER ;

-- Trigger to update avg_rating
DELIMITER $$
DROP TRIGGER IF EXISTS trg_update_avg_ratings_new;
create trigger trg_update_avg_ratings_new
after insert on tbl_rating
for each row
begin
	update tbl_product set avg_rating = (
    select avg(rating) from tbl_rating where product_id = new.product_id
    )
    where product_id = new.product_id;
end $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_update_cnt;


-- Trigger
-- update cnt table when order is placed
DELIMITER $$
DROP TRIGGER IF EXISTS trg_update_cnt;
CREATE TRIGGER trg_update_cnt
AFTER INSERT ON tbl_order_item
FOR EACH ROW
BEGIN
update tbl_order_cnt set order_cnt = (
	select count(*) from tbl_order_item where product_id = new.product_id
)
 where product_id = new.product_id;
END $$
DELIMITER ;

INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount, product_details)
VALUES (1, 15, 2, 1000, 10, 'Product A');

insert into tbl_order_cnt (product_id) values (13),(14),(15);

select * from tbl_order_cnt;
select * from tbl_order_item;
select count(product_id) from tbl_order_item group by product_id;
-- Checking
select * from tbl_rating;
select * from tbl_product;

INSERT INTO tbl_rating (user_id, product_id, rating) VALUES (1, 11, 1);
SELECT * FROM tbl_product;

-- Check
INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount, product_details)
VALUES (1, 11, 2, 1000, 10, 'Product A');
INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount, product_details)
VALUES (2, 12, 3, 1200, 20, 'Product B');
SELECT * FROM tbl_order;
select * from tbl_order_item;

-- Display all products with categories and sub categories
SELECT product_name, 
quantity_in_warehouse, 
product_price, 
currency, 
brand_id, 
avg_rating,
image_id,
sc.sub_category_name,
c.main_category_name
FROM 
tbl_product p
inner join
tbl_sub_category sc on p.sub_category_id = sc.sub_category_id
inner join 
tbl_main_category c on c.main_category_id = sc.main_category_id;

INSERT INTO tbl_product (
product_name, 
quantity_in_warehouse, 
product_price, 
currency, 
descriptions, 
terms_condititions, 
size_id, 
gender, 
brand_id, 
avg_rating, 
sub_category_id) VALUES (
'Off - White slim dress', 
50, 
899.99, 
'Rupees', 
'Shiffon', 
'No return after 17 days', 
22, 
'Women', 
1, 
4.7, 
1);

-- Find Trending Products
select p.product_name, 
p.descriptions, 
p.product_price, 
p.currency 
from 
tbl_order_cnt oc 
inner join 
tbl_product p 
on 
oc.product_id = p.product_id
where order_cnt >= 5;

-- find user fav items
select p.product_name, 
p.descriptions, 
p.product_price, 
p.currency 
from 
tbl_fav_of_users fu 
inner join 
tbl_product p 
on 
fu.product_id = p.product_id
where user_id = 1;

-- Saved by user
select p.product_name, 
p.descriptions, 
p.product_price, 
p.currency 
from 
tbl_save_by_users su
inner join 
tbl_product p 
on 
su.product_id = p.product_id
where user_id = 1;


-- Find products category wise
SELECT product_name, 
quantity_in_warehouse, 
product_price, 
currency, 
brand_id, 
avg_rating,
sc.sub_category_name,
c.main_category_name
FROM 
tbl_product p
inner join
tbl_sub_category sc on p.sub_category_id = sc.sub_category_id
inner join 
tbl_main_category c on c.main_category_id = sc.main_category_id
where main_category_name = "Clothing";

-- find new products (Latest IN)
SELECT product_name, 
quantity_in_warehouse, 
product_price, 
currency, 
brand_id, 
avg_rating,
sc.sub_category_name,
c.main_category_name
FROM 
tbl_product p
inner join
tbl_sub_category sc on p.sub_category_id = sc.sub_category_id
inner join 
tbl_main_category c on c.main_category_id = sc.main_category_id
where p.created_at >= date_sub(NOW(), interval 1 day) and c.main_category_name = "Clothing";

-- Search Results where user searched for "jea"
SELECT product_name, 
quantity_in_warehouse, 
product_price, 
currency, 
brand_id, 
avg_rating,
sc.sub_category_name,
c.main_category_name
FROM 
tbl_product p
inner join
tbl_sub_category sc on p.sub_category_id = sc.sub_category_id
inner join 
tbl_main_category c on c.main_category_id = sc.main_category_id
where product_name like "%jea%";

select * from tbl_product;
select * from tbl_credit_debit_card;
select * from tbl_address;


INSERT INTO tbl_order (user_id, payment_type, total_quantity, total_price, order_status, order_date, address_id, tracking_number, promo_code_id, delivery_charge, payment_status, order_number, shipping_id, grand_total, delivery_to_shipping_time, shipped_time, delivered_time, placed_time, credit_debit_card_id) VALUES
(4, 'COD', 1, 2499, 'Placed', '2024-08-01 10:00:00', 3, 'TRK12345678', 1, 100, 'Success', 10001, 1, 2599, '2024-08-02 12:00:00', '2024-08-03 15:00:00', '2024-08-04 18:00:00', '2024-08-01 10:05:00', 3);

INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount, product_details)
VALUES (4, 13, 1, 2000, 10, 'Running Shoes');
INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount, product_details)
VALUES (4, 14, 4, 800, 10, 'Leather Belt');
INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount, product_details)
VALUES (4, 12, 10, 1000, 10, 'Denim Jeans');
select * from tbl_order;
select * from tbl_order_item;


-- Trigger
-- Update total_price
DELIMITER $$
DROP TRIGGER IF EXISTS trg_update_total_price;
CREATE TRIGGER trg_update_total_price
AFTER INSERT ON tbl_order_item
FOR EACH ROW
BEGIN
    UPDATE tbl_order 
    SET total_price = (
        SELECT SUM(final_price) 
        FROM tbl_order_item 
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END $$
DELIMITER ;

-- Display Order Details
select o.payment_type, 
o.total_price, 
o.order_status, 
o.order_date,
cdc.type,
cdc.name_of_bank,
cdc.name_on_card,
a.address
from tbl_order o inner join tbl_address a on 
o.address_id = a.address_id
inner join 
tbl_credit_debit_card cdc
on cdc.id = o.credit_debit_card_id
where o.user_id = 4;

-- Display Order status
select o.payment_type, 
o.total_price, 
o.order_status,
cdc.type,
cdc.name_of_bank,
cdc.name_on_card,
a.address,
date_format(o.placed_time, "%d %b %Y %H:%i %p") as Placed_Order_time,
date_format(o.order_date, "%d %b %Y %H:%i %p") as Order_time,
date_format(o.delivery_to_shipping_time, "%d %b %Y %H:%i %p") as Delivery_to_Shipping,
date_format(o.shipped_time, "%d %b %Y %H:%i %p") as Shipped_time,
date_format(o.delivered_time, "%d %b %Y %H:%i %p") as Delivered_time
from tbl_order o inner join tbl_address a on 
o.address_id = a.address_id
inner join 
tbl_credit_debit_card cdc
on cdc.id = o.credit_debit_card_id
where o.user_id = 4;

select * from tbl_order;

-- Display particular user and their order
select oi.product_details,
oi.quantity
from tbl_order_item oi 
inner join tbl_order o 
on o.order_id = oi.order_id 
where o.user_id = 4 and o.order_id = 4;

-- Brand wise
select p.product_name, 
p.product_price,
p.currency,
p.descriptions,
p.gender,
b.brand_name
from 
tbl_product p 
inner join 
tbl_brand b 
on 
p.brand_id = b.brand_id
where b.brand_name = "Nike";

-- Filter with brand = Nike, Adidas
-- Price < 700
-- Gender = Men
-- color = Red, Black
select p.product_name,
b.brand_name,
p.currency,
p.product_price,
p.gender,
p.descriptions,
p.avg_rating,
pc.product_color_name
from tbl_product p 
inner join tbl_product_color pc
on p.product_id = pc.product_id
inner join
tbl_brand b on 
p.brand_id = b.brand_id
where b.brand_name in ("Nike", "Adidas") and 
p.product_price <= 700 and 
p.gender = "Men" and 
pc.product_color_name in ("Red", "Black");

-- select * from tbl_product_color;
-- select * from tbl_product;
-- select * from tbl_brand;
-- insert into tbl_product_color (product_id, product_color_name) values (11, "Red"), 
-- (12, "Yellow"), 
-- (11, "Blue"), 
-- (11, "Black"), (12, "Black"), (13, "Blue"), (14, "Red");


-- Trigger
-- to update grand total
DELIMITER $$
drop trigger if exists trg_update_grand_total;
CREATE TRIGGER trg_update_grand_total
AFTER INSERT ON tbl_order_item
FOR EACH ROW
BEGIN
	update tbl_order set grand_total = total_price + delivery_charge -  
    COALESCE((SELECT discount FROM tbl_promo_code WHERE promo_code_id = tbl_order.promo_code_id 
    and final_price > tbl_promo_code.max_amount 
    LIMIT 1), 0)
WHERE order_id = NEW.order_id;
END $$
DELIMITER ;

-- Check
-- INSERT INTO tbl_order (order_id, total_price, delivery_charge, promo_code_id) 
-- VALUES (4, 5000, 50, 1);
-- INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount, final_price) 
-- VALUES (4, 13, 1, 2000, 10, 1800);

INSERT INTO tbl_order (order_id, total_price, delivery_charge, promo_code_id) 
VALUES (5, 5000, 50, 2);
INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount, final_price) 
VALUES (5, 13, 2, 2000, 10, 1800);
select * from tbl_order;
select * from tbl_promo_code;

-- Default product listing based on preference
SELECT product_name, 
quantity_in_warehouse, 
product_price, 
currency, 
brand_id, 
avg_rating,
ir.image_id,
sc.sub_category_name,
c.main_category_name
FROM 
tbl_product p
inner join
tbl_sub_category sc on p.sub_category_id = sc.sub_category_id
inner join 
tbl_main_category c on c.main_category_id = sc.main_category_id
inner join
tbl_image_product_relation ir on
p.product_id = ir.product_id
INNER JOIN
    tbl_user u ON LOWER(p.gender) = LOWER(u.user_interested_in)
WHERE 
    u.user_id = 2;

select * from tbl_user;
select * from tbl_product;

-- Order by Price (Low to High)
select p.product_name,
b.brand_name,
p.currency,
p.product_price,
p.gender,
p.descriptions,
p.avg_rating,
pc.product_color_name
from tbl_product p 
inner join tbl_product_color pc
on p.product_id = pc.product_id
inner join
tbl_brand b on 
p.brand_id = b.brand_id
order by p.product_price asc;

-- Order by Price (High to Low)
select p.product_name,
b.brand_name,
p.currency,
p.product_price,
p.gender,
p.descriptions,
p.avg_rating,
pc.product_color_name
from tbl_product p 
left join tbl_product_color pc
on p.product_id = pc.product_id
inner join
tbl_brand b on 
p.brand_id = b.brand_id
order by p.product_price desc;


-- Trigger
-- Make delivery charge to 0 for total price > 5000;
select * from tbl_order;

DELIMITER $$
DROP TRIGGER IF EXISTS trg_set_delivery_charge $$
CREATE TRIGGER trg_set_delivery_charge
BEFORE UPDATE ON tbl_order
FOR EACH ROW
BEGIN
    IF NEW.total_price > 5000 THEN
        SET NEW.delivery_charge = 0;
    END IF;
END $$
DELIMITER ;

-- Check
INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount, final_price) 
VALUES (1, 13, 2, 2000, 10, 1800);
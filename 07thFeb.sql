CREATE DATABASE DB_07;
USE DB_07;

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
    image_id bigint references tbl_image(image_id),
    product_name varchar(128),
    quantity_in_warehouse bigint,
    product_price bigint,
    currency enum("Rupees", "Dollars"),
    descriptions text,
    terms_condititions text,
    product_color_id bigint references tbl_product_color(product_color_id),
    size_id bigint references tbl_size(size_id),
    gender enum("Men", "Women", "Unisex", "Other"),
    brand_id bigint references tbl_brand(brand_id),
    avg_rating float(5,2),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_product_color(
	product_color_id bigint primary key auto_increment,
    product_color_name varchar(64),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
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
    product_id bigint references tbl_user(user_id),
    rating float(5,2),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table fav_of_user(
	fav_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    product_id bigint references tbl_user(user_id),
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

create table tbl_size_group(
	size_group_id bigint primary key auto_increment,
    size_group varchar(128),
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

create table tbl_image(
	image_id bigint primary key auto_increment,
    image_name varchar(64),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

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


-- alter table fav_of_user rename to tbl_fav_of_user;
-- Insert into tables --

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

INSERT INTO tbl_image (image_name) VALUES
('image1.jpg'), ('image2.jpg'), ('image3.jpg'), ('image4.jpg'), ('image5.jpg'),
('image6.jpg'), ('image7.jpg'), ('image8.jpg'), ('image9.jpg'), ('image10.jpg');

INSERT INTO tbl_brand (brand_name) VALUES
('Nike'), ('Adidas'), ('Puma'), ('Reebok'), ('Under Armour'),
('Gucci'), ('Prada'), ('Levis'), ('Zara'), ('H&M');

INSERT INTO tbl_product_color (product_color_name) VALUES
('Red'), ('Blue'), ('Green'), ('Yellow'), ('Black'),
('White'), ('Purple'), ('Orange'), ('Gray'), ('Pink');

INSERT INTO tbl_size_group (size_group) VALUES
('Pants'), ('Shirts'), ('Shoes'), ('Hats'), ('Socks'),
('Bags'), ('Jackets'), ('Sweaters'), ('Gloves'), ('Belts');

INSERT INTO tbl_size (size_group_id, size) VALUES
(1, 'S'), (1, 'M'), (1, 'L'), (2, 'M'), (2, 'XL'),
(3, '42'), (3, '43'), (4, 'One Size'), (5, 'Free'), (6, 'Medium');


INSERT INTO tbl_product (image_id, product_name, quantity_in_warehouse, product_price, currency, descriptions, terms_condititions, product_color_id, size_id, gender, brand_id, avg_rating) VALUES
(1, 'Running Shoes', 50, 5000, 'Rupees', 'Best running shoes', 'No return', 1, 3, 'Men', 1, 4.5),
(2, 'Casual Shirt', 30, 1500, 'Rupees', 'Stylish shirt', '7-day return', 2, 1, 'Women', 2, 4.2),
(3, 'Leather Jacket', 20, 8000, 'Rupees', 'Premium leather', 'No return', 3, 2, 'Unisex', 3, 4.8),
(4, 'Backpack', 40, 2000, 'Rupees', 'Waterproof', '1-year warranty', 4, 6, 'Unisex', 4, 4.6),
(5, 'Sports Watch', 25, 3000, 'Rupees', 'Water-resistant', '6-month warranty', 5, 5, 'Men', 5, 4.1),
(6, 'Jeans', 35, 2500, 'Rupees', 'Slim fit', 'No return', 6, 2, 'Women', 6, 4.0),
(7, 'Sneakers', 60, 4000, 'Rupees', 'Lightweight', '7-day return', 7, 3, 'Men', 7, 4.7),
(8, 'Formal Trousers', 28, 3500, 'Rupees', 'Business wear', 'No return', 8, 1, 'Men', 8, 4.3),
(9, 'Handbag', 18, 5500, 'Rupees', 'Leather handbag', '1-year warranty', 9, 6, 'Women', 9, 4.9),
(10, 'Hoodie', 22, 3200, 'Rupees', 'Warm & stylish', 'Exchange only', 10, 7, 'Unisex', 10, 4.4);

INSERT INTO tbl_rating (user_id, product_id, rating) VALUES
(1, 1, 4.5), (2, 2, 4.2), (3, 3, 4.8), (4, 4, 4.6), (5, 5, 4.1),
(6, 6, 4.0), (7, 7, 4.7), (8, 8, 4.3), (9, 9, 4.9), (10, 10, 4.4);

INSERT INTO tbl_fav_of_user (user_id, product_id) VALUES
(1, 3), (2, 5), (3, 7), (4, 9), (5, 2),
(6, 4), (7, 6), (8, 8), (9, 1), (10, 10);

INSERT INTO tbl_order (user_id, payment_type, total_quantity, total_price, order_status, address_id, tracking_number, promo_code_id, delivery_charge, payment_status, order_number, shipping_id, grand_total) VALUES
(1, 'COD', 2, 6000, 'Placed', 1, 'TRACK123', 1, 200, 'Success', 123456, 1, 6200),
(2, 'Paypal', 1, 1500, 'Delivered', 2, 'TRACK456', 2, 100, 'Success', 741852, 2, 1600),
(3, 'Wallet', 3, 10500, 'Shipped', 3, 'TRACK789', 3, 300, 'Success', 748596, 3, 10800),
(4, 'Card', 1, 8000, 'Cancelled', 4, 'TRACK101', 4, 0, 'Failed', 456123, 4, 8000),
(5, 'COD', 4, 14000, 'Pending', 5, 'TRACK102', 5, 500, 'Success', 753963, 5, 14500),
(6, 'Paypal', 2, 8000, 'Placed', 6, 'TRACK103', 6, 200, 'Success', 753123, 6, 8200),
(7, 'Wallet', 1, 4000, 'Delivered', 7, 'TRACK104', 7, 100, 'Success', 685789, 7, 4100),
(8, 'Card', 2, 7000, 'Shipped', 8, 'TRACK105', 8, 300, 'Success', 452396, 8, 7300),
(9, 'COD', 3, 9000, 'Pending', 9, 'TRACK106', 9, 400, 'Success', 741236, 9, 9400),
(10, 'Paypal', 1, 3200, 'Placed', 10, 'TRACK107', 10, 150, 'Success', 456289, 10, 3350);


INSERT INTO tbl_shipping (shipping_add, shipping_name, shipping_options) VALUES
('123 Street, City A', 'John Doe', 'Express'),
('456 Avenue, City B', 'Jane Smith', 'Free'),
('789 Road, City C', 'Alice Johnson', 'Expressplus'),
('101 Highway, City D', 'Bob Brown', 'Express'),
('202 Lane, City E', 'Charlie Davis', 'Free'),
('303 Street, City F', 'David Wilson', 'Expressplus'),
('404 Avenue, City G', 'Eva Green', 'Express'),
('505 Road, City H', 'Frank White', 'Free'),
('606 Highway, City I', 'Grace Black', 'Expressplus'),
('707 Lane, City J', 'Henry Adams', 'Express');

INSERT INTO tbl_address (address) VALUES
('123 Main St, City A, Country X'),
('456 Oak St, City B, Country Y'),
('789 Pine St, City C, Country Z'),
('101 Maple Ave, City D, Country X'),
('202 Elm St, City E, Country Y'),
('303 Birch St, City F, Country Z'),
('404 Cedar Ave, City G, Country X'),
('505 Spruce St, City H, Country Y'),
('606 Willow Ave, City I, Country Z'),
('707 Chestnut St, City J, Country X');

INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, offer_price, discount, final_price, product_details) VALUES
(21, 1, 2, 500, 450, 10, 900, 'Men’s casual shirt'),
(22, 3, 1, 1500, 1200, 20, 1200, 'Women’s handbag'),
(23, 5, 3, 800, 700, 12, 2100, 'Running shoes'),
(24, 2, 1, 2000, 1800, 10, 1800, 'Smartwatch'),
(25, 4, 2, 300, 250, 15, 500, 'T-shirt'),
(26, 7, 5, 100, 90, 10, 450, 'Socks pack'),
(27, 6, 1, 4500, 4000, 11, 4000, 'Laptop'),
(28, 8, 3, 700, 600, 14, 1800, 'Jeans'),
(29, 9, 2, 900, 800, 11, 1600, 'Backpack'),
(30, 10, 4, 600, 550, 8, 2200, 'Wireless earbuds');

INSERT INTO tbl_main_category (main_category_name) VALUES
('Clothing'),
('Footwear'),
('Accessories'),
('Electronics'),
('Home & Kitchen'),
('Sports & Fitness'),
('Beauty & Personal Care'),
('Books & Stationery'),
('Toys & Games'),
('Automobiles');

INSERT INTO tbl_sub_category (sub_category_name, main_category_id) VALUES
('Men’s Clothing', 1),
('Women’s Clothing', 1),
('Casual Shoes', 2),
('Sports Shoes', 2),
('Watches', 3),
('Jewelry', 3),
('Smartphones', 4),
('Laptops', 4),
('Cookware', 5),
('Gym Equipment', 6);

INSERT INTO tbl_product_color (product_color_name) VALUES
('Red'),
('Blue'),
('Green'),
('Black'),
('White'),
('Yellow'),
('Pink'),
('Purple'),
('Brown'),
('Grey');

INSERT INTO tbl_promo_code (max_amt, discount, promocode, total_usage, total_used, start_date, end_date) VALUES
(5000, 10, 'SAVE10', 1000, 200, '2025-01-01 00:00:00', '2025-06-30 23:59:59'),
(7000, 15, 'DISCOUNT15', 800, 150, '2025-02-01 00:00:00', '2025-07-31 23:59:59'),
(3000, 5, 'FLAT5OFF', 1200, 400, '2025-03-01 00:00:00', '2025-08-31 23:59:59'),
(10000, 20, 'BIGSAVE20', 500, 100, '2025-04-01 00:00:00', '2025-09-30 23:59:59'),
(6000, 12, 'NEWYEAR12', 900, 250, '2025-05-01 00:00:00', '2025-10-31 23:59:59'),
(8000, 18, 'SUMMER18', 700, 180, '2025-06-01 00:00:00', '2025-11-30 23:59:59'),
(4000, 7, 'SPRING7', 1100, 300, '2025-07-01 00:00:00', '2025-12-31 23:59:59'),
(12000, 25, 'MEGA25', 400, 90, '2025-08-01 00:00:00', '2026-01-31 23:59:59'),
(9000, 14, 'EXTRA14', 600, 140, '2025-09-01 00:00:00', '2026-02-28 23:59:59'),
(2000, 3, 'SMALL3', 1300, 500, '2025-10-01 00:00:00', '2026-03-31 23:59:59');


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

DELIMITER $$

CREATE TRIGGER trg_update_grand_total
BEFORE INSERT ON tbl_order_item
FOR EACH ROW
BEGIN
    UPDATE tbl_order o
    JOIN (
        SELECT SUM(final_price) AS total_price
        FROM tbl_order_item
        WHERE order_id = NEW.order_id
    ) AS derived ON o.order_id = NEW.order_id
    SET o.grand_total = (
        derived.total_price + o.delivery_charge 
        - (
            derived.total_price * COALESCE(
                (SELECT p.discount FROM tbl_promo_code p
                 WHERE p.promo_code_id = o.promo_code_id
                 LIMIT 1), 0
            ) / 100
        )
    )
    WHERE o.order_id = NEW.order_id;
END $$

DELIMITER ;




-- (NEW.market_price * 
--             (SELECT p.discount 
--              FROM tbl_promo_code p 
--              INNER JOIN tbl_order o ON p.promo_code_id = o.promo_code_id 
--              WHERE o.order_id = NEW.order_id 
--              LIMIT 1) / 100
--         );

-- Trigger to update avg_rating
DELIMITER $$
create trigger trg_update_avg_rating
after insert on tbl_rating
for each row
begin
	update tbl_parking set avg_rating = (select avg(rating) from tbl_rating where product_id = new.product_id)
    where product_id = new.product_id;
end $$
DELIMITER ;

INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, offer_price, discount, final_price, product_details)
VALUES (31, 1, 2, 1000, 900, 10, 1800, 'Product A');
INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, offer_price, discount, final_price, product_details)
VALUES (33, 2, 3, 1200, 1000, 20, 3000, 'Product B');

-- Check
SELECT * FROM tbl_order where order_id = 33;

INSERT INTO tbl_promo_code (max_amt, discount, promocode, total_usage, total_used, start_date, end_date)
VALUES (5000, 15, 'PROMO15', 100, 10, NOW(), NOW() + INTERVAL 30 DAY);

-- Insert an order using the promo code
INSERT INTO tbl_order (user_id, payment_type, total_quantity, total_price, order_status, order_date, address_id, tracking_number, promo_code_id, delivery_charge, payment_status, order_number, shipping_id, grand_total, delivery_to_shipping_time, shipped_time, delivered_time, placed_time)
VALUES (2, 'Card', 3, 40000, 'Pending', NOW(), 1, 'TRK789', 11, 50, 'Success', 10002, 1, 7050, NOW(), NOW(), NULL, NOW());

-- Insert an order item (Trigger should update offer_price and final_price)
INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, offer_price, discount, final_price, product_details)
VALUES (22, 3, 2, 2000, 0, 15, 0, 'Product C');

-- Check offer_price and final_price
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_item;
select * from tbl_promo_code;

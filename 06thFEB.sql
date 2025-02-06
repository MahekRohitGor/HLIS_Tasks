CREATE DATABASE DB_06;
USE DB_06;

create table tbl_user(
	user_id bigint primary key auto_increment,
    phone_number char(16),
    email_id varchar(64) unique,
    passwords varchar(64),
    is_active boolean default 1,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_forgot_password (
  reset_id bigint primary key auto_increment,
  email_id VARCHAR(64) references tbl_user(email_id),
  reset_token varchar(128),
  created_at datetime default current_timestamp(),
  expires_at datetime on update current_timestamp()
);


create table tbl_image(
	image_id bigint primary key auto_increment,
    image_name varchar(64)
);

create table tbl_otp(
	otp_id bigint primary key auto_increment,
    actions enum("Signin", "Signup", "Forget", "Profile"),
    verify_with enum("Email", "Mobile"),
    verify boolean default 0,
    otp char(4),
    user_id bigint references tbl_user(user_id),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_category(
	category_id bigint primary key auto_increment,
    category_name varchar(64),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    is_delete boolean default 0
);

create table tbl_order(
	order_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    payment_type enum ("COD", "Paypal", "Wallet", "Card"),
    total_quantity bigint,
    total_price bigint,
    order_status enum("Pending", "Placed", "Cancelled"),
    order_date datetime,
    address_id bigint references tbl_address(address_id),
    tracking_number char(16),
    discount int,
    delivery_charge bigint,
    payment_status enum("Failed", "Success"),
    order_number bigint,
    shipping_id bigint references tbl_shipping(shipping_id),
    grand_total bigint,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_order_item(
	order_item_id bigint primary key auto_increment,
    order_id bigint references tbl_order(order_id),
    product_id bigint references tbl_products(product_id),
    quantity bigint,
    market_price bigint,
    offer_price bigint,
    discount int,
    final_price bigint,
    product_details text,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_products(
	product_id bigint primary key auto_increment,
    category_id bigint references tbl_category(category_id),
    product_name varchar(128),
    actual_price bigint,
    discount_price bigint,
    descriptions text,
    gender enum("M", "F"),
    image_id bigint references tbl_image(image_id),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_shipping(
	shipping_id bigint primary key auto_increment,
    shipping_add text,
    shipping_name varchar(128),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);
create table tbl_address(
	address_id bigint primary key auto_increment,
    address text,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);


-- Insert into Tables --

INSERT INTO tbl_user (phone_number, email_id, passwords) VALUES
('9876543210', 'john.doe@example.com', 'pass1234'),
('9123456789', 'jane.smith@example.com', 'secure567'),
('9988776655', 'alice.wonder@example.com', 'qwerty12'),
('8899001122', 'bob.builder@example.com', 'builder89'),
('7766554433', 'charlie.brown@example.com', 'brownie77'),
('6677889900', 'daisy.duck@example.com', 'daisy789'),
('5544332211', 'elena.gilbert@example.com', 'vampire123'),
('4455667788', 'frank.castle@example.com', 'punisher99'),
('3344556677', 'grace.hopper@example.com', 'coding123'),
('2233445566', 'harry.potter@example.com', 'magicwand');

INSERT INTO tbl_forgot_password (email_id, reset_token) VALUES
('john.doe@example.com', 'reset123abc'),
('jane.smith@example.com', 'secure567xyz'),
('alice.wonder@example.com', 'qwerty12reset'),
('bob.builder@example.com', 'builderreset89'),
('charlie.brown@example.com', 'brownie77reset'),
('daisy.duck@example.com', 'duckreset789'),
('elena.gilbert@example.com', 'vampreset123'),
('frank.castle@example.com', 'punishreset99'),
('grace.hopper@example.com', 'code123reset'),
('harry.potter@example.com', 'magicreset');

INSERT INTO tbl_image (image_name) VALUES
('aviator_sunglasses.jpg'),
('round_glasses.jpg'),
('wayfarer_black.jpg'),
('cat_eye_red.jpg'),
('rimless_gold.jpg'),
('sports_sunglasses.jpg'),
('reading_glasses.jpg'),
('polarized_sunshades.jpg'),
('blue_light_blockers.jpg'),
('clubmaster_silver.jpg');

INSERT INTO tbl_otp (actions, verify_with, otp, user_id) VALUES
('Signin', 'Email', '1234', 1),
('Signup', 'Mobile', '5678', 2),
('Forget', 'Email', '9101', 3),
('Profile', 'Mobile', '1122', 4),
('Signin', 'Email', '3344', 5),
('Signup', 'Mobile', '5566', 6),
('Forget', 'Email', '7788', 7),
('Profile', 'Mobile', '9900', 8),
('Signin', 'Email', '2233', 9),
('Signup', 'Mobile', '4455', 10);


INSERT INTO tbl_category (category_name) VALUES
('Sunglasses'),
('Eyeglasses'),
('Blue Light Glasses'),
('Contact Lenses'),
('Kids Glasses'),
('Reading Glasses'),
('Polarized Glasses'),
('Aviator Glasses'),
('Sports Glasses'),
('Computer Glasses');

INSERT INTO tbl_products (category_id, product_name, actual_price, discount_price, descriptions, gender, image_id) VALUES
(1, 'Aviator Sunglasses', 3000, 2500, 'Classic Aviator sunglasses with UV protection.', 'M', 1),
(2, 'Round Eyeglasses', 2000, 1800, 'Lightweight round glasses for everyday use.', 'F', 2),
(3, 'Wayfarer Black Frame', 2500, 2200, 'Trendy wayfarer glasses with black frame.', 'M', 3),
(4, 'Cat Eye Red Frame', 2800, 2600, 'Stylish cat-eye glasses with red frame.', 'F', 4),
(5, 'Rimless Gold Frame', 3200, 2900, 'Premium rimless glasses with gold finish.', 'M', 5),
(6, 'Sports Sunglasses', 3500, 3100, 'Sporty wraparound sunglasses for active wear.', 'M', 6),
(7, 'Reading Glasses', 1500, 1300, 'Lightweight reading glasses with clear lens.', 'F', 7),
(8, 'Polarized Sunshades', 4000, 3700, 'Polarized sunglasses to reduce glare.', 'M', 8),
(9, 'Blue Light Blockers', 2200, 2000, 'Protective glasses to block blue light from screens.', 'F', 9),
(10, 'Clubmaster Silver Frame', 2600, 2300, 'Classic clubmaster glasses with silver frame.', 'M', 10);

INSERT INTO tbl_shipping (shipping_add, shipping_name) VALUES
('123 Elm Street, NY', 'John Doe'),
('456 Oak Avenue, CA', 'Jane Smith'),
('789 Maple Road, TX', 'Alice Wonder'),
('101 Pine Lane, FL', 'Bob Builder'),
('202 Cedar Street, IL', 'Charlie Brown'),
('303 Birch Blvd, WA', 'Daisy Duck'),
('404 Redwood Dr, NV', 'Elena Gilbert'),
('505 Willow Way, AZ', 'Frank Castle'),
('606 Palm Ct, MI', 'Grace Hopper'),
('707 Cypress Lane, OR', 'Harry Potter');

INSERT INTO tbl_address (address) VALUES
('123 Elm Street, NY'),
('456 Oak Avenue, CA'),
('789 Maple Road, TX'),
('101 Pine Lane, FL'),
('202 Cedar Street, IL'),
('303 Birch Blvd, WA'),
('404 Redwood Dr, NV'),
('505 Willow Way, AZ'),
('606 Palm Ct, MI'),
('707 Cypress Lane, OR');

INSERT INTO tbl_order (user_id, payment_type, total_quantity, total_price, order_status, order_date, address_id, tracking_number, discount, delivery_charge, payment_status, order_number, shipping_id, grand_total) VALUES
(1, 'COD', 2, 5000, 'Placed', NOW(), 1, 'TRK1234567890', 500, 100, 'Success', 100001, 1, 4600),
(2, 'Paypal', 1, 3000, 'Pending', NOW(), 2, 'TRK2345678901', 300, 50, 'Success', 100002, 2, 2750),
(3, 'Wallet', 3, 7500, 'Placed', NOW(), 3, 'TRK3456789012', 700, 150, 'Success', 100003, 3, 6650),
(4, 'Card', 1, 2500, 'Cancelled', NOW(), 4, 'TRK4567890123', 200, 50, 'Failed', 100004, 4, 2350),
(5, 'COD', 2, 5600, 'Placed', NOW(), 5, 'TRK5678901234', 500, 100, 'Success', 100005, 5, 5000),
(6, 'Wallet', 1, 4000, 'Pending', NOW(), 6, 'TRK6789012345', 400, 75, 'Success', 100006, 6, 3675),
(7, 'Paypal', 2, 6400, 'Placed', NOW(), 7, 'TRK7890123456', 600, 120, 'Success', 100007, 7, 5680),
(8, 'Card', 1, 2200, 'Cancelled', NOW(), 8, 'TRK8901234567', 200, 50, 'Failed', 100008, 8, 2050),
(9, 'COD', 1, 2600, 'Placed', NOW(), 9, 'TRK9012345678', 300, 50, 'Success', 100009, 9, 2350),
(10, 'Paypal', 3, 8700, 'Placed', NOW(), 10, 'TRK0123456789', 800, 200, 'Success', 100010, 10, 7700);

INSERT INTO tbl_order_item 
(order_id, product_id, quantity, market_price, offer_price, discount, final_price, product_details) 
VALUES
(1, 3, 1, 2500, 2000, 500, 2000, 'Oakley Sports Glasses - Lightweight and polarized for outdoor activities');

INSERT INTO tbl_order_item 
(order_id, product_id, quantity, market_price, offer_price, discount, final_price, product_details) 
VALUES
(1, 1, 1, 3000, 2500, 500, 2500, 'Ray-Ban Aviator Sunglasses - Classic metal frame with UV protection'),
(1, 3, 1, 2500, 2000, 500, 2000, 'Oakley Sports Glasses - Lightweight and polarized for outdoor activities'),
(2, 5, 1, 3200, 2900, 300, 2900, 'Tom Ford Optical Glasses - Stylish full-rim frame with blue-light protection'),
(3, 6, 2, 7000, 6300, 700, 6300, 'Burberry Designer Glasses - Premium acetate frame with anti-glare lenses'),
(3, 8, 1, 4000, 3500, 500, 3500, 'Titan Eye+ Progressive Glasses - Dual-focus lenses for near and distance vision'),
(4, 2, 1, 2000, 1800, 200, 1800, 'Fastrack Rectangle Eyeglasses - Trendy and durable acetate frame'),
(5, 7, 2, 3000, 2600, 400, 2600, 'Police Wayfarer Sunglasses - Scratch-resistant and polarized lenses'),
(6, 9, 1, 2200, 2000, 200, 2000, 'Carrera Retro Sunglasses - High-quality UV-protected lenses'),
(7, 10, 2, 5200, 4600, 600, 4600, 'Vogue Round Glasses - Elegant metal frame with anti-reflective coating'),
(8, 4, 1, 2800, 2600, 200, 2600, 'Lenskart Air Flex - Ultra-lightweight flexible frame for all-day comfort'),
(9, 1, 1, 3000, 2600, 400, 2600, 'Ray-Ban Aviator Sunglasses - Timeless design with gold metal frame'),
(10, 3, 2, 5000, 4200, 800, 4200, 'Oakley Sports Glasses - Impact-resistant and hydrophobic coating for clarity');

-- Queries --

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

-- Update offer price when discount changes
-- DELIMITER $$
-- CREATE TRIGGER trg_update_offer_price
-- BEFORE INSERT ON tbl_order_item
-- FOR EACH ROW
-- BEGIN
--     SET NEW.offer_price = NEW.market_price - NEW.discount;
-- END $$
-- DELIMITER ;

-- Update Final price and offer price
DELIMITER $$
CREATE TRIGGER trg_update_prices
BEFORE INSERT ON tbl_order_item
FOR EACH ROW
BEGIN
    SET NEW.offer_price = NEW.market_price - NEW.discount;
    SET NEW.final_price = NEW.quantity * NEW.offer_price;
END $$
DELIMITER ;

-- Update Grand Total
DELIMITER $$
CREATE TRIGGER trg_update_grand_total
BEFORE INSERT ON tbl_order_item
FOR EACH ROW
BEGIN
    UPDATE tbl_order o
    JOIN tbl_order_item oi ON o.order_id = oi.order_id
    SET o.grand_total = (
        SELECT SUM(oi.final_price) + o.delivery_charge - o.discount
        FROM tbl_order_item oi
        WHERE oi.order_id = NEW.order_id
    )
    WHERE o.order_id = NEW.order_id;
END $$
DELIMITER ;

-- Test Case
INSERT INTO tbl_order_item (order_id, product_id, quantity, market_price, discount) 
VALUES (1, 10, 5, 400, 50);

select 
o.order_id,
oi.product_details, 
oi.quantity, 
oi.market_price, 
oi.offer_price, 
oi.discount,
oi.final_price,
p.product_name,
o.order_status,
o.payment_type,
o.delivery_charge,
o.discount as Order_Discount,
o.tracking_number,
o.total_quantity,
o.grand_total,
o.payment_status,
o.order_number 
from tbl_order o 
inner join tbl_order_item oi on o.order_id = oi.order_id 
inner join tbl_products p on p.product_id = oi.product_id where o.order_id = 1;

-- Display all product within particular category
select product_name, actual_price, discount_price, image_id, gender from tbl_products where category_id = 1;

-- Display particular product
select p.product_name, p.actual_price, p.discount_price, p.image_id, p.gender, c.category_name, p.descriptions 
from tbl_products p 
inner join tbl_category c on p.category_id = c.category_id where p.product_id = 1;

-- Display all categories
select category_name from tbl_category;
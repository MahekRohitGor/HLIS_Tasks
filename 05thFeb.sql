create database db_05;
use db_05;

-- Creating Tables --
create table tbl_user(
	user_id bigint primary key auto_increment,
    user_name varchar(128),
    phone_number char(16),
    email_id varchar(64) unique,
    passwords varchar(64),
    login_type enum("S", "F"),
    is_active boolean default 1,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_location(
	location_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    address text,
    tag enum("Home", "Work", "Other"),
    latitude char(16),
    longitude char(16),
    created_at datetime default current_timestamp(),
    is_delete boolean default 0,
    updated_at datetime on update current_timestamp()
);

create table tbl_banner(
	banner_id bigint primary key auto_increment,
    image_id bigint references tbl_image(image_id),
    banner_name varchar(64),
    is_active boolean default 0,
    dates datetime default current_timestamp()
);

create table tbl_restaurant(
	rest_id bigint primary key auto_increment,
    rest_name varchar(128),
    image_id bigint references tbl_image(image_id),
    status_ enum("OPEN", "CLOSE"),
    latitude char(16),
    longitude char(16),
    about_us text,
    free_delivery boolean,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

-- ALTER TABLE tbl_restaurant
-- ADD COLUMN avg_rating FLOAT(5,2);

-- UPDATE tbl_restaurant
-- set avg_rating = 4
-- where rest_id = 3;
-- select * from tbl_restaurant;

-- UPDATE tbl_user 
-- SET name_ = CONCAT('User ', user_id)
-- WHERE user_id IS NOT NULL
-- LIMIT 10;

create table tbl_timing(
	timing_id bigint primary key auto_increment,
    day_ varchar(32) not null,
    open_time time,
    close_time time,
    rest_id bigint references tbl_restaurant(rest_id)
);

create table tbl_category(
	category_id bigint primary key auto_increment,
    category_name varchar(64),
    status_ enum("A", "NA"),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    is_delete boolean default 0
);

create table tbl_relation_category_restaurant(
	realtion_id bigint primary key auto_increment,
    category_id bigint references tbl_category(category_id),
    rest_id bigint references tbl_restaurant(rest_id)
);

create table tbl_cart(
	cart_id bigint primary key auto_increment,
    rest_id bigint references tbl_restaurant(rest_id),
    user_id bigint references tbl_user(user_id),
    order_id bigint references tbl_order(order_id)
);

create table tbl_order(
	order_id bigint primary key auto_increment,
    menu_id bigint references tbl_menu(menu_id),
    user_id bigint references tbl_user(user_id)
);

create table tbl_menu(
	menu_id bigint primary key auto_increment,
    item_name varchar(64),
    item_price bigint,
    rest_id bigint references tbl_restaurant(rest_id),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_review(
	review_id bigint primary key auto_increment,
    rest_id bigint references tbl_restaurant(rest_id),
    user_id bigint references tbl_user(user_id),
    review text,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_rating(
	rating_id bigint primary key auto_increment,
    rest_id bigint references tbl_restaurant(rest_id),
    user_id bigint references tbl_user(user_id),
    rating float(5,2),
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

-- Insert Values --
INSERT INTO tbl_user (user_name, phone_number, email_id, passwords, login_type) VALUES
('John Doe', '1234567890', 'john@example.com', 'password1', 'S'),
('Jane Smith', '2345678901', 'jane@example.com', 'password2', 'F'),
('Alice Johnson', '3456789012', 'alice@example.com', 'password3', 'S'),
('Bob Brown', '4567890123', 'bob@example.com', 'password4', 'F'),
('Charlie Davis', '5678901234', 'charlie@example.com', 'password5', 'S'),
('Diana Evans', '6789012345', 'diana@example.com', 'password6', 'F'),
('Evan Foster', '7890123456', 'evan@example.com', 'password7', 'S'),
('Fiona Green', '8901234567', 'fiona@example.com', 'password8', 'F'),
('George Harris', '9012345678', 'george@example.com', 'password9', 'S'),
('Hannah Irving', '0123456789', 'hannah@example.com', 'password10', 'F');


INSERT INTO tbl_image (image_name) VALUES
('image1.jpg'),
('image2.jpg'),
('image3.jpg'),
('image4.jpg'),
('image5.jpg'),
('image6.jpg'),
('image7.jpg'),
('image8.jpg'),
('image9.jpg'),
('image10.jpg');

INSERT INTO tbl_location (user_id, address, tag, latitude, longitude) VALUES
(1, '123 Main St', 'Home', '37.7749', '-122.4194'),
(2, '456 Elm St', 'Work', '34.0522', '-118.2437'),
(3, '789 Oak St', 'Other', '40.7128', '-74.0060'),
(4, '135 Pine St', 'Home', '41.8781', '-87.6298'),
(5, '246 Maple St', 'Work', '29.7604', '-95.3698'),
(6, '357 Cedar St', 'Other', '39.7392', '-104.9903'),
(7, '468 Birch St', 'Home', '32.7767', '-96.7970'),
(8, '579 Walnut St', 'Work', '47.6062', '-122.3321'),
(9, '680 Cherry St', 'Other', '38.9072', '-77.0369'),
(10, '791 Aspen St', 'Home', '42.3601', '-71.0589');


INSERT INTO tbl_banner (image_id, banner_name, is_active) VALUES
(1, 'Summer Sale', 1),
(2, 'Winter Discount', 0),
(3, 'Spring Special', 1),
(4, 'Autumn Offers', 0),
(5, 'Holiday Deals', 1),
(6, 'New Year Sale', 1),
(7, 'Black Friday', 1),
(8, 'Cyber Monday', 0),
(9, 'Valentine Promo', 1),
(10, 'Back to School', 0);

INSERT INTO tbl_restaurant (rest_name, image_id, status_, latitude, longitude, about_us, free_delivery) VALUES
('Pizza Palace', 1, 'OPEN', '37.7749', '-122.4194', 'Best pizza in town.', 1),
('Burger Barn', 2, 'CLOSE', '34.0522', '-118.2437', 'Juicy burgers and more.', 0),
('Sushi Spot', 3, 'OPEN', '40.7128', '-74.0060', 'Fresh sushi daily.', 1),
('Taco Tower', 4, 'OPEN', '41.8781', '-87.6298', 'Authentic Mexican tacos.', 1),
('Pasta Place', 5, 'CLOSE', '29.7604', '-95.3698', 'Homemade pasta dishes.', 0),
('Curry Corner', 6, 'OPEN', '39.7392', '-104.9903', 'Delicious Indian curries.', 1),
('Noodle Nook', 7, 'OPEN', '32.7767', '-96.7970', 'Asian noodle specialties.', 1),
('Salad Stop', 8, 'CLOSE', '47.6062', '-122.3321', 'Healthy salads and wraps.', 0),
('BBQ Barn', 9, 'OPEN', '38.9072', '-77.0369', 'Smoked BBQ favorites.', 1),
('Dessert Den', 10, 'OPEN', '42.3601', '-71.0589', 'Sweet treats and desserts.', 1);

INSERT INTO tbl_timing (day_, open_time, close_time, rest_id) VALUES
('Monday', '09:00:00', '22:00:00', 1),
('Tuesday', '09:00:00', '22:00:00', 2),
('Wednesday', '09:00:00', '22:00:00', 3),
('Thursday', '09:00:00', '22:00:00', 4),
('Friday', '09:00:00', '23:00:00', 5),
('Saturday', '10:00:00', '23:00:00', 6),
('Sunday', '10:00:00', '20:00:00', 7),
('Monday', '09:00:00', '21:00:00', 8),
('Tuesday', '09:00:00', '21:00:00', 9),
('Wednesday', '09:00:00', '21:00:00', 10);

-- tbl_category --
INSERT INTO tbl_category (category_name, status_) VALUES
('Italian', 'A'),
('Mexican', 'A'),
('Chinese', 'NA'),
('Indian', 'A'),
('American', 'NA'),
('Japanese', 'A'),
('Mediterranean', 'A'),
('French', 'NA'),
('Thai', 'A'),
('Vegan', 'A');

INSERT INTO tbl_relation_category_restaurant (category_id, rest_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO tbl_order (menu_id, user_id) VALUES
(15, 1);

INSERT INTO tbl_menu (item_name, item_price, rest_id) VALUES
('Cheesy 7', 180, 1),
('Farm Villa', 170, 1),
('Garden Delight', 180, 1);

INSERT INTO tbl_menu (item_name, item_price, rest_id) VALUES
('Margherita Pizza', 10, 1),
('Cheeseburger', 8, 2),
('California Roll', 12, 3),
('Beef Taco', 5, 4),
('Spaghetti Bolognese', 15, 5),
('Chicken Curry', 13, 6),
('Ramen', 11, 7),
('Greek Salad', 9, 8),
('Pulled Pork Sandwich', 14, 9),
('Chocolate Cake', 7, 10);



INSERT INTO tbl_order (menu_id, user_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO tbl_cart (rest_id, user_id, order_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

INSERT INTO tbl_review (rest_id, user_id, review) VALUES
(1, 1, 'Great pizza!'),
(2, 2, 'Loved the burger!'),
(3, 3, 'Fresh sushi.'),
(4, 4, 'Tacos were amazing.'),
(5, 5, 'Delicious pasta.'),
(6, 6, 'Authentic curry.'),
(7, 7, 'Noodles were perfect.'),
(8, 8, 'Healthy and tasty.'),
(9, 9, 'BBQ was fantastic.'),
(10, 10, 'Best dessert ever.');

INSERT INTO tbl_rating (rest_id, user_id, rating) VALUES
(1, 1, 4.5),
(2, 2, 4.0),
(3, 3, 5.0),
(4, 4, 4.8),
(5, 5, 4.2),
(6, 6, 4.7),
(7, 7, 4.9),
(8, 8, 4.3),
(9, 9, 5.0),
(10, 10, 4.6);

INSERT INTO tbl_forgot_password (email_id, reset_token) VALUES
('john@example.com', 'token123'),
('jane@example.com', 'token234'),
('alice@example.com', 'token345'),
('bob@example.com', 'token456'),
('charlie@example.com', 'token567'),
('diana@example.com', 'token678'),
('evan@example.com', 'token789'),
('fiona@example.com', 'token890'),
('george@example.com', 'token901'),
('hannah@example.com', 'token012');

INSERT INTO tbl_otp (user_id, actions, verify_with, verify, otp) 
VALUES 
(1, 'signup', 'email', 1, '1234'),
(2, 'signin', 'mobile', 0, '5678'),
(3, 'forget', 'email', 1, '9876'),
(4, 'profile', 'mobile', 0, '4321'),
(5, 'signup', 'email', 1, '6789'),
(6, 'signin', 'mobile', 1, '1357'),
(7, 'forget', 'email', 0, '2468'),
(8, 'profile', 'mobile', 1, '7890'),
(9, 'signup', 'email', 0, '1122'),
(10, 'signin', 'mobile', 1, '3344');


-- Trigger --

-- Update Avg_rating when new rating is added
DELIMITER $$
CREATE TRIGGER trg_update_avg_rating_insert
AFTER INSERT ON tbl_rating
FOR EACH ROW
BEGIN
	UPDATE tbl_restaurant
    SET avg_rating = (
        SELECT AVG(rating)
        FROM tbl_rating
        WHERE rest_id = NEW.rest_id
    )
    WHERE rest_id = NEW.rest_id;
END $$
DELIMITER ;

SELECT * FROM tbl_rating;
SELECT * FROM tbl_restaurant;

INSERT INTO tbl_rating (rating, user_id, rest_id)
VALUES
(1, 1, 1);


-- Update Avg_rating when new rating is deleted
DELIMITER $$
CREATE TRIGGER trg_update_avg_rating_delete
AFTER DELETE ON tbl_rating
FOR EACH ROW
BEGIN
	UPDATE tbl_restaurant
    SET avg_rating = (
        SELECT AVG(rating)
        FROM tbl_rating
        WHERE rest_id = OLD.rest_id
    )
    WHERE rest_id = OLD.rest_id;
END $$
DELIMITER ;

DELETE FROM tbl_rating WHERE rating_id = 3;

-- Queries --

-- Last Page details
SELECT 
    r.rest_name, 
    r.image_id, 
    r.avg_rating, 
    r.free_delivery, 
    r.about_us, 
    AVG(m.item_price) AS avg_price,
    COUNT(rw.review_id) AS number_of_reviews,
    date_format(t.open_time, "%h:%i %p") as "OPENS AT",
    date_format(t.close_time, "%h:%i %p") as "CLOSE AT"
FROM 
    tbl_restaurant r
INNER JOIN 
    tbl_menu m ON r.rest_id = m.rest_id
INNER JOIN 
    tbl_review rw ON r.rest_id = rw.rest_id
INNER JOIN
	tbl_timing t ON t.rest_id = r.rest_id
GROUP BY 
    r.rest_id, r.rest_name, r.image_id, r.avg_rating, r.free_delivery, r.about_us, t.open_time, t.close_time;


-- Fetch Menu where rest_id = 1
SELECT item_name as Item, concat("Rs.", item_price) as Price from tbl_menu where rest_id = 1 order by Price;
-- insert into tbl_menu (item_name, item_price, rest_id) values ("Noodles", "200", 1);

-- Restaurants nearby

-- take latitude longitude from user's location
select latitude, longitude, user_id from tbl_location;

-- Find nearby restaurants
select *, concat(ROUND(( 3959 * ACOS( COS( RADIANS('37.7749') )  
		* COS( RADIANS( cm.latitude ) ) 
		* COS( RADIANS( cm.longitude ) - RADIANS('-122.4194') )  
		+ SIN( RADIANS('37.7749') )  
		* SIN( RADIANS( cm.latitude) ) ) ),0), " Miles away") as distance_km
        from tbl_restaurant cm having distance_km < 800 ;

-- OTP
-- User with user_id = 1 entered otp = 1234
UPDATE tbl_otp set verify = 1 where otp = "4321" and user_id = 4;
SELECT * FROM tbl_order;

-- User ID = 1
-- Total items
SELECT count(o.menu_id) as total_item FROM tbl_menu m 
inner join tbl_order o on m.menu_id = o.menu_id 
group by user_id having user_id = 1;

-- INSERT INTO tbl_order (menu_id, user_id) VALUES
-- (4, 1);

SELECT 
    m.item_name, 
    m.item_price, 
    m.rest_id
FROM 
    tbl_menu m
INNER JOIN 
    tbl_order o ON m.menu_id = o.menu_id
WHERE 
    o.user_id = 1;


-- Display Total Amount
select sum(m.item_price) as total from tbl_menu m 
INNER JOIN tbl_order o ON m.menu_id = o.menu_id where user_id = 1;

-- Top Rated Restaurants
select * from tbl_restaurant where avg_rating > 3.5 ;

select * from tbl_user;

-- Login 
-- Using credentials
-- Email: user1@example.com and password: password123
select concat("Welcome " , user_name) as msg from tbl_user where email_id = "john@example.com" and passwords = "password1";

-- Signup
insert into tbl_user (user_name, email_id, passwords, phone_number) values 
("Mahek Gor", "mahek.gce@gmail.com", "12345678", "9638527417");


-- Forgot Password
-- email id: mahek.gce@gmail.com
-- Insert Reset Token for Forgot Password: 
insert into tbl_forgot_password(email_id, reset_token, expires_at)
values ("mahek.gce@gmail.com", 'sometokenblahblah', '2025-02-10 23:59:59');

-- Check if Token is Valid
-- Token entered by user is sometokenblahblah then successful login else not
select reset_token from tbl_forgot_password where reset_token = 'sometokenblahblah' and expires_at > current_timestamp();

-- Update Password After Token Validation
-- Password given by user is mypswd2003
update tbl_user set passwords = 'mypswd2003', updated_at = current_timestamp()
where email_id = (select email_id from tbl_forgot_password where reset_token = 'sometokenblahblah');
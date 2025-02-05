create database db_04;
use db_04;

create table tbl_user(
	user_id bigint primary key auto_increment,
    user_type enum("User", "Vendor"),
    phone_number char(16),
    email_id varchar(64) unique,
    passwords varchar(64),
    is_active boolean default 1,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

ALTER TABLE tbl_user 
ADD COLUMN name_ VARCHAR(128);

create table tbl_forgot_password (
  reset_id bigint primary key auto_increment,
  email_id VARCHAR(64) references tbl_user(email_id),
  reset_token varchar(128),
  created_at datetime default current_timestamp(),
  expires_at datetime on update current_timestamp()
);

create table tbl_categories(
	category_id bigint primary key auto_increment,
    category_name varchar(128),
    created_at datetime default current_timestamp(),
	expires_at datetime on update current_timestamp()
);
drop table tbl_company;
create table tbl_company(
	company_id bigint primary key auto_increment,
    company_name varchar(64),
    avg_rating float(5,2),
    latitude char(16),
    longitude char(16),
    email_id varchar(64),
    phone char(16),
    tag_line varchar(64),
    address text,
    image_id bigint references tbl_image(image_id),
    created_at datetime default current_timestamp(),
	expires_at datetime on update current_timestamp()
);

create table tbl_relation_comp(
	relation_id bigint primary key auto_increment,
    company_id bigint references tbl_company(company_id),
    category_id bigint references tbl_categories(category_id)
);

create table tbl_sub_categories(
	sub_cat_id bigint primary key auto_increment,
    company_id bigint references tbl_company(company_id),
    sub_cat_name varchar(64),
    created_at datetime default current_timestamp(),
	expires_at datetime on update current_timestamp()
);

create table tbl_products(
	product_id bigint primary key auto_increment,
    product_name varchar(64),
    image_id bigint references tbl_image(image_id),
    sub_cat_id bigint references tbl_sub_categories(sub_cat_id),
    price float(10,2),
    descriptions text,
    created_at datetime default current_timestamp(),
	expires_at datetime on update current_timestamp()
);

create table tbl_image(
	image_id bigint primary key auto_increment,
    image_name varchar(64)
);

create table tbl_ratings(
	rating_id bigint primary key auto_increment,
    rating int,
    user_id bigint references tbl_user(user_id),
    company_id bigint references tbl_company(company_id)
);



-- -------------- Inserting Data --------------

INSERT INTO tbl_ratings (rating, user_id, company_id)
VALUES
(5, 1, 1),
(4, 2, 2),
(3, 3, 3),
(5, 4, 4),
(2, 5, 5),
(4, 6, 1),
(3, 7, 2),
(5, 8, 3),
(1, 9, 4),
(4, 10, 5);


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

INSERT INTO tbl_company (company_name, image_id, email_id, avg_rating, phone, latitude, longitude, address, tag_line) VALUES
('Company A', 1, 'companya@example.com', 4.5, '1234567890', 28.7041, 77.1025, 'Address A', 'Best company in town'),
('Company B', 2, 'companyb@example.com', 3.8, '2345678901', 28.5355, 77.3910, 'Address B', 'Leading industry player'),
('Company C', 3, 'companyc@example.com', 4.0, '3456789012', 28.7041, 77.2060, 'Address C', 'Innovating the future'),
('Company D', 4, 'companyd@example.com', 4.7, '4567890123', 28.5000, 77.1000, 'Address D', 'Quality products'),
('Company E', 5, 'companye@example.com', 4.2, '5678901234', 28.6519, 77.2315, 'Address E', 'Affordable services'),
('Company F', 6, 'companyf@example.com', 3.9, '6789012345', 28.7041, 77.2345, 'Address F', 'Customer satisfaction first'),
('Company G', 7, 'companyg@example.com', 4.3, '7890123456', 28.5667, 77.0667, 'Address G', 'The future of technology'),
('Company H', 8, 'companyh@example.com', 4.6, '8901234567', 28.7350, 77.0530, 'Address H', 'Our vision is growth'),
('Company I', 9, 'companyi@example.com', 3.7, '9012345678', 28.4097, 77.0389, 'Address I', 'Empowering businesses'),
('Company J', 10, 'companyj@example.com', 4.8, '1234509876', 28.6500, 77.0500, 'Address J', 'Leading by example');

INSERT INTO tbl_user (user_type, phone_number, email_id, passwords)
VALUES
('User', '+12345678901', 'user1@example.com', 'password123'),
('Vendor', '+12345678902', 'vendor1@example.com', 'vendorpass1'),
('User', '+12345678903', 'user2@example.com', 'password456'),
('Vendor', '+12345678904', 'vendor2@example.com', 'vendorpass2'),
('User', '+12345678905', 'user3@example.com', 'password789'),
('Vendor', '+12345678906', 'vendor3@example.com', 'vendorpass3'),
('User', '+12345678907', 'user4@example.com', 'password321'),
('Vendor', '+12345678908', 'vendor4@example.com', 'vendorpass4'),
('User', '+12345678909', 'user5@example.com', 'password654'),
('Vendor', '+12345678910', 'vendor5@example.com', 'vendorpass5');

INSERT INTO tbl_categories (category_name) VALUES
('Electronics'),
('Furniture'),
('Clothing'),
('Books'),
('Toys'),
('Home Appliances'),
('Groceries'),
('Health & Beauty'),
('Sports'),
('Automobiles');

INSERT INTO tbl_relation_comp (category_id, company_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(1,2),
(2,1),
(3,2);

INSERT INTO tbl_sub_categories (company_id, sub_cat_name)
VALUES
(1, 'Organic Farming'),
(1, "Flowers");

INSERT INTO tbl_sub_categories (company_id, sub_cat_name)
VALUES
(1, 'Fitness Equipment'),
(2, 'Organic Food'),
(3, 'Mobile Accessories'),
(4, 'Home Decor'),
(5, 'Outdoor Gear'),
(6, 'Tech Gadgets'),
(7, 'Beauty Products'),
(8, 'Sports Apparel'),
(9, 'Books & Stationery'),
(10, 'Gaming Accessories');

-- SET SQL_SAFE_UPDATES = 1;

-- UPDATE tbl_user 
-- SET name_ = CONCAT('User ', user_id)
-- WHERE user_id IS NOT NULL
-- LIMIT 10;

INSERT INTO tbl_products (product_name, image_id, sub_cat_id, price, descriptions)
VALUES
('Treadmill Pro 3400', 1, 2, 899.99, 'High-end treadmill with multiple workout modes and heart rate monitor. modified');

INSERT INTO tbl_products (product_name, image_id, sub_cat_id, price, descriptions)
VALUES
('Treadmill Pro 3000', 1, 1, 899.99, 'High-end treadmill with multiple workout modes and heart rate monitor.'),
('Organic Almond Butter', 2, 2, 12.49, 'Creamy organic almond butter with no added sugar.'),
('Wireless Earbuds X200', 3, 3, 59.99, 'Noise-canceling wireless earbuds with long battery life.'),
('Handmade Ceramic Vase', 4, 4, 45.00, 'Beautiful handcrafted ceramic vase perfect for home decor.'),
('Hiking Backpack 50L', 5, 5, 120.75, 'Durable and waterproof hiking backpack with multiple compartments.'),
('Smartwatch Series 5', 6, 6, 249.99, 'Feature-rich smartwatch with health tracking and GPS.'),
('Natural Face Serum', 7, 7, 29.95, 'Anti-aging face serum made with natural ingredients.'),
('Running Shoes MaxFit', 8, 8, 79.99, 'Lightweight and comfortable running shoes for all terrains.'),
('Leather Journal Notebook', 9, 9, 25.50, 'Premium leather-bound journal with high-quality paper.'),
('Gaming Mouse UltraSpeed', 10, 10, 49.99, 'Ergonomic gaming mouse with customizable buttons and RGB lighting.');

INSERT INTO tbl_forgot_password (email_id, reset_token)
VALUES
('user1@example.com', 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6'),
('vendor1@example.com', 'z9y8x7w6v5u4t3s2r1q0p9o8n7m6l5'),
('user2@example.com', 'k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5'),
('vendor2@example.com', 'f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u'),
('user3@example.com', 'p9o8n7m6l5k4j3h2g1f0e9d8c7b6a5'),
('vendor3@example.com', 'r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2'),
('user4@example.com', 'm3n4o5p6q7r8s9t0u1v2w3x4y5z6a7'),
('vendor4@example.com', 'h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2'),
('user5@example.com', 'x4y5z6a7b8c9d0e1f2g3h4i5j6k7l8'),
('vendor5@example.com', 'n7m6l5k4j3h2g1f0e9d8c7b6a5z4y3');


-- --------------------------- Queries ------------------------------------

-- ------------------- Triggers ------------------------------------------
-- Trigger for AVG RATING
select * from tbl_company;
select * from tbl_ratings;

INSERT INTO tbl_ratings (rating, user_id, company_id)
VALUES
(1, 1, 1);

select company_id, avg_rating from tbl_company where company_id = 1;

DELIMITER $$

DROP TRIGGER IF EXISTS update_avg_rating $$

CREATE TRIGGER update_avg_rating
AFTER INSERT ON tbl_ratings
FOR EACH ROW
BEGIN
    UPDATE tbl_company
    SET avg_rating = (
        SELECT AVG(rating)
        FROM tbl_ratings
        WHERE company_id = NEW.company_id
    )
    WHERE company_id = NEW.company_id;
END $$

DELIMITER ;

-- Updating avg_rating when rating is deleted
DELIMITER $$
DROP TRIGGER IF EXISTS update_avg_rating_delete $$
CREATE TRIGGER update_avg_rating_delete
AFTER DELETE ON tbl_ratings
FOR EACH ROW
BEGIN
    UPDATE tbl_company
    SET avg_rating = (
        SELECT AVG(rating)
        FROM tbl_ratings
        WHERE company_id = OLD.company_id
    )
    WHERE company_id = OLD.company_id;
END $$
DELIMITER ;

delete from tbl_ratings where rating_id = 6;
select * from tbl_company;
select * from tbl_ratings;

-- Display categories
select category_name from tbl_categories;


-- Display category wise company name
-- if category = ALL
select cm.company_name, cm.avg_rating, cm.email_id, cm.phone, cm.tag_line, cm.address, cm.image_id,
concat(ROUND(( 3959 * ACOS( COS( RADIANS('23.114792504094922') )  
		* COS( RADIANS( cm.latitude ) ) 
		* COS( RADIANS( cm.longitude ) - RADIANS('72.54021032611935') )  
		+ SIN( RADIANS('23.114792504094922') )  
		* SIN( RADIANS( cm.latitude) ) ) ),0), " Miles away") as distance_km
from tbl_categories c inner join 
tbl_relation_comp r on c.category_id = r.category_id 
inner join tbl_company cm on r.company_id = cm.company_id;

-- if category = "Books" or "Furniture"
select cm.company_name, cm.avg_rating, cm.email_id, cm.phone, cm.tag_line, cm.address, cm.image_id,
concat(ROUND(( 3959 * ACOS( COS( RADIANS('23.114792504094922') )  
		* COS( RADIANS( cm.latitude ) ) 
		* COS( RADIANS( cm.longitude ) - RADIANS('72.54021032611935') )  
		+ SIN( RADIANS('23.114792504094922') )  
		* SIN( RADIANS( cm.latitude) ) ) ),0), " Miles away") as distance_km
from tbl_categories c inner join 
tbl_relation_comp r on c.category_id = r.category_id 
inner join tbl_company cm on r.company_id = cm.company_id where c.category_name = "Furniture";

-- Particular Company's Product
-- Company A's product

select c.company_name, c.avg_rating, c.email_id, c.phone, c.tag_line, c.address, c.image_id,
concat(ROUND(( 3959 * ACOS( COS( RADIANS('23.114792504094922') )  
		* COS( RADIANS( c.latitude ) ) 
		* COS( RADIANS( c.longitude ) - RADIANS('72.54021032611935') )  
		+ SIN( RADIANS('23.114792504094922') )  
		* SIN( RADIANS( c.latitude) ) ) ),0), " Miles away") as distance_km,
        p.product_name, p.image_id, p.price, p.descriptions, sc.sub_cat_name
        from tbl_company c inner join tbl_sub_categories sc 
on c.company_id = sc.company_id inner join tbl_products p on p.sub_cat_id = sc.sub_cat_id 
where c.company_name = "Company B";

-- ----------------------------- GROUP BY AND HAVING ------------------------------------
-- Finding number of sub categories inside a company
select concat(count(*), " categories found " ) as num_of_sub_cat from tbl_sub_categories 
group by company_id having company_id = 1;

-- Finding products inside sub_categories
select concat(count(p.product_id), " products found") as message, sc.sub_cat_name 
from tbl_sub_categories as sc inner join tbl_products as p 
on sc.sub_cat_id = p.sub_cat_id group by sc.sub_cat_name;

-- Company wise ratings
select company_name, (
	select count(rating_id) from tbl_ratings where company_id = tbl_company.company_id
) as rating_cnt from tbl_company 
where company_id in (
	select company_id from tbl_ratings
);

-- Login 
-- Using credentials
-- Email: user1@example.com and password: password123
select concat("Welcome " , name_) as msg from tbl_user where email_id = "user1@example.com" and passwords = "password123";

-- Signup
insert into tbl_user (name_, email_id, passwords, phone_number, user_type) values 
("Mahek Gor", "mahek.gce@gmail.com", "12345678", "9638527417", "User");


-- Forgot Password
-- email id: mahek@gmail.com

-- Insert Reset Token for Forgot Password: 
insert into tbl_forgot_password(email_id, reset_token, expires_at)
values ("user2@example.com", 'sometokenblahblah', '2025-02-10 23:59:59');

-- Check if Token is Valid
-- Token entered by user is sometokenblahblah then successful login else not
select reset_token from tbl_forgot_password where reset_token = 'sometokenblahblah' and expires_at > current_timestamp();

-- Update Password After Token Validation
-- Password given by user is mypswd2003
update tbl_user set passwords = 'mypswd2003', updated_at = current_timestamp()
where email_id = (select email_id from tbl_forgot_password where reset_token = 'sometokenblahblah');

select * from tbl_forgot_password;
select * from tbl_user;
select * from tbl_categories;
select * from tbl_company;
select * from tbl_image;
select * from tbl_products;
select * from tbl_relation_comp;
select * from tbl_sub_categories;
select * from tbl_ratings;

ALTER TABLE tbl_products
CHANGE expires_at updated_at datetime;
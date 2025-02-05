create database db_31;
use db_31;
create table tbl_user(
	user_id bigint primary key auto_increment,
    name varchar(128),
    email varchar(128),
    passwords varchar(64),
    profile_pic varchar(32),
    login_type enum('S', 'F', 'G'),
    about text,
    social_id varchar(128),
    is_active boolean,
    created_at datetime default current_timestamp(),
    updated_at datetime
);

-- drop table tbl_place;

create table tbl_place(
	place_id bigint primary key auto_increment,
    location text,
    image_id bigint references tbl_image(image_id),
    user_id bigint references tbl_user(user_id),
    latitude char(16),
    longitude char(16), 
    about_us text,
    avg_rating float(5,1),
    total_reviews int,
    is_active boolean,
    created_at datetime default current_timestamp(),
    updated_at datetime
);
-- drop table tbl_place;
-- drop table tbl_image;
-- drop table tbl_reviews;
-- drop table tbl_user;

create table tbl_image(
	image_id bigint primary key auto_increment,
    image_name varchar(64),
    created_at datetime default current_timestamp(),
    updated_at datetime
);

create table tbl_reviews(
	review_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    review text,
    place_id bigint references tbl_place(place_id),
    created_at datetime default current_timestamp(),
    updated_at datetime
);

ALTER TABLE tbl_user ADD CONSTRAINT unique_email UNIQUE (email);

delete from tbl_user;

-- User Signup


INSERT INTO tbl_user (name, email, passwords, profile_pic, login_type, social_id, is_active, created_at, updated_at) VALUES
("Tanisha Agrawal", "tanisha1@gmail.com", "pass123", "img1.png", "G", "social_1", 1, "2024-05-06 09:00:00", NULL),
("Rahul Sharma", "rahul2@gmail.com", "pass234", "img2.png", "S", "social_2", 1, "2024-05-06 09:10:00", NULL),
("Aditi Patel", "aditi3@gmail.com", "pass345", "img3.png", "F", "social_3", 1, "2024-05-06 09:20:00", NULL),
("Vikram Singh", "vikram4@gmail.com", "pass456", "img4.png", "G", "social_4", 1, "2024-05-06 09:30:00", NULL),
("Sneha Jain", "sneha5@gmail.com", "pass567", "img5.png", "S", "social_5", 1, "2024-05-06 09:40:00", NULL),
("Manish Verma", "manish6@gmail.com", "pass678", "img6.png", "F", "social_6", 1, "2024-05-06 09:50:00", NULL),
("Priya Kapoor", "priya7@gmail.com", "pass789", "img7.png", "G", "social_7", 1, "2024-05-06 10:00:00", NULL),
("Rajesh Kumar", "rajesh8@gmail.com", "pass890", "img8.png", "S", "social_8", 1, "2024-05-06 10:10:00", NULL),
("Kavita Mehta", "kavita9@gmail.com", "pass901", "img9.png", "F", "social_9", 1, "2024-05-06 10:20:00", NULL),
("Aman Gupta", "aman10@gmail.com", "pass012", "img10.png", "G", "social_10", 1, "2024-05-06 10:30:00", NULL),
("Pooja Yadav", "pooja11@gmail.com", "pass111", "img11.png", "S", "social_11", 1, "2024-05-06 10:40:00", NULL),
("Harsh Tiwari", "harsh12@gmail.com", "pass222", "img12.png", "F", "social_12", 1, "2024-05-06 10:50:00", NULL),
("Neha Rathi", "neha13@gmail.com", "pass333", "img13.png", "G", "social_13", 1, "2024-05-06 11:00:00", NULL),
("Sachin Mishra", "sachin14@gmail.com", "pass444", "img14.png", "S", "social_14", 1, "2024-05-06 11:10:00", NULL),
("Deepika Sharma", "deepika15@gmail.com", "pass555", "img15.png", "F", "social_15", 1, "2024-05-06 11:20:00", NULL),
("Ankit Rathore", "ankit16@gmail.com", "pass666", "img16.png", "G", "social_16", 1, "2024-05-06 11:30:00", NULL),
("Sonia Malhotra", "sonia17@gmail.com", "pass777", "img17.png", "S", "social_17", 1, "2024-05-06 11:40:00", NULL),
("Gaurav Singh", "gaurav18@gmail.com", "pass888", "img18.png", "F", "social_18", 1, "2024-05-06 11:50:00", NULL),
("Ritika Joshi", "ritika19@gmail.com", "pass999", "img19.png", "G", "social_19", 1, "2024-05-06 12:00:00", NULL),
("Nitin Chauhan", "nitin20@gmail.com", "pass000", "img20.png", "S", "social_20", 1, "2024-05-06 12:10:00", NULL),
("Karan Arora", "karan21@gmail.com", "pass121", "img21.png", "F", "social_21", 1, "2024-05-06 12:20:00", NULL),
("Isha Kapoor", "isha22@gmail.com", "pass232", "img22.png", "G", "social_22", 1, "2024-05-06 12:30:00", NULL),
("Rohit Thakur", "rohit23@gmail.com", "pass343", "img23.png", "S", "social_23", 1, "2024-05-06 12:40:00", NULL),
("Swati Saxena", "swati24@gmail.com", "pass454", "img24.png", "F", "social_24", 1, "2024-05-06 12:50:00", NULL),
("Arjun Mehta", "arjun25@gmail.com", "pass565", "img25.png", "G", "social_25", 1, "2024-05-06 13:00:00", NULL),
("Meera Reddy", "meera26@gmail.com", "pass676", "img26.png", "S", "social_26", 1, "2024-05-06 13:10:00", NULL),
("Vivek Bhatia", "vivek27@gmail.com", "pass787", "img27.png", "F", "social_27", 1, "2024-05-06 13:20:00", NULL),
("Divya Nair", "divya28@gmail.com", "pass898", "img28.png", "G", "social_28", 1, "2024-05-06 13:30:00", NULL),
("Sahil Kapoor", "sahil29@gmail.com", "pass909", "img29.png", "S", "social_29", 1, "2024-05-06 13:40:00", NULL),
("Neeraj Verma", "neeraj30@gmail.com", "pass010", "img30.png", "F", "social_30", 1, "2024-05-06 13:50:00", NULL);

INSERT INTO tbl_image (image_name, created_at) VALUES
('beach.jpg', '2024-05-06 09:00:00'),
('mountain.jpg', '2024-05-06 09:05:00'),
('forest.jpg', '2024-05-06 09:10:00'),
('desert.jpg', '2024-05-06 09:15:00'),
('lake.jpg', '2024-05-06 09:20:00'),
('cityscape.jpg', '2024-05-06 09:25:00'),
('village.jpg', '2024-05-06 09:30:00'),
('river.jpg', '2024-05-06 09:35:00'),
('waterfall.jpg', '2024-05-06 09:40:00'),
('cave.jpg', '2024-05-06 09:45:00'),
('sunset.jpg', '2024-05-06 09:50:00'),
('night_sky.jpg', '2024-05-06 09:55:00'),
('aurora.jpg', '2024-05-06 10:00:00'),
('snow.jpg', '2024-05-06 10:05:00'),
('island.jpg', '2024-05-06 10:10:00'),
('valley.jpg', '2024-05-06 10:15:00'),
('canyon.jpg', '2024-05-06 10:20:00'),
('meadow.jpg', '2024-05-06 10:25:00'),
('volcano.jpg', '2024-05-06 10:30:00'),
('ocean.jpg', '2024-05-06 10:35:00'),
('harbor.jpg', '2024-05-06 10:40:00'),
('field.jpg', '2024-05-06 10:45:00'),
('waterfall_2.jpg', '2024-05-06 10:50:00'),
('temple.jpg', '2024-05-06 10:55:00'),
('historical_site.jpg', '2024-05-06 11:00:00'),
('mountain_2.jpg', '2024-05-06 11:05:00'),
('wildlife.jpg', '2024-05-06 11:10:00'),
('bridge.jpg', '2024-05-06 11:15:00'),
('roadtrip.jpg', '2024-05-06 11:20:00'),
('garden.jpg', '2024-05-06 11:25:00');


INSERT INTO tbl_place (location, image_id, user_id, latitude, longitude, about_us, avg_rating, total_reviews, is_active, created_at) VALUES
('Goa Beach', 1, 1, '15.2993', '74.1240', 'Beautiful sandy beach in Goa.', 4.5, 120, 1, '2024-05-06 12:00:00'),
('Amazon Forest', 3, 3, '-3.4653', '-62.2159', 'Dense tropical rainforest with rich biodiversity.', 4.7, 180, 1, '2024-05-06 12:10:00'),
('Sahara Desert', 4, 4, '23.4162', '25.6628', 'Expansive desert with sand dunes.', 4.2, 90, 1, '2024-05-06 12:15:00'),
('Lake Tahoe', 5, 5, '39.0968', '-120.0324', 'Scenic freshwater lake between California and Nevada.', 4.6, 140, 1, '2024-05-06 12:20:00'),
('New York City', 6, 6, '40.7128', '-74.0060', 'Vibrant city with iconic landmarks.', 4.9, 300, 1, '2024-05-06 12:25:00'),
('Santorini Village', 7, 7, '36.3932', '25.4615', 'White-washed houses with blue domes.', 4.8, 210, 1, '2024-05-06 12:30:00'),
('Ganges River', 8, 8, '25.3176', '83.0080', 'Holy river in India.', 4.3, 170, 1, '2024-05-06 12:35:00'),
('Niagara Falls', 9, 9, '43.0962', '-79.0377', 'Spectacular waterfalls between Canada and USA.', 4.9, 290, 1, '2024-05-06 12:40:00'),
('Ajanta Caves', 10, 10, '20.5522', '75.7030', 'Ancient Buddhist rock-cut caves.', 4.7, 150, 1, '2024-05-06 12:45:00'),
('Maldives', 11, 1, '-3.2028', '73.2207', 'Tropical paradise with blue waters.', 4.9, 310, 1, '2024-05-06 12:50:00'),
('Great Wall of China', 12, 4, '40.4319', '116.5704', 'Historic defense structure.', 4.8, 270, 1, '2024-05-06 12:55:00'),
('Swiss Alps', 13, 3, '46.8182', '8.2275', 'Alpine mountain range with skiing resorts.', 4.9, 260, 1, '2024-05-06 13:00:00'),
('Yellowstone Park', 14, 4, '44.4280', '-110.5885', 'Famous for geysers and wildlife.', 4.6, 200, 1, '2024-05-06 13:05:00'),
('Grand Canyon', 15, 5, '36.1069', '-112.1129', 'Majestic natural canyon.', 4.9, 280, 1, '2024-05-06 13:10:00'),
('Tokyo Skyline', 16, 6, '35.6895', '139.6917', 'Modern city with neon lights.', 4.8, 290, 1, '2024-05-06 13:15:00'),
('Venice Canals', 17, 7, '45.4408', '12.3155', 'Romantic gondola rides.', 4.7, 250, 1, '2024-05-06 13:20:00'),
('Banff National Park', 18, 8, '51.4968', '-115.9281', 'Scenic lakes and mountains.', 4.9, 220, 1, '2024-05-06 13:25:00'),
('Great Barrier Reef', 19, 9, '-18.2871', '147.6992', 'Coral reef with marine life.', 4.9, 260, 1, '2024-05-06 13:30:00'),
('Stonehenge', 20, 10, '51.1789', '-1.8262', 'Mysterious prehistoric monument.', 4.5, 190, 1, '2024-05-06 13:35:00');

INSERT INTO tbl_reviews (user_id, review, place_id, created_at) VALUES
(1, 'Amazing place, must visit!', 1, '2024-05-06 14:00:00'),
(4, 'Beautiful view, loved it!', 2, '2024-05-06 14:05:00'),
(3, 'A nature lover’s paradise.', 3, '2024-05-06 14:10:00'),
(4, 'Too hot, but great experience.', 4, '2024-05-06 14:15:00'),
(5, 'Very peaceful and scenic.', 5, '2024-05-06 14:20:00'),
(6, 'Bustling city with great vibes.', 6, '2024-05-06 14:25:00'),
(7, 'Absolutely stunning at night.', 7, '2024-05-06 14:30:00');

-- User logged in using email id: aditi3@gmail.com and password: pass345
SELECT 
    CASE 
        WHEN EXISTS (
            SELECT name 
            FROM tbl_user 
            WHERE email = "tanisha1@gmail.com" AND passwords = "pass123"
        ) 
        THEN CONCAT("Welcome ", name) 
        ELSE "You are not a member" 
    END AS Welcome_Message
FROM tbl_user
WHERE email = "tanisha1@gmail.com" AND passwords = "pass123";

-- User wants to signin and details provided are as below:
-- Name: Tanishaaa Agrawal 
-- Email: tan@gmail.com
-- password: 123456
-- profile_pic: awesome.jpg
-- login_type: G
-- social_id: sdfghnjm234567

INSERT INTO tbl_user (name, email, passwords, profile_pic, login_type, social_id, is_active) VALUES 
("Tanishaaa Agrawal", "tan@gmail.com", "123456", "awesome.jpg", "G", "sdfghnjm234567", 1);


-- Fetch Review
select u.name, u.profile_pic, r.review, date_format(r.created_at, "%d-%b-%Y %h:%i %p") as dates from tbl_user u 
inner join tbl_reviews r on u.user_id = r.review_id where u.user_id = 1;

-- place_id, location, latitude, longitude, about_us, avg_rating, total_reviews, image_id, image_name
select p.place_id, p.location, p.about_us, p.avg_rating, p.total_reviews, group_concat(i.image_name) as images,
ROUND(( 6371 * ACOS( COS( RADIANS('23.114792504094922') )  
		* COS( RADIANS( p.latitude ) ) 
		* COS( RADIANS( p.longitude ) - RADIANS('72.54021032611935') )  
		+ SIN( RADIANS('23.114792504094922') )  
		* SIN( RADIANS( p.latitude) ) ) ),1) as distance_km
from tbl_place p inner join tbl_image i on p.image_id = i.image_id where p.place_id = 1;

-- Nearby locations
select p.place_id, p.location, p.about_us, p.avg_rating, p.total_reviews, i.image_name,
ROUND(( 6371 * ACOS( COS( RADIANS('23.114792504094922') )  
		* COS( RADIANS( p.latitude ) ) 
		* COS( RADIANS( p.longitude ) - RADIANS('72.54021032611935') )  
		+ SIN( RADIANS('23.114792504094922') )  
		* SIN( RADIANS( p.latitude) ) ) ),1) as distance_km
from tbl_place p inner join tbl_image i on p.image_id = i.image_id having distance_km < 2000;
 

-- Find like name
select p.place_id, p.location, p.about_us, p.avg_rating, p.total_reviews, i.image_name,
ROUND(( 6371 * ACOS( COS( RADIANS('23.114792504094922') )  
		* COS( RADIANS( p.latitude ) ) 
		* COS( RADIANS( p.longitude ) - RADIANS('72.54021032611935') )  
		+ SIN( RADIANS('23.114792504094922') )  
		* SIN( RADIANS( p.latitude) ) ) ),1) as distance_km
from tbl_place p inner join tbl_image i on p.image_id = i.image_id where p.location like "%ama%";

-- Pinned Location
select p.location from tbl_user u inner join tbl_place p on u.user_id = p.user_id where u.user_id = 5;

-- User updates profile
update tbl_user set about="Heyyy I am Tanishaaa", profile_pic="tanisha.png" where user_id=1;

-- View user details based on user_id
select * from tbl_user where user_id=1;

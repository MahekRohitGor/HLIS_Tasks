CREATE DATABASE DB_13_02;
USE DB_13_02;
-- 1st Set: FoodyBite

create table tbl_user(
	user_id bigint primary key auto_increment,
    user_name varchar(164) not null,
    email_id varchar(164) unique not null,
    passwords varchar(64) not null,
    profile_pic varchar(64) default "default.jpg",
    latitude char(16),
    longitude char(16),
    review_count bigint,
    followers_count bigint,
    following_count bigint,
    language_pref varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    foreign key (contact_list) references tbl_user(user_id)
);

create table tbl_contact_list(
	cl_id bigint primary key auto_increment,
    contact_id_1 bigint,
    contact_id_2 bigint,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    foreign key (contact_id_1) references tbl_user(user_id),
    foreign key (contact_id_2) references tbl_user(user_id)
);

create table tbl_forgot_password (
  reset_id bigint primary key auto_increment,
  email_id varchar(256),
  reset_token varchar(128),
  is_active boolean default 1,
  is_deleted boolean default 0,
  created_at datetime default current_timestamp(),
  expires_at datetime,
  foreign key (email_id) references tbl_user(email_id)
);

create table tbl_category(
	category_id bigint primary key auto_increment,
    category_name varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_address(
	address_id bigint primary key auto_increment,
    address text,
    latitude char(16),
    longitude char(16),
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

create table tbl_restaurant(
	restaurant_id bigint primary key auto_increment,
    restaurant_name varchar(128),
    category_id bigint,
    cover_image bigint,
    review_count bigint default 0,
    address bigint,
    avg_rating bigint,
    country_code char(8),
    phone_number char(16),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    foreign key (category_id) references tbl_category(category_id),
    foreign key (address) references tbl_address(address_id),
    foreign key (cover_image) references tbl_image(image_id)
);

ALTER TABLE tbl_restaurant
MODIFY avg_rating decimal(10,2);

create table tbl_user_favs(
	fav_id bigint primary key auto_increment,
    user_id bigint,
    restaurant_id bigint,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    foreign key (restaurant_id) references tbl_restaurant(restaurant_id),
    foreign key (user_id) references tbl_user(user_id)
);

create table tbl_menu_and_photos(
	menu_id bigint primary key auto_increment,
    menu_photo bigint,
    restaurant_id bigint,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    foreign key (menu_photo) references tbl_image(image_id),
    foreign key (restaurant_id) references tbl_restaurant(restaurant_id)
);

create table tbl_rating_review(
	rating_id bigint primary key auto_increment,
    user_id bigint,
    restaurant_id bigint,
    rating float(5,2),
    review text,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    foreign key (user_id) references tbl_user(user_id),
    foreign key (restaurant_id) references tbl_restaurant(restaurant_id)
);

create table tbl_timings(
	id bigint primary key auto_increment,
    open_time time,
    close_time time,
    day_ enum("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun") not null,
    status_ enum("Open", "Close") not null,
    restaurant_id bigint,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    foreign key (restaurant_id) references tbl_restaurant(restaurant_id)
);

create table tbl_follow(
	pk_follow_id bigint primary key auto_increment,
    user_id bigint,
    follow_id bigint,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    foreign key (user_id) references tbl_user(user_id),
    foreign key (follow_id) references tbl_user(user_id)
);

create table tbl_block(
	block_id bigint primary key auto_increment,
    user_id bigint,
    block_user_id bigint,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    foreign key (user_id) references tbl_user(user_id),
    foreign key (block_user_id) references tbl_user(user_id)
);

-- TRIGGERS
-- Update review count for table
DELIMITER $$
CREATE TRIGGER trg_update_review_count_restaurant
AFTER INSERT ON tbl_rating_review
FOR EACH ROW
BEGIN
	UPDATE tbl_restaurant set review_count = (
		select count(*) from tbl_rating_review where restaurant_id = new.restaurant_id
    )
    where restaurant_id = new.restaurant_id;
END $$
DELIMITER ;

-- Update Avg Rating on insert
DELIMITER $$
DROP TRIGGER IF EXISTS trg_update_avg_rating;
CREATE TRIGGER trg_update_avg_rating
AFTER INSERT ON tbl_rating_review
FOR EACH ROW
BEGIN
	UPDATE tbl_restaurant SET avg_rating = (
		SELECT avg(rating) FROM tbl_rating_review where restaurant_id = new.restaurant_id
    )
    where restaurant_id = new.restaurant_id;
END $$
DELIMITER ;

-- Update avg_rating on delete 
DELIMITER $$
CREATE TRIGGER trg_update_avg_rating_delete
AFTER DELETE ON tbl_rating_review
FOR EACH ROW
BEGIN
	UPDATE tbl_restaurant
    SET avg_rating = (
        SELECT AVG(rating)
        FROM tbl_rating_review
        WHERE restaurant_id = OLD.restaurant_id
    )
    WHERE restaurant_id = OLD.restaurant_id;
END $$
DELIMITER ;

-- UPDATE FOLLOWER
DELIMITER $$
CREATE TRIGGER trg_update_follower_count
AFTER INSERT ON tbl_follow
FOR EACH ROW
BEGIN
	UPDATE tbl_user SET followers_count = (
		SELECT COUNT(*) FROM tbl_follow WHERE follow_id = new.follow_id
    )
    WHERE user_id = new.follow_id;
END $$
DELIMITER ;

-- UPDATE FOLLOWER ON DELETE
DELIMITER $$
CREATE TRIGGER trg_update_follower_count_delete
AFTER DELETE ON tbl_follow
FOR EACH ROW
BEGIN
	UPDATE tbl_user SET followers_count = (
		SELECT COUNT(*) FROM tbl_follow WHERE follow_id = OLD.follow_id
    )
    WHERE user_id = OLD.follow_id;
END $$
DELIMITER ;

-- Update User Review Count
DELIMITER $$
CREATE TRIGGER trg_update_review_cnt_user
AFTER INSERT ON tbl_rating_review
FOR EACH ROW
BEGIN
	UPDATE tbl_user set review_count = (
		select count(*) from tbl_rating_review where user_id = new.user_id
    )
    where user_id = new.user_id;
END $$
DELIMITER ;

-- Update User Review Count on delete
DELIMITER $$
CREATE TRIGGER trg_update_review_cnt_user_delete
AFTER DELETE ON tbl_rating_review
FOR EACH ROW
BEGIN
	UPDATE tbl_user set review_count = (
		select count(*) from tbl_rating_review where user_id = OLD.user_id
    )
    where user_id = OLD.user_id;
END $$
DELIMITER ;

-- UPDATE FOLLOWING
DELIMITER $$
CREATE TRIGGER trg_update_following_count
AFTER INSERT ON tbl_follow
FOR EACH ROW
BEGIN
	UPDATE tbl_user SET following_count = (
		SELECT COUNT(*) FROM tbl_follow WHERE user_id = new.user_id
    )
    WHERE user_id = new.user_id;
END $$
DELIMITER ;

-- UPDATE FOLLOWING ON DELETE
DELIMITER $$
CREATE TRIGGER trg_update_following_count_delete
AFTER DELETE ON tbl_follow
FOR EACH ROW
BEGIN
	UPDATE tbl_user SET following_count = (
		SELECT COUNT(*) FROM tbl_follow WHERE user_id = OLD.user_id
    )
    WHERE user_id = OLD.user_id;
END $$
DELIMITER ;

-- INSERT VALUES
INSERT INTO tbl_user 
(user_name, email_id, passwords, profile_pic, latitude, longitude, language_pref) 
VALUES 
("MAHEK GOR", "mahek@gmail.com", "mahek1234", "mahekprofile.jpg", "23.041000", "72.578537", "English"),
("VAISHVI PATEL", "vaish@gmail.com", "vaish1234", "vaishvi.jpg", "37.7749", "-122.4194", "French"),
("HELI BHATT", "heli@gmail.com", "heli1234", "heli.jpg", "34.0522", "-118.2437", "Spanish"),
("ADITI PATHAK", "aditi@gmail.com", "aditi1234", "aditi.jpg", '40.7128', '-74.0060', "Italian"),
("HIMANSHI SINGH", "himanshi@gmail.com", "himanshi1234", "himanshi.jpg", '41.8781', '-87.6298', "Japanese");

INSERT INTO tbl_user 
(user_name, email_id, passwords, profile_pic, latitude, longitude, language_pref) 
VALUES 
("JEET GOR", "jeet@gmail.com", "jeet", "jeet.jpg", "23.041000", "72.578537", "English"),
("PRINCY PATEL", "princy@gmail.com", "princy", "princy.jpg", "37.7749", "-122.4194", "French");

select * from tbl_user;

INSERT INTO tbl_contact_list (contact_id_1, contact_id_2)
values
(1,2),
(1,3),
(1,4),
(2,3),
(2,4),
(3,4);


INSERT INTO tbl_forgot_password (email_id, reset_token) 
VALUES
('mahek@gmail.com', 'token123'),
('vaish@gmail.com', 'token234'),
('heli@gmail.com', 'token345'),
('aditi@gmail.com', 'token456'),
('himanshi@gmail.com', 'token567');

INSERT INTO tbl_category
(category_name)
values
("Italian"),
("Chinese"),
("Mexican"),
("Indian"),
("Thai"),
("Arabian");


INSERT INTO tbl_address (address, latitude, longitude) VALUES
('123 Main St', '37.7749', '-122.4194'),
('456 Elm St', '34.0522', '-118.2437'),
('789 Oak St', '40.7128', '-74.0060'),
('135 Pine St', '41.8781', '-87.6298'),
('246 Maple St', '29.7604', '-95.3698'),
('357 Cedar St', '39.7392', '-104.9903'),
('468 Birch St', '32.7767', '-96.7970'),
('579 Walnut St', '47.6062', '-122.3321'),
('680 Cherry St', '38.9072', '-77.0369'),
('791 Aspen St', '42.3601', '-71.0589');

INSERT INTO tbl_image (image_name)
values
("img17.jpg"),
("img18.jpg"),
("img19.jpg"),
("img20.jpg"),
("img21.jpg"),
("img22.jpg"),
("img1.jpg"),
("img8.jpg"),
("img9.jpg"),
("img2.jpg"),
("img5.jpg"),
("img7.jpg");


INSERT INTO tbl_restaurant (restaurant_name, category_id, cover_image, address, country_code, phone_number)
VALUES
("La Pinoz", 1, 1, 1, "+91", "7418529634"),
("Sankalp", 2, 3, 2, "+91", "7523963851"),
("Dominos", 1, 2, 3, "+91", "7418529630"),
("Pink Door", 1, 4, 4, "+91", "7418529634"),
("Rustic Rays", 2, 5, 5, "+91", "7418529634"),
("Masala Story", 6, 1, 6, "+91", "7418529634");

select * from tbl_user_favs;
INSERT INTO tbl_user_favs (user_id, restaurant_id) 
VALUES 
(1, 2), 
(2, 3), 
(3, 1), 
(4, 5), 
(5, 4);

INSERT INTO tbl_user_favs (user_id, restaurant_id) 
VALUES
(1, 3), 
(1, 1), 
(4, 1), 
(5, 1);

INSERT INTO tbl_menu_and_photos (menu_photo, restaurant_id) 
VALUES 
(7, 1), 
(8, 2), 
(9, 3), 
(10, 4), 
(11, 5);

INSERT INTO tbl_menu_and_photos (menu_photo, restaurant_id) 
VALUES 
(7, 5), 
(8, 5), 
(9, 5), 
(10, 5);

INSERT INTO tbl_rating_review (user_id, restaurant_id, rating, review) 
VALUES 
(1, 4, 4.5, "Great food!"), 
(2, 2, 4.0, "Loved the ambiance."), 
(3, 1, 3.8, "Good experience."), 
(4, 3, 5.0, "Amazing place!"), 
(5, 2, 4.2, "Nice food and service."),
(1, 2, 2.4, "Taste should be improved"),
(3, 5, 5.0, "Best Food in Town"),
(4, 5, 4.4, "Taste is best !!");

INSERT INTO tbl_timings (open_time, close_time, day_, status_, restaurant_id) 
VALUES 
("08:00:00", "22:00:00", "Mon", "Open", 1), 
("08:00:00", "22:00:00", "Tue", "Open", 2), 
("08:00:00", "22:00:00", "Wed", "Open", 3), 
("08:00:00", "22:00:00", "Thu", "Open", 4), 
("08:00:00", "22:00:00", "Fri", "Open", 5),
("08:00:00", "22:00:00", "Mon", "Open", 2), 
("08:00:00", "22:00:00", "Tue", "Open", 3), 
("08:00:00", "22:00:00", "Wed", "Open", 4), 
("08:00:00", "22:00:00", "Thu", "Open", 5), 
("08:00:00", "22:00:00", "Fri", "Open", 1),
("08:00:00", "22:00:00", "Mon", "Open", 3), 
("08:00:00", "22:00:00", "Tue", "Open", 4), 
("08:00:00", "22:00:00", "Wed", "Open", 5), 
("08:00:00", "22:00:00", "Thu", "Open", 1), 
("08:00:00", "22:00:00", "Fri", "Open", 2);

SELECT * FROM tbl_follow;
INSERT INTO tbl_follow (user_id, follow_id) 
VALUES 
(1, 2), 
(2, 3), 
(3, 4), 
(4, 5), 
(5, 1);

SELECT * FROM tbl_follow;
INSERT INTO tbl_follow (user_id, follow_id) 
VALUES 
(1, 2), 
(2, 1), 
(3, 1), 
(4, 1), 
(5, 2);

SELECT * FROM tbl_follow;

INSERT INTO tbl_block (user_id, block_id) 
VALUES 
(1, 3), 
(2, 5), 
(3, 1), 
(4, 2), 
(5, 4);

-- Queries
-- Signup
-- Location can be received by turning on gps
INSERT INTO tbl_user 
(user_name, email_id, passwords, profile_pic, latitude, longitude, language_pref) 
VALUES 
("Tanisha Agarwal", "tanisha@gmail.com", "tanntann", "tan.jpg", "23.041000", "72.578537", "Spanish");

-- Login
select user_name from tbl_user
where email_id = "tanisha@gmail.com" and passwords = "tanntann";

-- Forgot Password
-- Forgot Password for tanisha@gmail.com
-- Insert Reset Token for Forgot Password: 
insert into tbl_forgot_password (email_id, reset_token, expires_at)
values ("tanisha@gmail.com", 'qwertyuiop', '2025-02-14 23:59:59');

-- Token from user side is qwertyuiop then successful else not
-- User entered: qwertyuiop
update tbl_user set passwords = 'mypswd2003', updated_at = current_timestamp()
where email_id = (
select email_id from tbl_forgot_password where reset_token = (
	select reset_token from tbl_forgot_password where reset_token = 'qwertyuiop' 
	and expires_at > current_timestamp()
)
);

select * from tbl_user;

-- trending restaurants
select 
distinct
r.restaurant_name,
c.category_name,
r.avg_rating,
r.review_count,
a.address,
i.image_id,
concat(ROUND(( 3959 * ACOS( COS( RADIANS('37.7749') )  
		* COS( RADIANS( a.latitude ) ) 
		* COS( RADIANS( a.longitude ) - RADIANS('-122.4194') )  
		+ SIN( RADIANS('37.7749') )  
		* SIN( RADIANS( a.latitude) ) ) ),0), " km") as distance_km
from
tbl_restaurant r
inner join
tbl_category c
on r.category_id = c.category_id
inner join 
tbl_address a
on a.address_id = r.address
inner join 
tbl_timings t
on t.restaurant_id = r.restaurant_id
inner join
tbl_image i
on i.image_id = r.cover_image
where avg_rating > 3.5 and review_count > 2;

-- Dispay Category Names
select category_name from tbl_category;

-- category count
select concat("See all", "(", count(*), ")") as category_count from tbl_category;

-- Display friends list for user id = 1;
-- Friends are those who mutually follow each other
-- Select users who follow user with id 1
select
*
from tbl_user u
left join
tbl_follow f
on u.user_id = f.follow_id
where f.follow_id in 
(
select user_id from tbl_follow where follow_id = 1
) and 
f.user_id = 1;

-- select * from tbl_follow where user_id = 5;
-- Count Number of Friends
select
concat("See all ", "(", count(*), ")") as friend_count
from tbl_user u
left join
tbl_follow f
on u.user_id = f.follow_id
where f.follow_id in 
(
select user_id from tbl_follow where follow_id = 1
) and 
f.user_id = 1;

-- Filter from category, ratings and distance
-- category = Italian
-- distance < 1700 km
-- rating >= 4.00
select 
distinct
r.restaurant_name,
c.category_name,
r.avg_rating,
r.review_count,
a.address,
i.image_id,
t.status_,
concat(ROUND(( 3959 * ACOS( COS( RADIANS('37.7749') )  
		* COS( RADIANS( a.latitude ) ) 
		* COS( RADIANS( a.longitude ) - RADIANS('-122.4194') )  
		+ SIN( RADIANS('37.7749') )  
		* SIN( RADIANS( a.latitude) ) ) ),0), " km") as distance_km
from
tbl_restaurant r
inner join
tbl_category c
on r.category_id = c.category_id
inner join 
tbl_address a
on a.address_id = r.address
inner join 
tbl_timings t
on t.restaurant_id = r.restaurant_id
inner join
tbl_image i
on i.image_id = r.cover_image
where avg_rating >= 3.00 and category_name = "Italian" and review_count >= 2
having distance_km < 1700;

-- Display Particular Restaurant
-- User clicked on Rustic Rays Restaurant
select 
distinct
r.restaurant_name,
c.category_name,
r.avg_rating,
r.review_count,
a.address,
i.image_name,
t.open_time,
t.close_time,
CASE
WHEN time(NOW()) NOT BETWEEN t.open_time and t.close_time THEN "CLOSE"
ELSE "OPEN"
END as current_status,
concat(ROUND(( 3959 * ACOS( COS( RADIANS('37.7749') )  
		* COS( RADIANS( a.latitude ) ) 
		* COS( RADIANS( a.longitude ) - RADIANS('-122.4194') )  
		+ SIN( RADIANS('37.7749') )  
		* SIN( RADIANS( a.latitude) ) ) ),0), " km") as distance_km
from
tbl_restaurant r
inner join
tbl_category c
on r.category_id = c.category_id
inner join 
tbl_address a
on a.address_id = r.address
inner join 
tbl_timings t
on t.restaurant_id = r.restaurant_id
inner join
tbl_image i
on i.image_id = r.cover_image
where restaurant_name like "%rustic ray%";

-- Menus an Photos of Above Restaurant
select i.image_name as Menu_Images from tbl_menu_and_photos mp
inner join tbl_image i
on mp.menu_photo = i.image_id
where restaurant_id in 
(SELECT restaurant_id from tbl_restaurant where restaurant_name like "%rustic ray%");


-- User with ID = 1 wants to Post Review about Rustic Rays
SELECT * from tbl_restaurant;
INSERT INTO tbl_rating_review (user_id, restaurant_id, rating, review) VALUES 
(1, 5, 4.5, "Amazinngggg Restaurant");

-- Display User ID 1's all review and ratings
select  
r.restaurant_name,
i.image_name,
rr.rating,
rr.review
from
tbl_rating_review rr
inner join
tbl_restaurant r
on rr.restaurant_id = r.restaurant_id
inner join
tbl_user u
on u.user_id = rr.user_id
inner join
tbl_image i
on i.image_id = r.cover_image
where rr.user_id = 1;

-- Category Wise Display of Restaurants
select 
distinct
r.restaurant_name,
c.category_name,
r.avg_rating,
r.review_count,
a.address,
i.image_id,
t.status_,
concat(ROUND(( 3959 * ACOS( COS( RADIANS('37.7749') )  
		* COS( RADIANS( a.latitude ) ) 
		* COS( RADIANS( a.longitude ) - RADIANS('-122.4194') )  
		+ SIN( RADIANS('37.7749') )  
		* SIN( RADIANS( a.latitude) ) ) ),0), " km") as distance_km
from
tbl_restaurant r
inner join
tbl_category c
on r.category_id = c.category_id
inner join 
tbl_address a
on a.address_id = r.address
inner join 
tbl_timings t
on t.restaurant_id = r.restaurant_id
inner join
tbl_image i
on i.image_id = r.cover_image
where category_name = "Italian"
order by avg_rating desc;

-- Find Friends for user id 1
-- Contacts
-- Friends who are in contact and user follows then it will show following 
-- Else a follow button for it
select
u.user_name,
u.review_count,
CASE
	WHEN u.user_id in (
		select user_id from tbl_follow
		where follow_id = 1
		) 	THEN "UNFOLLOW"
	ELSE "FOLLOW"
END as status_
from tbl_user u
where u.user_id in (select contact_id_2 from tbl_contact_list where contact_id_1 = 1);

-- select * from tbl_contact_list;
-- select * from tbl_follow;
-- Who follows user 1
-- select user_id from tbl_follow
-- where follow_id = 1;
-- select contact_id_2 from tbl_contact_list where contact_id_1 = 1;

-- Suggestions for user_id 1
-- Based on nearby locations and not in contact list
select user_name, review_count,
CASE
	WHEN user_id in (
		select user_id from tbl_follow
		where follow_id = 1
		) 	THEN "UNFOLLOW"
	ELSE "FOLLOW"
END as status_
from tbl_user
where user_id <> 1 and concat(ROUND(( 3959 * ACOS( COS( RADIANS('23.041000') )  
		* COS( RADIANS( latitude ) ) 
		* COS( RADIANS( longitude ) - RADIANS('72.578537') )  
		+ SIN( RADIANS('23.041000') )  
		* SIN( RADIANS( latitude) ) ) ),0), " km") < 8200
        and 
        user_id not in (select contact_id_2 from tbl_contact_list where contact_id_1 = 1);

-- Display Profile of a Particular User
-- Let's say user_id = 2;
-- User ID 1 viewing profile of User ID 2
select
user_name,  
profile_pic,
email_id,
review_count,
followers_count,
following_count,
CASE
	WHEN user_id in (
		select user_id from tbl_follow
		where follow_id = 1
		) 	THEN "UNFOLLOW"
	ELSE "FOLLOW"
END as follow_button,
CASE
	WHEN user_id in (
		select user_id from tbl_block
		where block_user_id = 2
		) 	THEN "UNBLOCK"
	ELSE "BLOCK"
END as block_button
from tbl_user 
where user_id = 2;


-- Reviews posted by above user with USER ID = 2
select distinct 
r.restaurant_name,
i.image_name,
rr.rating,
rr.review,
a.address,
r.review_count,
c.category_name
from
tbl_rating_review rr
inner join
tbl_restaurant r
on rr.restaurant_id = r.restaurant_id
inner join
tbl_user u
on u.user_id = rr.user_id
inner join
tbl_image i
on i.image_id = r.cover_image
inner join tbl_category c
on c.category_id = r.category_id
inner join
tbl_address a
on a.address_id = r.address
where rr.user_id = 2;

-- Search query
select distinct 
r.restaurant_name,
i.image_name,
a.address,
r.review_count,
c.category_name
from
tbl_restaurant r
inner join
tbl_image i
on i.image_id = r.cover_image
inner join tbl_category c
on c.category_id = r.category_id
inner join
tbl_address a
on a.address_id = r.address
where r.restaurant_name like "%A%";

-- User's Favorite
-- User with User_ID = 1
select distinct
r.restaurant_name,
i.image_name,
a.address,
r.review_count,
c.category_name,
CASE
WHEN time(NOW()) NOT BETWEEN t.open_time and t.close_time THEN "CLOSE"
ELSE "OPEN"
END as current_status
from tbl_user_favs uf
inner join
tbl_restaurant r
on uf.restaurant_id = r.restaurant_id
inner join
tbl_image i
on i.image_id = r.cover_image
inner join tbl_category c
on c.category_id = r.category_id
inner join
tbl_address a
on a.address_id = r.address
inner join 
tbl_timings t
on t.restaurant_id = r.restaurant_id
where user_id = 1;


-- Edit Profile
-- USer with User ID = 1 wants to Edit its Profile
update tbl_user
set user_name = "John Williams"
where user_id = 1;

select user_name from tbl_user where user_id = 1;

-- Display Followers of User ID 1
select  
user_name as followers,
concat(COALESCE(review_count, 0), " rated restaurants") as info,
CASE
	WHEN user_id in (
		select follow_id from tbl_follow
		where user_id = 1
		) 	THEN "UNFOLLOW"
	ELSE "FOLLOW"
END as follow_button
from tbl_user
where user_id 
in (
select user_id from tbl_follow where follow_id = 1
);

-- Display Following of User ID 1
select  
user_name as following,
concat(review_count, " rated restaurants") as info,
CASE
	WHEN user_id in (
		select user_id from tbl_follow
		where follow_id = 1
		) 	THEN "UNFOLLOW"
	ELSE "FOLLOW"
END as following_button
from tbl_user
where user_id 
in (
select follow_id from tbl_follow where user_id = 1
);

insert into tbl_follow (user_id, follow_id)
values 
(1,6);

-- select * from tbl_user;
-- ALTER TABLE tbl_block
-- ADD CONSTRAINT unique_block 
-- UNIQUE (user_id, block_user_id);
-- delete from tbl_follow where user_id=2 and follow_id=1;

-- Change Password
-- User ID 1 and wants to change password from mahek1234 to william1234
-- Case 1: Old Password Entered Correct
update tbl_user
set passwords = "william1234"
where passwords = "mahek1234" and user_id = 1;
-- Password Changed

-- Case 2: Old Password Entered WRONG
update tbl_user
set passwords = "will1234"
where passwords = "william123" and user_id = 1;
-- Password did'nt changed
select * from tbl_user;

-- Change Preferred Language for user
update tbl_user
set language_pref = "French"
where user_id = 1;
-- Preferred Lang changed
select language_pref from tbl_user where user_id = 1;

-- Edit Profile
-- User ID 1
-- Wants to update name: John Wills
-- Profile Picture to will.jpeg
select * from tbl_user;
update tbl_user set 
user_name = "John Wills", 
profile_pic = "will.jpeg"
where user_id = 1;

-- User ID 1
-- Wants to delete
-- Review
delete from 
tbl_rating_review 
where rating_id = 6 
and user_id = 1;

-- Review Deleted
select * from tbl_rating_review where user_id = 1;


-- select * from tbl_follow;
-- select * from tbl_user;
-- select * from tbl_restaurant;
-- select * from tbl_rating_review;

-- delete from tbl_follow where user_id = 1 and follow_id = 6;
-- insert into tbl_follow (user_id, follow_id) values (1,6);
-- delete from tbl_rating_review where rating_id = 2;


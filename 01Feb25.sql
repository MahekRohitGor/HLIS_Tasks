create database db_01;
use db_01;

create table tbl_user(
	user_id bigint primary key auto_increment,
    name varchar(128),
    email varchar(128) unique,
    passwords varchar(64),
    profile_pic varchar(32),
    login_type enum('S', 'F', 'G'),
    about text,
    social_id varchar(128) references tbl_socials(social_id),
    is_active boolean,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

-- drop table socials;

create table tbl_category(
	catgory_id bigint primary key auto_increment,
    category_name varchar(128),
    created_at datetime default current_timestamp()
);

create table tbl_image(
	image_id bigint primary key auto_increment,
    catgory_id bigint references tbl_category(catgory_id) on delete cascade,
    image_title varchar(128),
    descriptions text,
    user_id bigint references tbl_user(user_id) on delete cascade,
    total_likes int,
    tags varchar(128),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_notifications (
    notification_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id) on delete cascade,
    message text,
    status enum('unread', 'read') default 'unread',
    created_at datetime default current_timestamp()
);

create table tbl_reset_pswd(
	reset_id bigint primary key auto_increment,
    email varchar(128) references tbl_user(email),
    token varchar(128),
    created_at datetime default current_timestamp(),
    expires_at datetime
);


-- Insert values into tbl_user
INSERT INTO tbl_user (name, email, passwords, profile_pic, login_type, about, social_id, is_active)
VALUES 
('Alice Johnson', 'alice@example.com', 'password123', 'pic1.jpg', 'S', 'Photographer and traveler.', NULL, true),
('Bob Smith', 'bob@example.com', 'password456', 'pic2.jpg', 'G', 'Graphic designer.', '67890', true),
('Charlie Brown', 'charlie@example.com', 'password789', 'pic3.jpg', 'F', 'Nature enthusiast.', '54321', true),
('Diana Prince', 'diana@example.com', 'password321', 'pic4.jpg', 'S', 'Digital artist.', NULL, true),
('Eve Adams', 'eve@example.com', 'password654', 'pic5.jpg', 'G', 'Tech blogger.', '13578', true),
('Frank Castle', 'frank@example.com', 'password987', 'pic6.jpg', 'F', 'Wildlife photographer.', '24680', true),
('Grace Lee', 'grace@example.com', 'password852', 'pic7.jpg', 'S', 'Architect and designer.', NULL, true),
('Henry Ford', 'henry@example.com', 'password741', 'pic8.jpg', 'G', 'Engineer and innovator.', '46802', true),
('Ivy Green', 'ivy@example.com', 'password963', 'pic9.jpg', 'F', 'Botanist and researcher.', '57913', true),
('Jack Sparrow', 'jack@example.com', 'password159', 'pic10.jpg', 'S', 'Adventurer and sailor.', NULL, true),
('Karen White', 'karen@example.com', 'password753', 'pic11.jpg', 'G', 'Culinary artist.', '79135', true),
('Leo King', 'leo@example.com', 'password258', 'pic12.jpg', 'F', 'Filmmaker and editor.', '80246', true),
('Mona Lisa', 'mona@example.com', 'password369', 'pic13.jpg', 'S', 'Art historian.', NULL, true),
('Nina Simone', 'nina@example.com', 'password147', 'pic14.jpg', 'G', 'Musician and songwriter.', '02468', true),
('Oscar Wilde', 'oscar@example.com', 'password258', 'pic15.jpg', 'F', 'Poet and playwright.', '13579', true),
('Paula Dean', 'paula@example.com', 'password369', 'pic16.jpg', 'S', 'Chef and TV personality.', NULL, true),
('Quentin Blake', 'quentin@example.com', 'password987', 'pic17.jpg', 'G', 'Illustrator.', '35791', true),
('Rachel Green', 'rachel@example.com', 'password654', 'pic18.jpg', 'F', 'Fashion executive.', '46803', true),
('Steve Jobs', 'steve@example.com', 'password321', 'pic19.jpg', 'S', 'Tech visionary.', NULL, true),
('Tom Hanks', 'tom@example.com', 'password456', 'pic20.jpg', 'G', 'Actor and director.', '68024', true);

-- Insert values into tbl_category
INSERT INTO tbl_category (category_name)
VALUES 
('Nature'),
('Technology'),
('Art'),
('Travel'),
('Food'),
('Architecture'),
('Wildlife'),
('Fashion'),
('Music'),
('Film'),
('Sports'),
('Education'),
('Health'),
('Science'),
('Photography'),
('History'),
('Literature'),
('Space'),
('Gaming'),
('Finance');

INSERT INTO tbl_image (catgory_id, image_title, descriptions, user_id, total_likes, tags)
VALUES 
(1, 'Sunset in the Bhujj', 'A beautiful sunset captured in the Kutch.', 22, 170, 'sunset, mountains, nature, Kutch');

-- Insert values into tbl_image
INSERT INTO tbl_image (catgory_id, image_title, descriptions, user_id, total_likes, tags)
VALUES 
(1, 'Sunset in the Mountains', 'A beautiful sunset captured in the Alps.', 21, 150, 'sunset, mountains, nature'),
(2, 'Futuristic City', 'A digital art piece of a futuristic city.', 22, 200, 'city, futuristic, tech'),
(3, 'Abstract Colors', 'An abstract painting with vibrant colors.', 24, 175, 'abstract, art, colors'),
(4, 'Hidden Beach', 'A hidden beach in Thailand.', 23, 220, 'beach, travel, nature'),
(5, 'Gourmet Pizza', 'Homemade gourmet pizza with fresh ingredients.', 25, 100, 'food, pizza, gourmet'),
(6, 'Modern Skyscraper', 'A shot of a modern skyscraper in Dubai.', 26, 190, 'architecture, skyscraper, city'),
(7, 'Lion in the Wild', 'A majestic lion in its natural habitat.', 27, 250, 'wildlife, lion, nature'),
(8, 'Runway Fashion', 'Latest fashion trends from Milan.', 28, 130, 'fashion, runway, style'),
(9, 'Jazz Night', 'Live jazz performance in New Orleans.', 29, 210, 'music, jazz, live'),
(10, 'Film Festival', 'Highlights from Cannes Film Festival.', 30, 160, 'film, festival, cinema'),
(11, 'Soccer Match', 'Exciting moments from the World Cup.', 31, 300, 'sports, soccer, worldcup'),
(12, 'Graduation Day', 'Celebrating academic achievements.', 32, 140, 'education, graduation, success'),
(13, 'Healthy Living', 'Tips for a balanced lifestyle.', 33, 180, 'health, lifestyle, wellness'),
(14, 'Space Exploration', 'NASA’s new mission to Mars.', 34, 270, 'space, NASA, Mars'),
(15, 'Photography Tips', 'Mastering the art of photography.', 35, 195, 'photography, tips, camera'),
(16, 'Historical Monuments', 'Exploring ancient wonders.', 36, 170, 'history, monuments, ancient'),
(17, 'Classic Literature', 'Timeless books to read.', 37, 160, 'literature, books, classics'),
(18, 'Gaming Expo', 'Highlights from E3 Gaming Expo.', 38, 230, 'gaming, expo, video games'),
(19, 'Stock Market Trends', 'Latest updates on stock prices.', 39, 125, 'finance, stock market, economy'),
(20, 'Ocean Waves', 'Relaxing waves hitting the shore.', 40, 220, 'nature, ocean, waves');

-- Insert values into tbl_notifications
INSERT INTO tbl_notifications (user_id, message)
VALUES 
(21, 'Your image "Sunset in the Mountains" received 10 new likes!'),
(22, 'Your profile was viewed 5 times today.'),
(23, 'You have a new follower: Diana Prince.'),
(24, 'Your image "Abstract Colors" was featured in the Art category!'),
(25, 'Password reset requested for your account.'),
(26, 'Your image "Modern Skyscraper" is trending in Architecture!'),
(27, 'You have a new comment on "Lion in the Wild".'),
(28, 'Your post "Runway Fashion" was shared by 3 users.'),
(29, 'New message from fellow musician Henry Ford.'),
(30, 'Your film "Festival Highlights" was nominated for an award!'),
(31, 'Your sports update received 500 views.'),
(32, 'Graduation post is gaining traction.'),
(33, 'Health tips were featured in the Wellness section.'),
(34, 'NASA tagged you in their Mars mission post.'),
(35, 'Photography tips appreciated by 50 followers.'),
(36, 'Historical Monuments post was shared in History Monthly.'),
(37, 'Your book review was highlighted in the Literature Forum.'),
(38, 'Gaming Expo post reached 1000 views!'),
(39, 'Finance tips were featured in Economy Weekly.'),
(40, 'Ocean Waves post is now trending in Nature category.');

-- Insert values into tbl_reset_pswd
INSERT INTO tbl_reset_pswd (email, token, expires_at)
VALUES 
('alice@example.com', 'token123', NOW() + INTERVAL 1 HOUR),
('bob@example.com', 'token456', NOW() + INTERVAL 1 HOUR),
('charlie@example.com', 'token789', NOW() + INTERVAL 1 HOUR),
('diana@example.com', 'token321', NOW() + INTERVAL 1 HOUR),
('eve@example.com', 'token654', NOW() + INTERVAL 1 HOUR),
('frank@example.com', 'token987', NOW() + INTERVAL 1 HOUR),
('grace@example.com', 'token852', NOW() + INTERVAL 1 HOUR),
('henry@example.com', 'token741', NOW() + INTERVAL 1 HOUR),
('ivy@example.com', 'token963', NOW() + INTERVAL 1 HOUR),
('jack@example.com', 'token159', NOW() + INTERVAL 1 HOUR),
('karen@example.com', 'token753', NOW() + INTERVAL 1 HOUR),
('leo@example.com', 'token258', NOW() + INTERVAL 1 HOUR),
('mona@example.com', 'token369', NOW() + INTERVAL 1 HOUR),
('nina@example.com', 'token147', NOW() + INTERVAL 1 HOUR),
('oscar@example.com', 'token2589', NOW() + INTERVAL 1 HOUR),
('paula@example.com', 'token3698', NOW() + INTERVAL 1 HOUR),
('quentin@example.com', 'token9875', NOW() + INTERVAL 1 HOUR),
('rachel@example.com', 'token6543', NOW() + INTERVAL 1 HOUR),
('steve@example.com', 'token3217', NOW() + INTERVAL 1 HOUR),
('tom@example.com', 'token4569', NOW() + INTERVAL 1 HOUR);



create table tbl_socials(
    social_id varchar(128) primary key,
    name varchar(128),
    email varchar(128),
    passwords varchar(64),
    profile_pic varchar(32)
);

insert into tbl_socials (social_id, name, email, passwords, profile_pic) values 
("67890", "Bob Smith", "bob@example.com", "password456", "pic2.jpg"),
("54321", "Charlie Brown", "charlie@example.com", "password789", "pic3.jpg"),
("13578", "Eve Adams", "eve@example.com", "password654", "pic5.jpg"),
("24680", "Frank Castle", "frank@example.com", "password987", "pic6.jpg"),
("46802", "Henry Ford", "henry@example.com", "password741", "pic8.jpg"),
("57913", "Ivy Green", "ivy@example.com", "password963", "pic9.jpg"),
("79135", "Karen White", "karen@example.com", "password753", "pic11.jpg"),
("80246", "Leo King", "leo@example.com", "password258", "pic12.jpg"),
("02468", "Nina Simone", "nina@example.com", "password147", "pic14.jpg"),
("13579", "Oscar Wilde", "oscar@example.com", "password258", "pic15.jpg"),
("35791", "Quentin Blake", "quentin@example.com", "password987", "pic17.jpg"),
("46803", "Rachel Green", "rachel@example.com", "password654", "pic18.jpg"),
("68024", "Tom Hanks", "tom@example.com", "password456", "pic19.jpg"),
("17177", "Maheekk Goorr", "mah@example.com", "password1771", "pic21.jpg"),
("00015", "xyzzz Goorr", "xyzz@example.com", "password11", "pic22.jpg"),
("00017", "shrey Goorr", "shrey@example.com", "password177", "pic23.jpg");

-- Login using email: alice@example.com
-- Password: password123
select name, profile_pic from tbl_user where email = "alice@example.com" and passwords="password123" and login_type = "S";

-- Login Using Socials
-- Login Type 'G' and Social_id = "00017"
select s.name, s.profile_pic from tbl_socials as s 
inner join tbl_user as u on s.social_id = u.social_id where s.social_id = "00017" and login_type = "G";

-- User wants to Signup with below credentials
-- Name: Mahek Gor
-- Email_id: mahek@gmail.com
-- password: mahek2003
-- Signup Type: Simple
insert into tbl_user (name, email, passwords, login_type, is_active) values (
"Mahek Gor", "mahek@gmail.com", "mahek2003", "S", 1
);

-- User wants to Signup
-- Signup Type: Google
insert into tbl_user (social_id, login_type) values (
"00017", "G"
);

-- Mark a Notification as Read
update tbl_notifications
set status = 'read'
where notification_id = 21;

select * from tbl_notifications;

-- Delete Old Notifications 
delete from tbl_notifications
where user_id = 21  
and created_at < '2025-01-01' and status = "read";

-- Get Unread Notifications for a User
select notification_id, message, created_at
from tbl_notifications
where user_id = 21  
and status = 'unread'
order by created_at desc;

-- Insert Notifications
insert into tbl_notifications (user_id, message) values (21, 'Fantastic Workkkk!');

-- Show categories
select category_name from tbl_category;

-- Forgot Password
-- email id: mahek@gmail.com

-- Insert Reset Token for Forgot Password: 
insert into tbl_reset_pswd (email, token, expires_at)
values ("bob@example.com", 'sometokenblahblah', '2025-02-10 23:59:59');

-- Check if Token is Valid
-- Token entered by user is sometokenblahblah then successful login else not
select token from tbl_reset_pswd where token = 'sometokenblahblah' and expires_at > current_timestamp();

-- Update Password After Token Validation
-- Password given by user is mypswd2003
update tbl_user set passwords = 'mypswd2003', updated_at = current_timestamp()
where email = (select email from tbl_reset_pswd where token = 'sometokenblahblah');

select * from tbl_user where email = "bob@example.com";

-- Select images from a particular category
select i.image_id, i.image_title, c.category_name from 
tbl_image i inner join tbl_category c on i.catgory_id = c.catgory_id where c.catgory_id = 1;

-- Search Query
-- User searches "Wild"
select descriptions, tags from tbl_image where descriptions like "%wild%" or tags like "%wild%";
select image_id, descriptions, tags from tbl_image where descriptions like "%na%" or tags like "%na%";
select count(*) as counts from tbl_image where descriptions like "%na%" or tags like "%na%";

-- Fetching Top Photographers
select u.name, concat(total_likes, " Likes") from tbl_user u inner join tbl_image i on u.user_id = i.user_id order by total_likes desc;

-- User profile
select u.user_id, u.name, u.about, concat(total_likes, " Likes") as Likes, i.image_id from tbl_user u 
inner join tbl_image i on u.user_id = i.user_id where u.user_id = 31 order by total_likes desc;

-- Upload Images with user_id = 31
insert into tbl_image (catgory_id, image_title, descriptions, user_id, tags) values 
(1, "Rann Of Kutch", "Beautiful White Rann of Kutch in Dhorado", 31, "Nature, Desert, Photography");

-- make likes default zero

-- delete update use OLD
-- insert use NEW

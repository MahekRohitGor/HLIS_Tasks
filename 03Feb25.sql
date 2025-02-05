create database db_3feb;
use db_3feb;

create table tbl_user(
	user_id bigint primary key auto_increment,
    name varchar(128),
    age int ,
    gender enum('M','F'),
    email varchar(128) unique,
    passwordd varchar(64),
    profile_pic varchar(32),
    login_type enum('S','F','G'),
    fav_act text,
    social_id varchar(129),
    is_active boolean,
    created_at datetime default current_timestamp(),
    updated_at datetime ON UPDATE CURRENT_TIMESTAMP()
);

create table tbl_foget_passward (
  reset_id bigint primary key auto_increment,
  email VARCHAR(64) references tbl_user(email),
  reset_token varchar(128),
  created_at datetime default current_timestamp(),
  expires_at datetime
);

CREATE TABLE tbl_addEvent (
    event_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(256),
    painting_type ENUM('Abstract', 'Landscape', 'Portrait', 'Still Life', 'Figurative', 'Genre Scene'),
    medium ENUM('Acrylic', 'Charcoal', 'Clay', 'Collage', 'Digital', 'Oil', 'Pastel', 'Pencil', 'Print'),
    styles ENUM('Abstract', 'Impressionism', 'Minimalism', 'Modern', 'Photorealism', 'Pop Art', 'Post-Impressionism', 'Realism', 'Other'),
    for_sale BOOLEAN,
    location VARCHAR(256),
    description text,
    start_date datetime,
    end_date datetime,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);
 

CREATE TABLE tbl_addPost (
    post_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT references tbl_user(user_id),
    price DECIMAL(10,2),
    description text,
    like_cnt INT,
    share_clicks INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);
drop table tbl_addPost;

CREATE TABLE tbl_comments (
    comment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    comments TEXT,
    post_id BIGINT references tbl_addPost(post_id)
);

CREATE TABLE tbl_images (
    image_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    event_id BIGINT references tbl_addEvent(event_id),
    image_title VARCHAR(255),
    post_id BIGINT references tbl_addPost(post_id),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    CHECK ((event_id IS NULL AND post_id IS NOT NULL) OR (event_id IS NOT NULL AND post_id IS NULL))
);

-- Insert values into tbl_user
INSERT INTO tbl_user (name, age, gender, email, passwordd, profile_pic, login_type, fav_act, social_id, is_active, created_at, updated_at)
VALUES
('Alice Johnson', 25, 'F', 'alice@example.com', 'pass1234', 'alice.jpg', 'S', 'Painting', 'SOC12345', TRUE, '2024-01-10 12:00:00', '2024-01-15 14:30:00'),
('Bob Smith', 30, 'M', 'bob@example.com', 'securePass', 'bob.png', 'G', 'Photography', 'SOC67890', TRUE, '2024-01-11 11:30:00', '2024-01-16 15:00:00'),
('Charlie Brown', 22, 'M', 'charlie@example.com', 'charliePass', 'charlie.jpg', 'F', 'Sketching', 'SOC24680', FALSE, '2024-01-12 10:00:00', NULL),
('Diana Prince', 28, 'F', 'diana@example.com', 'dianaSecure', 'diana.png', 'S', 'Digital Art', 'SOC13579', TRUE, '2024-01-13 09:00:00', '2024-01-17 16:30:00'),
('Ethan White', 35, 'M', 'ethan@example.com', 'ethanStrong', 'ethan.jpg', 'G', 'Sculpting', 'SOC97531', TRUE, '2024-01-14 08:00:00', NULL),
('Fiona Green', 27, 'F', 'fiona@example.com', 'fionaPass', 'fiona.png', 'F', 'Calligraphy', 'SOC86420', FALSE, '2024-01-15 07:30:00', NULL),
('George Black', 31, 'M', 'george@example.com', 'georgeLock', 'george.jpg', 'S', 'Pottery', 'SOC75319', TRUE, '2024-01-16 06:00:00', '2024-01-18 17:00:00'),
('Hannah Blue', 24, 'F', 'hannah@example.com', 'hannahSecret', 'hannah.png', 'G', 'Graffiti', 'SOC64289', TRUE, '2024-01-17 05:30:00', NULL),
('Ian Gold', 29, 'M', 'ian@example.com', 'ianCode', 'ian.jpg', 'F', 'Animation', 'SOC53178', FALSE, '2024-01-18 04:00:00', NULL),
('Jasmine Red', 26, 'F', 'jasmine@example.com', 'jasmineLock', 'jasmine.png', 'S', 'Oil Painting', 'SOC42067', TRUE, '2024-01-19 03:30:00', '2024-01-20 18:30:00'),
('Kevin Gray', 33, 'M', 'kevin@example.com', 'kevinPass', 'kevin.jpg', 'G', 'Tattoo Art', 'SOC30956', FALSE, '2024-01-20 02:00:00', NULL),
('Laura White', 21, 'F', 'laura@example.com', 'lauraSecure', 'laura.png', 'F', 'Illustration', 'SOC29845', TRUE, '2024-01-21 01:30:00', NULL);

-- Insert values into tbl_foget_passward
INSERT INTO tbl_foget_passward (email, reset_token, created_at, expires_at)
VALUES
('alice@example.com', 'R123ABC', '2024-01-22 10:00:00', '2024-01-22 12:00:00'),
('bob@example.com', 'R456DEF', '2024-01-23 11:30:00', '2024-01-23 13:30:00'),
('charlie@example.com', 'R789GHI', '2024-01-24 09:00:00', '2024-01-24 11:00:00'),
('diana@example.com', 'R101JKL', '2024-01-25 08:30:00', '2024-01-25 10:30:00'),
('ethan@example.com', 'R112MNO', '2024-01-26 07:00:00', '2024-01-26 09:00:00'),
('fiona@example.com', 'R223PQR', '2024-01-27 06:30:00', '2024-01-27 08:30:00'),
('george@example.com', 'R334STU', '2024-01-28 05:00:00', '2024-01-28 07:00:00'),
('hannah@example.com', 'R445VWX', '2024-01-29 04:30:00', '2024-01-29 06:30:00'),
('ian@example.com', 'R556YZA', '2024-01-30 03:00:00', '2024-01-30 05:00:00'),
('jasmine@example.com', 'R667BCD', '2024-01-31 02:30:00', '2024-01-31 04:30:00'),
('kevin@example.com', 'R778EFG', '2024-02-01 01:00:00', '2024-02-01 03:00:00'),
('laura@example.com', 'R889HIJ', '2024-02-02 00:30:00', '2024-02-02 02:30:00');

-- Insert values into tbl_addEvent
INSERT INTO tbl_addEvent (title, painting_type, medium, styles, for_sale, location, description, start_date, end_date, created_at, updated_at)
VALUES
('Sunset Glory', 'Landscape', 'Acrylic', 'Impressionism', TRUE, 'NYC', 'Beautiful sunset scene', '2024-03-01 10:00:00', '2024-03-05 18:00:00', '2024-02-01 10:00:00', NULL),
('Forest Depth', 'Abstract', 'Oil', 'Abstract', FALSE, 'LA', 'Deep forest vibes', '2024-03-02 09:00:00', '2024-03-06 17:00:00', '2024-02-02 09:30:00', NULL),
('Portrait of Dreams', 'Portrait', 'Charcoal', 'Realism', TRUE, 'Chicago', 'A detailed portrait artwork', '2024-03-03 08:00:00', '2024-03-07 16:00:00', '2024-02-03 08:30:00', NULL),
('City Lights', 'Genre Scene', 'Digital', 'Photorealism', FALSE, 'Seattle', 'Vivid city view', '2024-03-04 07:00:00', '2024-03-08 15:00:00', '2024-02-04 07:30:00', NULL),
('Misty Morning', 'Landscape', 'Pencil', 'Minimalism', TRUE, 'Austin', 'Calm misty morning sketch', '2024-03-05 06:00:00', '2024-03-09 14:00:00', '2024-02-05 06:30:00', NULL),
('Floral Magic', 'Still Life', 'Pastel', 'Pop Art', FALSE, 'Miami', 'Bright floral arrangement', '2024-03-06 05:00:00', '2024-03-10 13:00:00', '2024-02-06 05:30:00', NULL);

-- More inserts for tbl_addPost, tbl_comments, tbl_images can be added similarly.
-- Insert values into tbl_addPost
INSERT INTO tbl_addPost (user_id, price, description, like_cnt, share_clicks, created_at, updated_at)
VALUES 
(1, 2500.00, 'A beautiful abstract painting for sale.', 15, 8, '2024-12-01 10:15:00', '2024-12-02 12:30:00'),
(2, 1800.50, 'Limited edition landscape artwork.', 20, 12, '2024-12-03 14:20:00', '2024-12-05 18:45:00'),
(3, 3200.75, 'Modern portrait of a woman.', 8, 5, '2024-12-05 08:10:00', '2024-12-07 14:20:00'),
(4, 1200.00, 'Minimalist still life painting.', 5, 3, '2024-12-07 11:30:00', '2024-12-09 09:55:00'),
(5, 4500.25, 'Digital painting inspired by pop culture.', 30, 20, '2024-12-10 16:45:00', '2024-12-12 20:10:00'),
(6, 2900.99, 'Impressionist oil painting on canvas.', 12, 7, '2024-12-13 07:50:00', '2024-12-14 10:25:00'),
(7, 1500.00, 'Charcoal sketch of a cityscape.', 6, 4, '2024-12-15 13:00:00', '2024-12-16 15:40:00'),
(8, 5000.00, 'High-resolution digital painting available for prints.', 45, 30, '2024-12-17 09:35:00', '2024-12-19 18:00:00'),
(9, 2750.50, 'Acrylic painting with mixed media techniques.', 18, 10, '2024-12-20 11:10:00', '2024-12-22 13:55:00'),
(10, 3700.75, 'Surrealist artwork depicting dreamscapes.', 25, 15, '2024-12-23 14:20:00', '2024-12-25 19:30:00');

select * from tbl_addPost;
-- Insert values into tbl_comments
INSERT INTO tbl_comments (comments, post_id)
VALUES
('Amazing work!', 1),
('Love the colors in this piece.', 2),
('Such a creative concept!', 3),
('This is so detailed and beautiful.', 4),
('The texture is stunning.', 5),
('I wish I could buy this.', 6),
('The contrast is so striking.', 7),
('Fantastic artwork!', 8),
('How long did this take to create?', 9),
('This is truly inspiring.', 10);

-- Insert values into tbl_images
INSERT INTO tbl_images (event_id, image_title, post_id, created_at, update_at)
VALUES
(1, 'Sunset Glory Image', NULL, '2024-02-10 14:00:00', NULL),
(NULL, 'Post Image 1', 1, '2024-02-10 14:30:00', NULL),
(2, 'Forest Depth Artwork', NULL, '2024-02-11 10:00:00', NULL),
(NULL, 'Post Image 2', 2, '2024-02-11 10:30:00', NULL),
(3, 'Portrait Sketch', NULL, '2024-02-12 12:00:00', NULL),
(NULL, 'Post Image 3', 3, '2024-02-12 12:30:00', NULL),
(4, 'City Lights Artwork', NULL, '2024-02-13 09:00:00', NULL),
(NULL, 'Post Image 4', 4, '2024-02-13 09:30:00', NULL),
(5, 'Misty Morning Drawing', NULL, '2024-02-14 11:00:00', NULL),
(NULL, 'Post Image 5', 5, '2024-02-14 11:30:00', NULL),
(6, 'Floral Magic Painting', NULL, '2024-02-15 08:00:00', NULL),
(NULL, 'Post Image 6', 6, '2024-02-15 08:30:00', NULL);

-- Change the updated_at when any updated in user_table
DELIMITER $$
CREATE TRIGGER trg_update_user_ts
BEFORE UPDATE ON tbl_user
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END $$
DELIMITER ;

UPDATE tbl_user SET name = 'New Name' WHERE user_id = 1;
SELECT user_id, updated_at FROM tbl_user WHERE user_id = 1;

ALTER TABLE tbl_addPost
ADD COLUMN comment_cnt INT DEFAULT 0;

CREATE TABLE tbl_likes (
    like_id bigint AUTO_INCREMENT PRIMARY KEY,
    user_id bigint NOT NULL references tbl_user(user_id) on delete cascade,
    post_id bigint NOT NULL,
    FOREIGN KEY (post_id) REFERENCES tbl_addPost(post_id)
        ON DELETE CASCADE
);
INSERT INTO tbl_likes (user_id, post_id) VALUES (1,2),(2,1),(2,2),(3,1),(3,2),(2,3);

-- Trigger Like Count
delimiter $$
create trigger trg_my_like_cnt
after insert on tbl_likes
for each row
begin
update tbl_addPost
set like_cnt = like_cnt + 1
where post_id = new.post_id;
end $$
delimiter ;

insert into tbl_likes (user_id, post_id) values (2,4);
select * from tbl_addPost;

-- Trigger comment count
delimiter $$
CREATE TRIGGER trg_inc_comments
AFTER INSERT ON tbl_comments
FOR EACH ROW
BEGIN
    UPDATE tbl_addPost 
    SET comment_cnt = comment_cnt + 1 
    WHERE post_id = NEW.post_id;
END $$
DELIMITER ;
INSERT INTO tbl_comments (comments, post_id) VALUES ('Great artwork!', 3);

-- Show events
select title, date_format(start_date, "%d %b %Y"), date_format(end_date, "%d %b %Y"), location from tbl_addEvent;

-- Show Posts
select u.user_id, u.name, u.profile_pic, p.description, p.price, p.like_cnt, p.share_clicks, p.comment_cnt 
from tbl_user u inner join tbl_addPost p on u.user_id = p.user_id;

select * from tbl_addEvent;

-- Show event at particular date like "2024-12-01"
select title ,description, date_format(start_date, "%h:%i %p") as start_time, location from 
tbl_addEvent where date(start_date) = "2024-03-01";

-- Login using email: alice@example.com
-- Password: password123
select name, profile_pic from tbl_user where email = "alice@example.com" and passwordd="pass1234" and login_type = "S";

-- User wants to Signup with below credentials
-- Name: Mahek Gor
-- Email_id: mahek@gmail.com
-- password: mahek2003
-- Signup Type: Simple
insert into tbl_user (name, email, passwordd, login_type, is_active) values (
"Mahek Gor", "mahek@gmail.com", "mahek2003", "S", 1
);



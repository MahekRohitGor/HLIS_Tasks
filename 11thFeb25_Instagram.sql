CREATE DATABASE INSTAGRAM;
USE INSTAGRAM;

create table tbl_socials(
    social_id varchar(128) primary key auto_increment,
    name_ varchar(128),
    email varchar(128),
    passwords varchar(64),
    profile_pic varchar(32),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_user(
	user_id bigint primary key auto_increment,
    username varchar(164) unique not null,
    user_full_name varchar(164) not null,
    email_id varchar(164) unique not null,
    phone_number char(16) unique,
    passwords varchar(64) not null,
    profile_type enum("Public", "Private") not null default "Public",
    profile_pic varchar(32) default "default.jpg",
    login_type enum('Simple', 'Facebook') default "Simple",
    about text,
    social_id varchar(128) references tbl_socials(social_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

ALTER TABLE tbl_post
ADD COLUMN latitude varchar(64),
ADD COLUMN longitude varchar(64);

-- ALTER TABLE tbl_user 
-- ADD COLUMN post_count BIGINT DEFAULT 0;
-- ALTER TABLE tbl_user 
-- ADD COLUMN follower_count BIGINT DEFAULT 0;
-- ALTER TABLE tbl_user 
-- ADD COLUMN following_count BIGINT DEFAULT 0;

create table tbl_post(
	post_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    descriptions text,
    likes_total bigint default 0,
    comments_total bigint default 0,
    share_total bigint default 0,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_post_media(
	post_media_id bigint primary key auto_increment,
    post_id bigint references tbl_post(post_id),
    media_name varchar(64),
    type_of_media enum ("video", "image"),
    duration_in_sec bigint default 0,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_follow(
	pk_follow_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    follow_id bigint references tbl_user(user_id),
    follow_status enum("pending", "accept", "reject") default "pending",
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_mention(
	mention_id bigint primary key auto_increment,
    post_id bigint references tbl_post(post_id),
    user_id bigint references tbl_user(user_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_story_mention(
	mention_id bigint primary key auto_increment,
    story_id bigint references tbl_story(story_id),
    user_id bigint references tbl_user(user_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);


create table tbl_hashtag(
	hashtag_id bigint primary key auto_increment,
    hastag varchar(128),
    total_count_usage bigint,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_post_hashtage(
	post_hashtag_id bigint primary key auto_increment,
    post_id bigint references tbl_post(post_id),
    hashtag_id bigint references tbl_hashtag(hashtag_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_story(
	story_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    story_media text,
    duration_in_sec bigint,
    media_type enum("Video", "Image", "Text", "Live"),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_like(
	like_id bigint primary key auto_increment,
    post_id bigint references tbl_post(post_id),
    user_id bigint references tbl_user(user_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_comment(
	comment_id bigint primary key auto_increment,
    post_id bigint references tbl_post(post_id),
    user_id bigint references tbl_user(user_id),
    comment_ text,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_forgot_password (
  reset_id bigint primary key auto_increment,
  email_id varchar(256) references tbl_user(email_id),
  reset_token varchar(128),
  is_active boolean default 1,
  is_deleted boolean default 0,
  created_at datetime default current_timestamp(),
  expires_at datetime
);

create table tbl_otp(
	otp_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    action enum ('signup','signin','forget','profile'),
    verify_with enum('email','mobile'),
    verify boolean default 0,
    otp char(4),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_share(
	share_id bigint primary key auto_increment,
    post_id bigint references tbl_post(post_id),
    user_id bigint references tbl_user(user_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

-- Triggers
-- UPDATE TOTAL LIKE COUNT
DELIMITER $$
CREATE TRIGGER trg_update_likes_count
AFTER INSERT ON tbl_like
FOR EACH ROW
BEGIN

	UPDATE tbl_post SET likes_total = (
		SELECT COUNT(*) FROM tbl_like WHERE post_id = NEW.post_id
    )
    WHERE post_id = NEW.post_id;
END $$
DELIMITER ;

-- Comment count
DELIMITER $$
DROP TRIGGER IF EXISTS trg_update_comment_count;
CREATE TRIGGER trg_update_comment_count
AFTER INSERT ON tbl_comment
FOR EACH ROW
BEGIN 
	UPDATE tbl_post SET comments_total = (
		SELECT count(*) FROM tbl_comment WHERE post_id = NEW.post_id
		)
        WHERE post_id = NEW.post_id;
END $$
DELIMITER ;

select * from tbl_comment;

-- UPDATE SHARE COUNT
DELIMITER $$
CREATE TRIGGER trg_update_share_count
AFTER INSERT ON tbl_share
FOR EACH ROW
BEGIN

	UPDATE tbl_post SET share_total = (
		SELECT COUNT(*) FROM tbl_share WHERE post_id = NEW.post_id
    )
    WHERE post_id = NEW.post_id;
END $$
DELIMITER ;

-- UPDATE FOLLOWER
DELIMITER $$
CREATE TRIGGER trg_update_follower_count
AFTER INSERT ON tbl_follow
FOR EACH ROW
BEGIN
	UPDATE tbl_post SET follower_count = (
		SELECT COUNT(user_id) FROM tbl_follow WHERE follow_id = new.follow_id
    )
    WHERE user_id = new.follow_id;
END $$
DELIMITER ;

-- UPDATE FOLLOWER
DELIMITER $$
CREATE TRIGGER trg_update_follower_count
AFTER INSERT ON tbl_follow
FOR EACH ROW
BEGIN
	UPDATE tbl_user SET follower_count = (
		SELECT COUNT(*) FROM tbl_follow WHERE follow_id = new.follow_id
    )
    WHERE user_id = new.follow_id;
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

-- UPDATE POST COUNT
DELIMITER $$
DROP TRIGGER IF EXISTS trg_post_cnt;
CREATE TRIGGER trg_post_cnt
AFTER INSERT on tbl_post
FOR EACH ROW
BEGIN
	UPDATE tbl_user SET post_count = post_count + 1 WHERE user_id  = NEW.user_id;
END $$
DELIMITER ;

-- Hashtag Count
DELIMITER $$
CREATE TRIGGER update_hashtag_usage
AFTER INSERT ON tbl_post_hashtage
FOR EACH ROW
BEGIN
    UPDATE tbl_hashtag 
    SET total_count_usage = total_count_usage + 1
    WHERE hashtag_id = NEW.hashtag_id;
END $$
DELIMITER ;

-- Insert Values
INSERT INTO tbl_socials (social_id, name_, email, passwords, profile_pic) VALUES
('s1', 'John Doe', 'john@example.com', 'password1', 'john.jpg'),
('s2', 'Jane Smith', 'jane@example.com', 'password2', 'jane.jpg'),
('s3', 'Mike Ross', 'mike@example.com', 'password3', 'mike.jpg'),
('s4', 'Rachel Green', 'rachel@example.com', 'password4', 'rachel.jpg'),
('s5', 'Chandler Bing', 'chandler@example.com', 'password5', 'chandler.jpg'),
('s6', 'Monica Geller', 'monica@example.com', 'password6', 'monica.jpg'),
('s7', 'Ross Geller', 'ross@example.com', 'password7', 'ross.jpg'),
('s8', 'Phoebe Buffay', 'phoebe@example.com', 'password8', 'phoebe.jpg'),
('s9', 'Joey Tribbiani', 'joey@example.com', 'password9', 'joey.jpg'),
('s10', 'Harvey Specter', 'harvey@example.com', 'password10', 'harvey.jpg');

INSERT INTO tbl_user (username, user_full_name, email_id, passwords) VALUES
('johndoe', 'John Doe', 'john@example.com', 'password1'),
('janesmith', 'Jane Smith', 'jane@example.com', 'password2'),
('mikeross', 'Mike Ross', 'mike@example.com', 'password3'),
('rachelgreen', 'Rachel Green', 'rachel@example.com', 'password4'),
('chandlerbing', 'Chandler Bing', 'chandler@example.com', 'password5'),
('monicageller', 'Monica Geller', 'monica@example.com', 'password6'),
('rossgeller', 'Ross Geller', 'ross@example.com', 'password7'),
('phoebebuffay', 'Phoebe Buffay', 'phoebe@example.com', 'password8'),
('joeytribbiani', 'Joey Tribbiani', 'joey@example.com', 'password9'),
('harveyspecter', 'Harvey Specter', 'harvey@example.com', 'password10');

INSERT INTO tbl_post (user_id, descriptions) VALUES
(1, 'First post by John Doe'),
(2, 'Excited to be here!'),
(3, 'Learning SQL is fun!'),
(4, 'Beautiful day outside.'),
(5, 'Just finished a great book!'),
(6, 'Who loves coffee?'),
(7, 'Gym time!'),
(8, 'Watching a new movie tonight!'),
(9, 'Friends marathon all night!'),
(10, 'Winning is everything.');

INSERT INTO tbl_follow (user_id, follow_id, follow_status) VALUES
(1, 2, 'accept'),
(2, 3, 'accept'),
(3, 4, 'accept'),
(4, 5, 'accept'),
(5, 6, 'accept'),
(6, 7, 'accept'),
(7, 8, 'accept'),
(8, 9, 'accept'),
(9, 10, 'accept'),
(10, 1, 'accept');

select * from tbl_post;
select * from tbl_user;

INSERT INTO tbl_like (post_id, user_id) VALUES
(21, 2),
(22, 3),
(23, 4),
(24, 5),
(25, 6),
(26, 7),
(27, 8),
(28, 9),
(29, 10),
(30, 1);

INSERT INTO tbl_comment (post_id, user_id, comment_) VALUES
(21, 2, 'Nice post!'),
(22, 3, 'I totally agree!'),
(23, 4, 'This is so cool!'),
(24, 5, 'Love this!'),
(25, 6, 'Great content!'),
(26, 7, 'Amazing!'),
(27, 8, 'Keep it up!'),
(28, 9, 'Wow, nice one!'),
(29, 10, 'I really like this.'),
(30, 1, 'Awesome!');


INSERT INTO tbl_share (post_id, user_id) VALUES
(21, 3),
(22, 4),
(23, 5),
(24, 6),
(25, 7),
(26, 8),
(27, 9),
(28, 10),
(29, 1),
(30, 2);

INSERT INTO tbl_story (user_id, story_media, duration_in_sec, media_type) VALUES
(1, 'story1.jpg', 15, 'Image'),
(2, 'story2.mp4', 30, 'Video'),
(3, 'story3.jpg', 15, 'Image'),
(4, 'story4.mp4', 30, 'Video'),
(5, 'story5.jpg', 15, 'Image'),
(6, 'story6.mp4', 30, 'Video'),
(7, 'story7.jpg', 15, 'Image'),
(8, 'story8.mp4', 30, 'Video'),
(9, 'story9.jpg', 15, 'Image'),
(10, 'story10.mp4', 30, 'Video');

INSERT INTO tbl_hashtag (hastag, total_count_usage) VALUES
('#fun', 0),
('#travel', 0),
('#food', 0),
('#fitness', 0),
('#music', 0),
('#love', 0),
('#fashion', 0),
('#sports', 0),
('#coding', 0),
('#movies', 0);

INSERT INTO tbl_post_media (post_id, media_name, type_of_media, duration_in_sec, is_active, is_deleted, created_at, updated_at)
VALUES 
(21, 'image1.jpg', 'image', 0, 1, 0, NOW(), NOW()),
(22, 'video1.mp4', 'video', 120, 1, 0, NOW(), NOW()),
(23, 'image2.jpg', 'image', 0, 1, 0, NOW(), NOW()),
(24, 'video2.mp4', 'video', 90, 1, 0, NOW(), NOW()),
(25, 'image3.png', 'image', 0, 1, 0, NOW(), NOW()),
(26, 'video3.mp4', 'video', 150, 1, 0, NOW(), NOW()),
(27, 'image4.jpg', 'image', 0, 1, 0, NOW(), NOW()),
(28, 'video4.mp4', 'video', 180, 1, 0, NOW(), NOW()),
(29, 'image5.jpeg', 'image', 0, 1, 0, NOW(), NOW()),
(30, 'video5.mp4', 'video', 210, 1, 0, NOW(), NOW());


INSERT INTO tbl_post_hashtage (post_id, hashtag_id) VALUES
(21, 1),
(22, 2),
(23, 3),
(24, 4),
(25, 5),
(26, 6),
(27, 7),
(28, 8),
(29, 9),
(30, 10);

-- Queries 
-- Screen Wise

-- Screen 3: Create Account
insert into tbl_user (
username, 
user_full_name, 
email_id, 
phone_number, 
passwords, 
profile_type, 
profile_pic, 
about) values 
("memahek1717", 
"Mahek Gor", 
"mahek@gmail.com", 
"+91-7894561230", 
"mahinsta", 
"Private", 
"profile.jpg", 
"Exploring World !");

SELECT * FROM tbl_otp;

-- Screen 4: Phone Verification
insert into tbl_otp (user_id, action, verify_with, otp) 
values 
(11, "signup", "mobile", "7410");

-- User entered code 7410
UPDATE tbl_otp set verify = 1 where user_id = 11 and otp = "7410";

-- Screen 5: Sigin
-- Signed in with email: mahek@gmail.com and passwords: mahinsta
select username from tbl_user where
email_id = "mahek@gmail.com" and passwords = "mahinsta" and is_deleted = 0;

-- Screen 6: Forgot Password
-- Forgot Password for mahek@gmail.com

-- Insert Reset Token for Forgot Password: 
insert into tbl_forgot_password (email_id, reset_token, expires_at)
values ("mahek@gmail.com", 'sometokenblahblah', '2025-02-12 23:59:59');

-- Check if Token is Valid
-- Token from user side is sometokenblahblah then successful login else not
select reset_token from tbl_forgot_password where reset_token = 'sometokenblahblah' 
and expires_at > current_timestamp();

-- Update Password After Token Validation
-- Password given by user is mypswd2003
update tbl_user set passwords = 'mypswd2003', updated_at = current_timestamp()
where email_id = (
select email_id from tbl_forgot_password where reset_token = 'sometokenblahblah'
);

select * from tbl_user;

-- Screen 7: All post Latest on top
select u.user_full_name,
u.username,
u.profile_pic,
pm.media_name,
pm.type_of_media,
pm.duration_in_sec,
p.descriptions,
p.likes_total,
p.comments_total,
p.share_total,
p.latitude,
p.longitude
from tbl_post p 
inner join tbl_post_media pm 
on p.post_id = pm.post_id
inner join 
tbl_user u on u.user_id = p.user_id
order by p.created_at desc;

-- Screen 8: User Profile
-- User profile
select user_full_name,
username,
profile_pic,
post_count,
follower_count,
following_count
from tbl_user
where user_id = 1;

-- User's Posts and comments
select u.user_full_name,
u.username,
u.profile_pic,
pm.media_name,
pm.type_of_media,
pm.duration_in_sec,
p.descriptions,
p.likes_total,
p.comments_total,
c.comment_,
p.share_total,
p.latitude,
p.longitude
from tbl_post p 
inner join tbl_post_media pm 
on p.post_id = pm.post_id
inner join 
tbl_user u on u.user_id = p.user_id
inner join tbl_comment c
on c.post_id = p.post_id
where u.user_id = 1
order by p.created_at desc;

-- Story
select * from tbl_story;
select * from tbl_follow;

-- Story
-- Login user id = 1
SELECT 
u.user_full_name,
u.username,
u.profile_pic,
s.story_media,
s.duration_in_sec,
s.media_type
FROM tbl_story s
INNER JOIN tbl_user u ON s.user_id = u.user_id
WHERE s.user_id IN (
    SELECT f.follow_id 
    FROM tbl_follow f
    WHERE f.user_id = 1 
    AND f.follow_status = "accept"
);

-- User posts something
insert into tbl_post (user_id, descriptions) values 
(1, "Royal Escape to Rajasthan");

INSERT INTO tbl_post_media (post_id, media_name, type_of_media, duration_in_sec, is_active, is_deleted, created_at, updated_at)
VALUES 
(21, 'image1.jpg', 'image', 0, 1, 0, NOW(), NOW());

INSERT INTO tbl_post_hashtage (post_id, hashtag_id) VALUES
(21, 3),
(31, 2);

select * from tbl_post where user_id = 1;

ALTER TABLE tbl_like 
ADD CONSTRAINT unique_user_post_like 
UNIQUE (user_id, post_id);

#trending hashtag
select hastag as trending_hashtag , 
total_count_usage 
from tbl_hashtag 
where total_count_usage >= 1
order by total_count_usage desc;

#top hashtag
select hastag as 
top_hashtag  
from tbl_hashtag 
where created_at >= NOW()- interval 1 day
order by created_at desc;

-- User id 2 commented on post
INSERT INTO tbl_comment (post_id, user_id, comment_) VALUES
(31, 2, 'Beautiful');

INSERT INTO tbl_comment (post_id, user_id, comment_) VALUES
(31, 2, 'Beautiful'),
(31, 3, 'Whoooo ! Amazing Pictures...'),
(31, 4, 'Love it !!');

-- Post's Comments
select 
p.post_id,
pm.media_name, 
pm.type_of_media,
p.descriptions,
c.comment_,
p.likes_total,
p.comments_total,
p.share_total
from tbl_comment c inner join tbl_post p
on c.post_id = p.post_id
inner join tbl_post_media pm
on pm.post_id = p.post_id;

select * from tbl_post_media;

DELIMITER $$
CREATE TRIGGER trig_follow_request
AFTER INSERT ON tbl_follow
FOR EACH ROW
BEGIN
    DECLARE user_profile_type VARCHAR(20);
    DECLARE follow_status VARCHAR(10);

    SELECT profile_type INTO user_profile_type 
    FROM tbl_user 
    WHERE user_id = NEW.follow_id;

    IF user_profile_type = "Private" THEN
        SET follow_status = "Pending";
    ELSE
        SET follow_status = "Accept";
    END IF;

    UPDATE tbl_follow 
    SET follow_status = follow_status
    WHERE pk_follow_id = NEW.pk_follow_id;

    UPDATE tbl_user 
    SET following_cnt = following_cnt + 1
    WHERE user_id = NEW.user_id;
    
    IF follow_status = "Accept" THEN
        UPDATE tbl_user 
        SET follower_cnt = follower_cnt + 1
        WHERE user_id = NEW.follow_id;
    END IF;
END $$
DELIMITER ;

select * from tbl_follow;
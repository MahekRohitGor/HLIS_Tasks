CREATE DATABASE DB_062;
USE DB_062;

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
    user_id bigint references tbl_user(user_id),
    action enum ('signup','signin','forget','profile'),
    verify_with enum('email','mobile'),
    verify boolean default 0,
    otp char(4)
);

create table tbl_address(
	address_id bigint primary key auto_increment,
    address text,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_services(
	service_id bigint primary key auto_increment,
    services varchar(128),
    parking_id bigint references tbl_parking(parking_id),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_parking(
	parking_id bigint primary key auto_increment,
    namess varchar(128),
    owner_name varchar(128),
    phone_number_owner char(16),
    avg_rating float(5,2),
    price bigint,
    descriptions text,
    image_id bigint references tbl_image(image_id),
    latitude char(16),
    longitude char(16),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_spots(
	spot_id bigint primary key auto_increment,
    spots enum("A", "NA"),
    parking_id bigint references tbl_parking(parking_id),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_rating(
	rating_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
	parking_id bigint references tbl_parking(parking_id),
    rating float(5,2),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_bookings(
	booking_id bigint primary key auto_increment,
    parking_id bigint references tbl_parking(parking_id),
    spot_id bigint references tbl_spots(spot_id),
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_remove(
	booking_id bigint primary key auto_increment,
    parking_id bigint references tbl_parking(parking_id),
    spot_id bigint references tbl_spots(spot_id),
    remove_time datetime default current_timestamp()
);

-- INSERT --

-- Insert into tbl_user
INSERT INTO tbl_user (phone_number, email_id, passwords)
VALUES 
('1234567890123456', 'user1@example.com', 'password1'),
('1234567890123456', 'user2@example.com', 'password2'),
('1234567890123456', 'user3@example.com', 'password3'),
('1234567890123456', 'user4@example.com', 'password4'),
('1234567890123456', 'user5@example.com', 'password5'),
('1234567890123456', 'user6@example.com', 'password6'),
('1234567890123456', 'user7@example.com', 'password7'),
('1234567890123456', 'user8@example.com', 'password8'),
('1234567890123456', 'user9@example.com', 'password9'),
('1234567890123456', 'user10@example.com', 'password10');

-- Insert into tbl_forgot_password
INSERT INTO tbl_forgot_password (email_id, reset_token)
VALUES 
('user1@example.com', 'token1'),
('user2@example.com', 'token2'),
('user3@example.com', 'token3'),
('user4@example.com', 'token4'),
('user5@example.com', 'token5'),
('user6@example.com', 'token6'),
('user7@example.com', 'token7'),
('user8@example.com', 'token8'),
('user9@example.com', 'token9'),
('user10@example.com', 'token10');

-- Insert into tbl_image
INSERT INTO tbl_image (image_name)
VALUES 
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

-- Insert into tbl_otp
INSERT INTO tbl_otp (user_id, action, verify_with, otp)
VALUES 
(1, 'signup', 'email', '1234'),
(2, 'signin', 'mobile', '2345'),
(3, 'forget', 'email', '3456'),
(4, 'profile', 'mobile', '4567'),
(5, 'signup', 'email', '5678'),
(6, 'signin', 'mobile', '6789'),
(7, 'forget', 'email', '7890'),
(8, 'profile', 'mobile', '8901'),
(9, 'signup', 'email', '9012'),
(10, 'signin', 'mobile', '0123');

-- Insert into tbl_address
INSERT INTO tbl_address (address)
VALUES 
('1234 Street, City, Country'),
('2345 Road, City, Country'),
('3456 Avenue, City, Country'),
('4567 Boulevard, City, Country'),
('5678 Lane, City, Country'),
('6789 Drive, City, Country'),
('7890 Way, City, Country'),
('8901 Path, City, Country'),
('9012 Circle, City, Country'),
('1012 Square, City, Country');

-- Insert into tbl_services
INSERT INTO tbl_services (services, parking_id)
VALUES 
('Valet Parking', 1),
('Self Parking', 2),
('Handicapped Parking', 3),
('VIP Parking', 4),
('Electric Car Charging', 5),
('Covered Parking', 6),
('Open Parking', 7),
('Long-Term Parking', 8),
('Short-Term Parking', 9),
('24/7 Parking', 10);

-- Insert into tbl_parking
INSERT INTO tbl_parking (namess, owner_name, phone_number_owner, avg_rating, price, descriptions, image_id, latitude, longitude)
VALUES 
('Parking Lot 1', 'John Doe', '9876543210123456', 4.5, 500, 'Near City Center', 1, '12.9716', '77.5946'),
('Parking Lot 2', 'Jane Smith', '9876543210123457', 3.8, 600, 'Near Mall', 2, '12.9717', '77.5947'),
('Parking Lot 3', 'Sam Brown', '9876543210123458', 4.2, 550, 'Near Station', 3, '12.9718', '77.5948'),
('Parking Lot 4', 'Emily Davis', '9876543210123459', 4.6, 700, 'Near Airport', 4, '12.9719', '77.5949'),
('Parking Lot 5', 'Michael Wilson', '9876543210123460', 4.0, 650, 'Near Hospital', 5, '12.9720', '77.5950'),
('Parking Lot 6', 'Sarah Lee', '9876543210123461', 4.1, 600, 'Near Park', 6, '12.9721', '77.5951'),
('Parking Lot 7', 'Chris White', '9876543210123462', 3.9, 500, 'Near Cinema', 7, '12.9722', '77.5952'),
('Parking Lot 8', 'Lisa Green', '9876543210123463', 4.3, 550, 'Near Market', 8, '12.9723', '77.5953'),
('Parking Lot 9', 'David Black', '9876543210123464', 4.7, 750, 'Near Beach', 9, '12.9724', '77.5954'),
('Parking Lot 10', 'Anna Brown', '9876543210123465', 3.5, 400, 'Near Museum', 10, '12.9725', '77.5955');

-- Insert into tbl_spots
INSERT INTO tbl_spots (spots, parking_id)
VALUES 
('A', 1),
('NA', 1),
('A', 2),
('NA', 2),
('A', 3),
('NA', 3),
('A', 4),
('NA', 4),
('A', 5),
('NA', 5);

-- Insert into tbl_rating
INSERT INTO tbl_rating (user_id, parking_id, rating)
VALUES 
(1, 1, 4.5),
(2, 2, 3.8),
(3, 3, 4.2),
(4, 4, 4.6),
(5, 5, 4.0),
(6, 6, 4.1),
(7, 7, 3.9),
(8, 8, 4.3),
(9, 9, 4.7),
(10, 10, 3.5);

-- Insert into tbl_bookings
INSERT INTO tbl_bookings (parking_id, spot_id)
VALUES 
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

-- Queries --
-- Triggers --

-- Trigger to Update spot status
DELIMITER $$
CREATE TRIGGER trg_update_spot_status
AFTER INSERT ON tbl_bookings
FOR EACH ROW
BEGIN
	UPDATE tbl_spots 
    SET spots = "NA" 
    where spots = "A" 
    and 
    spot_id = new.spot_id;
END $$
DELIMITER ;

-- Test Case
INSERT INTO tbl_bookings (parking_id, spot_id)
VALUES 
(2, 3);

-- Check
select * from tbl_spots;

-- Trigger to update avg_rating
DELIMITER $$
create trigger trg_update_avg_rating
after insert on tbl_rating
for each row
begin
	update tbl_parking set avg_rating = (select avg(rating) from tbl_rating where parking_id = new.parking_id)
    where parking_id = new.parking_id;
end $$
DELIMITER ;

-- Test Case
INSERT INTO tbl_rating (user_id, parking_id, rating) VALUES (1, 1, 2.0);

-- Check
SELECT parking_id, avg_rating FROM tbl_parking WHERE parking_id = 1;

-- Count Total Spots
select count(*) as total_spots, parking_id from tbl_spots group by parking_id;

-- Available Slots
select count(*) as avail_spots, parking_id from tbl_spots where spots = "A" group by parking_id;

-- Display All Parking
select namess, avg_rating, price, image_id from tbl_parking; 

-- Display Particular Parking Slot
select  namess, avg_rating, price, image_id, owner_name, descriptions, s.services, p.phone_number_owner
from tbl_parking p inner join tbl_services s on p.parking_id = s.parking_id where p.parking_id = 1;
CREATE DATABASE DB_112;
USE DB_112;

create table tbl_patient_acc(
	patient_id bigint primary key auto_increment,
    patient_name varchar(128),
    email_id varchar(64) unique,
    passwords varchar(64),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_speciality(
	speciality_id bigint primary key auto_increment,
    speciality varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

ALTER TABLE tbl_speciality 
ADD COLUMN category_id BIGINT,
ADD CONSTRAINT fk_speciality_category 
FOREIGN KEY (category_id) REFERENCES tbl_category(category_id) ON DELETE CASCADE;

create table tbl_hospital(
	hospital_id bigint primary key auto_increment,
    hospital_name varchar(128),
    latitude varchar(64),
    longitude varchar(64),
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

create table tbl_doctor(
	doctor_id bigint primary key auto_increment,
    doctor_name varchar(128),
    avg_rating decimal(10,2),
    speciality_id bigint references tbl_speciality(speciality_id),
    years_of_experience int,
    price_per_hour decimal(10,2),
    image_id bigint references tbl_image(image_id),
    hospital_id bigint references tbl_hospital(hospital_id),
    view_cnt bigint,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

ALTER TABLE tbl_doctor 
ADD COLUMN is_featured boolean;

select * from tbl_doctor;

-- update tbl_doctor set is_featured = 0 where doctor_id = 6;

create table tbl_views_by_user(
	view_id BIGINT primary key auto_increment,
	patient_id BIGINT,
    doctor_id bigint,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp(),
    FOREIGN KEY (doctor_id) REFERENCES tbl_doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES tbl_patient_acc(patient_id)
);

CREATE TABLE tbl_slot (
    slot_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    doctor_id BIGINT,
    availability_of_doctor ENUM("Available", "Not Available"),
    start_time_of_slot DATETIME,
    end_time_of_slot DATETIME GENERATED ALWAYS AS (start_time_of_slot + INTERVAL 30 MINUTE) VIRTUAL,
    slot_duration_mins INT DEFAULT 30, 
    is_active BOOLEAN DEFAULT 1,
    is_deleted BOOLEAN DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP(),
    FOREIGN KEY (doctor_id) REFERENCES tbl_doctor(doctor_id)
);

select * from tbl_slot;

create table tbl_book_appointment(
	appointment_id bigint primary key auto_increment,
    doctor_id bigint references tbl_doctor(doctor_id),
    patient_name varchar(128),
    patient_contact_number char(16),
    slot_id bigint references tbl_slot(slot_id),
    patient_role enum("Myself", "Parents", "Child", "Wife", "Other"),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_category(
	category_id bigint primary key auto_increment,
    category_name varchar(128),
	is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

ALTER TABLE tbl_category 
ADD COLUMN image_id BIGINT,
ADD CONSTRAINT fk_image_add
FOREIGN KEY (image_id) REFERENCES tbl_image(image_id) ON DELETE CASCADE;

drop table tbl_category;

create table tbl_rating(
	rating_id bigint primary key auto_increment,
    patient_id bigint references tbl_patient_acc(patient_id),
    doctor_id bigint references tbl_doctor(doctor_id),
    rating float(5,2),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);


create table tbl_fav_doctor_of_user(
	fav_id bigint primary key auto_increment,
    patient_id bigint references tbl_patient_acc(patient_id),
    doctor_id bigint references tbl_doctor(doctor_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

INSERT INTO tbl_speciality (speciality, category_id) VALUES
('Pediatric Dentistry', 1),
('Orthodontics', 1),
('Prosthodontics', 1),
('Interventional Cardiology', 2),
('Electrophysiology', 2),
('Stroke Neurology', 3),
('Neurocritical Care', 3),
('Sports Medicine', 4),
('Spinal Surgery', 4),
('Cosmetic Dermatology', 5),
('Pediatric Dermatology', 5);

INSERT INTO tbl_category (category_name) VALUES
('Dentistry'),
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Dermatology');

INSERT INTO tbl_hospital (hospital_name, latitude, longitude) VALUES 
('Apollo Hospital', '28.7041', '77.1025'),
('Fortis Hospital', '19.0760', '72.8777'),
('AIIMS Delhi', '28.5672', '77.2100');

INSERT INTO tbl_doctor (doctor_name, avg_rating, speciality_id, years_of_experience, price_per_hour, hospital_id) VALUES 
('Dr. Rajesh Sharma', 4.8, 12, 12, 2000.00, 1),
('Dr. Meena Patel', 4.5, 13, 8, 1500.00, 2),
('Dr. Ankit Verma', 4.7, 14, 10, 1800.00, 3);

select * from tbl_doctor;

INSERT INTO tbl_slot (doctor_id, availability_of_doctor, start_time_of_slot) VALUES
(4, 'Available', '2025-02-11 09:00:00'),
(5, 'Available', '2025-02-11 09:30:00'),
(4, 'Available', '2025-02-11 10:00:00'),
(4, 'Available', '2025-02-11 10:30:00'),
(4, 'Available', '2025-02-11 11:00:00'),
(5, 'Available', '2025-02-11 09:00:00'),
(5, 'Available', '2025-02-11 09:30:00'),
(5, 'Available', '2025-02-11 10:00:00'),
(5, 'Available', '2025-02-11 10:30:00'),
(5, 'Available', '2025-02-11 11:00:00'),
(6, 'Available', '2025-02-11 09:00:00'),
(6, 'Available', '2025-02-11 09:30:00'),
(6, 'Available', '2025-02-11 10:00:00'),
(6, 'Available', '2025-02-11 10:30:00'),
(6, 'Available', '2025-02-11 11:00:00'),
(4, 'Available', '2025-02-12 09:00:00'),
(4, 'Available', '2025-02-12 09:30:00'),
(4, 'Available', '2025-02-12 10:00:00'),
(4, 'Available', '2025-02-12 10:30:00'),
(4, 'Available', '2025-02-12 11:00:00'),
(5, 'Available', '2025-02-12 09:00:00'),
(5, 'Available', '2025-02-12 09:30:00'),
(5, 'Available', '2025-02-12 10:00:00'),
(5, 'Available', '2025-02-12 10:30:00'),
(5, 'Available', '2025-02-12 11:00:00'),
(6, 'Available', '2025-02-12 09:00:00'),
(6, 'Available', '2025-02-12 09:30:00'),
(6, 'Available', '2025-02-12 10:00:00'),
(6, 'Available', '2025-02-12 10:30:00'),
(6, 'Available', '2025-02-12 11:00:00');

INSERT INTO tbl_patient_acc (patient_name, email_id, passwords) VALUES 
('Amit Kumar', 'amit.kumar@email.com', 'secure123'),
('Priya Sharma', 'priya.sharma@email.com', 'strongPass1');

select * from tbl_slot;

INSERT INTO tbl_book_appointment (doctor_id, slot_id, patient_role) VALUES 
(4, 31, 'Myself'),
(5, 33, 'Parents');

-- Insert Images
INSERT INTO tbl_image (image_name) VALUES
('doctor1.jpg'),
('doctor2.jpg'),
('doctor3.jpg'),
('doctor4.jpg'),
('doctor5.jpg'),
('doctor6.jpg');

select * from tbl_rating;

INSERT INTO tbl_rating (patient_id, doctor_id, rating) VALUES
(1, 4, 4.5),
(2, 5, 4.8);

INSERT INTO tbl_fav_doctor_of_user (patient_id, doctor_id) VALUES
(1, 4),
(2, 6);


INSERT INTO tbl_views_by_user (patient_id, doctor_id)
VALUES (1, 4),
	(1, 5),
    (2, 6),
    (2, 5),
    (1, 4),
    (1, 4);

select * from tbl_views_by_user;
-- Triggers
-- Update Avg Rating
DELIMITER $$
CREATE TRIGGER trg_update_avg_rating
AFTER INSERT ON tbl_rating
FOR EACH ROW
BEGIN
	UPDATE tbl_doctor SET avg_rating = (
		SELECT avg(rating) FROM tbl_rating where doctor_id = new.doctor_id
    )
    where doctor_id = new.doctor_id;
END $$
DELIMITER ;

-- Check
INSERT INTO tbl_rating (patient_id, doctor_id, rating) VALUES
(1, 4, 1.3),
(2, 5, 2.3);
select * from tbl_doctor;

-- Update View Count
DELIMITER $$
CREATE TRIGGER trg_update_view_cnt
AFTER INSERT ON tbl_views_by_user
FOR EACH ROW
BEGIN
	UPDATE tbl_doctor SET view_cnt = (
		SELECT count(*) FROM tbl_views_by_user where doctor_id = new.doctor_id
    )
    where doctor_id = new.doctor_id;
END $$
DELIMITER ;

-- Update Availability of Doctor
DELIMITER $$
CREATE TRIGGER trg_update_avail
AFTER INSERT ON tbl_book_appointment
FOR EACH ROW
BEGIN
    UPDATE tbl_slot 
    SET availability_of_doctor = 'Not Available'
    WHERE doctor_id = NEW.doctor_id 
      AND slot_id = NEW.slot_id;
END $$
DELIMITER ;

INSERT INTO tbl_book_appointment (appointment_id, doctor_id, patient_name, patient_contact_number, slot_id, patient_role)
VALUES (1, 4, 'John Doe', '1234567890', 34, 'Myself');

-- Screen 1
-- Display all categories
select c.category_name, 
im.image_name 
from 
tbl_category c 
inner join 
tbl_image im 
on c.image_id = im.image_id
where 
c.is_deleted = 0;

-- Popular Doctors
select 
d.doctor_name, 
d.avg_rating,
s.speciality,
d.image_id
from tbl_doctor d
inner join tbl_speciality s
on d.speciality_id = s.speciality_id
where d.view_cnt > 3
and d.avg_rating > 3.00
and d.years_of_experience > 5;

-- Select Featured Doctor
select 
d.doctor_name, 
d.avg_rating,
s.speciality,
d.years_of_experience,
d.price_per_hour,
d.image_id
from tbl_doctor d
inner join tbl_speciality s
on d.speciality_id = s.speciality_id
where is_featured = 1
order by d.avg_rating desc;

-- Search Functionality
select 
d.doctor_name, 
d.avg_rating,
s.speciality,
d.years_of_experience,
d.price_per_hour,
d.image_id
from tbl_doctor d
inner join tbl_speciality s
on d.speciality_id = s.speciality_id
where d.doctor_name like "%me%";

-- Screen 2
-- Display all Doctors
SELECT 
d.doctor_id,
d.doctor_name, 
d.avg_rating,
s.speciality,
d.years_of_experience,
d.price_per_hour,
d.image_id,
date_format(MIN(sl.start_time_of_slot), "%d %b %Y %H:%i %p") AS first_available_slot
FROM tbl_doctor d
INNER JOIN tbl_speciality s 
ON d.speciality_id = s.speciality_id
LEFT JOIN tbl_slot sl 
ON d.doctor_id = sl.doctor_id 
AND sl.availability_of_doctor = 'Available'
GROUP BY d.doctor_id, 
d.doctor_name, 
d.avg_rating, 
s.speciality, 
d.years_of_experience, 
d.price_per_hour, 
d.image_id
ORDER BY 
first_available_slot 
ASC;

-- Screen 3
-- Specific selected date for a doctor
-- Selected date is 12 Feb 2025
-- appointment for tomorrow
SELECT 
    d.doctor_id,
    d.doctor_name, 
    d.avg_rating,
    s.speciality,
    d.years_of_experience,
    d.price_per_hour,
    d.image_id,
    date_format(MIN(sl.start_time_of_slot), "%d %b %Y %H:%i %p") AS first_available_slot,
    CASE 
        WHEN DATE(MIN(sl.start_time_of_slot)) = CURDATE() THEN 'Today'
        WHEN DATE(MIN(sl.start_time_of_slot)) = CURDATE() + INTERVAL 1 DAY THEN 'Tomorrow'
        ELSE DATE(MIN(sl.start_time_of_slot))
    END AS slot_date_display
FROM tbl_doctor d
INNER JOIN tbl_speciality s ON d.speciality_id = s.speciality_id
LEFT JOIN tbl_slot sl 
    ON d.doctor_id = sl.doctor_id 
    AND sl.availability_of_doctor = 'Available'
    AND DATE(sl.start_time_of_slot) = "2025-02-11"
    where d.doctor_id = 4
GROUP BY d.doctor_id, d.doctor_name, d.avg_rating, s.speciality, d.years_of_experience, d.price_per_hour, d.image_id
ORDER BY first_available_slot ASC;

-- Screen 4
-- Showing all slots of particular doctor
select d.doctor_name, 
s.availability_of_doctor,
s.start_time_of_slot,
d.image_id
from tbl_slot s 
inner join tbl_doctor d 
on d.doctor_id = s.doctor_id 
INNER JOIN tbl_speciality sl ON d.speciality_id = sl.speciality_id
where d.doctor_id = 4 and date(start_time_of_slot) = "2025-02-11";

-- Screen 5
-- Display Popular Doctors
select 
d.doctor_name, 
d.avg_rating,
s.speciality,
d.image_id
from tbl_doctor d
inner join tbl_speciality s
on d.speciality_id = s.speciality_id
order by d.view_cnt desc, d.avg_rating desc, d.years_of_experience desc;

-- Screen 6
SELECT 
d.doctor_id,
d.doctor_name, 
d.avg_rating,
s.speciality,
d.years_of_experience,
d.price_per_hour,
d.image_id
FROM tbl_doctor d
INNER JOIN tbl_speciality s 
ON d.speciality_id = s.speciality_id
LEFT JOIN tbl_slot sl 
ON d.doctor_id = sl.doctor_id
where d.doctor_id = 4
GROUP BY d.doctor_id, 
d.doctor_name, 
d.avg_rating, 
s.speciality, 
d.years_of_experience, 
d.price_per_hour, 
d.image_id;

-- Screen 7
-- Appointment Book
-- Find Available slots
select * from tbl_slot where doctor_id = 4;

-- Book Appointment
insert into tbl_book_appointment (doctor_id, patient_name, patient_contact_number, slot_id, patient_role)
values
(4, "Mahek Gor", "7418529630", 33, "Myself");

-- Checking 33 slot id changed to not available
select * from tbl_slot where doctor_id = 4;
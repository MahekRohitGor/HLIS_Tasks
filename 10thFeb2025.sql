CREATE DATABASE DB_102;
USE DB_102;

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

INSERT INTO tbl_speciality (speciality) VALUES 
('Cardiology'), 
('Dermatology'), 
('Neurology'), 
('Orthopedics'),
('Dentist');

INSERT INTO tbl_hospital (hospital_name, latitude, longitude) VALUES 
('Apollo Hospital', '28.7041', '77.1025'),
('Fortis Hospital', '19.0760', '72.8777'),
('AIIMS Delhi', '28.5672', '77.2100');

INSERT INTO tbl_doctor (doctor_name, avg_rating, speciality_id, years_of_experience, price_per_hour, hospital_id) VALUES 
('Dr. Rajesh Sharma', 4.8, 1, 12, 2000.00, 1),
('Dr. Meena Patel', 4.5, 2, 8, 1500.00, 2),
('Dr. Ankit Verma', 4.7, 3, 10, 1800.00, 3);

INSERT INTO tbl_slot (doctor_id, availability_of_doctor, start_time_of_slot) VALUES
(1, 'Available', '2025-02-11 09:00:00'),
(1, 'Available', '2025-02-11 09:30:00'),
(1, 'Available', '2025-02-11 10:00:00'),
(1, 'Available', '2025-02-11 10:30:00'),
(1, 'Available', '2025-02-11 11:00:00'),
(2, 'Available', '2025-02-11 09:00:00'),
(2, 'Available', '2025-02-11 09:30:00'),
(2, 'Available', '2025-02-11 10:00:00'),
(2, 'Available', '2025-02-11 10:30:00'),
(2, 'Available', '2025-02-11 11:00:00'),
(3, 'Available', '2025-02-11 09:00:00'),
(3, 'Available', '2025-02-11 09:30:00'),
(3, 'Available', '2025-02-11 10:00:00'),
(3, 'Available', '2025-02-11 10:30:00'),
(3, 'Available', '2025-02-11 11:00:00'),
(1, 'Available', '2025-02-12 09:00:00'),
(1, 'Available', '2025-02-12 09:30:00'),
(1, 'Available', '2025-02-12 10:00:00'),
(1, 'Available', '2025-02-12 10:30:00'),
(1, 'Available', '2025-02-12 11:00:00'),
(2, 'Available', '2025-02-12 09:00:00'),
(2, 'Available', '2025-02-12 09:30:00'),
(2, 'Available', '2025-02-12 10:00:00'),
(2, 'Available', '2025-02-12 10:30:00'),
(2, 'Available', '2025-02-12 11:00:00'),
(3, 'Available', '2025-02-12 09:00:00'),
(3, 'Available', '2025-02-12 09:30:00'),
(3, 'Available', '2025-02-12 10:00:00'),
(3, 'Available', '2025-02-12 10:30:00'),
(3, 'Available', '2025-02-12 11:00:00');

INSERT INTO tbl_patient_acc (patient_name, email_id, passwords) VALUES 
('Amit Kumar', 'amit.kumar@email.com', 'secure123'),
('Priya Sharma', 'priya.sharma@email.com', 'strongPass1');

INSERT INTO tbl_book_appointment (doctor_id, slot_id, patient_role) VALUES 
(1, 1, 'Myself'),
(1, 3, 'Parents');

-- Insert Images
INSERT INTO tbl_image (image_name) VALUES
('doctor1.jpg'),
('doctor2.jpg'),
('doctor3.jpg'),
('doctor4.jpg'),
('doctor5.jpg'),
('doctor6.jpg');


select * from tbl_speciality;


INSERT INTO tbl_rating (patient_id, doctor_id, rating) VALUES
(1, 1, 4.5),
(2, 2, 4.8);

INSERT INTO tbl_fav_doctor_of_user (patient_id, doctor_id) VALUES
(1, 2),
(2, 1);

TRUNCATE TABLE tbl_doctor;
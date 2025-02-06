CREATE DATABASE DB_06;
USE DB_06;

create table tbl_user(
	user_id bigint primary key auto_increment,
    phone_number char(16),
    email_id varchar(64) unique,
    passwords varchar(64),
    is_active boolean default 1,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);


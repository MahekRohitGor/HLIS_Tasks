CREATE DATABASE DB_07;
USE DB_07;

create table tbl_user(
	user_id bigint primary key auto_increment,
    email_id varchar(64) unique,
    fname varchar(64),
    lname varchar(64),
    passwords varchar(64),
    dob date,
    user_interested_in enum("Men", "Women"),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_product(
	product_id bigint primary key auto_increment,
    image_id bigint references tbl_image(image_id),
    product_name varchar(128),
    quantity_in_warehouse bigint,
    product_price bigint,
    currency enum("Rupees", "Dollars"),
    descriptions text,
    terms_condititions text,
    size_id bigint references tbl_size(size_id),
    gender enum("Men", "Women", "Unisex", "Other"),
    brand_id bigint references tbl_brand(brand_id),
    avg_rating float(5,2),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_brand(
	brand_id bigint primary key auto_increment,
    brand_name varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_rating(
	rating_id bigint primary key auto_increment,
    
);

create table fav_of_user(
	fav_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    product_id bigint references tbl_user(user_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);





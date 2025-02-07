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
    color_id bigint references tbl_color(color_id),
    size_id bigint references tbl_size(size_id),
    gender enum("Men", "Women", "Unisex", "Other"),
    brand_id bigint references tbl_brand(brand_id),
    avg_rating float(5,2),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_color(
	color_id bigint primary key auto_increment,
    color_name varchar(64),
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
    user_id bigint references tbl_user(user_id),
    product_id bigint references tbl_user(user_id),
    rating float(5,2),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
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

create table tbl_main_category(
	main_category_id bigint primary key auto_increment,
    main_category_name varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_sub_category(
	sub_category_id bigint primary key auto_increment,
    sub_category_name varchar(128),
	main_category_id bigint references tbl_main_category(main_category_id),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_size_group(
	size_group_id bigint primary key auto_increment,
    size_group varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_size(
	size_id bigint primary key auto_increment,
    size_group_id bigint references tbl_size_group(size_group_id),
    size char(8),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_order(
	order_id bigint primary key auto_increment,
    user_id bigint references tbl_user(user_id),
    payment_type enum ("COD", "Paypal", "Wallet", "Card"),
    total_quantity bigint,
    total_price bigint,
    order_status enum("Pending", "Placed", "Cancelled"),
    order_date datetime,
    address_id bigint references tbl_address(address_id),
    tracking_number char(16),
    discount int,
    delivery_charge bigint,
    payment_status enum("Failed", "Success"),
    order_number bigint,
    shipping_id bigint references tbl_shipping(shipping_id),
    grand_total bigint,
	is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

create table tbl_order_item(
	order_item_id bigint primary key auto_increment,
    order_id bigint references tbl_order(order_id),
    product_id bigint references tbl_product(product_id),
    quantity bigint,
    market_price bigint,
    offer_price bigint,
    discount int,
    final_price bigint,
    product_details text,
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

create table tbl_shipping(
	shipping_id bigint primary key auto_increment,
    shipping_add text,
    shipping_name varchar(128),
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);
create table tbl_address(
	address_id bigint primary key auto_increment,
    address text,
    is_active boolean default 1,
    is_deleted boolean default 0,
    created_at datetime default current_timestamp(),
    updated_at datetime on update current_timestamp()
);

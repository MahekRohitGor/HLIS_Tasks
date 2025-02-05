create table tbl_mahek.emp_details(
	PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

INSERT INTO tbl_mahek.emp_details values (1, "Gor", "Mahek", "K-15, ODHAV PARK 3", "Bhuj");
INSERT INTO tbl_mahek.emp_details values (5, "Gor", "Jeet", "Madhapar", "Mumbai");
INSERT INTO tbl_mahek.emp_details values (3, "Gor", "Ankita", "K-15, ODHAV PARK 3", "Bhuj");
INSERT INTO tbl_mahek.emp_details values (4, "Gor", "Rohit", "K-15, ODHAV PARK 3", "Bhuj");

SELECT * from tbl_mahek.emp_details;
SELECT * from tbl_mahek.tbl_users;
SELECT * from tbl_mahek.tbl_forgot_pswd;
SELECT * from tbl_mahek.tbl_audit_logs;

create table tbl_users(
	id int PRIMARY KEY auto_increment,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_verified BOOLEAN DEFAULT FALSE,
    verification_token VARCHAR(255)
);

create table tbl_forgot_pswd(
	id int primary key auto_increment,
    user_id int references tbl_mahek.tbl_users(id),
    reset_token varchar(255) UNIQUE NOT NULL,
    created_at timestamp default current_timestamp,
    expires_at timestamp not null,
    is_used boolean default false
);

create table tbl_audit_logs(
	id int primary key auto_increment,
    user_id int references tbl_mahek.tbl_users(id),
    action varchar(255) not null,
    ip_address varchar(255),tbl_audit_logs
    timestamps timestamp default current_timestamp
);

describe tbl_mahek.tbl_forgot_pswd;
SHOW COLUMNS FROM tbl_mahek.tbl_forgot_pswd;

create schema db_practice;

create table db_practice.tbl_user(
	user_id int primary key auto_increment,
	name varchar(255) not null,
    email varchar(255) unique not null,
    passwords varchar(255) not null,
    phone int unique not null,
    pic varchar(255),
    about varchar(255)
);

create table db_practice.tbl_place(
	place_id int primary key auto_increment,
    location_name varchar(255) not null,
    descriptions varchar(255)
);

create table db_practice.tbl_image(
	image_id int primary key auto_increment,
    place_id int references tbl_place(place_id),
    image_url varchar(255)
);

create table db_practice.tbl_review(
	review_id int primary key auto_increment,
    user_id int references tbl_user(user_id),
    review varchar(255),
    place_id int references tbl_place(place_id)
);

create table db_task1.tbl_school(
	school_id bigint primary key auto_increment,
	school_name varchar(64)
);

create table db_task1.tbl_school1(
	school_id bigint primary key auto_increment,
	school_name varchar(128)
);


INSERT INTO db_task1.tbl_school1 (school_name) VALUES ("Vallurupalli Nageswara Rao Vignana Jyothi Institute of Engineering and Technology");

create table db_task1.tb_worker(
	worker_id bigint primary key auto_increment,
    first_name varchar(32),
    last_name varchar(32),
    salary int,
    joining_date datetime,
    department varchar(16)
);

alter table db_task1.tb_worker rename to db_task1.tbl_worker;

INSERT INTO db_task1.tbl_worker (worker_id, first_name, last_name, salary, joining_date, department) VALUES
(1, "Monika", "Arora", 100000, "2024-02-20 09:00:00", "HR"),
(2, "Niharika", "Verma", 80000, "2014-06-11 09:00:00", "Admin"),
(3, "Vishal", "Singhal", 300000, "2014-02-20 09:00:00", "HR"),
(4, "Vivek", "Bhati", 500000, "2014-06-11 09:00:00", "Admin"),
(5, "Vipul", "Diwan", 200000, "2014-01-20 09:00:00", "Admin"),
(6, "Satish", "Kumar", 75000, "2014-06-11 09:00:00", "Account"),
(7, "Pooja", "Jain", 95000, "2017-05-22 09:00:00", "Finance"),
(8, "Rajesh", "Gupta", 250000, "2016-08-10 09:00:00", "HR"),
(9, "Sonia", "Mehra", 180000, "2013-11-05 09:00:00", "Marketing"),
(10, "Rahul", "Kumar", 275000, "2018-09-30 09:00:00", "Sales"),
(11, "Neha", "Patel", 110000, "2020-01-14 09:00:00", "IT"),
(12, "Sameer", "Joshi", 140000, "2015-07-18 09:00:00", "Operations"),
(13, "Anita", "Kapoor", 85000, "2019-12-25 09:00:00", "Admin"),
(14, "Kunal", "Malhotra", 220000, "2012-06-17 09:00:00", "HR"),
(15, "Deepak", "Rao", 270000, "2014-04-12 09:00:00", "Finance"),
(16, "Simran", "Kaur", 175000, "2021-07-23 09:00:00", "Marketing"),
(17, "Ravi", "Chopra", 240000, "2013-10-19 09:00:00", "Sales"),
(18, "Sakshi", "Yadav", 90000, "2016-02-28 09:00:00", "Operations"),
(19, "Aditya", "Bansal", 290000, "2017-09-09 09:00:00", "HR"),
(20, "Meera", "Tiwari", 130000, "2019-06-05 09:00:00", "Finance"),
(21, "Arjun", "Verma", 320000, "2022-08-11 09:00:00", "Admin"),
(22, "Ishita", "Shah", 150000, "2015-03-21 09:00:00", "IT"),
(23, "Kartik", "Mishra", 210000, "2018-11-07 09:00:00", "Sales"),
(24, "Ramesh", "Pandey", 280000, "2016-07-29 09:00:00", "HR"),
(25, "Nitin", "Desai", 175000, "2023-10-01 09:00:00", "Marketing"),
(26, "Anjali", "Chawla", 95000, "2012-04-30 09:00:00", "Admin"),
(27, "Prakash", "Reddy", 200000, "2020-09-19 09:00:00", "Finance"),
(28, "Swati", "Nanda", 270000, "2014-05-15 09:00:00", "Operations"),
(29, "Tarun", "Jain", 225000, "2013-01-09 09:00:00", "IT"),
(30, "Preeti", "Kohli", 195000, "2017-12-03 09:00:00", "Sales");

select * from db_task1.tbl_worker;

-- query 1
-- Write an SQL query to fetch FIRST_NAME from the Worker table using the alias name as <WORKER_NAME>
select first_name as WORKER_NAME from db_task1.tbl_worker;

-- query 2
-- Write an SQL query to fetch FIRST_NAME from the Worker table in uppercase.
SELECT UPPER(FIRST_NAME) FROM db_task1.tbl_worker;

-- query 3
-- Write an SQL query to fetch unique values of DEPARTMENT from the Worker table.
select distinct department as UNIQUE_DEPARTMENT FROM db_task1.tbl_worker;

-- query 4
-- Write an SQL query to fetch the first three characters of FIRST_NAME from the Worker table.
select substring(first_name, 1,3) FROM db_task1.tbl_worker;

-- query 5
-- Write an SQL query to fetch the unique values of DEPARTMENT from the Worker table and print their lengths.
select distinct department, length(department) as LENGTH_OF_DEPARTMENT from db_task1.tbl_worker;

-- query 6
-- Write an SQL query to print the FIRST_NAME after replacing ‘a’ with ‘A’.
select replace(first_name, "a", "A") as FIRST_NAME from db_task1.tbl_worker;

-- query 7
-- Write an SQL query to concatenate FIRST_NAME and LAST_NAME into a single 
select concat(first_name, " ", last_name) as COMPLETE_NAME from db_task1.tbl_worker;

-- query 8
-- Write an SQL query to print all Worker details ordered by FIRST_NAME in ascending order.
select * from db_task1.tbl_worker order by first_name asc;

-- query 9
-- Write an SQL query to print all Worker details ordered by FIRST_NAME in ascending order and DEPARTMENT in descending order.
select * from db_task1.tbl_worker order by first_name asc, department desc;

-- query 10
-- Write an SQL query to print details of Workers with the FIRST_NAME as “Vipul” or “Satish”.
select * from db_task1.tbl_worker where first_name in ("Vipul", "Satish");

-- query 11
-- Write an SQL query to print details of Workers excluding those with FIRST_NAME as “Vipul” or “Satish”.
select * from db_task1.tbl_worker where first_name not in ("Vipul", "Satish");

-- query 12
-- Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”
select * from db_task1.tbl_worker where department = "Admin";

-- query 13
-- Write an SQL query to print details of Workers whose FIRST_NAME contains the letter ‘a’.
select * from db_task1.tbl_worker where first_name LIKE "%a%";

-- query 14
-- Write an SQL query to print details of Workers whose FIRST_NAME ends with the letter ‘a’.
select * from db_task1.tbl_worker where first_name LIKE "%a";

-- query 15
-- Write an SQL query to print details of Workers whose FIRST_NAME ends with ‘h’ and has six characters.
select * from db_task1.tbl_worker where first_name LIKE "_____h";

-- query 16
-- Write an SQL query to print details of Workers whose SALARY lies between 100000 and 500000.
select * from db_task1.tbl_worker where salary between 100000 and 500000;

-- query 17
-- Write an SQL query to print details of Workers who joined in February 2014.
select * from db_task1.tbl_worker where joining_date between "2014-02-01 09:00:00" and "2014-02-28 09:00:00";

-- query 18
-- Write an SQL query to fetch the count of employees working in the department “Admin”.
select count(*) as Number_of_employees_in_Admin from db_task1.tbl_worker where department = "Admin";
select count(*) as Number_of_employees_in_Admin, department from db_task1.tbl_worker group by department having department = "Admin";

-- query 19
-- Write an SQL query to fetch FIRST_NAME of Workers with SALARY >= 50000 and <= 100000.
select first_name from db_task1.tbl_worker where salary between 50000 and 100000;

-- query 20
-- Write an SQL query to fetch the odd rows of a table.
select * from db_task1.tbl_worker where not worker_id%2 = 0;

-- query 21
-- Write an SQL query to fetch the top 5 records of a table.
select * from db_task1.tbl_worker where worker_id < 6;
select * from db_task1.tbl_worker limit 5;

-- query 24
-- Write an SQL query to fetch the departments with less than five employees.
select count(*) as count_dept, department from db_task1.tbl_worker group by department having count_dept < 5;

-- query 25
-- Write an SQL query to fetch all departments along with the number of employees in each department.
select count(*) as number_of_emp, department from db_task1.tbl_worker group by department;

-- query 26
-- Write an SQL query to calculate the average SALARY of employees in each department.
-- Write an SQL query to fetch Workers who joined before January 2014.
select floor(avg(salary)) as AVG_SAL, department from db_task1.tbl_worker group by department;
select round(avg(salary)) as AVG_SAL, department from db_task1.tbl_worker group by department;
select * from db_task1.tbl_worker where joining_date < "2014-01-01 09:00:00";

-- query 27
-- Write an SQL query to fetch Workers in the "Admin" department with SALARY above 80000.
select * from db_task1.tbl_worker where department = "Admin" and salary > 80000;

-- query 28
-- Write an SQL query to fetch Workers whose FIRST_NAME contains 'i'.
select * from db_task1.tbl_worker where first_name like "%i%";

-- query 29
-- Write an SQL query to fetch details of Workers whose SALARY lies between 75000 and 200000.
select * from db_task1.tbl_worker where salary between 75000 and 200000;

-- query 30
-- Write an SQL query to fetch details of Workers who have 'Singh' in their LAST_NAME
select * from db_task1.tbl_worker where last_name like "%Singh%";

-- query 31
-- Write an SQL query to group workers by their DEPARTMENT and count the number of workers in each department.
select department, count(*) as num_workers from db_task1.tbl_worker group by department;

-- query 32
-- Write an SQL query to find the average salary for each DEPARTMENT and only include departments with an average salary greater than 100,000.
select floor(avg(salary)) as avg_sal, department from db_task1.tbl_worker group by department having avg_sal > 100000;

-- query 33
-- Write an SQL query to display the department name and the total salary of workers in each department, 
-- but only include departments where the total salary is greater than 400,000.
select department, sum(salary) as TOTAL_SALARY from db_task1.tbl_worker group by department having TOTAL_SALARY > 400000;

-- query 34
-- Write an SQL query to group workers by DEPARTMENT and find the maximum salary in each department. 
-- Only include departments with a maximum salary greater than 200,000.
select department, max(salary) as MAX_SALARY from db_task1.tbl_worker group by department having MAX_SALARY > 200000;

-- query 35
-- Write an SQL query to display the department name and the number of workers in each department, 
-- but only include departments with more than 3 workers.
select department, count(*) as num_workers from db_task1.tbl_worker group by department having num_workers > 3;

-- query 36
-- Write an SQL query to group workers by DEPARTMENT and calculate the total salary of workers in each department. 
-- Show only the departments where the total salary is less than 1,000,000.
select department, sum(salary) as total_salary from db_task1.tbl_worker group by department having total_salary > 1000000;

-- query 37
-- Write an SQL query to find departments where the number of workers is less than 4, using HAVING.
select department, count(*) as num_workers from db_task1.tbl_worker group by department having num_workers < 4;

-- query 38
-- Write an SQL query to find the departments where the number of workers is greater than 5, and their average salary is above 100,000.
select department, count(*) as num_workers, floor(avg(salary)) as avg_sal from db_task1.tbl_worker group by department having num_workers > 5 and avg_sal > 100000;

-- query 39
-- Write an SQL query to group workers by DEPARTMENT and fetch departments that have more than 2 workers with a salary greater than 90,000.
select count(*) as num_workers, department from db_task1.tbl_worker where salary > 90000 group by department having num_workers > 2;

-- query 40
-- Write an SQL query to display the department and the total number of workers who earn a salary greater than 80,000.
select department, count(*) as total_worker from db_task1.tbl_worker where salary > 80000 group by department;

-- query 41
-- Write an SQL query to display departments with the minimum salary greater than 60,000 using HAVING.
select department, min(salary) as min_sal from db_task1.tbl_worker group by department having min_sal > 60000;

-- query 42
-- Write an SQL query to group workers by their DEPARTMENT and show only departments where the average salary is above 150,000.
select avg(salary) as avg_sal, department from db_task1.tbl_worker group by department having avg_sal > 150000;

-- query 43
-- Write an SQL query to group workers by DEPARTMENT and show the departments where the total salary is greater than 500,000 but less than 1,000,000.
select sum(salary) as total_salary, department from db_task1.tbl_worker group by department having total_salary between 500000 and 1000000;

-- query 44
-- Write an SQL query to display the DEPARTMENT name and the sum of salaries where the sum is greater than 800,000.
select department, sum(salary) as total_salary from db_task1.tbl_worker group by department having total_salary > 800000;

-- query 45
-- Write an SQL query to find departments that have at least 3 workers and have a salary greater than 100,000.
select department, count(*) as total_workers from db_task1.tbl_worker where salary > 100000 group by department having total_workers >= 3;

-- query 46
-- Write an SQL query to calculate the total number of workers in each department and show only those departments with a count greater than 1.
select department, count(*) as total_workers from db_task1.tbl_worker group by department having total_workers > 1;

-- query 47
-- Write an SQL query to display departments with an average salary above 70,000 and group them by DEPARTMENT.
select department from db_task1.tbl_worker group by department having avg(salary) > 70000;

-- query 48
-- Write an SQL query to group workers by DEPARTMENT and fetch the minimum salary of workers in each department. Only include departments with a minimum salary above 50,000.
select department, min(salary) as min_sal from db_task1.tbl_worker group by department having min_sal > 50000;

-- query 49
-- Write an SQL query to find departments with a salary total greater than 300,000 and a count of workers greater than 2.
select department from db_task1.tbl_worker group by department having sum(salary) > 300000 and count(*) > 2;

-- query 50
-- Write an SQL query to group workers by DEPARTMENT and only include departments where the number of workers is exactly 2.
select department, count(*) as num_workers from db_task1.tbl_worker group by department having num_workers = 2;

-- query 51
-- Write an SQL query to calculate the average salary for each DEPARTMENT and show departments where the average salary is below 80,000.
select avg(salary) as avg_sal, department from db_task1.tbl_worker group by department having avg_sal < 80000;

-- query 52
-- Write an SQL query to find the total salary and average salary for each DEPARTMENT and display only departments where the total salary is greater than 400,000.
select sum(salary) as total_salary, floor(avg(salary)) as avg_sal, department from db_task1.tbl_worker group by department having total_salary > 400000;

-- query 53
-- Write an SQL query to cast SALARY as an integer and display the result as SALARY_INT for each worker in the Worker table.
select salary*1 as salary_int from db_task1.tbl_worker;
select salary*1.00 as salary_int from db_task1.tbl_worker;

-- query 54
-- Write an SQL query to display the sum of SALARY as a FLOAT value.
select sum(salary)*1.00  as float_salary from db_task1.tbl_worker;
-- select cast(sum(salary) as float) as float_salary from db_task1.tbl_worker;

select * from db_task1.tbl_worker;

select avg(salary) as avg_sal, department from db_task1.tbl_worker where joining_date > "2014-01-01 09:00:00" group by department having avg_sal > 50000;

create database db_task_29;

create table db_task_29.tbl_worker(
	worker_id bigint primary key auto_increment,
    first_name varchar(32),
    last_name varchar(32),
    salary int,
    joining_date datetime,
    department_id bigint references tbl_department(department_id)
);

create table db_task_29.tbl_department(
	department_id bigint primary key auto_increment,
    department varchar(16)
);

create table db_task_29.tbl_worker_rating(
	id bigint primary key auto_increment,
    worker_id bigint references tbl_worker(worker_id),
    rating float(4,2)
);

insert into db_task_29.tbl_worker (worker_id, first_name, last_name, salary, joining_date, department_id) values
(1, 'Monika', 'Arora', 100000, '1982-02-20 09:00:00', 1),
(2, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 2),
(3, 'Vishal', 'Singhal', 300000, '2015-02-20 09:00:00', 1),
(4, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 2),
(5, 'Vivek', 'Bhati', 500000, '2016-06-11 09:00:00', 2),
(6, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 3),
(7, 'Satish', 'Kumar', 75000, '1985-01-20 09:00:00', 4),
(8, 'Geetika', 'Chauhan', 90000, '1988-04-11 09:00:00', 2),
(9, 'Anjali', 'Mishra', 120000, '2012-09-15 09:00:00', 3),
(10, 'Rahul', 'Sharma', 95000, '2013-08-21 09:00:00', 4),
(11, 'Sneha', 'Rao', 105000, '2016-07-30 09:00:00', 1),
(12, 'Arun', 'Gupta', 87000, '2010-05-10 09:00:00', 2),
(13, 'Preeti', 'Joshi', 95000, '2018-04-17 09:00:00', 3),
(14, 'Ramesh', 'Patel', 150000, '2019-11-22 09:00:00', 1),
(15, 'Meena', 'Goyal', 93000, '2017-12-05 09:00:00', 2),
(16, 'Rajesh', 'Yadav', 89000, '2011-01-09 09:00:00', 4),
(17, 'Sandeep', 'Kumar', 97000, '2020-02-14 09:00:00', 3),
(18, 'Pooja', 'Sharma', 115000, '2021-03-11 09:00:00', 1),
(19, 'Deepak', 'Shah', 99000, '2015-10-05 09:00:00', 2),
(20, 'Kiran', 'Jain', 80000, '2014-11-19 09:00:00', 3),
(21, 'Varun', 'Chopra', 95000, '2012-06-08 09:00:00', 4),
(22, 'Neha', 'Tiwari', 87000, '2020-07-25 09:00:00', 1),
(23, 'Akash', 'Mehta', 102000, '2018-09-30 09:00:00', 2),
(24, 'Sonia', 'Kapoor', 110000, '2019-12-20 09:00:00', 3),
(25, 'Mohit', 'Rana', 92000, '2015-07-15 09:00:00', 4),
(26, 'Kavita', 'Sharma', 97000, '2016-05-29 09:00:00', 2),
(27, 'Nitin', 'Shukla', 103000, '2011-04-14 09:00:00', 3),
(28, 'Swati', 'Saxena', 98000, '2017-08-18 09:00:00', 1),
(29, 'Tarun', 'Singh', 89000, '2013-03-22 09:00:00', 2),
(30, 'Ritika', 'Verma', 94000, '2022-01-05 09:00:00', 4);

insert into db_task_29.tbl_worker (worker_id, first_name, last_name, salary, joining_date, department_id) values
(31, 'Mahek', 'R', 5000000, '2003-01-30 09:00:00', 3);

insert into db_task_29.tbl_department (department_id, department) values
(1, 'HR'),
(2, 'Admin'),
(3, 'Account'),
(4, 'Sales');

insert into db_task_29.tbl_worker_rating (id, worker_id, rating) values
(1, 1, 3),
(2, 1, 2),
(3, 2, 4),
(4, 3, 5),
(5, 4, 2),
(6, 2, 1),
(7, 1, 3),
(8, 3, 5),
(9, 5, 4),
(10, 6, 2),
(11, 7, 3),
(12, 8, 1),
(13, 9, 5),
(14, 10, 4),
(15, 11, 3),
(16, 12, 2),
(17, 13, 1),
(18, 14, 4),
(19, 15, 3),
(20, 16, 2),
(21, 17, 5),
(22, 18, 1),
(23, 19, 4),
(24, 20, 3),
(25, 21, 2),
(26, 22, 5),
(27, 23, 4),
(28, 24, 3),
(29, 25, 2),
(30, 26, 1);

-- Q.1 Retrieve the first and last names of all workers along with their department names.
select w.first_name, w.last_name, d.department from db_task_29.tbl_worker as w left join db_task_29.tbl_department as d on w.department_id = d.department_id;

-- Q.2 Retrieve the total salary of workers in each department.
select sum(w.salary) as total_salary_department_wise, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id group by d.department;

-- Q.3 Write an SQL query to fetch the Department wise worker count.
select count(w.worker_id) as worker_cnt, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id group by d.department;

-- Q.4 Write an SQL query to fetch the department-wise highest salary record
select max(w.salary) as max_salary, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id group by d.department;

-- Q.5 Write an SQL query to fetch the average rating with worker details whose rating is greater than or equal to 4
select avg(r.rating), w.* from db_task_29.tbl_worker as w inner join db_task_29.tbl_worker_rating as r on w.worker_id = r.worker_id group by w.worker_id having avg(r.rating) >= 4.00;

-- Q.6 Get the list of workers with their department name and salary who have a rating of 3 or more.
select distinct w.first_name, d.department, w.salary, r.rating from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r on w.worker_id = r.worker_id where r.rating >= 3.00;

-- Q.7 Show the department-wise average salary of workers who have been rated 4 or higher.
select distinct d.department, avg(w.salary) as avg_sal from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r on w.worker_id = r.worker_id where r.rating >= 4.00 group by d.department;

-- Q.8 Display the number of workers in each department where the average salary is greater than 100,000.
select d.department, count(w.worker_id) from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id group by d.department having avg(w.salary) > 100000;

-- Q.9 Get the list of workers who joined before 2015, along with their department names.
select w.*, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id where w.joining_date < "2015-01-01 09:00:00";

-- Q.10 Write an SQL query to fetch data on who joined in 2014-02.
select w.*, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id where w.joining_date between "2014-02-01 09:00:00" and "2014-02-28 09:00:00";

-- Q.11 Find the workers hired in the 80s means (1980 to 1989)
select w.*, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id where w.joining_date between "1980-01-01 09:00:00" and "1989-12-31 09:00:00";

-- Q.12 Display the total number of ratings for each worker and their respective department.
select w.worker_id, concat(first_name, " ", last_name), d.department, count(r.rating) as num_of_rating from db_task_29.tbl_worker as w left join db_task_29.tbl_department as d on w.department_id = d.department_id left join db_task_29.tbl_worker_rating as r on w.worker_id = r.worker_id group by d.department, w.worker_id;

-- Q.13 Show the workers whose salary is greater than or equal to 500,000 along with their department.
select w.*, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id where w.salary >= 500000;

-- Q.14 Find the number of workers in each department with a rating of less than 3.
select d.department, count(w.worker_id) from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r on r.worker_id = w.worker_id where r.rating <= 3.00 group by d.department;

-- Q.15 Retrieve the department and average rating for workers in each department.
select d.department, avg(r.rating) as avg_rating from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r on r.worker_id = w.worker_id group by d.department;

-- Q.16 Display the department names where the total salary is more than 1,000,000
select d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id group by department having sum(w.salary) > 1000000;

-- Q.17 Get the workers who have a rating of 1 and their department name.
select distinct w.*, r.rating, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r where r.rating = 1.00 order by w.worker_id;

-- Q.18 Write an SQL query to get the count of workers joining year wise.
select year(w.joining_date) as joining_year, count(w.worker_id) from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id group by joining_year;

-- Q.19 Write an SQL query to fetch data whose joining in the month of February
select * from db_task_29.tbl_worker where month(joining_date) = 2;

-- Q.20 Find the workers who joined the company after the 15th date.
select * from db_task_29.tbl_worker where day(joining_date) > 15;

-- Q.21 Find the average salary of workers who have been rated 5 in each department.
select avg(w.salary), d.department from db_task_29.tbl_worker as w left join db_task_29.tbl_department as d on w.department_id = d.department_id left join db_task_29.tbl_worker_rating as r on w.worker_id = r.worker_id where r.rating = 5.00 group by d.department;

-- Q.22 List the departments where the number of workers with a rating of 4 or more exceeds 3.
select d.department, count(w.worker_id) from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r where r.rating > 4.00 group by department having count(w.worker_id) > 30;

-- Q.23 Show the workers who have a salary greater than 200,000 and were rated 3 or higher.
select distinct w.*, r.rating from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r where r.rating > 3.00 and salary > 200000;

-- Q.24 Retrieve the department name and the total salary of workers in that department where the average rating is below 3.
select d.department, sum(w.salary) from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r where r.rating < 3.00 group by d.department;

-- Q.25 Display the departments with more than 2 workers who have been rated 2 or higher.
select d.department, count(distinct w.worker_id) as worker_count from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r where rating > 2.00 group by d.department having count(distinct w.worker_id) = 2;

-- Q.26 Get the department-wise count of workers who joined before 2014.
select count(w.worker_id) as worker_joined_before_2014, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id where year(w.joining_date) < 2014 group by d.department;

-- Q.27 Show the department-wise average salary of workers who have a rating of 3 or more.
select avg(w.salary), d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r on w.worker_id = r.worker_id where rating > 3.00 group by d.department;

-- Q.28 List the departments where the total salary of workers exceeds the department’s average salary.
select w.*, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id where w.salary > (SELECT AVG(w1.salary) FROM db_task_29.tbl_worker AS w1 WHERE w1.department_id = w.department_id);

-- Q.29 Show the department name along with the average joining date of workers in each department.
select d.department, avg(joining_date) as avg_date from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id group by d.department;

-- Q.30 Retrieve the department-wise count of workers who have been rated exactly 4.
select d.department, count(w.worker_id) as count_worker_id from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r on w.worker_id = r.worker_id where rating = 4.00 group by d.department;

-- Q.31 Display the department-wise count of workers whose salary is below 100,000.
select d.department, count(w.worker_id) as count_worker_id from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id where salary < 100000 group by d.department;

-- Q.32 Get the total number of workers in each department with a salary greater than 150,000.
select count(w.worker_id) as total_workers, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id where salary > 150000 group by d.department;

-- Q.33 List the departments that have workers with the highest salary greater than 300,000.
select max(w.salary) as max_salary, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id group by d.department having max_salary > 300000;

-- Q.34 Show the departments with workers who have an average rating of exactly 2.
with new_tbl as(
select avg(r.rating) as avg_rating, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department 
as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r on r.worker_id = w.worker_id 
group by d.department)

select w.*, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department 
as d on w.department_id = d.department_id inner join new_tbl as n on n.department = d.department 
where n.avg_rating > 2.00;

-- Q.35 Get the departments where the average rating is less than 3 and total salary is greater than 1,000,000.
select avg(r.rating) as avg_rating, d.department from db_task_29.tbl_worker as w inner join db_task_29.tbl_department 
as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r on r.worker_id = w.worker_id 
group by d.department having sum(w.salary) > 1000000 and avg_rating < 3.00;

-- Q.36 Retrieve the workers who have been rated 1 or 2 and their department names.
select distinct w.*, d.department, r.rating from db_task_29.tbl_worker as w inner join db_task_29.tbl_department 
as d on w.department_id = d.department_id inner join db_task_29.tbl_worker_rating as r on r.worker_id = w.worker_id where r.rating = 1.00  or r.rating = 2.00;

-- Q.37Find the department with the highest total salary..
select d.department, sum(w.salary)as total_salary from db_task_29.tbl_worker as w inner join db_task_29.tbl_department 
as d on w.department_id = d.department_id group by d.department order by total_salary desc limit 1;

-- Q.38 Find the department with the lowest average rating, excluding departments with no ratings..
select d.department as department_name, avg(r.rating) as avg_rating
from db_task_29.tbl_worker as w
inner join db_task_29.tbl_worker_rating as r ON w.worker_id = r.worker_id
inner join db_task_29.tbl_department as d ON w.department_id = d.department_id
where r.rating is not null
group by d.department
order by avg_rating asc
limit 1;

-- Q.39 Find the total salary and average rating for departments where the total salary is greater than 500,000:
select sum(w.salary) as total_salary, avg(r.rating) as avg_rating, d.department 
from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d 
on d.department_id = w.department_id inner join db_task_29.tbl_worker_rating as r 
on r.worker_id = w.worker_id group by d.department having total_salary > 500000;

-- Q.40 Get department-wise worker names using GROUP_CONCAT
select group_concat(concat(first_name, " ", last_name) order by first_name) as worker_names, d.department 
from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on w.department_id = d.department_id 
group by d.department;

-- Q.41 Get workers who joined in the last 5 years
select * from db_task_29.tbl_worker where joining_date >= date_sub(current_date(), interval 5 year);

-- Q.42 Get the number of workers who joined each year
select year(joining_date) as joining_year, count(worker_id) as worker_cnt 
from db_task_29.tbl_worker group by joining_year order by joining_year desc;

-- Q.43 Get department-wise earliest and latest joining date
select d.department, max(w.joining_date) as latest_joining_date, min(w.joining_date) as earliest_join_date 
from db_task_29.tbl_worker as w inner join db_task_29.tbl_department as d on d.department_id = w.department_id 
group by d.department;

-- Q.44 Get workers who have been in the company for more than 10 years.
select * from db_task_29.tbl_worker where datediff(current_date(), joining_date) > 3650;
-- select * from db_task_29.tbl_worker where timestampdiff(year, joining_date, current_date()) > 10;

-- Q.45 Retrieve the workers who have a birthday today
select * from db_task_29.tbl_worker where date_format(joining_date, "%m-%d") = date_format(current_date(), "%m-%d");
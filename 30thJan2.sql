create database db_30_2;

use db_30_2;

create table tbl_employees(
	emp_id bigint primary key auto_increment,
    emp_name varchar(128),
    street_address varchar(256),
    city varchar(64),
    salary decimal(10,2),
    commission decimal(10,2),
    job varchar(128),
    hiredate date,
    dept_id bigint references tbl_dept(dept_id),
    position enum('Clerk', 'Manager', 'President', 'Salesman')
);
-- drop table tb_employees;

create table tbl_dept(
	dept_id bigint primary key auto_increment,
    dname varchar(64)
);

INSERT INTO tbl_dept (dname) VALUES 
('Analyst'), ('Salesman'), ('HR'), ('IT'), ('Finance'), ('Marketing');


INSERT INTO tbl_employees (emp_name, street_address, city, salary, commission, job, hiredate, dept_id, position) VALUES
('John Doe', '123 Main St', 'New York', 12000.00, 500.00, 'First Bank Corporation', '2023-05-12', 1, 'Manager'),
('Jane Smith', '456 Elm St', 'Los Angeles', 9500.00, 300.00, 'Global Tech Ltd', '2022-03-15', 2, 'Clerk'),
('Michael Johnson', '789 Oak St', 'Chicago', 11000.00, 700.00, 'First Bank Corporation', '2021-07-20', 3, 'President'),
('Emily Davis', '321 Pine St', 'Houston', 10500.00, 600.00, 'Global Tech Ltd', '2020-12-05', 4, 'Manager'),
('Daniel Brown', '654 Cedar St', 'Phoenix', 9800.00, 250.00, 'First Bank Corporation', '2019-06-22', 5, 'Clerk'),
('Sophia Wilson', '987 Birch St', 'San Francisco', 13500.00, 1000.00, 'Tech Solutions', '2018-11-11', 6, 'Manager'),
('Liam Martinez', '147 Spruce St', 'Miami', 8900.00, 200.00, 'Finance Corp', '2017-08-30', 1, 'Clerk'),
('Olivia Taylor', '258 Maple St', 'Dallas', 12500.00, 800.00, 'Marketing Experts', '2016-04-14', 2, 'Manager'),
('Noah White', '369 Willow St', 'Seattle', 14000.00, 1200.00, 'Sales Corp', '2015-09-18', 3, 'President'),
('Ava Harris', '753 Redwood St', 'Boston', 9700.00, 350.00, 'First Bank Corporation', '2014-07-07', 4, 'Clerk'),
('William Clark', '159 Aspen St', 'Denver', 10200.00, 450.00, 'Tech Solutions', '2013-12-29', 5, 'Manager'),
('Mia Lewis', '264 Poplar St', 'Atlanta', 9300.00, 270.00, 'Global Tech Ltd', '2012-06-15', 6, 'Clerk'),
('Ethan Walker', '375 Fir St', 'Las Vegas', 12700.00, 900.00, 'Finance Corp', '2011-03-22', 1, 'Manager'),
('Isabella Hall', '486 Hemlock St', 'Portland', 15000.00, 1300.00, 'Marketing Experts', '2010-01-10', 2, 'President'),
('James Young', '597 Palm St', 'Orlando', 8700.00, 150.00, 'Sales Corp', '2009-08-05', 3, 'Clerk'),
('Charlotte Allen', '708 Banyan St', 'Minneapolis', 11800.00, 650.00, 'Tech Solutions', '2008-04-17', 4, 'Manager'),
('Benjamin King', '819 Magnolia St', 'San Diego', 11300.00, 550.00, 'First Bank Corporation', '2007-10-12', 5, 'Clerk'),
('Amelia Scott', '930 Cypress St', 'Detroit', 12100.00, 780.00, 'Global Tech Ltd', '2006-07-30', 6, 'Manager'),
('Lucas Adams', '246 Sycamore St', 'St. Louis', 14500.00, 1100.00, 'Finance Corp', '2005-05-22', 1, 'President'),
('Harper Baker', '357 Cherry St', 'Tampa', 9400.00, 320.00, 'Marketing Experts', '2004-02-19', 2, 'Clerk'),
('Alexander Gonzalez', '468 Juniper St', 'Charlotte', 10800.00, 500.00, 'Sales Corp', '2003-12-11', 3, 'Manager'),
('Evelyn Nelson', '579 Dogwood St', 'Indianapolis', 9100.00, 230.00, 'Tech Solutions', '2002-09-25', 4, 'Clerk'),
('Mason Carter', '680 Hickory St', 'Columbus', 11500.00, 600.00, 'First Bank Corporation', '2001-07-08', 5, 'Manager'),
('Abigail Mitchell', '791 Beech St', 'Kansas City', 15500.00, 1400.00, 'Global Tech Ltd', '2000-04-16', 6, 'President'),
('Elijah Perez', '802 Alder St', 'Austin', 8900.00, 180.00, 'Finance Corp', '1999-02-01', 1, 'Clerk'),
('Elizabeth Roberts', '913 Sassafras St', 'Memphis', 13000.00, 850.00, 'Marketing Experts', '1998-11-09', 2, 'Manager'),
('Daniel Thomas', '1024 Mulberry St', 'Louisville', 9600.00, 400.00, 'Sales Corp', '1997-08-24', 3, 'Clerk'),
('Sofia Hernandez', '1135 Black Oak St', 'Oklahoma City', 11900.00, 720.00, 'Tech Solutions', '1996-05-11', 4, 'Manager'),
('Matthew Sanchez', '1246 White Oak St', 'Raleigh', 10600.00, 480.00, 'First Bank Corporation', '1995-02-27', 5, 'Clerk'),
('Ella Ramirez', '1357 Red Oak St', 'Nashville', 13800.00, 980.00, 'Global Tech Ltd', '1994-12-15', 6, 'Manager');


INSERT INTO tbl_employees (emp_name, street_address, city, salary, commission, job, hiredate, dept_id, position) VALUES
('John Smith', '456 Main St', 'New Angeles', 12000.00, 500.00, 'First Bank Corporation', '2023-05-12', 1, 'Salesman'),
('Jane Doe', '123 Elm St', 'Los York', 9500.00, 300.00, 'Global Tech Ltd', '2022-03-15', 2, 'Salesman'),
('Micthell Jackson', '789 Oak St', 'California', 11000.00, 700.00, 'First Bank Corporation', '2021-07-20', 3, 'Salesman');

-- q1
select emp_name, street_address, city, salary from tbl_employees where job = "First Bank Corporation" and salary > 10000;

-- q2 since we dont have 30 dept we can do with dept_id = 3
select e.*, d.dname, d.dept_id from tbl_employees e inner join tbl_dept d on e.dept_id = d.dept_id where d.dept_id = 3;

-- 3. List the names, numbers and departments of all clerks.
select e.emp_name, e.dept_id, d.dname, e.position from tbl_employees e inner join tbl_dept d on e.dept_id = d.dept_id where position = "Clerk";

-- 4. Find the department numbers and names of employees of all departments with
-- deptno greater than 20.
select dept_id, emp_name from tbl_employees where dept_id > 2;

select count(*) as emp_cnt, e.dept_id, d.dname from tbl_employees e 
inner join tbl_dept d on e.dept_id = d.dept_id 
group by dept_id,d.dname having emp_cnt > 20;

-- 5. Find employees whose commission is greater than their salaries.
select emp_name, commission, salary from tbl_employees where commission > salary;

-- 6. Find employees whose commission is greater than 60 % of their salaries.
select emp_name, commission, salary from tbl_employees where commission > salary*0.6;

-- 7. List name, job and salary of all employees in department 20 who earn more than
-- 2000/-.
select job, emp_name, salary from tbl_employees where dept_id = 2 and salary > 2000;

-- 8. Find all salesmen in department 30 whose salary is greater than 1500/-.
select * from tbl_employees where dept_id = 3 and salary > 1500 and position = "Salesman";

-- 9. Find all employees whose designation is either manager or president.
select * from tbl_employees where position = "Manager" or position = "President";

-- 10. Find all managers who are not in department 30.
select * from tbl_employees where dept_id != 3 and position = "Manager";

-- 11. Find all the details of managers and clerks in dept 10.
select * from tbl_employees where dept_id = 1 and (position = "Manager" or position = "Clerk");

-- 12. Find the details of all the managers (in any dept) and clerks in dept 20.
select * from tbl_employees where position = "Manager" or (position = "Clerk" and dept_id = 2);

-- 13. Find the details of all the managers in dept. 10 and all clerks in dept 20 and all
-- employees who are neither managers nor clerks but whose salary is more than or
-- equal to 2000/-.
select * from tbl_employees where (position = "Manager" and dept_id = 1) or 
(position = "Clerk" and dept_id = 20) or 
(position not in ('Manager', 'Clerk') and salary > 2000);

-- 14. Find the names of anyone in dept. 20 who is neither manager nor clerk.
select emp_name, position from tbl_employees where dept_id = 2 and position not in ('Manager', 'Clerk');

-- 15. Find the names of employees who earn between 1200/- and 1400/-.
select emp_name from tbl_employees where salary between 1200 and 1400;

-- 16. Find the employees who are clerks, President or salesmen.
select * from tbl_employees where position in ("Clerk", "President", "Salesman");

-- 17. Find the employees who are not clerks, President or salesmen.
select * from tbl_employees where position not in ("Clerk", "President", "Salesman");

-- 18. Find the employees who do not receive commission.
select * from tbl_employees where commission = 0;

-- 19. Find the different jobs of employees receiving commission.
select distinct job from tbl_employees where commission <> 0;

-- 20. Find the employees who do not receive commission or whose commission is less
-- than 100/-.
select * from tbl_employees where commission = 0 or commission < 100;

-- 21. If all the employees not receiving commission is entitles to a bonus of Rs. 250/-
-- show the net earnings of all the employees.
select salary+(case when commission = 0 then 250 else 0 end) as net_earnings, emp_name from tbl_employees;

-- 22. Find all the employees whose total earning is greater than 2000/- .
select salary+(case when commission = 0 then 250 else commission end) as net_earnings, emp_name from tbl_employees where salary+(case when commission = 0 then 250 else commission end) > 2000;

-- 23. Find all the employees whose name begins or ends with ‘M’
select * from tbl_employees where emp_name like "M%M";

-- 24. Find all the employees whose names contain the letter ‘M’ in any case.
select * from tbl_employees where lower(emp_name) like "%m%";

-- 25. Find all the employees whose names are upto 15 character long and have letter
-- ‘R’ as 3rd character of their names.
select * from tbl_employees where emp_name like "__R____________";

-- 26. Find all the employees who were hired in the month of February (of any year).
select * from tbl_employees where month(hiredate) = 2;

-- 27. Find all the employees who were hired on last day of the month.
select * from tbl_employees where day(hiredate) = day(last_day(hiredate));

-- 28. Find all the employees who were hired more than 2 years ago.
select * from tbl_employees where hiredate < date_sub(current_date(), interval 2 year);

-- 29. Find the managers hired in the year 2003.
select * from tbl_employees where year(hiredate) = 2003 and position = "Manager";

-- 30. Display the names and jobs of all the employees separated by a space.
select concat(emp_name, "   ", job) as details from tbl_employees;

-- 31. Display the names of all the employees right aligning them to 15 characters.
select lpad(emp_name, 15, ' ') as right_aligned_name from tbl_employees;

-- 32. Display the names of all the employees padding them to the right up to 15
-- characters with ‘*’.
select rpad(emp_name, 15, '*') as left_aligned_name from tbl_employees;

-- 33. Display the names of all the employees without any leading ‘A’.
select * from tbl_employees where emp_name not like "A%";

-- 34. Display the names of all the employees without any trailing ‘R’.
select * from tbl_employees where emp_name not like "%R";

-- 35. Show the first 3 and last 3 characters of the names of all the employees.
select left(emp_name, 3) as first_3_chars, right(emp_name, 3) as last_3_char from tbl_employees;

-- 36. Display the names of all the employees replacing ‘A’ with ‘a’.
select emp_name, replace(emp_name, 'A', 'a') as new_name from tbl_employees;

-- 37. Display the names of all the employees and position where the string ‘AR’
-- occurs in the name.
select emp_name, position from tbl_employees where lower(emp_name) like "%ar%";

-- 38. Show the salary of all the employees , rounding it to the nearest Rs. 1000/-
select round(salary, -3) as rounded_salary, emp_name, salary from tbl_employees;

-- 39. Display the names, jobs and salaries of employees, sorting on job and salary.
select emp_name, job, salary from tbl_employees order by job,salary desc;

-- 40. Display the names, jobs and salaries of employees, sorting on descending order
-- of job and within job sorted on salary.
select emp_name, job, salary from tbl_employees order by job desc, salary asc;

-- 41. List the employee names, department names and salary for those employees who
-- have completed 1 year of service.
select e.emp_name, d.dname, e.salary, e.hiredate from tbl_employees e inner join tbl_dept d on d.dept_id = e.dept_id where hiredate <= date_sub(current_date(), interval 1 year);

-- 42. List the employee names, department names and hiredate for those employees
-- who have joined in 2003 . Sort your output in the order of joining date.
select e.emp_name, d.dname, e.salary, e.hiredate from tbl_employees e inner join tbl_dept d on d.dept_id = e.dept_id 
where year(hiredate) = 2003 order by hiredate;


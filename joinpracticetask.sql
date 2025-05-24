-- Active: 1747489205729@@127.0.0.1@5432@ph
--create a employee table
create table employees(
    emp_id serial primary key,
    emp_name varchar(50),
    dept_id int,
    salary decimal(10,2),
    hire_date date
);
--create a departments table
create table departments(
    dept_id serial primary key,
    dept_name varchar(50)
);
-- Inserting sample data into the departments table
insert into departments(dept_name)VALUES
    ('HR'), 
    ('Marketing'), 
    ('Finance'), 
    ('IT'), 
    ('Sales'), 
    ('Engineering'), 
    ('Customer Support'), 
    ('Administration'), 
    ('Research'), 
    ('Quality Assurance');
-- Inserting sample data into the employees table with a foreign key constraint
insert into employees(emp_name, dept_id, salary, hire_date)VALUES
    ('John Doe', 1, 60000.00, '2022-01-10'),
    ('Jane Smith', 2, 75000.50, '2021-05-22'),
    ('Bob Johnson', 3, 80000.75, '2020-11-15'),
    ('Alice Williams', 4, 90000.25, '2019-08-03'),
    ('David Lee', 5, 65000.50, '2020-03-18'),
    ('Sara Brown', 6, 70000.00, '2021-09-28'),
    ('Mike Miller', 7, 55000.75, '2022-02-05'),
    ('Emily Davis', 8, 95000.00, '2018-12-12'),
    ('Chris Wilson', 9, 72000.50, '2020-06-30'),
    ('Amy White', 10, 68000.25, '2021-11-09'),
    ('John Johnson', 1, 62000.00, '2022-01-15'),
    ('Jessica Thompson', 2, 78000.50, '2021-06-05'),
    ('Michael Harris', 3, 85000.75, '2020-11-25'),
    ('Emma Martinez', 4, 92000.25, '2019-09-15'),
    ('James Taylor', 5, 67000.50, '2020-04-08'),
    ('Sophia Anderson', 6, 72000.00, '2021-10-10'),
    ('William Jackson', 7, 56000.75, '2022-02-10'),
    ('Olivia Nelson', 8, 97000.00, '2018-12-20'),
    ('Daniel White', 9, 73000.50, '2020-07-05'),
    ('Ava Wilson', 10, 69000.25, '2021-11-15'),
    ('Matthew Brown', 1, 63000.00, '2022-01-20'),
    ('Emily Garcia', 2, 76000.50, '2021-06-15'),
    ('Christopher Allen', 3, 86000.75, '2020-12-05'),
    ('Madison Hall', 4, 93000.25, '2019-09-25'),
    ('Andrew Cook', 5, 68000.50, '2020-04-18'),
    ('Abigail Torres', 6, 73000.00, '2021-10-20'),
    ('Ethan Murphy', 7, 57000.75, '2022-02-15'),
    ('Ella King', 8, 98000.00, '2018-12-28'),
    ('Nathan Rivera', 9, 74000.50, '2020-07-15'),
    ('Mia Roberts', 10, 70000.25, '2021-11-20');

select * from employees;
select * from departments;

--task1:inner join to retrieve employee and department information
select emp_name, salary, dept_name from employees
inner join departments on employees.emp_id=departments.dept_id;

select * from employees join departments using(dept_id);

--task2: group by department with average salary
select dept_name, round(avg(salary)) from employees join departments using(dept_id) group by dept_name;

--task3: count employees in each department
select dept_name, count(*) from employees join departments using(dept_id) group by dept_name;

--task4: find the department name with the highest average salary
select dept_name as dept_salary, round(avg(salary)) as avg_salary from employees join departments using(dept_id) 
group by dept_name
order by avg(salary) DESC
limit 1;

--task5: count employees hired each year
select extract(year from hire_date) as hire_year, count(*) from employees group by hire_year;

--create an order table
create table orders(
    order_id serial primary key,
    cus_id int,
    order_date date,
    total_amount decimal(10,2)
);
-- Inserting sample data into the orders table
insert into orders(cus_id, order_date,total_amount)VALUES
    (1, '2022-01-05', 100.50),
    (2, '2022-01-07', 200.75),
    (1, '2022-01-08', 150.25),
    (3, '2022-01-10', 300.00),
    (2, '2022-01-15', 180.50),
    (3, '2022-01-20', 220.25),
    (1, '2022-01-25', 90.00),
    (2, '2022-01-28', 120.75),
    (3, '2022-02-01', 250.50),
    (1, '2022-02-05', 180.25);

--task6: find customers who have placed more than 2 orders and calculate the total amount spend by each of these customers
select * from orders;
select cus_id, count(order_id), sum(total_amount) from orders 
group by cus_id
having count(order_id)>2;

--task7: find the total amount of orders placed each month in the year 2022.
select * from orders;
select extract(month from order_date) as month, sum(total_amount) from orders group by month;

drop table departments;
drop table employees;
drop table orders;

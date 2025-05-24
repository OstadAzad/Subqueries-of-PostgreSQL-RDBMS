-- Active: 1747489205729@@127.0.0.1@5432@ph
--create employees table;
create table employees(
    emp_id serial primary key,
    emp_name varchar(50),
    dept_id int references departments(dept_id),
    salary numeric(10,2),
    hire_date date
);

--create department table
create table departments(
    dept_id serial primary key,
    dept_name varchar(50),
    location varchar(100),
    budget numeric(10,2)
);
--insert sample data for departments table
insert into departments(dept_name, location, budget)VALUES
    ('IT', 'New York', 1000000),
    ('HR', 'Chicago', 800000),
    ('Sales', 'Los Angeles', 1200000),
    ('Marketing', 'Boston', 900000);
--insert sample data for employees table
insert into employees(emp_name, dept_id, salary, hire_date)VALUES
    ('Ibrahim', 1, 75000, '2020-01-15'),
    ('Minhaz', 2, 65000, '2019-05-22'),
    ('Mizan Chy', 3, 82000, '2018-03-10'),
    ('Masud', 4, 78000, '2021-07-30'),
    ('Kazi Asif', 1, 88000, '2017-11-05'),
    ('Shakib khan', 2, 72000, '2020-09-18'),
    ('Al zabah', 3, 91000, '2019-02-14'),
    ('Sarjil', 4, 85000, '2018-08-22');
    drop table employees;
    drop table departments;

--Example 1: Basic Subquery in WHERE Clause
--Find employees who earn more than the average salary

select avg(salary) from employees; --inner query
select emp_name, salary from employees --outer query or main query
where salary>(select avg(salary) from employees);

--Example 2: Subquery with IN Operator
--Find employees in departments with budgets over $900,000
select budget from departments;
select dept_name,budget from departments where budget>900000;--inner query
select emp_name, dept_name, budget from employees join departments using(dept_id)--outer query
where budget>900000;

--Example 3: Correlated Subquery
--Find employees who earn more than the average salary in their department
select dept_name,avg(salary) from employees join departments using(dept_id) group by dept_name;
select emp_name, dept_id, salary from employees where salary>(select avg(salary)from employees join departments using(dept_id));
--or
select dept_name, avg(salary) from employees join departments on employees.dept_id=departments.dept_id group by dept_name;
select emp_name, dept_id, salary from employees where salary>(select avg(salary) from employees where dept_id=dept_id);

--Example 4: Subquery in FROM Clause
--Find the highest paid employee in each department
select emp_name from employees;
select max(salary) from employees join departments using(dept_id) group by dept_name;
select max(salary), dept_name from employees join departments using(dept_id)
group by dept_name
order by max(salary) desc;

drop table employees;
drop table departments;


--create a employees table
create table employees(
    emp_id serial primary key,
    emp_name varchar(50),
    dept_id int references departments(dept_id),
    salary int
);

--create a department table
create table departments(
    dept_id serial primary key,
    dept_name varchar(50)
);
--insert employees values on it's table
insert into employees(emp_name, dept_id, salary)VALUES
    ('Azad',  1, 40000),
    ('Rahim', 2, 45000),
    ('Karim', 3, 50000),
    ('Salma', 4, 55000),
    ('Anika', 5, 60000);
--insert departments values on it's table
insert into departments(dept_name)VALUES
    ('HR'),('IT'),('Finance'),('Math'),('Physics');

drop table departments;
drop table employees;

--Q1. Single-row Subquery
--Get employees whose salary is equal to the lowest salary.
select * from employees;
select emp_name, salary from employees 
where salary = (select min(salary) from employees);

select emp_name, salary from employees
where salary = (select max(salary) from employees);

--Q2. Multiple-row Subquery
--List employees who work in departments that exist in the departments table.
select emp_name, dept_name from employees join departments using(dept_id);
select emp_name, dept_name from employees join departments on employees.dept_id=departments.dept_id;
select emp_name from employees where dept_id in (select dept_id from departments);

--Question 1: Single-Row Subquery
--Find employees who earn more than the average salary.

select avg(salary) from employees;--inner query
select emp_name, salary from employees--outer query
where salary>(select avg(salary) from employees);

--Question 2: Multiple-Row Subquery with IN
--Find the names of employees who work in departments 'IT', 'Math', or 'Physics'.
select emp_name from employees
where dept_id in (select dept_id from departments where dept_name in ('IT', 'Math','Physics'));

--Correlated Subquery
--Find employees whose salary is greater than the average salary of their department.
select avg(salary) from employees;
select emp_name, salary from employees WHERE
salary>(select avg(salary) from employees where dept_id=employees.dept_id);

--Scalar Subquery
--Show each employee name with the highest salary in the company.
select max(salary) from employees;
select emp_name, salary,
(select max(salary) from employees) as hightest_salary from employees;

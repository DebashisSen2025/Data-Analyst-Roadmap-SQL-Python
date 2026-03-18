-- ========================================
-- SQL BASICS FOR DATA ANALYSTS
-- ========================================
-- Created by: Debashis Sen
-- Last Updated: March 2026
-- ========================================

-- SAMPLE TABLE SETUP (Run these first)
-- ========================================

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    manager_id INT
);

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(100)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE
);

CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

-- INSERT SAMPLE DATA
-- ========================================

INSERT INTO employees VALUES
(1, 'Alice Johnson', 'Sales', 60000, '2020-01-15', NULL),
(2, 'Bob Smith', 'IT', 75000, '2019-03-22', NULL),
(3, 'Charlie Brown', 'Sales', 55000, '2021-06-10', 1),
(4, 'Diana Prince', 'IT', 85000, '2018-11-05', 2),
(5, 'Eve Wilson', 'HR', 50000, '2020-09-12', NULL),
(6, 'Frank Castle', 'Sales', 62000, '2021-02-18', 1),
(7, 'Grace Lee', 'IT', 90000, '2017-05-30', 2),
(8, 'Henry Ford', 'HR', 48000, '2022-01-20', 5);

INSERT INTO departments VALUES
(1, 'Sales', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'HR', 'Chicago');

INSERT INTO customers VALUES
(1, 'John Doe', 'john@email.com', 'New York'),
(2, 'Jane Smith', 'jane@email.com', 'Los Angeles'),
(3, 'Bob Johnson', 'bob@email.com', 'Chicago'),
(4, 'Alice Williams', 'alice@email.com', 'Houston');

INSERT INTO orders VALUES
(1, 1, 500, '2024-01-15'),
(2, 1, 750, '2024-02-20'),
(3, 2, 1000, '2024-01-10'),
(4, 3, 250, '2024-03-05'),
(5, 1, 600, '2024-03-15');

-- ========================================
-- 1. BASIC SELECT STATEMENT
-- ========================================

-- Get all employees
SELECT * FROM employees;

-- Get specific columns
SELECT name, department, salary FROM employees;

-- Get employees with alias
SELECT name AS employee_name, salary AS annual_salary FROM employees;

-- ========================================
-- 2. WHERE CLAUSE - FILTERING DATA
-- ========================================

-- Find employees with salary > 60000
SELECT name, salary FROM employees WHERE salary > 60000;

-- Find employees in Sales department
SELECT * FROM employees WHERE department = 'Sales';

-- Find employees hired after 2020
SELECT name, hire_date FROM employees WHERE hire_date > '2020-01-01';

-- Multiple conditions (AND)
SELECT name, salary FROM employees 
WHERE department = 'IT' AND salary > 80000;

-- Multiple conditions (OR)
SELECT name, department FROM employees 
WHERE department = 'Sales' OR department = 'IT';

-- Using IN operator
SELECT name FROM employees 
WHERE department IN ('Sales', 'IT');

-- Using BETWEEN
SELECT name, salary FROM employees 
WHERE salary BETWEEN 50000 AND 70000;

-- ========================================
-- 3. ORDER BY - SORTING RESULTS
-- ========================================

-- Sort by salary (ascending)
SELECT name, salary FROM employees ORDER BY salary;

-- Sort by salary (descending)
SELECT name, salary FROM employees ORDER BY salary DESC;

-- Sort by multiple columns
SELECT name, department, salary FROM employees 
ORDER BY department, salary DESC;

-- ========================================
-- 4. AGGREGATE FUNCTIONS
-- ========================================

-- Count total employees
SELECT COUNT(*) as total_employees FROM employees;

-- Sum of all salaries
SELECT SUM(salary) as total_salary FROM employees;

-- Average salary
SELECT AVG(salary) as average_salary FROM employees;

-- Maximum salary
SELECT MAX(salary) as highest_salary FROM employees;

-- Minimum salary
SELECT MIN(salary) as lowest_salary FROM employees;

-- ========================================
-- 5. GROUP BY - AGGREGATING BY CATEGORY
-- ========================================

-- Count employees per department
SELECT department, COUNT(*) as employee_count 
FROM employees 
GROUP BY department;

-- Average salary per department
SELECT department, AVG(salary) as avg_salary 
FROM employees 
GROUP BY department;

-- Total salary budget per department
SELECT department, SUM(salary) as total_salary 
FROM employees 
GROUP BY department;

-- Employees and salary per department with order
SELECT department, COUNT(*) as emp_count, 
       AVG(salary) as avg_salary,
       MAX(salary) as max_salary
FROM employees 
GROUP BY department
ORDER BY avg_salary DESC;

-- ========================================
-- 6. HAVING CLAUSE - FILTERING GROUPS
-- ========================================

-- Departments with more than 2 employees
SELECT department, COUNT(*) as emp_count 
FROM employees 
GROUP BY department
HAVING COUNT(*) > 2;

-- Departments with average salary > 60000
SELECT department, AVG(salary) as avg_salary 
FROM employees 
GROUP BY department
HAVING AVG(salary) > 60000;

-- ========================================
-- 7. DISTINCT - REMOVE DUPLICATES
-- ========================================

-- Get unique departments
SELECT DISTINCT department FROM employees;

-- Count unique departments
SELECT COUNT(DISTINCT department) FROM employees;

-- ========================================
-- 8. LIMIT - GET TOP N RESULTS
-- ========================================

-- Get top 5 highest paid employees
SELECT name, salary FROM employees 
ORDER BY salary DESC 
LIMIT 5;

-- Get top 3 departments by average salary
SELECT department, AVG(salary) as avg_salary 
FROM employees 
GROUP BY department
ORDER BY avg_salary DESC
LIMIT 3;

-- ========================================
-- 9. REAL-WORLD EXAMPLES
-- ========================================

-- Example 1: Average salary by department (excluding HR)
SELECT department, AVG(salary) as avg_salary 
FROM employees 
WHERE department != 'HR'
GROUP BY department
ORDER BY avg_salary DESC;

-- Example 2: Count of high earners (salary > 70000) per department
SELECT department, COUNT(*) as high_earners
FROM employees
WHERE salary > 70000
GROUP BY department;

-- Example 3: Find departments with salary budget > 150000
SELECT department, SUM(salary) as salary_budget
FROM employees
GROUP BY department
HAVING SUM(salary) > 150000
ORDER BY salary_budget DESC;

-- Example 4: Employees earning more than their department average
SELECT name, department, salary 
FROM employees e1
WHERE salary > (
    SELECT AVG(salary) FROM employees e2 
    WHERE e2.department = e1.department
);

-- Example 5: Order summary by customer
SELECT c.name as customer_name, 
       COUNT(o.id) as order_count,
       SUM(o.amount) as total_spent
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- ========================================
-- 10. PRACTICE QUESTIONS - TRY THESE!
-- ========================================

-- Q1: How many employees in each department?
-- Q2: What's the average salary in the company?
-- Q3: Find the highest paid employee
-- Q4: Which department has the highest total salary budget?
-- Q5: How many employees were hired in 2021?
-- Q6: Which customers made purchases?
-- Q7: Find the customer who spent the most
-- Q8: Count employees per department with salary > 55000
-- Q9: Find departments with average salary between 50000 and 70000
-- Q10: Which employee has been with the company the longest?

-- ========================================
-- SOLUTIONS BELOW (Try without looking!)
-- ========================================

-- Q1 Solution:
SELECT department, COUNT(*) FROM employees GROUP BY department;

-- Q2 Solution:
SELECT AVG(salary) FROM employees;

-- Q3 Solution:
SELECT name, salary FROM employees ORDER BY salary DESC LIMIT 1;

-- Q4 Solution:
SELECT department, SUM(salary) FROM employees GROUP BY department ORDER BY SUM(salary) DESC LIMIT 1;

-- Q5 Solution:
SELECT COUNT(*) FROM employees WHERE YEAR(hire_date) = 2021;

-- Q6 Solution:
SELECT DISTINCT c.name FROM customers c INNER JOIN orders o ON c.id = o.customer_id;

-- Q7 Solution:
SELECT c.name, SUM(o.amount) as total FROM customers c JOIN orders o ON c.id = o.customer_id GROUP BY c.name ORDER BY total DESC LIMIT 1;

-- ========================================
-- NEXT: Move to SQL/02_SQL_Intermediate.sql
-- ========================================

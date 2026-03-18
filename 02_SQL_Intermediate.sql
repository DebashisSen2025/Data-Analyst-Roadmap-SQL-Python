-- ========================================
-- SQL INTERMEDIATE FOR DATA ANALYSTS
-- ========================================
-- Focus: JOINS, Subqueries, CASE statements
-- Created by: Debashis Sen
-- ========================================

-- ========================================
-- 1. INNER JOIN
-- ========================================

-- Get employee names with their departments
SELECT e.name, d.department_name, d.location
FROM employees e
INNER JOIN departments d ON e.department = d.department_name;

-- Get all orders with customer names
SELECT o.id, c.name, o.amount, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_date DESC;

-- Join with WHERE clause
SELECT e.name, e.salary, d.department_name
FROM employees e
INNER JOIN departments d ON e.department = d.department_name
WHERE e.salary > 60000;

-- ========================================
-- 2. LEFT JOIN (Keep all from left table)
-- ========================================

-- All customers, even those with no orders
SELECT c.name, c.email, COUNT(o.id) as order_count
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name, c.email
ORDER BY order_count DESC;

-- All employees with their managers (if exists)
SELECT e.name as employee, 
       m.name as manager,
       e.salary
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
ORDER BY e.name;

-- Customers who haven't made any purchases
SELECT c.name, c.email
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.id IS NULL;

-- ========================================
-- 3. RIGHT JOIN (Keep all from right table)
-- ========================================

-- All departments, even those with no employees
SELECT d.department_name, COUNT(e.id) as emp_count
FROM employees e
RIGHT JOIN departments d ON e.department = d.department_name
GROUP BY d.department_name;

-- ========================================
-- 4. FULL OUTER JOIN (Rare in MySQL, use UNION)
-- ========================================

-- All departments with employee count (including empty departments)
SELECT d.department_name, COUNT(e.id) as emp_count
FROM employees e
FULL OUTER JOIN departments d ON e.department = d.department_name
GROUP BY d.department_name;

-- ========================================
-- 5. MULTIPLE JOINS
-- ========================================

-- Complex join: Orders with customer and employee details
SELECT o.id as order_id,
       c.name as customer_name,
       o.amount,
       o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_date DESC;

-- Employees with their department location
SELECT e.name, 
       e.department,
       d.location,
       e.salary
FROM employees e
INNER JOIN departments d ON e.department = d.department_name
WHERE e.salary > 50000;

-- ========================================
-- 6. SUBQUERIES IN WHERE CLAUSE
-- ========================================

-- Employees earning more than average
SELECT name, salary, department
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- Employees earning more than their department average
SELECT name, salary, department
FROM employees e1
WHERE salary > (
    SELECT AVG(salary) FROM employees e2 
    WHERE e2.department = e1.department
);

-- Customers who made purchases above average order value
SELECT DISTINCT c.name, c.email
FROM customers c
WHERE c.id IN (
    SELECT customer_id FROM orders 
    WHERE amount > (SELECT AVG(amount) FROM orders)
);

-- Find departments with more than 2 employees
SELECT name, department
FROM employees
WHERE department IN (
    SELECT department FROM employees 
    GROUP BY department 
    HAVING COUNT(*) > 2
);

-- ========================================
-- 7. SUBQUERIES IN FROM CLAUSE
-- ========================================

-- Average salary by department (using subquery)
SELECT dept_name, avg_salary
FROM (
    SELECT department as dept_name, 
           AVG(salary) as avg_salary
    FROM employees
    GROUP BY department
) as dept_salaries
WHERE avg_salary > 60000;

-- Top earners per department
SELECT department, name, salary
FROM (
    SELECT department, name, salary,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rank
    FROM employees
) as ranked
WHERE rank = 1;

-- ========================================
-- 8. CASE STATEMENT - CONDITIONAL LOGIC
-- ========================================

-- Categorize employees by salary level
SELECT name, salary,
  CASE 
    WHEN salary >= 80000 THEN 'High'
    WHEN salary >= 60000 THEN 'Medium'
    ELSE 'Low'
  END as salary_category
FROM employees
ORDER BY salary DESC;

-- Bonus calculation based on department
SELECT name, salary, department,
  CASE 
    WHEN department = 'IT' THEN salary * 0.15
    WHEN department = 'Sales' THEN salary * 0.10
    WHEN department = 'HR' THEN salary * 0.08
    ELSE salary * 0.05
  END as bonus_amount
FROM employees;

-- Performance rating (using multiple conditions)
SELECT name,
  CASE 
    WHEN salary > 80000 AND department = 'IT' THEN 'Top Performer'
    WHEN salary > 70000 THEN 'Excellent'
    WHEN salary > 50000 THEN 'Good'
    ELSE 'Average'
  END as performance_rating
FROM employees;

-- ========================================
-- 9. ADVANCED JOIN EXAMPLES
-- ========================================

-- Sales by customer with order details
SELECT c.name,
       COUNT(o.id) as total_orders,
       SUM(o.amount) as total_spent,
       AVG(o.amount) as avg_order_value
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Department statistics with employee count
SELECT d.department_name,
       d.location,
       COUNT(e.id) as emp_count,
       AVG(e.salary) as avg_salary,
       MAX(e.salary) as max_salary,
       MIN(e.salary) as min_salary
FROM departments d
LEFT JOIN employees e ON d.department_name = e.department
GROUP BY d.department_name, d.location;

-- ========================================
-- 10. SELF JOIN (Employee-Manager Relationships)
-- ========================================

-- Show each employee with their manager's name
SELECT e.name as employee,
       m.name as manager,
       e.salary as emp_salary,
       m.salary as manager_salary
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- Employees earning more than their manager
SELECT e.name as employee,
       m.name as manager,
       e.salary as emp_salary,
       m.salary as manager_salary
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
WHERE e.salary > m.salary;

-- ========================================
-- 11. UNION (Combine multiple queries)
-- ========================================

-- List all people (employees and customers combined)
SELECT name, 'Employee' as type FROM employees
UNION
SELECT name, 'Customer' as type FROM customers
ORDER BY name;

-- ========================================
-- 12. PRACTICE QUESTIONS
-- ========================================

-- Q1: Get all employees with their department location
-- Q2: Find customers who never made a purchase
-- Q3: Show employees earning more than average
-- Q4: Count orders per customer (including those with 0 orders)
-- Q5: Employees with bonus amounts (15% for IT, 10% for Sales)
-- Q6: Departments with average salary > 60000
-- Q7: Find the top paid employee in each department
-- Q8: Employees earning more than their manager
-- Q9: Total sales by customer (sorted by highest first)
-- Q10: Department comparison (name, location, employee count, avg salary)

-- ========================================
-- SOLUTIONS
-- ========================================

-- Q1:
SELECT e.name, e.department, d.location
FROM employees e
LEFT JOIN departments d ON e.department = d.department_name;

-- Q2:
SELECT c.name FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.id IS NULL;

-- Q3:
SELECT name, salary FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Q4:
SELECT c.name, COUNT(o.id) as order_count
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;

-- Q5:
SELECT name, salary,
  CASE 
    WHEN department = 'IT' THEN salary * 0.15
    WHEN department = 'Sales' THEN salary * 0.10
    ELSE salary * 0.05
  END as bonus
FROM employees;

-- Q6:
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;

-- Q7:
SELECT department, name, salary
FROM employees e1
WHERE salary = (SELECT MAX(salary) FROM employees e2 WHERE e2.department = e1.department);

-- Q8:
SELECT e.name, e.salary, m.name as manager, m.salary as manager_salary
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
WHERE e.salary > m.salary;

-- Q9:
SELECT c.name, SUM(o.amount) as total_sales
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY total_sales DESC;

-- Q10:
SELECT d.department_name, d.location, COUNT(e.id) as emp_count, AVG(e.salary) as avg_salary
FROM departments d
LEFT JOIN employees e ON d.department_name = e.department
GROUP BY d.department_name, d.location;

-- ========================================
-- NEXT: Move to SQL/03_SQL_Advanced.sql
-- ========================================

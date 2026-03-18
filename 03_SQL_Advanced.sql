-- ========================================
-- SQL ADVANCED FOR DATA ANALYSTS
-- ========================================
-- Focus: Window Functions, CTEs, Performance
-- Created by: Debashis Sen
-- ========================================

-- ========================================
-- 1. WINDOW FUNCTIONS - ROW_NUMBER
-- ========================================

-- Rank employees by salary within each department
SELECT name, department, salary,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rank
FROM employees;

-- Get the top earner from each department
SELECT name, department, salary
FROM (
    SELECT name, department, salary,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rank
    FROM employees
) as ranked
WHERE rank = 1;

-- Find second highest salary
SELECT name, salary
FROM (
    SELECT name, salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) as rank
    FROM employees
) as ranked
WHERE rank = 2;

-- ========================================
-- 2. RANK AND DENSE_RANK
-- ========================================

-- Rank employees by salary (handles ties)
SELECT name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) as salary_rank
FROM employees;

-- Dense rank (no gaps in ranking)
SELECT name, salary,
       RANK() OVER (ORDER BY salary DESC) as rank,
       DENSE_RANK() OVER (ORDER BY salary DESC) as dense_rank
FROM employees;

-- Employees in top 3 salary bracket
SELECT name, salary,
       RANK() OVER (ORDER BY salary DESC) as salary_rank
FROM employees
WHERE RANK() OVER (ORDER BY salary DESC) <= 3;

-- ========================================
-- 3. RUNNING TOTAL / CUMULATIVE SUM
-- ========================================

-- Running total of order amounts
SELECT order_date, amount,
       SUM(amount) OVER (ORDER BY order_date) as running_total
FROM orders
ORDER BY order_date;

-- Running total per customer
SELECT customer_id, order_date, amount,
       SUM(amount) OVER (PARTITION BY customer_id ORDER BY order_date) as customer_running_total
FROM orders
ORDER BY customer_id, order_date;

-- Month to date sales
SELECT DATE_TRUNC('month', order_date) as month,
       order_date, amount,
       SUM(amount) OVER (PARTITION BY DATE_TRUNC('month', order_date) ORDER BY order_date) as month_total
FROM orders
ORDER BY order_date;

-- ========================================
-- 4. LAG AND LEAD (Previous and Next values)
-- ========================================

-- Compare current order with previous order per customer
SELECT customer_id, order_date, amount,
       LAG(amount) OVER (PARTITION BY customer_id ORDER BY order_date) as prev_order,
       LEAD(amount) OVER (PARTITION BY customer_id ORDER BY order_date) as next_order
FROM orders;

-- Calculate day-over-day change in sales
SELECT order_date, amount,
       LAG(amount) OVER (ORDER BY order_date) as prev_day_sales,
       amount - LAG(amount) OVER (ORDER BY order_date) as change,
       ROUND(100.0 * (amount - LAG(amount) OVER (ORDER BY order_date)) / LAG(amount) OVER (ORDER BY order_date), 2) as pct_change
FROM orders
ORDER BY order_date;

-- ========================================
-- 5. AVERAGE / MAX / MIN (Window Functions)
-- ========================================

-- Compare each employee's salary to department average
SELECT name, department, salary,
       AVG(salary) OVER (PARTITION BY department) as dept_avg_salary,
       salary - AVG(salary) OVER (PARTITION BY department) as diff_from_avg
FROM employees
ORDER BY department, salary DESC;

-- Find max salary in each department
SELECT name, department, salary,
       MAX(salary) OVER (PARTITION BY department) as max_dept_salary
FROM employees;

-- Percentage of department salary budget
SELECT name, salary, department,
       SUM(salary) OVER (PARTITION BY department) as dept_total,
       ROUND(100.0 * salary / SUM(salary) OVER (PARTITION BY department), 2) as pct_of_dept
FROM employees
ORDER BY department, salary DESC;

-- ========================================
-- 6. NTILE (Distribution into Buckets)
-- ========================================

-- Divide employees into salary quartiles
SELECT name, salary,
       NTILE(4) OVER (ORDER BY salary DESC) as salary_quartile
FROM employees;

-- Divide departments into 3 groups by average salary
SELECT department, AVG(salary) as avg_sal,
       NTILE(3) OVER (ORDER BY AVG(salary) DESC) as salary_tier
FROM employees
GROUP BY department;

-- ========================================
-- 7. COMMON TABLE EXPRESSIONS (CTE)
-- ========================================

-- Simple CTE: High earners
WITH high_earners AS (
    SELECT * FROM employees WHERE salary > 70000
)
SELECT department, COUNT(*) as high_earner_count
FROM high_earners
GROUP BY department;

-- Multiple CTEs
WITH dept_avg AS (
    SELECT department, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department
),
high_earners AS (
    SELECT * FROM employees WHERE salary > 60000
)
SELECT e.name, e.salary, da.avg_salary, e.salary - da.avg_salary as diff
FROM high_earners e
JOIN dept_avg da ON e.department = da.department
ORDER BY diff DESC;

-- ========================================
-- 8. RECURSIVE CTE (Manager Hierarchy)
-- ========================================

-- Manager hierarchy (who reports to whom)
WITH RECURSIVE org_chart AS (
    -- Base case: top management (no manager)
    SELECT id, name, manager_id, 1 as level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: direct reports
    SELECT e.id, e.name, e.manager_id, oc.level + 1
    FROM employees e
    INNER JOIN org_chart oc ON e.manager_id = oc.id
)
SELECT CONCAT(REPEAT('  ', level - 1), name) as employee_hierarchy, level
FROM org_chart
ORDER BY level, name;

-- ========================================
-- 9. COMPLEX WINDOW FUNCTION EXAMPLES
-- ========================================

-- Customer order frequency and average order value
SELECT customer_id,
       COUNT(*) OVER (PARTITION BY customer_id) as order_count,
       SUM(amount) OVER (PARTITION BY customer_id) as total_spent,
       AVG(amount) OVER (PARTITION BY customer_id) as avg_order_value,
       MAX(amount) OVER (PARTITION BY customer_id) as max_order,
       MIN(amount) OVER (PARTITION BY customer_id) as min_order
FROM orders;

-- Month-over-month sales growth
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', order_date) as month,
           SUM(amount) as monthly_total
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT month, monthly_total,
       LAG(monthly_total) OVER (ORDER BY month) as prev_month,
       monthly_total - LAG(monthly_total) OVER (ORDER BY month) as change,
       ROUND(100.0 * (monthly_total - LAG(monthly_total) OVER (ORDER BY month)) / LAG(monthly_total) OVER (ORDER BY month), 2) as pct_change
FROM monthly_sales
ORDER BY month;

-- ========================================
-- 10. PERFORMANCE OPTIMIZATION
-- ========================================

-- Bad: Multiple subqueries (SLOW)
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
AND department IN (SELECT department FROM employees GROUP BY department HAVING COUNT(*) > 2);

-- Good: CTE approach (FASTER)
WITH dept_stats AS (
    SELECT department, COUNT(*) as emp_count, AVG(salary) as avg_sal
    FROM employees
    GROUP BY department
    HAVING COUNT(*) > 2
)
SELECT e.* FROM employees e
JOIN dept_stats ds ON e.department = ds.department
WHERE e.salary > ds.avg_sal;

-- ========================================
-- 11. ADVANCED PRACTICE QUESTIONS
-- ========================================

-- Q1: Get top 2 paid employees from each department
-- Q2: Calculate month-over-month sales growth
-- Q3: Identify customers with increasing order values
-- Q4: Salary percentile for each employee
-- Q5: Running total of orders per customer
-- Q6: Employees earning more than department average
-- Q7: Department rank by average salary
-- Q8: Find gaps in salary within each department
-- Q9: Customer acquisition cohort analysis
-- Q10: Second time purchase customers

-- ========================================
-- SOLUTIONS
-- ========================================

-- Q1: Top 2 paid per department
SELECT name, department, salary
FROM (
    SELECT name, department, salary,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rank
    FROM employees
) ranked
WHERE rank <= 2;

-- Q2: Month-over-month growth
WITH monthly AS (
    SELECT DATE_TRUNC('month', order_date) as month, SUM(amount) as total
    FROM orders
    GROUP BY month
)
SELECT month, total,
       LAG(total) OVER (ORDER BY month) as prev_month,
       ROUND(100.0 * (total - LAG(total) OVER (ORDER BY month)) / LAG(total) OVER (ORDER BY month), 2) as growth_pct
FROM monthly;

-- Q3: Increasing order values
SELECT customer_id, order_date, amount,
       LAG(amount) OVER (PARTITION BY customer_id ORDER BY order_date) as prev_amount
FROM orders
WHERE amount > LAG(amount) OVER (PARTITION BY customer_id ORDER BY order_date);

-- Q4: Salary percentile
SELECT name, salary,
       PERCENT_RANK() OVER (ORDER BY salary) * 100 as salary_percentile
FROM employees;

-- Q5: Running total per customer
SELECT customer_id, order_date, amount,
       SUM(amount) OVER (PARTITION BY customer_id ORDER BY order_date) as running_total
FROM orders;

-- Q6: Above department average
SELECT name, salary, department,
       AVG(salary) OVER (PARTITION BY department) as dept_avg
FROM employees
WHERE salary > AVG(salary) OVER (PARTITION BY department);

-- Q7: Department rank by average salary
SELECT department, AVG(salary) as avg_salary,
       RANK() OVER (ORDER BY AVG(salary) DESC) as dept_rank
FROM employees
GROUP BY department;

-- Q8: Salary gaps in department
SELECT name, salary, department,
       LAG(salary) OVER (PARTITION BY department ORDER BY salary DESC) as prev_salary,
       LAG(salary) OVER (PARTITION BY department ORDER BY salary DESC) - salary as gap
FROM employees;

-- Q9: Cohort analysis (by month)
WITH cohorts AS (
    SELECT customer_id, DATE_TRUNC('month', MIN(order_date)) as cohort_month
    FROM orders
    GROUP BY customer_id
)
SELECT c.cohort_month, COUNT(DISTINCT c.customer_id) as customer_count
FROM cohorts c
GROUP BY c.cohort_month
ORDER BY c.cohort_month;

-- Q10: Second time buyers
WITH purchase_sequence AS (
    SELECT customer_id, order_date,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) as purchase_order
    FROM orders
)
SELECT DISTINCT customer_id FROM purchase_sequence
WHERE purchase_order = 2;

-- ========================================
-- NEXT: Move to Python/Python_Roadmap.md
-- ========================================

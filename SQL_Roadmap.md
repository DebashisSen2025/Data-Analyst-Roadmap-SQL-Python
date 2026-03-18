# 📊 SQL Roadmap for Data Analysts

## 🎯 Learning Objectives

By the end of this roadmap, you'll be able to:
- ✅ Write basic to advanced SQL queries
- ✅ Handle complex joins and subqueries
- ✅ Use window functions for advanced analysis
- ✅ Optimize query performance
- ✅ Answer real interview questions

---

## 📚 Level 1: SQL Basics (Week 1-2)

### What You'll Learn:
- SELECT statement
- WHERE clause
- GROUP BY & HAVING
- ORDER BY
- AGGREGATE functions (COUNT, SUM, AVG, MIN, MAX)

### Key Concepts:
```sql
-- Basic SELECT
SELECT column1, column2 FROM table_name;

-- Filter with WHERE
SELECT * FROM employees WHERE salary > 50000;

-- Aggregate with GROUP BY
SELECT department, COUNT(*) FROM employees GROUP BY department;

-- Sort results
SELECT * FROM employees ORDER BY salary DESC;
```

### Practice Topics:
1. How many employees in each department?
2. What's the average salary by department?
3. Find the highest salary employee
4. Count orders per customer

**📁 Reference File:** `01_SQL_Basics.sql`

---

## 📚 Level 2: SQL Intermediate (Week 3-4)

### What You'll Learn:
- JOINS (INNER, LEFT, RIGHT, FULL)
- Subqueries
- CASE statements
- Date functions
- String functions

### Key Concepts:
```sql
-- INNER JOIN
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id;

-- LEFT JOIN
SELECT c.name, COUNT(o.id) as order_count
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;

-- Subquery
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- CASE statement
SELECT name,
  CASE 
    WHEN salary > 100000 THEN 'High'
    WHEN salary > 50000 THEN 'Medium'
    ELSE 'Low'
  END as salary_level
FROM employees;
```

### Practice Topics:
1. Find customers who made purchases
2. Calculate total orders per customer
3. Find employees earning more than their manager
4. Categorize sales by regions

**📁 Reference File:** `02_SQL_Intermediate.sql`

---

## 📚 Level 3: SQL Advanced (Week 5-6)

### What You'll Learn:
- Window Functions (ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD)
- CTEs (Common Table Expressions)
- Complex aggregations
- Performance optimization

### Key Concepts:
```sql
-- Window Function: Running Total
SELECT date, sales,
  SUM(sales) OVER (ORDER BY date) as running_total
FROM daily_sales;

-- Window Function: Rank
SELECT name, salary,
  RANK() OVER (ORDER BY salary DESC) as salary_rank
FROM employees;

-- CTE (Common Table Expression)
WITH high_earners AS (
  SELECT * FROM employees WHERE salary > 100000
)
SELECT department, COUNT(*) from high_earners
GROUP BY department;

-- LAG and LEAD
SELECT date, sales,
  LAG(sales) OVER (ORDER BY date) as prev_day_sales,
  LEAD(sales) OVER (ORDER BY date) as next_day_sales
FROM daily_sales;
```

### Practice Topics:
1. Find the 2nd highest salary
2. Calculate month-over-month growth
3. Rank products by sales
4. Identify top N customers per region

**📁 Reference File:** `03_SQL_Advanced.sql`

---

## 🎯 Real Interview Questions (50+)

Here are actual questions asked at top companies:

### Easy (10 Questions)
1. Find duplicate rows in a table
2. Count employees per department
3. Find employees earning more than average
4. Get top 5 products by revenue
5. Calculate total sales per month

### Medium (20 Questions)
1. Find the 2nd highest salary
2. Get customers with 0 orders
3. Calculate running total
4. Find products with declining sales
5. Identify customer churn

### Hard (20 Questions)
1. Find median salary by department
2. Calculate customer lifetime value
3. Find the top 3 products per category
4. Identify seasonal trends
5. Complex multi-table joins

**📁 Complete Questions:** `Top_50_SQL_Interview_Questions.sql`

---

## 🔧 SQL Tools & Platforms

### Online Practice:
- **SQLZoo** → Best for learning
- **LeetCode** → Interview prep
- **HackerRank** → Job-ready problems
- **Mode Analytics** → Real datasets

### Local Databases:
- **SQLite** → Easy to start (no setup)
- **MySQL** → Most popular
- **PostgreSQL** → Advanced features
- **SQL Server** → Enterprise

---

## 📈 Learning Timeline

| Week | Focus | Tasks |
|------|-------|-------|
| 1-2 | Basics | Learn SELECT, WHERE, GROUP BY. Write 20 queries |
| 3-4 | Joins & Subqueries | Master JOINS. Solve 30 problems |
| 5-6 | Advanced | Learn Window Functions. Solve 20 problems |
| 7-8 | Interview Prep | Solve Top 50 questions. Practice 2x |

---

## ✅ Checklist: When You're Ready to Move to Python

- [ ] Write SELECT queries without thinking
- [ ] Comfortable with INNER, LEFT, RIGHT JOINs
- [ ] Can write subqueries
- [ ] Understand GROUP BY, HAVING, ORDER BY
- [ ] Can solve medium-level interview questions
- [ ] Know basic window functions

---

## 💡 Pro Tips

1. **Practice daily** — 30 mins of SQL daily > 5 hours once a week
2. **Use real datasets** — Don't just memorize syntax
3. **Explain your queries** — Why did you choose this approach?
4. **Optimize queries** — Write fast SQL, not just correct SQL
5. **Version control** — Save your SQL queries on GitHub

---

## 🚀 Next: Move to Python

Once you complete SQL, move to `Python/Python_Roadmap.md`

---

*Created by: Debashis Sen | Data Analyst*
*Last Updated: March 2026*

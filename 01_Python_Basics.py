# Python Basics for Data Analysts
# Run each cell in Jupyter Notebook
# Created by: Debashis Sen

# ========================================
# 1. VARIABLES AND DATA TYPES
# ========================================

# Strings
name = "John Doe"
email = "john@email.com"
print(f"Name: {name}, Email: {email}")

# Numbers
age = 25
salary = 50000.50
print(f"Age: {age}, Salary: {salary}")

# Boolean
is_manager = True
print(f"Is Manager: {is_manager}")

# Checking data types
print(type(name))  # <class 'str'>
print(type(age))  # <class 'int'>
print(type(salary))  # <class 'float'>

# ========================================
# 2. LISTS (Ordered, Mutable)
# ========================================

# Create a list
employees = ["Alice", "Bob", "Charlie", "Diana"]
print(employees)

# Access elements
print(employees[0])  # Alice
print(employees[-1])  # Diana

# List operations
employees.append("Eve")  # Add to end
print(employees)

employees.insert(2, "Frank")  # Insert at position
print(employees)

# Slicing
print(employees[0:3])  # First 3 elements
print(employees[1:])  # From index 1 to end

# List length
print(len(employees))

# Check if item exists
if "Alice" in employees:
    print("Alice is in the list")

# ========================================
# 3. DICTIONARIES (Key-Value Pairs)
# ========================================

# Create a dictionary
employee = {
    "name": "John Doe",
    "department": "Sales",
    "salary": 60000,
    "years_experience": 5
}
print(employee)

# Access values
print(employee["name"])  # John Doe
print(employee["salary"])  # 60000

# Add new key-value
employee["manager"] = "Alice"
print(employee)

# Update value
employee["salary"] = 65000
print(employee)

# Get all keys
print(employee.keys())

# Get all values
print(employee.values())

# Get all items
print(employee.items())

# ========================================
# 4. LOOPS
# ========================================

# For loop - iterate over list
print("\n--- For Loop ---")
for emp in employees:
    print(f"Employee: {emp}")

# For loop - with index
for i, emp in enumerate(employees):
    print(f"Position {i}: {emp}")

# For loop - range
for i in range(5):
    print(f"Number: {i}")

# While loop
print("\n--- While Loop ---")
count = 0
while count < 3:
    print(f"Count: {count}")
    count += 1

# Loop through dictionary
print("\n--- Dictionary Loop ---")
for key, value in employee.items():
    print(f"{key}: {value}")

# ========================================
# 5. CONDITIONAL STATEMENTS
# ========================================

salary = 55000

# If-elif-else
if salary > 70000:
    print("High salary")
elif salary > 50000:
    print("Medium salary")
else:
    print("Low salary")

# Multiple conditions
age = 30
experience = 5

if age > 25 and experience > 3:
    print("Eligible for senior role")

if salary > 60000 or years_of_service > 10:
    print("Eligible for bonus")

# ========================================
# 6. FUNCTIONS
# ========================================

# Simple function
def greet(name):
    return f"Hello, {name}!"

print(greet("Alice"))
print(greet("Bob"))

# Function with default parameter
def calculate_bonus(salary, rate=0.10):
    return salary * rate

print(calculate_bonus(60000))  # Uses default 10%
print(calculate_bonus(60000, 0.15))  # Custom 15%

# Function returning multiple values
def get_employee_stats(salary):
    bonus = salary * 0.10
    tax = salary * 0.20
    net = salary - tax
    return bonus, tax, net

bonus, tax, net = get_employee_stats(60000)
print(f"Bonus: {bonus}, Tax: {tax}, Net: {net}")

# ========================================
# 7. LISTS OF DICTIONARIES (Common in Data Analysis)
# ========================================

employees_list = [
    {"name": "Alice", "department": "Sales", "salary": 60000},
    {"name": "Bob", "department": "IT", "salary": 75000},
    {"name": "Charlie", "department": "Sales", "salary": 55000},
    {"name": "Diana", "department": "IT", "salary": 85000}
]

# Print all employees
for emp in employees_list:
    print(f"{emp['name']} - {emp['department']} - ${emp['salary']}")

# Find total salary
total_salary = sum(emp["salary"] for emp in employees_list)
print(f"\nTotal Salary: ${total_salary}")

# Find average salary
avg_salary = total_salary / len(employees_list)
print(f"Average Salary: ${avg_salary}")

# Find highest paid employee
highest_paid = max(employees_list, key=lambda x: x["salary"])
print(f"Highest Paid: {highest_paid['name']} - ${highest_paid['salary']}")

# ========================================
# 8. STRING MANIPULATION
# ========================================

text = "python is awesome"

# Convert case
print(text.upper())  # PYTHON IS AWESOME
print(text.title())  # Python Is Awesome

# Check content
print(text.startswith("python"))  # True
print(text.endswith("awesome"))  # True
print("python" in text)  # True

# Replace
new_text = text.replace("awesome", "cool")
print(new_text)  # python is cool

# Split
words = text.split()
print(words)  # ['python', 'is', 'awesome']

# Join
joined = " ".join(["Python", "is", "awesome"])
print(joined)

# ========================================
# 9. LIST COMPREHENSIONS (Important!)
# ========================================

# Traditional loop to create list
numbers = []
for i in range(1, 6):
    numbers.append(i ** 2)
print(numbers)  # [1, 4, 9, 16, 25]

# List comprehension (one line!)
squares = [i ** 2 for i in range(1, 6)]
print(squares)

# With condition
even_squares = [i ** 2 for i in range(1, 11) if i % 2 == 0]
print(even_squares)  # [4, 16, 36, 64, 100]

# Extract names from employee list
names = [emp["name"] for emp in employees_list]
print(names)

# ========================================
# 10. PRACTICE QUESTIONS
# ========================================

print("\n=== PRACTICE QUESTIONS ===")

# Q1: Create a list of 5 numbers and find the average
numbers = [10, 20, 30, 40, 50]
average = sum(numbers) / len(numbers)
print(f"Q1 - Average: {average}")

# Q2: Create a function that converts Celsius to Fahrenheit
def celsius_to_fahrenheit(celsius):
    return (celsius * 9/5) + 32

print(f"Q2 - 0°C = {celsius_to_fahrenheit(0)}°F")
print(f"Q2 - 25°C = {celsius_to_fahrenheit(25)}°F")

# Q3: Find all employees with salary > 60000
high_earners = [emp["name"] for emp in employees_list if emp["salary"] > 60000]
print(f"Q3 - High Earners: {high_earners}")

# Q4: Group employees by department
departments = {}
for emp in employees_list:
    dept = emp["department"]
    if dept not in departments:
        departments[dept] = []
    departments[dept].append(emp["name"])

print(f"Q4 - By Department: {departments}")

# ========================================
# NEXT: Go to 02_Pandas_Numpy.ipynb
# ========================================

print("\n✅ Python Basics Complete! Move to Pandas next.")

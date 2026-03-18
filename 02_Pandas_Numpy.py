# Pandas & NumPy for Data Analysts
# Working with real datasets
# Created by: Debashis Sen

import pandas as pd
import numpy as np

print("=== PANDAS & NUMPY FOR DATA ANALYSIS ===\n")

# ========================================
# 1. READING DATA
# ========================================

print("--- Reading Data ---")

# Read CSV file
df_customers = pd.read_csv('../Datasets/customers.csv')
df_orders = pd.read_csv('../Datasets/orders.csv')

print("Customers Dataset:")
print(df_customers.head())
print(f"\nShape: {df_customers.shape}")  # Rows, Columns

print("\n\nOrders Dataset:")
print(df_orders.head())

# ========================================
# 2. EXPLORING DATA
# ========================================

print("\n--- Exploring Data ---")

# Basic info
print("Data Types:")
print(df_customers.dtypes)

# Statistical summary
print("\nCustomers Statistics:")
print(df_customers.describe())

# Get column names
print("\nColumns:", df_customers.columns.tolist())

# Check for missing values
print("\nMissing Values:")
print(df_customers.isnull().sum())

# ========================================
# 3. FILTERING DATA
# ========================================

print("\n--- Filtering Data ---")

# Filter rows where amount > 500
large_orders = df_orders[df_orders['amount'] > 500]
print("Large Orders (> $500):")
print(large_orders)

# Filter by text value
completed_orders = df_orders[df_orders['status'] == 'Completed']
print(f"\nCompleted Orders: {len(completed_orders)}")

# Multiple conditions (AND)
premium_completed = df_orders[
    (df_orders['status'] == 'Completed') & 
    (df_orders['amount'] > 400)
]
print(f"\nPremium Completed Orders: {len(premium_completed)}")

# Multiple conditions (OR)
special_orders = df_orders[
    (df_orders['status'] == 'Pending') | 
    (df_orders['status'] == 'Cancelled')
]
print(f"\nNon-Completed Orders: {len(special_orders)}")

# Filter with isin()
selected_categories = df_orders[df_orders['product_category'].isin(['Electronics', 'Furniture'])]
print(f"\nElectronics & Furniture Orders: {len(selected_categories)}")

# ========================================
# 4. SELECTING COLUMNS
# ========================================

print("\n--- Selecting Columns ---")

# Select single column
customer_names = df_customers['name']
print("Customer Names:")
print(customer_names.head())

# Select multiple columns
order_summary = df_orders[['order_id', 'amount', 'order_date']]
print("\nOrder Summary:")
print(order_summary.head())

# Using iloc (position-based)
first_3_cols = df_customers.iloc[:, 0:3]
print("\nFirst 3 Columns:")
print(first_3_cols.head())

# Using loc (label-based)
specific_data = df_customers.loc[df_customers['customer_segment'] == 'Premium', ['name', 'city']]
print("\nPremium Customers:")
print(specific_data)

# ========================================
# 5. SORTING
# ========================================

print("\n--- Sorting ---")

# Sort by single column (ascending)
sorted_by_amount = df_orders.sort_values('amount')
print("Orders (Lowest to Highest Amount):")
print(sorted_by_amount[['order_id', 'amount']].head())

# Sort by single column (descending)
highest_orders = df_orders.sort_values('amount', ascending=False)
print("\nOrders (Highest to Lowest Amount):")
print(highest_orders[['order_id', 'amount']].head())

# Sort by multiple columns
multi_sort = df_orders.sort_values(['status', 'amount'], ascending=[True, False])
print("\nOrders (By Status, then Amount):")
print(multi_sort[['order_id', 'status', 'amount']].head())

# ========================================
# 6. GROUPBY - AGGREGATION
# ========================================

print("\n--- GroupBy Aggregations ---")

# Count orders per customer
orders_per_customer = df_orders.groupby('customer_id').size()
print("Orders per Customer:")
print(orders_per_customer)

# Sum amount per customer
total_spent = df_orders.groupby('customer_id')['amount'].sum()
print("\nTotal Spent per Customer:")
print(total_spent)

# Average order value
avg_order_value = df_orders.groupby('customer_id')['amount'].mean()
print("\nAverage Order Value per Customer:")
print(avg_order_value)

# Multiple aggregations
customer_stats = df_orders.groupby('customer_id')['amount'].agg(['count', 'sum', 'mean', 'max'])
print("\nCustomer Order Statistics:")
print(customer_stats)

# GroupBy with naming
order_stats = df_orders.groupby('product_category').agg({
    'amount': ['sum', 'mean', 'count'],
    'order_id': 'count'
}).round(2)
print("\nSales by Category:")
print(order_stats)

# ========================================
# 7. CREATING NEW COLUMNS
# ========================================

print("\n--- Creating New Columns ---")

# Simple calculation
df_orders['discount'] = df_orders['amount'] * 0.1
df_orders['final_amount'] = df_orders['amount'] - df_orders['discount']
print("Orders with Discount:")
print(df_orders[['order_id', 'amount', 'discount', 'final_amount']].head())

# Using conditions (similar to SQL CASE)
df_orders['order_size'] = pd.cut(
    df_orders['amount'],
    bins=[0, 200, 600, float('inf')],
    labels=['Small', 'Medium', 'Large']
)
print("\nOrders with Size Category:")
print(df_orders[['order_id', 'amount', 'order_size']].head())

# Extract from datetime
df_orders['order_month'] = pd.to_datetime(df_orders['order_date']).dt.month
df_orders['order_year'] = pd.to_datetime(df_orders['order_date']).dt.year
print("\nOrders with Date Extraction:")
print(df_orders[['order_id', 'order_date', 'order_month', 'order_year']].head())

# ========================================
# 8. MERGING DATASETS
# ========================================

print("\n--- Merging Datasets ---")

# Left join (all from left table)
merged = df_orders.merge(df_customers, left_on='customer_id', right_on='customer_id', how='left')
print("Orders with Customer Info:")
print(merged[['order_id', 'amount', 'name', 'city']].head())

# Inner join (only matching records)
inner_merged = df_orders.merge(df_customers, on='customer_id', how='inner')
print(f"\nInner Join Results: {len(inner_merged)} rows")

# ========================================
# 9. HANDLING MISSING VALUES
# ========================================

print("\n--- Handling Missing Values ---")

# Create sample data with missing values
df_with_missing = pd.DataFrame({
    'employee_id': [1, 2, 3, 4, 5],
    'name': ['Alice', 'Bob', np.nan, 'Diana', 'Eve'],
    'salary': [60000, 75000, 65000, np.nan, 55000]
})

print("Data with Missing Values:")
print(df_with_missing)

# Count missing
print("\nMissing Values Count:")
print(df_with_missing.isnull().sum())

# Remove rows with any missing value
cleaned = df_with_missing.dropna()
print("\nAfter Removing Missing:")
print(cleaned)

# Fill missing values
filled = df_with_missing.fillna({
    'name': 'Unknown',
    'salary': df_with_missing['salary'].mean()
})
print("\nAfter Filling Missing:")
print(filled)

# Forward fill (use previous value)
filled_forward = df_with_missing.fillna(method='ffill')
print("\nAfter Forward Fill:")
print(filled_forward)

# ========================================
# 10. HANDLING DUPLICATES
# ========================================

print("\n--- Handling Duplicates ---")

# Create data with duplicates
df_duplicates = pd.DataFrame({
    'customer_id': [1, 1, 2, 2, 3],
    'order_amount': [100, 100, 200, 200, 300]
})

print("Data with Duplicates:")
print(df_duplicates)

# Find duplicates
print("\nDuplicate Rows:")
print(df_duplicates[df_duplicates.duplicated()])

# Remove duplicates
unique = df_duplicates.drop_duplicates()
print("\nAfter Removing Duplicates:")
print(unique)

# ========================================
# 11. NUMPY OPERATIONS
# ========================================

print("\n--- NumPy Operations ---")

# Create arrays
numbers = np.array([10, 20, 30, 40, 50])
print(f"Array: {numbers}")
print(f"Mean: {numbers.mean()}")
print(f"Std Dev: {numbers.std()}")
print(f"Sum: {numbers.sum()}")
print(f"Max: {numbers.max()}")

# 2D array operations
matrix = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
])
print(f"\nMatrix:\n{matrix}")
print(f"Mean: {matrix.mean()}")
print(f"Sum of rows: {matrix.sum(axis=1)}")
print(f"Sum of columns: {matrix.sum(axis=0)}")

# Element-wise operations
result = numbers * 2
print(f"\nNumbers * 2: {result}")

result = numbers[numbers > 25]  # Boolean indexing
print(f"Numbers > 25: {result}")

# ========================================
# 12. PRACTICE QUESTIONS
# ========================================

print("\n=== PRACTICE QUESTIONS ===")

# Q1: Total sales per category
sales_by_category = df_orders.groupby('product_category')['amount'].sum().sort_values(ascending=False)
print(f"Q1 - Sales by Category:\n{sales_by_category}\n")

# Q2: Average order value
avg_order = df_orders['amount'].mean()
print(f"Q2 - Average Order Value: ${avg_order:.2f}\n")

# Q3: Top 3 customers by total spending
top_customers = df_orders.groupby('customer_id')['amount'].sum().nlargest(3)
print(f"Q3 - Top 3 Customers:\n{top_customers}\n")

# Q4: Orders per status
status_count = df_orders['status'].value_counts()
print(f"Q4 - Orders by Status:\n{status_count}\n")

# Q5: Completed orders in Electronics
electronics_completed = df_orders[
    (df_orders['product_category'] == 'Electronics') &
    (df_orders['status'] == 'Completed')
]
print(f"Q5 - Completed Electronics Orders: {len(electronics_completed)}\n")

# ========================================
# NEXT: Go to 03_Data_Cleaning.py
# ========================================

print("✅ Pandas & NumPy Complete! Move to Data Cleaning next.")

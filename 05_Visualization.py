# Data Visualization for Data Analysts
# Create stunning charts and dashboards
# Created by: Debashis Sen

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
import plotly.graph_objects as go

# Load data
df_orders = pd.read_csv('../Datasets/orders.csv')
df_customers = pd.read_csv('../Datasets/customers.csv')

print("=== DATA VISUALIZATION TUTORIAL ===\n")

# ========================================
# 1. MATPLOTLIB - BASIC CHARTS
# ========================================

print("Creating Matplotlib Charts...\n")

# Setup figure size
plt.figure(figsize=(12, 4))

# 1.1 Line Plot
plt.subplot(1, 3, 1)
daily_sales = df_orders.groupby('order_date')['amount'].sum()
plt.plot(daily_sales.index, daily_sales.values, marker='o', color='blue')
plt.title('Daily Sales Trend')
plt.xlabel('Date')
plt.ylabel('Sales ($)')
plt.xticks(rotation=45)

# 1.2 Bar Chart
plt.subplot(1, 3, 2)
category_sales = df_orders.groupby('product_category')['amount'].sum().sort_values(ascending=False)
plt.bar(category_sales.index, category_sales.values, color='green')
plt.title('Sales by Category')
plt.xlabel('Category')
plt.ylabel('Sales ($)')
plt.xticks(rotation=45)

# 1.3 Histogram
plt.subplot(1, 3, 3)
plt.hist(df_orders['amount'], bins=10, color='orange', edgecolor='black')
plt.title('Order Amount Distribution')
plt.xlabel('Amount ($)')
plt.ylabel('Frequency')

plt.tight_layout()
print("✓ Matplotlib charts created\n")

# ========================================
# 2. SEABORN - STATISTICAL VISUALIZATIONS
# ========================================

print("Creating Seaborn Charts...\n")

# 2.1 Heatmap (Correlation matrix)
plt.figure(figsize=(8, 6))
# Create numeric data for correlation
numeric_data = df_orders[['amount']].copy()
numeric_data['day'] = pd.to_datetime(df_orders['order_date']).dt.day
numeric_data['month'] = pd.to_datetime(df_orders['order_date']).dt.month

correlation = numeric_data.corr()
sns.heatmap(correlation, annot=True, cmap='coolwarm', center=0)
plt.title('Correlation Heatmap')
plt.tight_layout()
print("✓ Heatmap created\n")

# 2.2 Box Plot (Distribution comparison)
plt.figure(figsize=(10, 6))
sns.boxplot(x='product_category', y='amount', data=df_orders)
plt.title('Order Amount Distribution by Category')
plt.xlabel('Category')
plt.ylabel('Amount ($)')
plt.xticks(rotation=45)
plt.tight_layout()
print("✓ Box plot created\n")

# 2.3 Count Plot
plt.figure(figsize=(10, 6))
sns.countplot(x='status', data=df_orders, palette='Set2')
plt.title('Order Count by Status')
plt.xlabel('Status')
plt.ylabel('Count')
plt.tight_layout()
print("✓ Count plot created\n")

# ========================================
# 3. PLOTLY - INTERACTIVE CHARTS
# ========================================

print("Creating Interactive Plotly Charts...\n")

# 3.1 Interactive Line Chart
daily_sales_df = df_orders.groupby('order_date')['amount'].sum().reset_index()
daily_sales_df.columns = ['date', 'sales']

fig1 = px.line(daily_sales_df, x='date', y='sales', 
               title='Daily Sales Trend (Interactive)',
               labels={'sales': 'Sales ($)', 'date': 'Date'},
               markers=True)
# Uncomment to show: fig1.show()
print("✓ Interactive line chart created\n")

# 3.2 Interactive Bar Chart
category_sales_df = df_orders.groupby('product_category')['amount'].sum().reset_index()
category_sales_df.columns = ['category', 'sales']

fig2 = px.bar(category_sales_df, x='category', y='sales',
              title='Sales by Category (Interactive)',
              color='sales',
              color_continuous_scale='Viridis')
# Uncomment to show: fig2.show()
print("✓ Interactive bar chart created\n")

# 3.3 Pie Chart
fig3 = px.pie(category_sales_df, values='sales', names='category',
              title='Sales Distribution by Category')
# Uncomment to show: fig3.show()
print("✓ Pie chart created\n")

# 3.4 Scatter Plot
df_merged = df_orders.merge(df_customers, on='customer_id')
fig4 = px.scatter(df_merged, x='amount', y='customer_id',
                  color='product_category',
                  size='amount',
                  title='Orders: Amount vs Customer',
                  hover_name='name')
# Uncomment to show: fig4.show()
print("✓ Scatter plot created\n")

# ========================================
# 4. CUSTOM MATPLOTLIB DASHBOARD
# ========================================

print("Creating Custom Dashboard...\n")

fig, axes = plt.subplots(2, 2, figsize=(15, 10))
fig.suptitle('Sales Dashboard', fontsize=16, fontweight='bold')

# Chart 1: Top customers by spending
top_customers = df_merged.groupby('name')['amount'].sum().nlargest(5)
axes[0, 0].barh(top_customers.index, top_customers.values, color='skyblue')
axes[0, 0].set_title('Top 5 Customers by Spending')
axes[0, 0].set_xlabel('Total Spent ($)')

# Chart 2: Sales by status
status_sales = df_orders.groupby('status')['amount'].sum()
axes[0, 1].pie(status_sales.values, labels=status_sales.index, autopct='%1.1f%%')
axes[0, 1].set_title('Sales Distribution by Status')

# Chart 3: Orders over time
daily_orders = df_orders.groupby('order_date').size()
axes[1, 0].plot(daily_orders.index, daily_orders.values, marker='o', linewidth=2)
axes[1, 0].set_title('Order Volume Over Time')
axes[1, 0].set_xlabel('Date')
axes[1, 0].set_ylabel('Number of Orders')
axes[1, 0].tick_params(axis='x', rotation=45)

# Chart 4: Average order value by category
avg_by_category = df_orders.groupby('product_category')['amount'].mean().sort_values(ascending=False)
axes[1, 1].bar(range(len(avg_by_category)), avg_by_category.values, color='lightcoral')
axes[1, 1].set_xticks(range(len(avg_by_category)))
axes[1, 1].set_xticklabels(avg_by_category.index, rotation=45)
axes[1, 1].set_title('Average Order Value by Category')
axes[1, 1].set_ylabel('Average Amount ($)')

plt.tight_layout()
print("✓ Custom dashboard created\n")

# ========================================
# 5. VISUALIZATION BEST PRACTICES
# ========================================

print("=== VISUALIZATION BEST PRACTICES ===\n")

print("""
1. CHOOSE THE RIGHT CHART:
   - Line: Trends over time
   - Bar: Comparing categories
   - Pie: Part-to-whole relationships
   - Scatter: Relationships between variables
   - Histogram: Distribution of single variable

2. COLORS:
   - Use colorblind-friendly palettes (viridis, colorblind)
   - Limit to 3-5 colors per chart
   - Use color to highlight important data

3. LABELS:
   - Always include title, x-label, y-label
   - Format numbers with commas (1,000)
   - Use clear, concise labels

4. SIMPLICITY:
   - Remove unnecessary elements (gridlines, borders)
   - Keep aspect ratio reasonable
   - One message per chart

5. INTERACTIVITY:
   - Use Plotly for exploring data
   - Add hover information
   - Allow zooming and panning
""")

# ========================================
# 6. SAVING CHARTS
# ========================================

print("\n=== SAVING CHARTS ===\n")

# Save matplotlib figure
plt.figure(figsize=(10, 6))
category_sales = df_orders.groupby('product_category')['amount'].sum().sort_values(ascending=False)
plt.bar(category_sales.index, category_sales.values)
plt.title('Sales by Category')
plt.ylabel('Sales ($)')
plt.tight_layout()
# plt.savefig('sales_by_category.png', dpi=300, bbox_inches='tight')
print("Matplotlib figure saved as PNG\n")

# Save Plotly figure
# fig1.write_html('dashboard.html')
print("Plotly figure saved as HTML\n")

# ========================================
# 7. PRACTICE QUESTIONS
# ========================================

print("=== PRACTICE QUESTIONS ===\n")

print("""
Q1: Create a line chart showing cumulative sales over time
Q2: Create a bar chart showing count of orders per status
Q3: Create a scatter plot with order amount vs order date
Q4: Create a dashboard with 4 different visualizations
Q5: Create an interactive Plotly dashboard with filters
""")

print("\n✅ Data Visualization Complete!")
print("Next: Build a real project combining SQL, Python, and Visualization\n")

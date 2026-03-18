# 🐍 Python Roadmap for Data Analysts

## 🎯 Learning Objectives

By the end of this roadmap, you'll be able to:
- ✅ Manipulate and clean messy datasets
- ✅ Perform exploratory data analysis (EDA)
- ✅ Create professional visualizations
- ✅ Build real-world data projects
- ✅ Write production-quality code

---

## 📚 Level 1: Python Basics (Week 1-2)

### What You'll Learn:
- Variables, data types
- Lists, tuples, dictionaries
- Loops and conditionals
- Functions
- String manipulation

### Key Concepts:
```python
# Variables and data types
name = "John"
age = 25
salary = 50000.50

# Lists and loops
employees = ["Alice", "Bob", "Charlie"]
for emp in employees:
    print(emp)

# Functions
def calculate_bonus(salary, rate=0.10):
    return salary * rate

# Dictionaries
employee = {"name": "John", "age": 25, "salary": 50000}
```

### Practice Topics:
1. Create a list of numbers and find the average
2. Write a function to convert temperatures
3. Dictionary manipulation

**📁 Reference File:** `01_Python_Basics.ipynb`

---

## 📚 Level 2: Data Manipulation with Pandas & NumPy (Week 3-4)

### What You'll Learn:
- Reading/writing CSV and Excel files
- DataFrame operations (filtering, sorting, groupby)
- Data transformation
- Merging datasets
- Handling missing values

### Key Concepts:
```python
import pandas as pd
import numpy as np

# Read CSV
df = pd.read_csv('data.csv')

# Basic operations
df.head()  # First 5 rows
df.describe()  # Statistical summary
df.info()  # Column info

# Filtering
high_salary = df[df['salary'] > 60000]

# GroupBy
dept_avg = df.groupby('department')['salary'].mean()

# Creating new columns
df['bonus'] = df['salary'] * 0.10
```

### Practice Topics:
1. Load customer data and explore it
2. Filter orders above average
3. Calculate group statistics
4. Create derived columns

**📁 Reference File:** `02_Pandas_Numpy.ipynb`

---

## 📚 Level 3: Data Cleaning & EDA (Week 5-6)

### What You'll Learn:
- Identifying and handling missing data
- Dealing with outliers
- Data type conversion
- Duplicate detection
- Exploratory data analysis techniques

### Key Concepts:
```python
# Missing values
df.isnull().sum()  # Count missing values
df.dropna()  # Remove rows with missing values
df.fillna(0)  # Fill with default value

# Outliers
Q1 = df['salary'].quantile(0.25)
Q3 = df['salary'].quantile(0.75)
IQR = Q3 - Q1
outliers = df[(df['salary'] < Q1 - 1.5*IQR) | (df['salary'] > Q3 + 1.5*IQR)]

# Data profiling
df['column'].value_counts()
df['column'].duplicated().sum()
```

### Practice Topics:
1. Handle missing values in datasets
2. Identify and remove outliers
3. Create summary statistics
4. Data quality assessment

**📁 Reference File:** `03_Data_Cleaning.ipynb`

---

## 📚 Level 4: Visualization (Week 7-8)

### What You'll Learn:
- Matplotlib basics
- Seaborn statistical plots
- Plotly interactive charts
- Best practices for data visualization

### Key Concepts:
```python
import matplotlib.pyplot as plt
import seaborn as sns

# Line plot
plt.plot(df['month'], df['sales'])

# Bar chart
df.groupby('department')['salary'].sum().plot(kind='bar')

# Histogram
plt.hist(df['salary'], bins=20)

# Scatter plot
plt.scatter(df['experience'], df['salary'])

# Seaborn heatmap
sns.heatmap(df.corr(), annot=True)
```

### Practice Topics:
1. Create sales trends visualization
2. Compare departments with bar charts
3. Build dashboard-like visualizations
4. Interactive plots with Plotly

**📁 Reference File:** `05_Visualization.ipynb`

---

## 📚 Level 5: Real Projects (Week 9-12)

### What You'll Learn:
- End-to-end analysis workflow
- Answering business questions
- Portfolio-building projects
- Presenting findings

### Available Projects:
1. **Customer Churn Analysis** — Predict customer loss
2. **Sales Analytics Dashboard** — Revenue trends
3. **Data Quality Assessment** — Profiling datasets

**📁 Reference Files:** `Projects/` folder

---

## 🔧 Python Tools & Environments

### Installation
```bash
# Install Python 3.8 or higher
# Then install required libraries:
pip install -r requirements.txt
```

### Popular IDEs
- **Jupyter Notebook** ← Best for learning
- **VS Code** ← Professional development
- **Google Colab** ← Free, cloud-based
- **PyCharm** ← Full-featured IDE

### Online Platforms
- **Kaggle** → Datasets and competitions
- **Towards Data Science** → Tutorials
- **Medium** → Data analysis articles

---

## 📊 Library Overview

| Library | Purpose | Usage |
|---------|---------|-------|
| **pandas** | Data manipulation | Read, filter, transform data |
| **numpy** | Numerical computing | Mathematical operations |
| **matplotlib** | Static plots | Basic visualizations |
| **seaborn** | Statistical plots | Beautiful statistical graphics |
| **plotly** | Interactive plots | Dashboard-ready visualizations |
| **scikit-learn** | Machine learning | Models and preprocessing |

---

## 📈 Learning Timeline

| Week | Focus | Tasks |
|------|-------|-------|
| 1-2 | Basics | Learn variables, loops, functions |
| 3-4 | Pandas | Data reading and manipulation |
| 5-6 | Cleaning | Handle missing values, outliers |
| 7-8 | Visualization | Create charts and dashboards |
| 9-10 | EDA | Full exploratory analysis |
| 11-12 | Projects | Build 2-3 complete projects |

---

## ✅ Checklist: When You're Ready to Move On

- [ ] Can read CSV files with pandas
- [ ] Comfortable with filtering and groupby operations
- [ ] Can handle missing values
- [ ] Can create bar charts, line plots, scatter plots
- [ ] Understand data types and conversions
- [ ] Completed at least one mini-project

---

## 💡 Pro Tips for Success

1. **Code along** — Don't just watch, type every example
2. **Ask questions** — Why is this output what it is?
3. **Use Jupyter** — Write notes alongside your code
4. **Practice daily** — 1 hour daily beats 5 hours once a week
5. **Build projects** — This is what employers want to see

---

## 🚀 Next Steps After Completing This Roadmap

✅ **Build Portfolio Projects**
- Create 3-5 complete analysis projects
- Share on GitHub
- Write blog posts about your findings

✅ **Move to Advanced Topics**
- Machine learning basics
- Statistical analysis
- API integration

✅ **Get a Job**
- Polish your GitHub profile
- Apply for junior analyst roles
- Network with other analysts

---

## 🔗 Helpful Resources

### Documentations
- pandas: https://pandas.pydata.org/docs/
- matplotlib: https://matplotlib.org/
- seaborn: https://seaborn.pydata.org/
- plotly: https://plotly.com/python/

### Learning Platforms
- Coursera (pandas & python courses)
- DataCamp (interactive coding)
- Real Python (tutorials)

---

## 📞 Questions?

- Check the `Resources/` folder for cheatsheets
- Look at example code in `Projects/`
- Review solutions in the notebooks

---

*Created by: Debashis Sen | Data Analyst*
*Last Updated: March 2026*

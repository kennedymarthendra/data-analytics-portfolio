# 🗄️ SQL Data Cleaning

This folder documents the SQL scripts used to clean and prepare the layoffs dataset.

The project demonstrates a structured SQL workflow for improving data quality and preparing raw data for downstream analysis.

---

# 📂 SQL Workflow

The SQL data cleaning process consists of several stages:

## 1️⃣ Remove Duplicate Records

Duplicate rows were identified using SQL window functions and removed to ensure data uniqueness.

---

## 2️⃣ Standardize Data

Text values were standardized to improve consistency across the dataset.

Examples include:

- Removing unnecessary whitespace
- Standardizing company names
- Standardizing industry names
- Standardizing country names

---

## 3️⃣ Handle Missing Values

Missing and blank values were identified and addressed using SQL techniques.

Examples include:

- Replacing blank values with NULL
- Updating missing values where appropriate
- Validating incomplete records

---

## 4️⃣ Convert Data Types

Columns were converted into appropriate data types to improve data integrity and support future analysis.

Examples include:

- Date conversion
- Text formatting
- Data validation

---

## 5️⃣ Remove Unnecessary Columns

Temporary columns used during the cleaning process were removed to produce the final cleaned dataset.

---

# 🛠️ SQL Techniques Used

The SQL scripts demonstrate the use of various SQL techniques, including:

- SELECT
- UPDATE
- DELETE
- ALTER TABLE
- CREATE TABLE
- Common Table Expressions (CTE)
- ROW_NUMBER()
- PARTITION BY
- TRIM()
- DISTINCT
- CASE WHEN
- NULL Handling
- Data Type Conversion

---

# 📈 SQL Data Cleaning Workflow

```text
Raw Dataset
      │
      ▼
Identify Duplicates
      │
      ▼
Remove Duplicates
      │
      ▼
Standardize Data
      │
      ▼
Handle Missing Values
      │
      ▼
Convert Data Types
      │
      ▼
Remove Unnecessary Columns
      │
      ▼
Clean Dataset
      │
      ▼
Ready for Analysis
```

---

# 🚀 Business Value

Although this project focuses on data cleaning rather than business analysis, it demonstrates one of the most critical stages of the data analytics lifecycle.

By improving data quality through SQL, the project ensures that downstream reporting, visualization, and analytical processes are built on accurate, consistent, and reliable data.

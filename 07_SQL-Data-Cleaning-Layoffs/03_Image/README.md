# 🖼️ SQL Data Cleaning Workflow

This folder documents each step of the SQL data cleaning process through screenshots of the SQL implementation and the final cleaned dataset.

---

## 1. Create Staging Table

Creates a staging table to preserve the original dataset before performing any data cleaning operations.

![Create Staging Table](01-create-staging-table.png)

---

## 2. Remove Duplicates

Identifies duplicate records using `ROW_NUMBER()` and removes redundant observations while preserving valid data.

![Remove Duplicates](02-remove-duplicates.png)

---

## 3. Standardize Data

Standardizes inconsistent values by trimming whitespace, correcting category names, and formatting textual fields.

![Standardize Data](03-standardize-data.png)

---

## 4. Handle Missing Values

Fills missing values by leveraging existing records from the same company and location to improve data completeness.

![Handle Missing Values](04-handle-missing-values.png)

---

## 5. Remove Unnecessary Records

Removes records with insufficient information and drops temporary columns created during the cleaning process.

![Remove Unnecessary Records](05-remove-unnecessary-records.png)

---

## 6. Final Clean Dataset

Displays the cleaned dataset after completing all preprocessing steps, making it ready for exploratory analysis and visualization.

![Final Clean Dataset](06-final-clean-dataset.png)

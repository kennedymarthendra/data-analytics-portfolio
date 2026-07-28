# 🍕 Pizza Sales Analysis Dashboard

> End-to-end data analytics project using **MySQL** and **Power BI** to analyze pizza sales performance, customer purchasing behavior, and product performance through interactive business intelligence dashboards.

---

## 📌 Project Overview

This project analyzes one year of pizza sales transaction data to uncover actionable business insights related to revenue performance, customer purchasing behavior, product performance, and sales trends.

The analysis begins with **MySQL** for data exploration and business query analysis, followed by **Power BI** to develop an interactive dashboard that enables dynamic business monitoring and supports data-driven decision making.

---

## 🎯 Business Problem

Although the restaurant collected daily sales transactions, the data was stored in multiple tables and lacked a centralized reporting solution. As a result, management struggled to answer important business questions such as:

- Which pizzas generate the highest revenue?
- Which products consistently underperform?
- What are the busiest sales periods?
- Which pizza categories and sizes contribute the most revenue?
- How do customer purchasing patterns change over time?

To address these challenges, an interactive reporting dashboard was developed to transform raw transactional data into meaningful business insights.

---

## 🎯 Project Objectives

- Analyze overall sales performance.
- Evaluate customer purchasing behavior.
- Identify top and bottom-performing products.
- Analyze sales contribution by category and pizza size.
- Build an interactive dashboard for business monitoring.

---

## 🛠️ Tools & Technologies

| Category | Tools |
|-----------|-------|
| Database | MySQL |
| Visualization | Power BI |
| Data Modeling | DAX |
| Data Source | Microsoft Excel |

---

# 📂 Repository Structure

```
Pizza-Sales-Analysis
│
├── README.md
│
├── 01_Data
│   ├── README.md
│   └── pizza_sales_dataset.xlsx
│
├── 02_SQL
│   ├── README.md
│   └── Pizza Sales Analysis.sql
│
├── 03_PowerBI
│   ├── README.md
│   └── Pizza Sales Analysis Dashboard.pbix
│
└── 04 - Image
    ├── README.md
    ├── dashboard-home.png
    └── dashboard-product-performance.png
```

---

# 📊 Dashboard Preview

## Dashboard 1 — Sales Performance Overview

![Sales Performance Dashboard](04%20-%20Image/dashboard-home.png)

### Dashboard Features

- Executive KPI Cards
- Daily Sales Trend
- Monthly Sales Trend
- Revenue by Pizza Category
- Revenue by Pizza Size
- Total Quantity Sold
- Interactive Date Filter
- Interactive Category Filter

### Key Performance Indicators

| KPI | Value |
|------|---------:|
| Total Revenue | $817.86K |
| Total Orders | 21,350 |
| Total Pizzas Sold | 49,574 |
| Average Order Value | $38.31 |
| Average Pizzas per Order | 2.32 |

### Business Insights

- Generated **$817.86K** in total revenue.
- Processed **21,350** customer orders.
- Sold **49,574** pizzas during the analysis period.
- Friday recorded the highest customer order volume.
- July achieved the highest monthly sales.
- Classic pizzas represented approximately **26.9%** of total sales volume.
- Large-size pizzas generated approximately **45.9%** of total revenue.

---

## Dashboard 2 — Product Performance Analysis

![Product Performance Dashboard](04%20-%20Image/dashboard-product-performance.png)

### Dashboard Features

Top & Bottom Performance Analysis based on:

- Revenue
- Quantity Sold
- Total Orders

Interactive filtering allows users to compare product performance across different categories and time periods.

### Business Insights

- Thai Chicken Pizza and Barbecue Chicken Pizza generated the highest revenue (approximately **$43K** each).
- Classic Deluxe Pizza achieved the highest quantity sold and order frequency.
- Brie Carre Pizza consistently ranked as the lowest-performing product across all sales metrics.
- The dashboard enables stakeholders to quickly distinguish between high-performing and underperforming menu items.

---

# 🗄️ SQL Analysis

The sales dataset was explored using MySQL to answer key business questions.

### SQL Skills Demonstrated

- Aggregate Functions
- GROUP BY
- ORDER BY
- CASE WHEN
- Date Functions
- Ranking Functions
- Sales Aggregation

### Business Questions Answered

- What is the total revenue?
- Which pizzas generate the highest revenue?
- Which products perform the worst?
- Which day records the highest number of orders?
- Which month generates the highest sales?
- Which pizza category contributes the most revenue?
- Which pizza size generates the highest revenue?

---

# 📈 Power BI Development

The interactive dashboard was developed after completing SQL analysis.

### DAX Measures

- Total Revenue
- Total Orders
- Total Pizzas Sold
- Average Order Value
- Average Pizzas per Order

### Dashboard Capabilities

- Interactive KPI Monitoring
- Dynamic Filtering
- Drill-down Analysis
- Product Performance Comparison
- Executive Reporting
- Business Trend Analysis

---

# 💼 Business Value

This project demonstrates how SQL and Power BI can be integrated to transform raw transactional data into an interactive reporting solution that helps businesses:

- Monitor sales performance.
- Identify growth opportunities.
- Optimize product offerings.
- Understand customer purchasing behavior.
- Support strategic business decisions through data.

---

# 🚀 Skills Demonstrated

### SQL

- Data Exploration
- Data Aggregation
- Business Query Analysis
- Ranking Analysis
- Date Functions

### Power BI

- Data Modeling
- DAX
- Interactive Dashboard Development
- KPI Design
- Business Intelligence Reporting

### Business Analytics

- Sales Performance Analysis
- Product Performance Analysis
- Customer Behavior Analysis
- Trend Analysis
- Executive Dashboard Development

# 🛒 E-Commerce Sales & Customer Insights Analytics

An end-to-end SQL data modeling and analytics project built using **PostgreSQL**. This repository demonstrates relational schema design, data insertion, and analytical queries to extract operational e-commerce metrics.

---

## 📊 Business Problem & Objectives
The goal of this project is to model an e-commerce platform's core data structure and answer key business questions:
1. **Customer Lifetime Value (CLV):** Who are our top revenue-generating customers?
2. **Product Category Performance:** Which product categories drive the highest sales volume and gross revenue?
3. **Monthly Revenue Trends:** How does revenue fluctuate month-over-month, and what is the average order value (AOV)?

---

## 🗄️ Relational Database Schema
The database consists of 4 normalized relational tables:
- **`customers`** (Stores user profiles and signup dates)
- **`products`** (Catalog listing items, categories, and unit pricing)
- **`orders`** (Header records for customer purchases)
- **`order_items`** (Line-item details linking individual items to orders)

---

## 🔍 Key SQL Techniques Applied
- **DDL & DML:** Table creation with Foreign Keys, `PRIMARY KEY` constraints, and sample data population.
- **Multi-Table JOINs:** Combining customer, transaction, and item tables to assemble composite reporting views.
- **Aggregations & Grouping:** Utilizing `SUM()`, `COUNT()`, and `GROUP BY` to evaluate metrics.
- **Common Table Expressions (CTEs):** Structuring multi-stage queries for monthly summary metrics and Average Order Value calculations.

---

## 🚀 How to Run
1. Open **pgAdmin** or connected terminal client.
2. Create a target database:
   ```sql
   CREATE DATABASE ecommerce_analytics;

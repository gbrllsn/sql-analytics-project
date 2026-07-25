-- ============================================================
-- Project: E-Commerce Sales & Customer Insights Analytics
-- Author: Sean Gabrielle Torres
-- Database Engine: PostgreSQL
-- Description: Schema creation, dummy data setup, and data 
--              analysis queries for e-commerce performance.
-- ============================================================

-- ------------------------------------------------------------
-- STEP 1: SCHEMA CREATION
-- ------------------------------------------------------------

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    signup_date DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    price_per_unit DECIMAL(10, 2)
);

-- ------------------------------------------------------------
-- STEP 2: DATA INSERTION
-- ------------------------------------------------------------

INSERT INTO customers (first_name, last_name, email, signup_date) VALUES
('John', 'Doe', 'john.doe@email.com', '2025-01-15'),
('Jane', 'Smith', 'jane.smith@email.com', '2025-02-10'),
('Alex', 'Johnson', 'alex.j@email.com', '2025-03-01'),
('Maria', 'Santos', 'maria.santos@email.com', '2025-03-12');

INSERT INTO products (product_name, category, price) VALUES
('Mechanical Keyboard', 'Electronics', 89.99),
('Wireless Mouse', 'Electronics', 29.99),
('Ergonomic Chair', 'Furniture', 199.99),
('Coffee Mug', 'Home', 12.50);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-04-01', 119.98),
(2, '2025-04-02', 199.99),
(1, '2025-04-10', 29.99),
(3, '2025-04-15', 102.49);

INSERT INTO order_items (order_id, product_id, quantity, price_per_unit) VALUES
(1, 1, 1, 89.99),
(1, 2, 1, 29.99),
(2, 3, 1, 199.99),
(3, 2, 1, 29.99),
(4, 1, 1, 89.99),
(4, 4, 1, 12.50);

-- ------------------------------------------------------------
-- STEP 3: ANALYTICAL QUERIES (INSIGHTS)
-- ------------------------------------------------------------

-- Query 1: Top 3 Spending Customers (Customer Lifetime Value)
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 3;

-- Query 2: Revenue Generated per Product Category
SELECT 
    p.category,
    SUM(oi.quantity * oi.price_per_unit) AS total_revenue,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Query 3: Monthly Sales Summary using CTE (Common Table Expression)
WITH monthly_summary AS (
    SELECT 
        TO_CHAR(order_date, 'YYYY-MM') AS sales_month,
        COUNT(order_id) AS total_orders,
        SUM(total_amount) AS gross_revenue
    FROM orders
    GROUP BY sales_month
)
SELECT 
    sales_month,
    total_orders,
    gross_revenue,
    ROUND(gross_revenue / total_orders, 2) AS avg_order_value
FROM monthly_summary;

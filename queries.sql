-- 1. Find customers who have never ordered
SELECT c.customer_id, c.customer_name  
FROM Customers c  
LEFT JOIN Orders o ON c.customer_id = o.customer_id  
WHERE o.order_id IS NULL;

-- 2. Average Price per Dish
SELECT restaurant_id, AVG(price) AS avg_dish_price  
FROM Dishes  
GROUP BY restaurant_id;

-- 3. Find the Top Restaurant in Terms of Number of Orders for a Given Month
SELECT r.restaurant_name, COUNT(o.order_id) AS total_orders  
FROM Orders o  
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id  
WHERE DATE_FORMAT(o.order_date, '%Y-%m') = '2024-02'  
GROUP BY r.restaurant_name  
ORDER BY total_orders DESC  
LIMIT 1;

-- 4. Restaurants with Monthly Sales Greater than X
SELECT o.restaurant_id, r.restaurant_name, SUM(o.total_price) AS total_sales  
FROM Orders o  
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id  
WHERE DATE_FORMAT(o.order_date, '%Y-%m') = '2024-02'  
GROUP BY o.restaurant_id, r.restaurant_name  
HAVING total_sales > 10000;

-- 5. Show All Orders with Order Details for a Particular Customer in a Particular Date Range
SELECT o.order_id, o.order_date, d.dish_name, oi.quantity, oi.price_per_unit  
FROM Orders o  
JOIN Order_Items oi ON o.order_id = oi.order_id  
JOIN Dishes d ON oi.dish_id = d.dish_id  
WHERE o.customer_id = 1  
AND o.order_date BETWEEN '2024-02-01' AND '2024-02-10';

-- 6. Find Restaurants with Max Repeated Customers
SELECT o.restaurant_id, r.restaurant_name, COUNT(DISTINCT o.customer_id) AS unique_customers  
FROM Orders o  
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id  
GROUP BY o.restaurant_id, r.restaurant_name  
ORDER BY unique_customers DESC  
LIMIT 1;

-- 7. Month-over-Month Revenue Growth of Swiggy
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,  
       SUM(total_price) AS revenue,  
       LAG(SUM(total_price)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) AS prev_month_revenue,  
       (SUM(total_price) - LAG(SUM(total_price)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m'))) /  
       LAG(SUM(total_price)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) * 100 AS revenue_growth  
FROM Orders  
GROUP BY month;

-- 8. Find Customer's Favorite Food (Most Ordered Dish per Customer)
SELECT o.customer_id, c.customer_name, d.dish_name, COUNT(oi.dish_id) AS order_count  
FROM Orders o  
JOIN Order_Items oi ON o.order_id = oi.order_id  
JOIN Dishes d ON oi.dish_id = d.dish_id  
JOIN Customers c ON o.customer_id = c.customer_id  
GROUP BY o.customer_id, c.customer_name, d.dish_name  
ORDER BY order_count DESC;

-- 9. Find the Most Loyal Customers for Each Restaurant
SELECT o.restaurant_id, r.restaurant_name, o.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders  
FROM Orders o  
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id  
JOIN Customers c ON o.customer_id = c.customer_id  
GROUP BY o.restaurant_id, r.restaurant_name, o.customer_id, c.customer_name  
ORDER BY o.restaurant_id, total_orders DESC;

-- 10. Month-over-Month Revenue Growth of Each Restaurant
SELECT o.restaurant_id, r.restaurant_name, DATE_FORMAT(o.order_date, '%Y-%m') AS month,  
       SUM(o.total_price) AS revenue,  
       LAG(SUM(o.total_price)) OVER (PARTITION BY o.restaurant_id ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')) AS prev_month_revenue,  
       (SUM(o.total_price) - LAG(SUM(o.total_price)) OVER (PARTITION BY o.restaurant_id ORDER BY DATE_FORMAT(o.order_date, '%Y-%m'))) /  
       LAG(SUM(o.total_price)) OVER (PARTITION BY o.restaurant_id ORDER BY DATE_FORMAT(o.order_date, '%Y-%m')) * 100 AS revenue_growth  
FROM Orders o  
JOIN Restaurants r ON o.restaurant_id = r.restaurant_id  
GROUP BY o.restaurant_id, r.restaurant_name, month;

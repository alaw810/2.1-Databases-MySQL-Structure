-- Pizzeria DB queries

-- List how many 'Drink' category products have been sold in a specific city
SELECT 
l.locality_id,
l.name AS locality_name,
SUM(oi.quantity) AS drinks_units_sold
FROM order_items oi
JOIN orders o ON o.order_id   = oi.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN stores s ON s.store_id   = o.store_id
JOIN localities l ON l.locality_id = s.locality_id
WHERE p.product_type = 'drink'
AND l.locality_id = 1
GROUP BY l.locality_id, l.name;

-- List how many orders have been handled by a specific employee
SELECT 
e.employee_id,
e.first_name,
e.last_name,
COUNT(o.order_id) AS orders_delivered
FROM employees e
LEFT JOIN orders o
ON o.delivered_by_employee_id = e.employee_id
AND o.order_type = 'delivery'
WHERE e.employee_id = 2
GROUP BY e.employee_id;

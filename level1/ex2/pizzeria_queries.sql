-- Adrià Lorente - Pizzeria DB queries

-- List how many 'Beverage' category products have been sold in a specific city
SELECT c.name AS city,
       SUM(od.quantity) AS total_beverages_sold
FROM order_details od
JOIN product p ON od.product_id = p.product_id
JOIN orders o ON od.order_id = o.order_id
JOIN store s ON o.store_id = s.store_id
JOIN city c ON s.city_id = c.city_id
WHERE p.product_type = 'beverage'
  AND c.name = 'Barcelona'
GROUP BY c.name;

-- List how many orders have been handled by a specific employee - by employee_id
SELECT e.employee_id, e.name, e.surname, COUNT(o.order_id) AS orders_handled
FROM employee e
LEFT JOIN orders o ON o.delivery_employee_id = e.employee_id
WHERE e.employee_id = 2
GROUP BY e.employee_id, e.name, e.surname;



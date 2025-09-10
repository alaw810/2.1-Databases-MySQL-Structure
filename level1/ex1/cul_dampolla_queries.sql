-- "Cul d'Ampolla" queries

-- List the total invoices of a customer within a specific time period
SELECT 
c.customer_id,
c.name AS customer_name,
s.sale_date,
s.sale_price
FROM sales s
JOIN customers c ON c.customer_id = s.customer_id
WHERE s.customer_id = 1
AND s.sale_date >= '2025-01-01'
AND s.sale_date <  '2026-01-01';

-- List the different models of glasses sold by an employee during a given year
SELECT DISTINCT
g.glasses_id,
b.name AS brand,
ft.frame_type,
g.frame_colour,
g.grad_left,
g.grad_right,
g.color_left,
g.color_right,
g.price
FROM sales s
JOIN glasses g ON g.glasses_id = s.glasses_id
JOIN brands b ON b.brand_id = g.brand_id
JOIN frame_types ft ON ft.frame_type_id = g.frame_type_id
WHERE s.employee_id = 1
AND YEAR(s.sale_date) = 2025;

-- List the different suppliers who have provided glasses that were successfully sold by the optician
SELECT DISTINCT
sup.supplier_id,
sup.name,
sup.city, 
sup.country,
sup.tax_id
FROM sales s
JOIN glasses g ON g.glasses_id = s.glasses_id
JOIN brands b ON b.brand_id = g.brand_id
JOIN suppliers sup ON sup.supplier_id = b.supplier_id;

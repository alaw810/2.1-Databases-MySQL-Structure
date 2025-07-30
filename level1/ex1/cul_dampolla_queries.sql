-- Adrià Lorente – Optician DB "Cul d'Ampolla" queries

-- List the total invoices of a customer within a specific time period
SELECT sale_id, sale_date, glasses_id, employee_id
FROM sales
WHERE customer_id = 1
  AND sale_date BETWEEN '2025-01-01' AND NOW();

-- List the different models of glasses sold by an employee during a given year
SELECT DISTINCT g.glasses_id, g.graduation, ft.frame_type, b.name AS brand, g.frame_colour, g.lens_colour, g.price
FROM sales s
JOIN glasses g        ON s.glasses_id = g.glasses_id
JOIN brand b          ON g.brand_id = b.brand_id
JOIN frame_types ft   ON g.frame_type_id = ft.frame_type_id
WHERE s.employee_id = 1
  AND YEAR(s.sale_date) = 2025;

-- List the different suppliers who have provided glasses that were successfully sold by the optician
SELECT DISTINCT sp.supplier_id, sp.name AS supplier_name, sp.city, sp.country
FROM sales s
JOIN glasses g    ON s.glasses_id = g.glasses_id
JOIN brand b      ON g.brand_id = b.brand_id
JOIN supplier sp  ON b.supplier_id = sp.supplier_id;

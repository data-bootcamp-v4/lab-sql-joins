USE sakila;
SHOW tables FROM sakila;
-- 1
SELECT c.name AS category, COUNT(f.film_id) AS Number_of_films FROM sakila.film AS f
JOIN sakila.film_category AS fc ON f.film_id = fc.film_id
JOIN sakila.category AS c ON c.category_id = fc.category_id
GROUP BY category; 
-- 2
SELECT s.store_id, c.city , co.country FROM sakila.store as s
JOIN sakila.address as a ON s.address_id = a.address_id
JOIN sakila.city as c ON a.address_id = c.city_id
JOIN sakila.country as co ON c.country_id = co.country_id;
-- 3
SELECT s.store_id, SUM(p.amount) AS Amount_generated FROM sakila.store as s
JOIN sakila.customer as c ON s.store_id = c.store_id
JOIN sakila.payment as p ON c.customer_id = p.customer_id
GROUP BY s.store_id;
-- 4
SELECT c.name as Category, AVG(f.length) as avg_length FROM sakila.film as f
JOIN sakila.film_category as fc ON f.film_id = fc.film_id
JOIN sakila.category as c ON fc.category_id = c.category_id
GROUP BY Category;

-- BONUS

-- 5
SELECT c.name as Category, AVG(f.length) as avg_length FROM sakila.film as f
JOIN sakila.film_category as fc ON f.film_id = fc.film_id
JOIN sakila.category as c ON fc.category_id = c.category_id
GROUP BY Category ORDER BY avg_length DESC LIMIT 3;

-- 6
SELECT f.title, COUNT(r.rental_id) AS times_rented FROM sakila.film as f
JOIN sakila.inventory as i ON f.film_id = i.film_id 
JOIN sakila.rental as r ON i.inventory_id = r.inventory_id
GROUP BY f.title ORDER BY times_rented DESC LIMIT 10;

-- 7 
SELECT f.title, s.store_id, f.film_id, i.inventory_id FROM sakila.store as s
JOIN sakila.inventory as i ON s.store_id = i.store_id
JOIN sakila.film as f ON i.film_id = f.film_id
WHERE title = "Academy Dinosaur";

-- 8
SELECT DISTINCT f.title, CASE 
WHEN i.inventory_id IS NOT NULL THEN 'Available'
WHEN i.inventory_id IS NULL THEN 'not available' 
END AS Availability_status FROM sakila.film as f
LEFT JOIN sakila.inventory as i ON f.film_id = i.film_id; 



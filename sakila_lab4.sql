-- Display all available tables in the Sakila database.
USE sakila;

SHOW TABLES;

SELECT
   c.name AS category,
   COUNT(fc.film_id) AS number_of_films
FROM
   category c
JOIN
   film_category fc ON c.category_id = fc. category_id
GROUP BY
   c.name;
   
-- 2.
SELECT
   s.store_id,
   ci.city,
   co.country
FROM
   store s
JOIN
   address a ON s.address_id = a.address_id
JOIN
   city ci ON a.city_id = ci.city_id
JOIN
   country co ON ci.country_id = co.country_id;

-- 3.
SELECT
   i.store_id,
   SUM(p.amount) AS total_revenue
FROM
   payment p
JOIN
   rental r ON p.rental_id = r.rental_id
JOIN
   inventory i ON r.inventory_id = i.inventory_id
GROUP BY
   i.store_id;
   
-- 4.
SELECT 
   c.name AS category,
   AVG(f.length) AS average_running_time
FROM
   film f
JOIN
   film_category fc ON f.film_id = fc.film_id
JOIN
   category c ON fc.category_id = c.category_id
GROUP BY
   c.name;

-- LAB | SQL Joins
USE sakila;

-- Challenge - Joining on multiple tables

-- 1
SELECT  c.category_id, COUNT(f.film_id) AS films_count FROM sakila.film AS f
LEFT JOIN sakila.film_category AS c
ON f.film_id = c.film_id
GROUP BY c.category_id
ORDER BY films_count DESC;

-- 2
SELECT s.store_id, ci.city, co.country FROM sakila.store AS s
JOIN sakila.address AS a
ON s.address_id = a.address_id
JOIN sakila.city AS ci
ON a.city_id = ci.city_id
JOIN sakila.country AS co
ON ci.country_id = co.country_id; 

-- 3
SELECT i.store_id, SUM(p.amount) AS Revenue FROM sakila.payment AS p
JOIN sakila.rental AS r
ON p.rental_id = r.rental_id
JOIN sakila.inventory AS i
ON r.inventory_id = i.inventory_id
GROUP BY  i.store_id
ORDER BY  i.store_id;

-- 4 
SELECT c.category_id, c.name, ROUND(AVG(f.length),2) AS Avg_Running_Time FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
JOIN sakila.film AS f
ON fc.film_id = f.film_id
GROUP BY  c.category_id
ORDER BY  c.category_id;

-- 5
SELECT c.category_id, c.name, ROUND(AVG(f.length),2) AS Avg_Running_Time FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
JOIN sakila.film AS f
ON fc.film_id = f.film_id
GROUP BY  c.category_id
ORDER BY  Avg_Running_Time DESC
LIMIT 3;

-- 6
SELECT f.title, COUNT(r.rental_id) AS rental_count FROM sakila.rental AS r
JOIN sakila.inventory AS i
ON r.inventory_id = i.inventory_id
JOIN sakila.film AS f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- 7
SELECT f.film_id, f.title, i.store_id FROM sakila.film AS f
JOIN sakila.inventory AS i
ON f.film_id = i.film_id
WHERE f.title = "Academy Dinosaur" AND i.store_id = 1
LIMIT 1;

-- 8
SELECT 
    f.title, 
    CASE 
        WHEN IFNULL(i.inventory_count, 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM 
    sakila.film AS f
LEFT JOIN (
    SELECT 
        film_id, 
        COUNT(inventory_id) AS inventory_count
    FROM 
        sakila.inventory
    GROUP BY 
        film_id
) AS i ON f.film_id = i.film_id;
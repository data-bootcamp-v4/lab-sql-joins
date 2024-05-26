USE sakila;

-- #1
SELECT name AS category_name, 
       COUNT(f.film_id) AS number_of_films 
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY name
ORDER BY number_of_films DESC;

-- #2
SELECT s.store_id, ci.city, co.country 
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

-- #3
SELECT s.store_id, 
	   SUM(p.amount) AS total_revenue 
FROM payment AS p
JOIN 
    rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN store AS s ON i.store_id = s.store_id
GROUP BY store_id

-- #4
SELECT c.name AS category_name, 
       AVG(f.length) AS average_running_time 
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY name
ORDER BY average_running_time DESC;

-- BONUS
-- #5
SELECT c.name AS category_name, 
       AVG(f.length) AS average_running_time 
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC
LIMIT 1;

-- #6
SELECT f.title, 
       COUNT(r.rental_id) AS rental_count 
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT 
    CASE 
        WHEN i.inventory_id IS NOT NULL THEN 'Yes' 
        ELSE 'No' 
    END AS can_be_rented 
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id AND i.store_id = 1
WHERE f.title = 'Academy Dinosaur';

SELECT f.title, 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;
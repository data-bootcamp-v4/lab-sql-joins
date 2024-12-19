USE sakila;
-- 1
SELECT c.name AS category_name, COUNT(fc.film_id) AS film_count
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;
-- 2
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;
-- 3
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;
-- 4
SELECT c.name AS category_name, AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;
-- 5
SELECT c.name AS category_name, AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;
-- 6
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;
-- 7
SELECT CASE WHEN COUNT(i.inventory_id) > 0 THEN 'Available' ELSE 'Not Available'
       END AS availability
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;
-- 8
SELECT f.title, CASE WHEN COUNT(i.inventory_id) > 0 THEN 'Available' ELSE 'NOT available'
       END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id AND i.store_id IS NOT NULL
GROUP BY f.title;
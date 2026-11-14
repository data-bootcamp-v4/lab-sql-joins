USE sakila;

SELECT c.name AS category, COUNT(*) AS num_films
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY num_films DESC;

SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

SELECT st.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
GROUP BY st.store_id;

SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_duration DESC;

SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING avg_duration > 120
ORDER BY avg_duration DESC;

SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING avg_duration > 120
ORDER BY avg_duration DESC;

SELECT f.title, COUNT(*) AS times_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 10;

SELECT f.title, i.store_id, COUNT(*) AS copies
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1
GROUP BY f.title, i.store_id;

SELECT DISTINCT f.title,
       CASE
           WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
           ELSE 'Available'
       END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
ORDER BY availability, f.title;
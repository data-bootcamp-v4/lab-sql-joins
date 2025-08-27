
SELECT c.name AS category,
       COUNT(f.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY film_count DESC;


SELECT s.store_id,
       ci.city,
       co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


SELECT s.store_id,
       SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;


SELECT c.name AS category,
       AVG(f.length) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;
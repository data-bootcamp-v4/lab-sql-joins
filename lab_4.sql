USE sakila;

SELECT 
    c.name AS category_name, 
    COUNT(f.film_id) AS num_films
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY num_films DESC;

SELECT s.store_id, ci.city, co.country
from store s
join address a on a.address_id = s.address_id
join city ci on ci.city_id = a.city_id
join country co on ci.country_id = co.country_id;


SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;
   


SELECT 
    c.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

SELECT 
    c.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 1;

SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT 
    i.inventory_id, 
    i.store_id, 
    f.title, 
    IF(COUNT(r.rental_id) < COUNT(i.inventory_id), 'Available', 'NOT Available') AS availability
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
GROUP BY i.inventory_id;

SELECT 
    f.title, 
    CASE 
        WHEN i.inventory_id IS NULL THEN 'NOT Available'
        ELSE 'Available'
    END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title ASC;


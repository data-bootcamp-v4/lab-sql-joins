USE sakila;
SELECT 
    c.name AS category,
    COUNT(f.film_id) AS film_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY film_count DESC;
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;
SELECT 
    s.store_id,
    CONCAT('$', ROUND(SUM(p.amount), 2)) AS total_revenue
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.store_id;
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_duration DESC;
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_duration DESC
LIMIT 3;  -- Top 3 longest average durations
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;
SELECT 
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
GROUP BY f.title, i.store_id;
SELECT 
    f.title,
    CASE 
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT Available'
        ELSE 'Available'
    END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title, i.inventory_id
ORDER BY f.title;
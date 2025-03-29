SELECT 
    c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;

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
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;

SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 3;

SELECT 
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC
LIMIT 10;

SELECT 
    IF(COUNT(*) > 0, 'Yes', 'No') AS available_in_store_1
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1;

SELECT 
    f.title,
    CASE 
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title ASC;

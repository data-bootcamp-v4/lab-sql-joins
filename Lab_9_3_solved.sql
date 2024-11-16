USE sakila;

SELECT 
    cat.name AS category_name, 
    COUNT(f.film_id) AS conteo_film
FROM category AS cat
JOIN film_category AS fcat 
ON cat.category_id = fcat.category_id
JOIN film AS f 
ON fcat.film_id = f.film_id
GROUP BY cat.name
ORDER BY conteo_film DESC;

SELECT 
    store.store_id, 
    city.city, 
    co.country
FROM store
JOIN address AS ad ON store.address_id = ad.address_id
JOIN city ON ad.city_id = city.city_id
JOIN country AS co ON city.country_id = co.country_id;

SELECT 
    s.store_id, 
    SUM(pay.amount) AS total_revenue
FROM store AS s
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS pay ON st.staff_id = pay.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

SELECT 
    cat.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS cat
JOIN film_category AS fc ON cat.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY cat.name
ORDER BY avg_running_time DESC;

SELECT 
    cat.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS cat
JOIN film_category AS fc ON cat.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY cat.name
ORDER BY avg_running_time DESC
LIMIT 1;

SELECT 
    f.title, 
    COUNT(r.rental_id) AS conteo_rental
FROM rental AS r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY conteo_rental DESC
LIMIT 10;

SELECT 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN store AS s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;

SELECT 
    f.title, 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT Available'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title ASC;
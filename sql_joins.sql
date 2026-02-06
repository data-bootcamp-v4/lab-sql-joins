USE sakila;

SELECT
    c.name AS category,
    COUNT(fc.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
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
    SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time_minutes
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time_minutes DESC;

SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

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
    s.store_id,
    COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur'
  AND s.store_id = 1
GROUP BY f.title, s.store_id;

SELECT
    f.title,
    CASE
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title, availability_status
ORDER BY f.title;
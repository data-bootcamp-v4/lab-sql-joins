USE sakila;
SHOW TABLES;

SELECT 
    c.name AS category_name,
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
GROUP BY s.store_id;

SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS average_duration
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_duration DESC;

SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS average_duration
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_duration DESC
LIMIT 1;


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
    CASE 
        WHEN i.inventory_id IS NOT NULL THEN 'Available'
        ELSE 'NOT Available'
    END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id AND i.store_id = 1
WHERE f.title = 'Academy Dinosaur';


SELECT 
    f.title,
    COUNT(i.inventory_id) AS copies_in_store_1
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id AND i.store_id = 1
WHERE f.title = 'Academy Dinosaur'
GROUP BY f.title;


SELECT 
    f.title,
    IFNULL(
        CASE 
            WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        END, 
        'NOT available'
    ) AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;

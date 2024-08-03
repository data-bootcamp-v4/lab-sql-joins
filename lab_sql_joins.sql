USE sakila;

SELECT 
    c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name;

DESCRIBE address;

DESCRIBE city;

DESCRIBE country;

SELECT 
    s.store_id,
    ci.city AS city,
    co.country AS country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id;

SELECT 
    s.store_id,
    ci.city AS city,
    co.country AS country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id;

SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    store s
JOIN 
    customer c ON s.store_id = c.store_id
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    s.store_id;
SELECT 
    c.name AS category,
    AVG(f.length) AS average_duration
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name;

WITH AvgDuration AS (
    SELECT 
        c.name AS category,
        AVG(f.length) AS average_duration
    FROM 
        category c
    JOIN 
        film_category fc ON c.category_id = fc.category_id
    JOIN 
        film f ON fc.film_id = f.film_id
    GROUP BY 
        c.name
)
SELECT 
    category,
    average_duration
FROM 
    AvgDuration
ORDER BY 
    average_duration DESC
LIMIT 1;

SELECT 
    f.title AS film_title,
    COUNT(r.rental_id) AS rental_count
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.title
ORDER BY 
    rental_count DESC
LIMIT 10;

SELECT 
    CASE
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT Available'
    END AS availability
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    store s ON i.store_id = s.store_id
WHERE 
    f.title = 'Academy Dinosaur'
    AND s.store_id = 1
    AND i.inventory_id NOT IN (
        SELECT 
            r.inventory_id
        FROM 
            rental r
    );


















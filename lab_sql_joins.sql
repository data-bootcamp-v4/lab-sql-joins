-- LAB SQL JOINS
-- Sakila Database
USE sakila;

USE sakila;

-- 1. Number of films per category
SELECT 
    c.name AS category,
    COUNT(fc.film_id) AS total_films
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
GROUP BY c.name;

-- 2. Store ID, city and country
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a 
    ON s.address_id = a.address_id
JOIN city ci 
    ON a.city_id = ci.city_id
JOIN country co 
    ON ci.country_id = co.country_id;
    
    -- 3. Total revenue per store
    SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store s
JOIN inventory i 
    ON s.store_id = i.store_id
JOIN rental r 
    ON i.inventory_id = r.inventory_id
JOIN payment p 
    ON r.rental_id = p.rental_id
GROUP BY s.store_id;


-- 4. Average running time per category
SELECT 
    c.name AS category,
    AVG(f.length) AS avg_duration
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
JOIN film f 
    ON fc.film_id = f.film_id
GROUP BY c.name;

#bonus
-- BONUS 1: Categories with longest average running time
SELECT 
    c.name AS category,
    AVG(f.length) AS avg_duration
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
JOIN film f 
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_duration DESC;

-- BONUS 2: Top 10 most frequently rented movies
SELECT 
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 10;

-- BONUS 3: Check availability of Academy Dinosaur in Store 1
SELECT 
    CASE 
        WHEN COUNT(*) > 0 THEN 'YES'
        ELSE 'NO'
    END AS availability
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1;

-- BONUS 4: Film availability status
SELECT 
    f.title,
    CASE 
        WHEN i.inventory_id IS NULL THEN 'NOT available'
        ELSE 'Available'
    END AS status
FROM film f
LEFT JOIN inventory i 
    ON f.film_id = i.film_id
GROUP BY f.title, i.inventory_id;
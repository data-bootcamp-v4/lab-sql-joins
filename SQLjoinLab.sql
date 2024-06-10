-- Challenge - Joining on multiple tables
USE sakila;
-- 1 
SELECT 
    COUNT(DISTINCT f.film_id) AS number_films, 
    c.name AS category_name
FROM 
    sakila.category AS c
JOIN 
    sakila.film_category AS fc ON c.category_id = fc.category_id
JOIN 
    sakila.film AS f ON fc.film_id = f.film_id
GROUP BY 
    c.name;

-- 2
SELECT 
    s.store_id, ct.city, cn.country
FROM
    sakila.store AS s 
JOIN 
    sakila.address AS a ON s.address_id = a.address_id
JOIN
     sakila.city AS ct ON a.city_id = ct.city_id
JOIN
    sakila.country AS cn ON ct.country_id = cn.country_id
GROUP BY
	store_id;

-- 3
SELECT 
	SUM(p.amount) AS total_pay, s.store_id
FROM
    sakila.payment AS p
JOIN 
    sakila.customer AS cs ON p.customer_id = cs.customer_id
JOIN 
    sakila.store AS s ON cs.store_id = s.store_id
GROUP BY 
    s.store_id;

-- 4
SELECT 
    AVG(ROUND(f.length)) AS average_runtime, 
    c.name AS category_name
FROM 
    sakila.category AS c
JOIN 
    sakila.film_category AS fc ON c.category_id = fc.category_id
JOIN 
    sakila.film AS f ON fc.film_id = f.film_id
GROUP BY 
    c.name;

-- BONUS 
-- 5
SELECT 
    c.name AS category_name,
    AVG(f.length) AS average_runtime
FROM 
    sakila.category AS c
JOIN 
    sakila.film_category AS fc ON c.category_id = fc.category_id
JOIN 
    sakila.film AS f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    average_runtime DESC;

-- 6
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- 7
SELECT 
    f.title,
    COUNT(i.inventory_id) AS available_copies
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE 
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1
GROUP BY 
    f.title;

-- 8 
SELECT 
    f.title,
    CASE 
        WHEN IFNULL(SUM(CASE WHEN r.return_date IS NULL THEN 1 ELSE 0 END), 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
GROUP BY 
    f.title
ORDER BY 
    f.title;

    
    
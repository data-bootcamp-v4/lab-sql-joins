SHOW TABLES;
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;
SELECT title FROM film;
SELECT 
    c.name AS category_name,
    COUNT(f.film_id) AS number_of_films
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    number_of_films DESC;
    SELECT 
    s.store_id,
    ci.city,
    co.country
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
    payment p
JOIN 
    rental r ON p.rental_id = r.rental_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    store s ON i.store_id = s.store_id
GROUP BY 
    s.store_id
ORDER BY 
    total_revenue DESC;
    SELECT 
    c.name AS category_name,
    AVG(f.length) AS average_running_time
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    average_running_time DESC;
SELECT 
    c.name AS category_name,
    AVG(f.length) AS average_running_time
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    average_running_time DESC
LIMIT 10;
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
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
WHERE 
    f.title = 'Academy Dinosaur' 
    AND i.store_id = 1
    AND i.inventory_id NOT IN (
        SELECT inventory_id 
        FROM rental 
        WHERE return_date IS NULL
    );


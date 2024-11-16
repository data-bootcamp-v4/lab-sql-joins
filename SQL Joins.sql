-- Task 1
SELECT 
    c.name AS category_name,
    COUNT(f.film_id) AS number_of_films
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    number_of_films DESC;

-- Task 2
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

-- Task 3
SELECT 
    p.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    payment p
GROUP BY 
    p.store_id
ORDER BY 
    total_revenue DESC;

-- Task 4
SELECT 
    c.name AS category_name,
    AVG(f.length) AS average_running_time
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    average_running_time DESC;

-- Bonus

SELECT 
    c.name AS category_name,
    AVG(f.length) AS average_running_time
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    average_running_time DESC
LIMIT 1;

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
    i.inventory_id,
    f.title,
    i.store_id
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1
    AND i.inventory_id NOT IN (
        SELECT inventory_id 
        FROM rental 
        WHERE return_date IS NULL
    );

SELECT 
    f.title,
    CASE 
        WHEN i.inventory_id IS NOT NULL AND i.inventory_id NOT IN (
            SELECT inventory_id 
            FROM rental 
            WHERE return_date IS NULL
        ) THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.title;



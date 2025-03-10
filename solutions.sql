SELECT 
    c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.category_id, c.name;

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
    store s
JOIN
    inventory i on s.store_id = i,store_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    s.store_id;

SELECT 
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.category_id, c.name;

SELECT 
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.category_id, c.name
ORDER BY 
    average_running_time DESC;

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
        ELSE 'Not Available'
    END AS availability_status
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    store s ON i.store_id = s.store_id
WHERE 
    f.title = 'Academy Dinosaur'
    AND s.store_id = 1;

SELECT 
    f.title AS film_title,
    CASE 
        WHEN IFNULL(COUNT(i.inventory_id), 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.title;


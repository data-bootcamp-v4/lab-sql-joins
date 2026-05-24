SELECT 
    c.name AS category_name, 
    COUNT(DISTINCT fc.film_id) AS total_films
FROM 
    category AS c
INNER JOIN 
    film_category AS fc ON c.category_id = fc.category_id
GROUP BY 
    c.category_id, 
    c.name
ORDER BY 
    total_films DESC, 
    category_name ASC;

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
    SUM(p.amount) AS total_revenue_dollars
FROM 
    store s
JOIN 
    staff st ON s.store_id = st.store_id
JOIN 
    payment p ON st.staff_id = p.staff_id
GROUP BY 
    s.store_id;
    
SELECT 
    c.name AS category_name, 
    ROUND(AVG(f.length), 2) AS average_duration
FROM 
    category AS c
JOIN 
    film_category AS fc ON c.category_id = fc.category_id
JOIN 
    film AS f ON fc.film_id = f.film_id
GROUP BY 
    c.name
;

SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS average_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_running_time DESC;

SELECT 
    f.title AS film_title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT 
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS copies_in_stock
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
GROUP BY f.title, i.store_id;

SELECT 
    f.title AS film_title,
    CASE 
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title ASC;

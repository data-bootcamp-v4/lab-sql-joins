SELECT 
    c.name AS category_name, 
    COUNT(f.film_id) AS film_count
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY film_count DESC;

SELECT 
    s.store_id, 
    ci.city, 
    co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN store AS s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

SELECT 
    c.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_duration
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_duration DESC;

SELECT 
    c.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_duration
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_duration DESC
LIMIT 1;

SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT 
    f.title, 
    s.store_id,
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available' 
        ELSE 'Not Available' 
    END AS availability_status
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN store AS s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY f.title, s.store_id;

SELECT 
    f.title,
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available' 
        ELSE 'Not Available' 
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY availability_status DESC, f.title ASC;


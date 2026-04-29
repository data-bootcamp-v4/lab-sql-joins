USE sakila;

SELECT 
    c.name AS category_name, 
    COUNT(fc.film_id) AS number_of_films
FROM category AS c
INNER JOIN film_category AS fc 
    ON c.category_id = fc.category_id
GROUP BY c.name;


SELECT 
    s.store_id, 
    ci.city, 
    co.country
FROM store AS s
INNER JOIN address AS a 
    ON s.address_id = a.address_id
INNER JOIN city AS ci 
    ON a.city_id = ci.city_id
INNER JOIN country AS co 
    ON ci.country_id = co.country_id;
    
SELECT
s.store_id,
SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN staff AS st ON p.staff_id = st.staff_id
JOIN store AS s ON st.store_id = s.store_id
GROUP BY s.store_id;

SELECT 
    c.name AS category_name, 
    AVG(f.length) AS average_running_time
FROM category AS c
JOIN film_category AS fc 
    ON c.category_id = fc.category_id
JOIN film AS f 
    ON fc.film_id = f.film_id
GROUP BY c.name;

SELECT 
    c.name AS category_name, 
    AVG(f.length) AS average_running_time
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC;

SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT 
    f.title, 
    i.store_id,
    COUNT(i.inventory_id) AS units_in_stock
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
GROUP BY f.title, i.store_id;

SELECT 
    DISTINCT f.title,
    CASE 
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id;

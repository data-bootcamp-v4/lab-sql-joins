USE sakila;

SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM store;
SELECT * FROM inventory;

SELECT name AS category, COUNT(film_id) AS number_of_films 
FROM category AS c
INNER JOIN film_category AS f
ON c.category_id = f.category_id
GROUP BY name;

SELECT 
    s.store_id, 
    ci.city,
    co.country
FROM 
    store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id;

SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    payment p
INNER JOIN rental r ON p.rental_id = r.rental_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN store s ON i.store_id = s.store_id
GROUP BY 
    s.store_id;
    
    SELECT 
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM 
    category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY 
    c.name;
    
    SELECT 
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM 
    category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    AVG(f.length) DESC;
    
    SELECT 
    f.title AS film_title,
    COUNT(r.rental_id) AS rental_count
FROM 
    film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.title
ORDER BY 
    COUNT(r.rental_id) DESC
LIMIT 10;


SELECT 
    f.title AS film_title,
    CASE 
        WHEN COUNT(r.rental_id) > 0 THEN 'Yes'
        ELSE 'No'
    END AS available_in_store_1
FROM 
    film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN store s ON i.store_id = s.store_id
WHERE 
    f.title = 'Academy Dinosaur' AND s.store_id = 1;
    SELECT 
    f.title AS film_title,
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM 
    film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY 
    f.title;
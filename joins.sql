SELECT category_id, COUNT(*) AS films_per_category
FROM film_category
GROUP BY category_id;

SELECT *
FROM store; 

SELECT * 
FROM city;

SELECT * 
FROM country;

SELECT * 
FROM address;

SELECT s.store_id, c.city AS city, co.country AS country
FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country co
ON c.country_id = co.country_id
;

SELECT DISTINCT *
FROM payment;

SELECT *
FROM store;

SELECT *
FROM staff;

SELECT store_id, SUM(amount) AS revenue_per_store
FROM payment p
JOIN store s
ON p.staff_id = s.manager_staff_id
GROUP BY s.store_id;

SELECT *
FROM film;

SELECT *
FROM category;

SELECT*
FROM film_category;

SELECT c.name, AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY avg_length DESC;

SELECT c.name, AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY avg_length DESC
LIMIT 1;

SELECT *
FROM rental;

SELECT *
FROM inventory;

SELECT *
FROM film;

SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT *
FROM inventory;

SELECT *
FROM film;



SELECT f.title, i.store_id, COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i 
ON f.film_id = i.film_id
WHERE 
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1
GROUP BY 
    f.title, i.store_id;


SELECT *
FROM inventory;

SELECT *
FROM film;

SELECT 
    f.title,
    CASE 
        WHEN COUNT(i.inventory_id) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.film_id, f.title;


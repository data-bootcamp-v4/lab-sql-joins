USE sakila;
-- 1. 
SELECT c.name AS category_name, COUNT(fc.film_id) AS movie_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id;

-- 2. 
SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 3. 
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY s.store_id;

-- 4. 
SELECT c.name AS category_name, AVG(f.length) AS avg_running_time
FROM film_category fc
JOIN film f ON fc.film_id = f.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 5.
SELECT c.name AS category_name, AVG(f.length) AS avg_running_time
FROM film_category fc
JOIN film f ON fc.film_id = f.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

-- 6. 
SELECT f.title AS film_title, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 10;

-- 7. 
SELECT 
    CASE 
        WHEN COUNT(rental.inventory_id) > 0 THEN 'NO'
        ELSE 'YES'
    END AS availability
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
LEFT JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
JOIN 
    store ON inventory.store_id = store.store_id
WHERE 
    film.title = 'Academy Dinosaur' AND
    store.store_id = 1;

-- 8.
SELECT 
    f.title AS film_title,
    IFNULL(CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END, 'NOT available') AS availability_status
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.film_id;
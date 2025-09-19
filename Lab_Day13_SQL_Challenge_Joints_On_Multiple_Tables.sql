-- Lab Day 13 SQL challenge: Write SQL queries to perform the following tasks using the sakila database.
USE sakila;

-- 1. Number of films per category
WITH film_count_per_category AS (
    SELECT 
        category.name AS category_name,
        COUNT(film_table.film_id) AS total_films
    FROM film AS film_table
    JOIN film_category AS category_link ON film_table.film_id = category_link.film_id
    JOIN category ON category_link.category_id = category.category_id
    GROUP BY category.name
)
SELECT * FROM film_count_per_category;

-- 2. Store ID, city, and country
SELECT 
    store.store_id,
    city.city AS store_city,
    country.country AS store_country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 3. Total revenue per store
WITH revenue_per_store AS (
    SELECT 
        store.store_id,
        ROUND(SUM(payment.amount), 2) AS total_revenue_usd
    FROM payment
    JOIN staff ON payment.staff_id = staff.staff_id
    JOIN store ON staff.store_id = store.store_id
    GROUP BY store.store_id
)
SELECT * FROM revenue_per_store;

-- 4. Average running time per category
WITH average_runtime_by_category AS (
    SELECT 
        category.name AS category_name,
        ROUND(AVG(film_table.length), 2) AS average_duration_minutes
    FROM film AS film_table
    JOIN film_category AS category_link ON film_table.film_id = category_link.film_id
    JOIN category ON category_link.category_id = category.category_id
    GROUP BY category.name
)
SELECT * FROM average_runtime_by_category;

-- 5. Category with longest average running time
SELECT 
    category_name,
    average_duration_minutes
FROM average_runtime_by_category
ORDER BY average_duration_minutes DESC
LIMIT 1;

-- 6. Top 10 most rented movies
WITH rental_frequency AS (
    SELECT 
        film_table.title AS movie_title,
        COUNT(rental.rental_id) AS total_rentals
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film AS film_table ON inventory.film_id = film_table.film_id
    GROUP BY film_table.title
)
SELECT 
    movie_title,
    total_rentals
FROM rental_frequency
ORDER BY total_rentals DESC
LIMIT 10;

-- 7. Availability of "Academy Dinosaur" in Store 1
SELECT 
    film_table.title AS movie_title,
    CASE 
        WHEN inventory.inventory_id IS NOT NULL THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film AS film_table
LEFT JOIN inventory 
    ON film_table.film_id = inventory.film_id AND inventory.store_id = 1
WHERE film_table.title = 'Academy Dinosaur';

-- 8. Distinct film titles with availability status
SELECT 
    film_table.title AS movie_title,
    CASE 
        WHEN IFNULL(inventory.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film AS film_table
LEFT JOIN inventory ON film_table.film_id = inventory.film_id
GROUP BY film_table.title;

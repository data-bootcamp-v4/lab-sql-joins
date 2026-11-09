USE sakila;

-- 1. Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT COUNT(i.inventory_id) AS number_of_copies
FROM inventory AS i
JOIN film AS f
ON i.film_id = f.film_id
WHERE f.title = "HUNCHBACK IMPOSSIBLE";
-- 2. List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT 
title,
length 
FROM film
WHERE length > (
SELECT AVG(length)
FROM film
)
ORDER BY length DESC;
-- 3. Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT
actor_id 
first_name
last_name
FROM actor
WHERE actor_id (
SELECT actor-id
FROM film_actor
WHERE film_id 

)
-- Bonus:
-- 4. Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
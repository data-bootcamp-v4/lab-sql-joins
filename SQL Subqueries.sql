-- Challenge
-- 
-- Write SQL queries to perform the following tasks using the Sakila database:
-- 
-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.



SELECT f.title,
       COUNT(i.inventory_id) AS number_of_copies
FROM film f
JOIN inventory i
  ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY length DESC;

-- Use a subquery to display all actors who appear in the film "Alone Trip".


SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    WHERE fa.film_id = (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
    )
)
ORDER BY a.last_name, a.first_name;



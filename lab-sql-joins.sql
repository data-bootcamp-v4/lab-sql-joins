-- Write SQL queries to perform the following tasks using the Sakila database:

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- List all films whose length is longer than the average length of all the films in the Sakila database.
-- Use a subquery to display all actors who appear in the film "Alone Trip".

-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT 
    COUNT(*) AS num_copies
FROM 
    film
WHERE 
    title = 'Hunchback Impossible';
    
SELECT 
    COUNT(i.inventory_id) AS num_copies
FROM 
    inventory i
JOIN 
    film_id = 'Hunchback Impossible';
    
-- List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT 
    film.film_id, 
    film.title
FROM 
    film
WHERE 
    film.length > (SELECT AVG(film.length) FROM film);
    
-- Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT 
    act.first_name, 
    act.last_name
FROM 
    actor act
WHERE 
    act.actor_id IN (
        SELECT 
            fa.actor_id 
        FROM 
            film_actor fa
        JOIN 
            film f ON fa.film_id = f.film_id
        WHERE 
            f.title = 'Alone Trip'
    );

--

SELECT 
    act.first_name, 
    act.last_name
FROM 
    actor act
JOIN 
    film_actor fa ON act.actor_id = fa.actor_id
JOIN 
    film f ON fa.film_id = f.film_id
WHERE 
    f.title = 'Alone Trip';
    
    
--  

SELECT 
    act.first_name, 
    act.last_name
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
JOIN 
    actor act ON fa.actor_id = act.actor_id
WHERE 
    f.title = 'Alone Trip';
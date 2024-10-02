USE sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:

-- List the number of films per category.
SELECT COUNT(*) as number_of_films, c.name as category
FROM film_category as f
LEFT JOIN category as c
ON f.category_id = c.category_id
GROUP BY c.name;

-- Retrieve the store ID, city, and country for each store.
SELECT * from store LIMIT 20;
SELECT s.store_id, c.city, d.country
FROM store as s
INNER join address as a
on s.address_id = a.address_id
INNER join city as c
ON a.city_id = c.city_id
INNER join country as d
ON c.country_id = d.country_id;

-- Determine the average running time of films for each category.
SELECT ROUND(AVG(length),2) as average_running_time, c.name as category
FROM film as f
LEFT JOIN film_category d
ON f.film_id = d.film_id
LEFT JOIN category as c
ON d.category_id = c.category_id
GROUP BY category;
-- Bonus:

-- Identify the film categories with the longest average running time.
SELECT ROUND(AVG(length),2) as average_running_time, c.name as category
FROM film as f
LEFT JOIN film_category d
ON f.film_id = d.film_id
LEFT JOIN category as c
ON d.category_id = c.category_id
GROUP BY category
ORDER BY average_running_time DESC;

-- Display the top 10 most frequently rented movies in descending order.
SELECT f.title, COUNT(r.rental_id) as rental_count from rental as r
LEFT join inventory as i 
on r.inventory_id = i.inventory_id
LEFT join film as f
on i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- Determine if "Academy Dinosaur" can be rented from Store 1.

SELECT s.store_id, f.title
FROM store as s
LEFT join inventory as i 
on s.store_id = i.store_id
LEFT join film as f
on i.film_id = f.film_id
WHERE s.store_id = "1" and  f.title like "%ACADEMY DINOSAUR%";

-- Provide a list of all distinct film titles, along with their availability status in the inventory.

-- Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory,
--  and this information can be obtained using a CASE statement combined with IFNULL."
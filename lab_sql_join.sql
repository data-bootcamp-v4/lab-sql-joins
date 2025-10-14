-- 1
USE sakila;

SELECT c_film.name AS category_name, COUNT(f_film.film_id) AS film_count
FROM sakila.film_category AS f_film
JOIN sakila.category AS c_film
ON f_film.category_id = c_film.category_id
GROUP BY c_film.name;

-- 2

-- store ID, city, and country

-- store table: store_id, address_id / address table:address_id,  city_id / city table: city_id, country_id /  country table: country

SELECT s.store_id, city.city, c.country
FROM sakila.store AS s
JOIN sakila.address AS a
ON a.address_id = a.address_id
JOIN sakila.city 
ON a.city_id = city.city_id
JOIN sakila.country AS c
ON city.country_id = c.country_id;

-- 3

SELECT s.store_id , SUM(p.amount) AS total_rev
FROM sakila.store AS s
JOIN sakila.customer AS c
ON s.store_id = c.store_id
JOIN sakila.payment AS p
ON c.customer_id = p.customer_id
GROUP BY s.store_id;

-- 4

SELECT f.category_id, c.name AS category, AVG(film.length) AS avg_duration
FROM sakila.film AS film
JOIN sakila.film_category AS f
ON film.film_id= f.film_id
JOIN sakila.category AS c
ON f.category_id = c.category_id
GROUP BY f.category_id;

-- 5

SELECT f.category_id, c.name AS category, AVG(film.length) AS avg_duration
FROM sakila.film AS film
JOIN sakila.film_category AS f
ON film.film_id= f.film_id
JOIN sakila.category AS c
ON f.category_id = c.category_id
GROUP BY f.category_id
ORDER BY avg_duration DESC;

-- 6
-- Display the top 10 most frequently rented movies in descending order.

SELECT f.film_id, f.title, COUNT(r.inventory_id) AS num_film
FROM sakila.rental AS r
JOIN sakila.inventory AS i
ON r.inventory_id = i.inventory_id
JOIN sakila.film AS f
ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY num_film desc
LIMIT 10;

-- 7 

-- Determine if "Academy Dinosaur" can be rented from Store 1.

SELECT f.film_id, f.title, r.return_date
FROM sakila.rental AS r
JOIN sakila.inventory AS i
ON r.inventory_id = i.inventory_id
JOIN sakila.film AS f
ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
ORDER BY r.return_date DESC;

-- Provide a list of all distinct film titles, along with their availability status in the inventory. 
-- Include a column indicating whether each title is 'Available' or 'NOT available.' 
-- Note that there are 42 titles that are not in the inventory, and this information can be obtained using a 
-- CASE statement combined with IFNULL."

SELECT f.film_id, f.title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.film_id IS NULL;


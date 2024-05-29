-- EX1
USE sakila;
SELECT c.category_id as Category_number, COUNT(f.film_id)AS Count_film from film_category as f
JOIN category as c
ON f.category_id = c.category_id
GROUP BY c.category_id;

-- EX2
SELECT store_id,city,country FROM store AS s
JOIN city AS c
ON s.address_id = c.city_id
JOIN country AS co
ON c.country_id = co.country_id; 

-- EX3
SELECT s.store_id, SUM(p.amount) AS 'Total revenue' FROM store as s
JOIN customer as c
ON s.store_id = c.store_id
JOIN payment as p
ON c.customer_id = p.customer_id
GROUP BY s.store_id;

-- EX4
SELECT category_id, AVG(f.rental_duration) as 'Total runing time' FROM film as f
JOIN film_Category as fc
ON f.film_id = fc.film_id
GROUP BY category_id
ORDER BY AVG(f.rental_duration) DESC;

-- EX 5
SELECT category_id, AVG(f.rental_duration) as 'Total runing time' FROM film as f
JOIN film_Category as fc
ON f.film_id = fc.film_id
GROUP BY category_id
ORDER BY AVG(f.rental_duration) DESC
LIMIT 10;

-- EX6
SELECT f.title, SUM(rental_id) AS 'Total rentals' FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY SUM(rental_id) DESC
LIMIT 10;

-- EX7
SELECT f.title, i.store_id FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
WHERE f.title ='ACADEMY DINOSAUR' AND  i.store_id = '1';

-- EX8
SELECT
CASE
	WHEN f.title IS NULL THEN 'OOS'
    ELSE f.title
END AS film_title,
i.store_id
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
GROUP BY film_title, i.store_id

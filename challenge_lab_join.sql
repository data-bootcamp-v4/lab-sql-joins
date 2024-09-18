-- Challenge 1 Lab Day 18 (I)

USE sakila;

-- 1

SELECT
	c.name AS category_name,
    COUNT(f.film_id) AS num_of_films
FROM film AS f
JOIN film_category AS fc
	ON f.film_id = fc.film_id
JOIN category AS c 
	ON fc.category_id = c.category_id
GROUP BY c.name;

-- 2

SELECT
	s.store_id,
    c.city,
    co.country
FROM store AS s
JOIN address AS a
	ON s.address_id = a.address_id
JOIN city AS c 
	ON a.city_id = c.city_id
JOIN country AS co
	ON c.country_id = co.country_id;
    
-- 3

SELECT 
	i.store_id, 
    SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN rental AS r 
	ON p.rental_id = r.rental_id
JOIN inventory AS i 
	ON r.inventory_id = i.inventory_id
GROUP BY i.store_id;

-- 4

SELECT 
	c.name AS category_name,
    AVG(f.length) AS average_length
FROM film AS f
JOIN film_category AS fc 
	ON f.film_id = fc.film_id
JOIN category AS c 
	ON fc.category_id = c.category_id
GROUP BY c.name;
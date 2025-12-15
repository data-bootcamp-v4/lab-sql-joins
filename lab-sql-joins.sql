USE sakila;
show tables;
-- challenge
-- 1
SELECT COUNT(fc.film_id) AS n_films, fc.category_id, c.name
from film_category AS fc
INNER JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c.name, fc.category_id
ORDER BY c.name;
-- 2
SELECT s.store_id as store_number, ci.city as city_name, co.country as country_name
from store as s
INNER JOIN address as a ON  s.address_id = a.address_id
INNER JOIN city as ci ON a.city_id = ci.city_id
INNER JOIN country as co ON ci.country_id = co.country_id
GROUP BY s.store_id, ci.city, co.country;
-- 3
SELECT s.store_id as store_number, SUM(amount) as total_revenue
FROM store as s
INNER JOIN customer as cust ON s.store_id = cust.store_id
INNER JOIN payment as p ON cust.customer_id = p.customer_id
GROUP BY s.store_id;
-- 4
SELECT cat.name as category_name, AVG(length) from category as cat
join film_category as fcat on cat.category_id = fcat.category_id
join film as f on fcat.film_id = f.film_id
GROUP BY cat.name;
-- 5
SELECT cat.name as category_name, AVG(length) as av_duration from category as cat
join film_category as fcat on cat.category_id = fcat.category_id
join film as f on fcat.film_id = f.film_id
GROUP BY cat.name
ORDER BY av_duration DESC
limit 5;
-- 6
SELECT title, COUNT(rental_id) as number_rented from film as f
JOIN inventory as i ON f.film_id = i.film_id
JOIN rental as r on i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY number_rented DESC
limit 10;
-- 7
SELECT title, s.store_id as store from film as f
JOIN inventory as i ON f.film_id = i.film_id
JOIN store as s on i.store_id = s.store_id
WHERE f.title = "Academy Dinosaur" AND s.store_id = '1'
GROUP BY title, s.store_id;
-- 8
SELECT title,
	CASE
		WHEN COUNT(i.inventory_id) > 0 THEN 'available'
		ELSE 'unavailable'
	END AS availability
from film as f
LEFT JOIN inventory as i ON f.film_id = i.film_id
GROUP BY f.title, f.film_id;

CREATE TABLE availability_table as
SELECT title,
	CASE
		WHEN COUNT(i.inventory_id) > 0 THEN 'available'
		ELSE 'unavailable'
	END AS availability
from film as f
LEFT JOIN inventory as i ON f.film_id = i.film_id
GROUP BY f.title, f.film_id;


SELECT COUNT(*) from availability_table
WHERE availability = 'unavailable';
USE sakila;
-- 1
SHOW FULL TABLES;
SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT c.name, COUNT(fc.film_id)
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
GROUP BY c.name;

-- 2
SELECT * FROM store;
SELECT * FROM country;
SELECT * FROM city;
SELECT * FROM address;

SELECT s.store_id, c.city, co.country
FROM store AS s
JOIN address AS a
ON s.address_id = a.address_id
JOIN city as c
ON a.city_id = c.city_id
JOIN country AS co
ON c.country_id = co.country_id;

-- 3
SELECT * FROM payment;
SELECT * FROM store;
SELECT * FROM staff;

SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN staff AS st
ON p.staff_id = st.staff_id
JOIN store AS s
ON st.store_id = s.store_id
GROUP BY s.store_id;

-- 4
SELECT * FROM film;
SELECT* FROM category;
SELECT * FROM film_category;

SELECT c.name, ROUND(AVG(f.length), 2) AS avg_length
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.name;

-- 5
SELECT c.name, ROUND(AVG(f.length), 2) AS avg_length
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC;

-- 6
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;

SELECT f.title, COUNT(r.rental_id) AS times_rented
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 10;

-- 7
SELECT * FROM film;
SELECT * FROM inventory;

SELECT f.title, i.store_id
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE f.title = "Academy Dinosaur" AND i.store_id = 1;

-- 8
SELECT * FROM inventory;
SELECT * FROM film;

SELECT DISTINCT f.title,
CASE
	WHEN IFNULL(i.inventory_id, 0) = 0 THEN "not avaliable"
	ELSE "avaliable"
END AS avaliability
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id = i.film_id;


















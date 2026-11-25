USE sakila;


-- 1.
SELECT COUNT(f.title) AS 'Number of Films', c.name AS 'Genre'
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c.name;


-- 2.
SELECT s.store_id, c.country, ct.city
FROM store AS s
JOIN address AS a
ON s.address_id = a.address_id
JOIN city AS ct
ON a.city_id = ct.city_id
JOIN country AS c
ON ct.country_id = c.country_id;


-- 3.
SELECT COUNT(p.amount) AS 'Revenue (Dollars)', s.store_id AS "Store"
FROM payment AS p
JOIN rental AS r
ON p.rental_id = r.rental_id
JOIN staff AS s
ON r.staff_id = s.staff_id
GROUP BY store_id;


-- 4.
SELECT AVG(f.length) AS 'Average Runtime', c.name AS 'Genre'
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c.name;
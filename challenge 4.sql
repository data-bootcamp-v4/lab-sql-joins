USE Sakila;

SELECT title, length FROM film LIMIT 10;


SELECT f.title, f.length, fc.category_id
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id;


SELECT c.name AS category_name, f.length
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id;


SELECT c.name AS category_name, ROUND(AVG(f.length), 2) AS average_runtime
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_runtime DESC;
USE Sakila;


SELECT * FROM category;


SELECT c.category_id, c.name, fc.film_id
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id;


SELECT c.name AS category_name, COUNT(fc.film_id) AS number_of_films
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;


SELECT  c.name AS category_name, COUNT(fc.film_id) AS number_of_films
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;









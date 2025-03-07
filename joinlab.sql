
USE sakila;

-- 1. numero de peliculas por categoria.

SELECT category.name, COUNT(film_category.film_id) AS numero_de_films
FROM film_category 
JOIN category 
ON film_category.category_id = category.category_id
GROUP BY category.category_id;

-- 2. Buscar store ID, city, and country para cada store.

SELECT s.store_id, c.city, co.country
FROM store AS s
LEFT JOIN address AS a
ON s.address_id = a.address_id
JOIN city AS c
ON a.city_id = c.city_id
JOIN country AS co
ON c.country_id = co.country_id;

-- 3. calcular el total de ganancias por tiendas calculadas en dolar.
SELECT* 
FROM
store;
SELECT*
FROM payment;
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store AS s
LEFT JOIN staff AS st
ON s.store_id = st.store_id
JOIN payment AS p
ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- 4. promedio de duracion de los filmes por categoria

SELECT ca.name, ROUND(AVG(f.length), 2) AS average_length
FROM film_category AS c
JOIN film AS f
ON c.film_id = f.film_id
JOIN category AS ca
ON c.category_id = ca.category_id
GROUP BY c.category_id
ORDER BY average_length DESC;
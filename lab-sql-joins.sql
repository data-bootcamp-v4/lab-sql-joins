USE sakila;
#1. 
SELECT c.name AS category_name, COUNT(c.name) AS number_of_films
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY COUNT(c.name) DESC;

#2.
SELECT s.store_id, c.city, cn.country
FROM address AS a
JOIN store AS s
ON a.address_id = s.address_id
JOIN city AS c
ON a.city_id = c.city_id
JOIN country AS cn
ON c.country_id = cn.country_id;

#3.
SELECT s.store_id AS store, SUM(p.amount) AS revenue_in_$
FROM payment AS p
JOIN staff AS st
ON p.staff_id = st.staff_id
JOIN store AS s
ON s.store_id = st.staff_id
GROUP BY s.store_id;

#4.
SELECT c.name AS category_name, FLOOR(AVG(length)) AS avg_runtime_in_mnt
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON f.film_id = fc.film_id
GROUP BY c.name;
USE sakila

SELECT
c.name,
COUNT(f.film_id) AS num_peliculas
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id
INNER JOIN film AS f
ON f.film_id = fc.film_id
GROUP BY
c.name
ORDER BY num_peliculas DESC;



SELECT 
s.store_id,
ci.city,
co.country
FROM store AS s
INNER JOIN address AS a ON s.address_id = a.address_id
INNER JOIN city AS ci ON a.city_id = ci.city_id
INNER JOIN country AS co ON ci.country_id = co.country_id;

SELECT
s.store_id,
SUM(p.amount) AS total_revenue
FROM store AS s
INNER JOIN staff AS st ON s.store_id = st.store_id
INNER JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY
s.store_id
ORDER BY total_revenue DESC;

SELECT
c.name,
ROUND(AVG(f.length),2) AS average_running_time
FROM category AS c
INNER JOIN film_category AS fc ON fc.category_id = c.category_id
INNER JOIN film AS f ON f.film_id = fc.film_id
GROUP BY
c.name;


SELECT
c.name,
ROUND(AVG(f.length),2) AS average_running_time
FROM category AS c
INNER JOIN film_category AS fc ON fc.category_id = c.category_id
INNER JOIN film AS f ON f.film_id = fc.film_id
GROUP BY
c.name
ORDER BY average_running_time DESC;

SELECT 
f.title,
COUNT(r.rental_id) AS rental_count
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY
f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT 
f.title,
s.store_id,
COUNT(i.inventory_id) AS copies_in_store
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN store AS s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY
f.title,
s.store_id;







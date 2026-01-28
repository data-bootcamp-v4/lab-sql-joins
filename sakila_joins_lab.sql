USE sakila;
SHOW TABLES;




SELECT *
FROM film_category;

SELECT *
FROM category;



SELECT
c.category_id,
c.name,
COUNT(fc.film_id) AS num_films
FROM film_category AS fc
INNER JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY
c.category_id,
c.name;


SELECT*
FROM store;

SELECT*
FROM city;

SELECT*
FROM address;

SELECT*
FROM country;

SELECT
s.store_id,
a.address_id,
c.city_id,
co.country_id
FROM store AS s
LEFT JOIN address AS a
ON s.address_id = a.address_id
LEFT JOIN city AS c
ON a.city_id = c.city_id
LEFT JOIN country AS co
ON c.country_id = co.country_id;




SELECT*
FROM store;   -- store id

SELECT*
FROM payment; -- amount

SELECT*
FROM staff; -- address id

SELECT
s.store_id,
SUM(p.amount) AS total_revenue
FROM store AS s
JOIN staff AS st
ON s.store_id = st.store_id
JOIN payment AS p
ON st.staff_id = p.staff_id
GROUP BY
s.store_id;




SELECT *
FROM film_category;

SELECT *
FROM category;

SELECT *
FROM film;

SELECT
fc.category_id,
c.name,
AVG(f.length) AS avg_length
FROM film AS f
LEFT JOIN film_category AS fc
ON f.film_id = fc.film_id
LEFT JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY
fc.category_id,
c.name
ORDER BY fc.category_id;


SELECT
fc.category_id,
c.name,
AVG(f.length) AS avg_length
FROM film AS f
LEFT JOIN film_category AS fc
ON f.film_id = fc.film_id
LEFT JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY
fc.category_id,
c.name
ORDER BY avg_length DESC;


SELECT *
FROM film;

SELECT *
FROM inventory;

SELECT *
FROM rental;

SELECT
f.title,
COUNT(rental_id) AS num_rented
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY num_rented DESC
LIMIT 10;


SELECT *
FROM film;

SELECT *
FROM inventory;

SELECT *
FROM store;

SELECT
s.store_id
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN store AS s
ON i.store_id = s.store_id
WHERE f.title = "Academy Dinosaur" AND s.store_id = 1;


SELECT
    f.title,
    CASE
        WHEN IFNULL(COUNT(i.inventory_id), 0) > 0 THEN 'AVAILABLE'
        ELSE 'NOT AVAILABLE'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
GROUP BY
    f.title;




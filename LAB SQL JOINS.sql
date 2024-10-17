USE sakila;
--- 1
--- Usamos las tablas category, film_category y film
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM film;

--- categroy as c, film as f, film_category as fc

SELECT c.name AS category, COUNT(f.film_id) AS total_films
FROM category as c
JOIN film_category as fc ON c.category_id = fc.category_id -- Relacionamos la categoria con sus peliculas
JOIN film as f ON fc.film_id = f.film_id -- peliculas por categoria
GROUP BY c.name; -- agrupamos por nombre de categoria

--- 2
---  Usamos las tablas store, address, city, country
SELECT * FROM store;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;

--- store as s, address as a, city as ci, country as co

SELECT s.store_id, ci.city, co.country
FROM store as s
JOIN address as a ON s.address_id = a.address_id
JOIN city as ci ON a.city_id = ci.city_id
JOIN country as co ON ci.country_id = co.country_id;

--- 3
--- Usamos las tablas store, customer, invoice
SELECT * FROM store;
SELECT * FROM customer;
SELECT * FROM payment;

--- store as s, customer as c, payment as p

SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store as s
JOIN customer as c ON s.store_id = c.store_id 
JOIN payment as p ON c.customer_id = p.customer_id
GROUP BY s.store_id;

--- 4
--- Usamos las tablas category, film_category, film
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM film;

--- category as c, film_category as fc, film as f
--- category_id(c,fc),  film_id(fc,f)

SELECT c.name AS category, ROUND(AVG(f.length),2) AS average_length
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name;
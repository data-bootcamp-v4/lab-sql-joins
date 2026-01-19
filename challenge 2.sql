
USE Sakila;



SELECT * FROM store;


SELECT s.store_id, a.address, a.city_id
FROM store s
INNER JOIN address a ON s.address_id = a.address_id;


SELECT s.store_id, ci.city, ci.country_id
FROM store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id;


SELECT s.store_id, ci.city, co.country
FROM store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id;
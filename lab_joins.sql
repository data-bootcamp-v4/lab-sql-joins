USE sakila;

#1
SELECT * FROM sakila.film;
SELECT * FROM sakila.category;
SELECT * FROM sakila.film_category;

#Table A: film
#Table B: film_category
#Table C: category
#INNER JOIN film_category AS fc
#ON f.film_id = fc.film_id
#This combines film and film_category into a temporary “table” (let’s call it AB).
#Each row in AB now represents a film linked to its category IDs.
#(AB)
#INNER JOIN category AS c
#ON fc.category_id = c.category_id
#Now we take that intermediate AB result and join it to category (table C) using the matching category_id.
#The final result (ABC) contains:
#film info (from film)
#category link info (from film_category)
#category name (from category)

SELECT c.name AS categories, COUNT(f.title) AS nr_of_films FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY categories;

#2
SELECT * FROM sakila.rental;
SELECT * FROM sakila.city;
SELECT * FROM sakila.country;
SELECT * FROM sakila.store;
SELECT * FROM sakila.address;	

#FROM is the first thing that SQL does -> JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
SELECT store_id, city, country 
FROM sakila.city AS c
INNER JOIN sakila.country AS ct
ON c.country_id = ct.country_id
INNER JOIN sakila.address AS a
ON c.city_id = a.city_id
INNER JOIN sakila.store AS s
ON a.address_id = s.address_id
GROUP BY store_id;

#3
SELECT * FROM sakila.store;
SELECT * FROM sakila.payment;
SELECT * FROM sakila.staff;

#When the erros message says it is ambigous its bc I didnt specified which table the variable belongs to.
#Por exemplo no SELECT eu tinha apenas store_id mas existem mais store_ids referenciados na query
SELECT s.store_id AS store, SUM(amount) AS total_revenue
FROM sakila.store AS s
INNER JOIN sakila.staff AS st
ON s.store_id = st.store_id
INNER JOIN sakila.payment AS p
ON st.staff_id = p.staff_id
GROUP BY store;

#4
SELECT * FROM sakila.film;
SELECT * FROM sakila.film;

SELECT name AS category, AVG(length) AS avg_film_length
FROM sakila.film AS f
INNER JOIN sakila.film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN sakila.category AS c
ON fc.category_id = c.category_id
GROUP BY category;

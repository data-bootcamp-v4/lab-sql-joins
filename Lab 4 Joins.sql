USE sakila;

SELECT *
FROM film f
LEFT JOIN film_category c
ON f.film_id = c.film_id;


SELECT c.category_id AS film_category_id, COUNT(f.film_id) AS number_of_films
FROM film f
LEFT JOIN film_category c
ON f.film_id = c.film_id
GROUP BY c.category_id
ORDER BY number_of_films DESC;

SELECT store_id, country, city
From address a
RIGHT JOIN store s
ON a.address_id = s.address_id
LEFT JOIN city c
ON a.city_id = c.city_id
LEFT JOIN country r
ON c.country_id = r.country_id;

SELECT *
FROM store;

SELECT *
fROM payment;

SELECT store_id, SUM(amount) AS total_revenue
From payment p
INNER JOIN staff s
ON p.staff_id = s.staff_id
GROUP BY store_id;

SELECT *
FROM film_category;


SELECT ROUND(AVG(length),2) AS avg_length, category_id
From film f
INNER JOIN film_category c
ON f.film_id = c.film_id
GROUP BY category_id
ORDER BY avg_length DESC;

SELECT COUNT(rental_id) AS total, title
FROM rental r
INNER JOIN inventory i 
ON r.inventory_id = i.inventory_id
INNER JOIN film f 
ON f.film_id = i.film_id
GROUP BY title
ORDER BY total DESC;

SELECT store_id, title, inventory_id
FROM inventory i 
INNER JOIN film f
ON i.film_id = f.film_id
WHERE title = "Academy Dinosaur"; 

SELECT title, COUNT(inventory_id)
FROM inventory i 
INNER JOIN film f
ON i.film_id = f.film_id
GROUP BY title; 
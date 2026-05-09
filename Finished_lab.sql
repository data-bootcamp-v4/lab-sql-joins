-- 1. 

USE sakila;
SELECT category.name AS category,
COUNT(film.film_id) AS numver_of_films
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN film 
ON film_category.film_id = film.film_id
GROUP BY category.name;

-- 2.
SELECT store.store_id, city.city_id, country.country
FROM store
JOIN address
ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 3. 
SELECT store.store_id, SUM(payment.amount) AS total_revenue
FROM store
JOIN customer
ON store.store_id = customer.store_id
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;

-- 4. 
SELECT category.name AS category,AVG(film.length) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

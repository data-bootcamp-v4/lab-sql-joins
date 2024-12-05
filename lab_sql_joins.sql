USE sakila;

SELECT c.name AS categoria, COUNT(f.film_id) AS num_peliculas
FROM category c
JOIN film_category fc 
ON c.category_id = fc.category_id
JOIN film f 
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY num_peliculas DESC;

SELECT c.name, count(fc.category_id) as num_films
FROM film_category as fc
JOIN category as c
USING(category_id)
GROUP BY c.name
ORDER BY num_films DESC;

SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a 
ON s.address_id = a.address_id
JOIN city c 
ON a.city_id = c.city_id
JOIN country co 
ON c.country_id = co.country_id;

SELECT s.store_id, ci.city, co.country
FROM store as s
JOIN address
USING(address_id)
JOIN city as ci
USING(city_id)
JOIN country as co
USING (country_id);

SELECT s.store_id, c.city, SUM(p.amount) as total_revenue
FROM customer as cu
JOIN store as s
USING(store_id)
JOIN payment as p
USING(customer_id)
JOIN address as a
ON s.address_id = a.address_id
JOIN city as c
USING(city_id)
GROUP BY s.store_id, c.city
ORDER BY total_revenue DESC;

SELECT s.store_id, SUM(p.amount) as total_revenue
FROM customer
JOIN store as s
USING(store_id)
JOIN payment as p
USING(customer_id)
GROUP BY s.store_id
ORDER BY total_revenue DESC;

SELECT c.name, ROUND(AVG(f.length)) as average_running_time
FROM film as f
JOIN film_category
USING(film_id)
JOIN category as c
USING(category_id)
GROUP BY c.name
ORDER BY average_running_time DESC;
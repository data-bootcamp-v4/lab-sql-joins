use sakila;

select * from category;
SELECT * from film;
SELECT * FROM film_category;

SELECT
	c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM category c
JOIN film_category fc
	ON c.category_id = fc.category_id
JOIN film f 
	ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY number_of_films DESC;

select * from store;
select * from inventory;
SELECT * from rental;
SELECT * FROM payment;

-- 2. Retrieve the store ID, city, and country for each store
SELECT 
	s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a 
	ON s.address_id = a.address_id
JOIN city ci
	ON a.city_id = ci.city_id
JOIN country co
ON ci.country_id = co.country_id;
    
SELECT
	s.store_id,
    SUM(p.amount) AS total_revenue
FROM store s 
JOIN inventory i 
	ON s.store_id = i.store_id
JOIN rental r 
	ON i.inventory_id = r.inventory_id
JOIN payment p
	ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;
    
    
select * from category;
select * from film_category;
SELECT * from film;

-- Average running time of films for each category
SELECT
	c.name AS movie_category,
    ROUND(avg(f.length), 2) AS average_running_time
FROM category c
JOIN film_category fc
	ON c.category_id = fc.category_id
JOIN film f 
	ON f.film_id = fc.film_id
GROUP BY movie_category
ORDER BY average_running_time DESC;


	
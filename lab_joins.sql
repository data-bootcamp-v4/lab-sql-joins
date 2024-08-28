USE sakila;

SELECT c.name AS category_name, COUNT(fc.film_id) AS number_of_films FROM film_category AS fc
JOIN sakila.category AS c 
ON fc.category_id = c.category_id
GROUP BY c.name;

SELECT store_id, city, country FROM sakila.store AS s
JOIN sakila.address AS ad
ON s.address_id = ad.address_id
JOIN sakila.city AS ci
ON ci.city_id = ad.city_id
JOIN sakila.country AS co
ON ci.country_id = co.country_id;


SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM sakila.store AS s
JOIN sakila.inventory AS i ON s.store_id = i.store_id
JOIN sakila.rental AS r ON i.inventory_id = r.inventory_id
JOIN sakila.payment AS p ON r.rental_id = p.rental_id
GROUP BY s.store_id;

SELECT c.name AS category_name, AVG(f.length) AS average_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_running_time DESC;
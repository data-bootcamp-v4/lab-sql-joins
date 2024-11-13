use sakila;
SELECT * FROM sakila.film AS f
JOIN sakila.film_category AS fc
ON f.film_id = fc.film_id;
#2
SELECT s.store_id, ci.city AS City, co.country AS Country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;
#3
SELECT s.store_id, ROUND(SUM(p.amount), 2) AS Total_Revenue
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN store AS s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY Total_Revenue DESC;
#4
SELECT c.name AS Category, ROUND(AVG(f.length), 2) AS Average_Length
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY Average_Length DESC;

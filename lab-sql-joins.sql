SELECT 
c.name,
COUNT(DISTINCT fc.film_id) AS total
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
GROUP BY c.name;

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
c.store_id,
SUM(p.amount) total
FROM payment p
JOIN customer c 
ON p.customer_id = c.customer_id
GROUP BY c.store_id;

SELECT
c.name,
AVG(DISTINCT f.length) time
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name;

SELECT
c.name,
AVG(DISTINCT f.length) time
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY time DESC
LIMIT 2;

SELECT i.title, COUNT(r.rental_id) count
FROM (
	SELECT f.title, i.inventory_id
	FROM inventory i
	LEFT JOIN film F
	ON i.film_id = f.film_id) i
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY i.title
ORDER BY count DESC
LIMIT 10;









USE sakila;

-- 1
SELECT c.name, COUNT(fc.film_id) AS film_count FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
GROUP BY c.name;

-- 2
SELECT s.store_id, ci.city, co.country FROM store AS s
JOIN address AS a
ON s.address_id = a.address_id
JOIN city AS ci 
ON a.city_id = ci.city_id
JOIN country AS co
ON ci.country_id = co.country_id;

-- 3
SELECT s.store_id, SUM(p.amount) AS total_revenue FROM payment AS p
JOIN rental AS r
ON p.rental_id = r.rental_id
JOIN inventory AS i 
ON r.inventory_id = i.inventory_id
JOIN store AS s 
ON i.store_id = s.store_id
GROUP BY s.store_id;

-- 4
SELECT c.name, AVG(f.length) AS avg_length FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c 
ON fc.category_id = c.category_id
GROUP BY c.name;

-- 5
SELECT c.name, AVG(f.length) AS avg_length FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c 
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 1;

-- 6
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i 
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- 7
SELECT f.title, i.store_id FROM film f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;

-- 8
SELECT f.TITLE,
       CASE WHEN i.FILM_ID IS NOT NULL THEN 'Available' ELSE 'NOT available' END AS availability
FROM FILM f
LEFT JOIN INVENTORY i ON f.FILM_ID = i.FILM_ID;




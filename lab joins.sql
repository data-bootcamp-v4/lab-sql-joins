USE sakila;

-- QUESTION 1:
SELECT c.name AS category_name, COUNT(fc.film_id) AS film_count
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_ID = fc.category_ID
GROUP BY c.name;

-- QUESTION 2:
SELECT store_id, city, country
FROM store AS s
INNER JOIN address AS a
ON s.address_id = a.address_id
INNER JOIN city AS ci
ON a.city_id = ci.city_id
INNER JOIN country AS co
ON ci.country_id = co.country_id;

-- QUESTION 3:
SELECT c.store_id, SUM(p.amount) AS total_revenue
FROM payment AS p
INNER JOIN customer AS c
ON p.customer_id = c.customer_id
GROUP BY c.store_id;

-- QUESTION 4:
SELECT c.name AS cat_name, ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id
INNER JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.name;

-- BONUS:
-- QUESTION 5:
SELECT c.name AS cat_name, ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id
INNER JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

-- QUESTION 6:
SELECT f.film_id, f.title, COUNT(rental_id) AS rental_count
FROM rental AS r
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id 
INNER JOIN film AS f
ON i.film_id = f.film_id
GROUP BY film_id, title
ORDER BY rental_count DESC
LIMIT 10;

-- QUESTION 7:
SELECT f.title AS film_title, i.inventory_id, s.store_id
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN store AS s
ON i.store_id = s.store_id
WHERE f.title = "Academy Dinosaur" AND s.store_id = 1;

-- QUESTION 8:
SELECT
    f.title AS film_title,
    CASE
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;

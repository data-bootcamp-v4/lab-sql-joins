USE Sakila;

-- 1
SELECT 
COUNT(film_id)
FROM film
GROUP BY
rating;

SELECT 
s.store_id, 
ci.city, 
co.country
FROM store AS s
JOIN address AS a 
ON s.address_id = a.address_id
JOIN city AS ci 
ON a.city_id = ci.city_id
JOIN country AS co 
ON ci.country_id = co.country_id;

SELECT
s.store_id,
SUM(p.amount) as total
FROM store AS s 
JOIN staff as st
ON s.store_id = st.store_id
JOIN payment as p
GROUP BY
s.store_id;

SELECT 
ca.name, 
AVG(f.length) AS media_len
FROM film AS f
JOIN film_category AS fc 
ON f.film_id = fc.film_id
JOIN category AS ca 
ON fc.category_id = ca.category_id
GROUP BY 
ca.name; 

-- 2
SELECT 
ca.name, 
AVG(f.length) AS media_len
FROM film AS f
JOIN film_category AS fc 
ON f.film_id = fc.film_id
JOIN category AS ca 
ON fc.category_id = ca.category_id
GROUP BY 
ca.name
ORDER BY media_len DESC; 

SELECT
f.title, 
COUNT(r.rental_id) as total_alq
FROM film as f 
JOIN inventory as i 
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
GROUP BY 
f.title
ORDER BY
total_alq desc
LIMIT 10; 

SELECT 
f.title,
s.store_id,
COUNT(i.inventory_id) as availability
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN store as s 
ON i.store_id = s.store_id
WHERE f.title = 'ACADEMY DINOSAUR'
GROUP BY s.store_id;

SELECT distinct
f.title, 
CASE 
	WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'Not available'
    ELSE 'Available'
END AS availability
FROM film as f 
LEFT JOIN inventory as i 
ON f.film_id = i.film_id 
ORDER BY 
availability;
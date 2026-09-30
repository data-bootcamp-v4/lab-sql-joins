USE sakila;


-- ejercicio 1
SELECT
c.name AS category,
c.category_id,
COUNT(fc.film_id) AS film_count
FROM category AS c
LEFT JOIN film_category AS fc
ON c.category_id = fc.category_id
GROUP BY
c.name,
c.category_id
ORDER BY
film_count DESC;

-- ejercicio 2
SELECT
s.store_id,
ci.city,
co.country
FROM store AS s
INNER JOIN address AS a 
ON s.address_id = a.address_id
INNER JOIN city AS ci
ON a.city_id = ci.city_id
INNER JOIN country AS co
ON ci.country_id = co.country_id;

-- ejercicio 3
SELECT s.store_id,
CONCAT('$', SUM(p.amount)) AS total_revenue
FROM payment AS p
INNER JOIN staff AS st
ON p.staff_id = st.staff_id
INNER JOIN store AS s
ON st.store_id = s.store_id
GROUP BY
s.store_id;

-- ejercicio 4
SELECT
c.name,
AVG(f.length) AS avg_length_minutes
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY
c.category_id,
c.name;

-- ejercicio 5
SELECT
c.name,
AVG(f.length) AS avg_length_minutes
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY
c.category_id,
c.name
ORDER BY avg_length_minutes DESC
LIMIT 5;

-- ejercicio 6
SELECT
f.title,
COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY
f.film_id,
f.title
ORDER BY rental_count DESC
LIMIT 10;

-- ejercicio 7
SELECT
f.title,
i.inventory_id,
i.store_id
FROM film AS f
JOIN inventory AS i 
ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1;

-- ejercicio 8
SELECT DISTINCT
f.title,
CASE
    WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
    ELSE 'Available'
END AS availability
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
ORDER BY f.title;



























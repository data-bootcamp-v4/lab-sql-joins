USE sakila;

-- 1.
SELECT c.name, COUNT(*) AS total_films
FROM film_category AS fc
JOIN category AS c
  ON fc.category_id = c.category_id
GROUP BY c.name;


-- 2.
SELECT s.store_id, ci.city, co.country
FROM store AS s
JOIN address AS a
  ON s.address_id = a.address_id
JOIN city AS ci
  ON a.city_id = ci.city_id
JOIN country AS co
  ON ci.country_id = co.country_id;


-- 3. 
SELECT st.store_id, SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN staff AS st
  ON p.staff_id = st.staff_id
GROUP BY st.store_id;


-- 4.
SELECT c.name, ROUND(AVG(f.length), 2) AS avg_length
FROM film AS f
JOIN film_category AS fc
  ON f.film_id = fc.film_id
JOIN category AS c
  ON fc.category_id = c.category_id
GROUP BY c.name;


-- 5.
SELECT c.name, ROUND(AVG(f.length), 2) AS avg_length
FROM film AS f
JOIN film_category AS fc
  ON f.film_id = fc.film_id
JOIN category AS c
  ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;


-- 6.
SELECT f.title, COUNT(*) AS times_rented
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 10;


-- 7.
SELECT f.title, i.store_id, i.inventory_id
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1;


-- 8.
SELECT DISTINCT f.title,
  CASE
    WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
    ELSE 'Available'
  END AS availability
FROM film AS f
LEFT JOIN inventory AS i
  ON f.film_id = i.film_id;
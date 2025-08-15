USE sakila;

SELECT c.name AS category, COUNT(fc.film_id) AS num_films
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY num_films DESC, c.name;

SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a   ON s.address_id = a.address_id
JOIN city ci     ON a.city_id     = ci.city_id
JOIN country co  ON ci.country_id = co.country_id
ORDER BY s.store_id;

SELECT s.store_id, ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s  ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY s.store_id;

SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f           ON f.film_id      = fc.film_id
GROUP BY c.name
ORDER BY avg_length_minutes DESC, c.name;

-- Bonus

SELECT t.name AS category, ROUND(t.avg_len, 2) AS avg_length_minutes
FROM (
  SELECT c.name, AVG(f.length) AS avg_len
  FROM category c
  JOIN film_category fc ON fc.category_id = c.category_id
  JOIN film f           ON f.film_id      = fc.film_id
  GROUP BY c.name
) AS t
WHERE t.avg_len = (
  SELECT MAX(x.avg_len) FROM (
    SELECT AVG(f.length) AS avg_len
    FROM category c
    JOIN film_category fc ON fc.category_id = c.category_id
    JOIN film f           ON f.film_id      = fc.film_id
    GROUP BY c.name
  ) AS x
);

-- top 10 most freq rented

SELECT f.title, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f      ON i.film_id      = f.film_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC, f.title
LIMIT 10;

-- Academy dinosaur

SELECT COUNT(*) AS copies_available_now
FROM inventory i
JOIN film f ON f.film_id = i.film_id
LEFT JOIN rental r
  ON r.inventory_id = i.inventory_id
  AND r.return_date IS NULL         
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1
  AND r.rental_id IS NULL;  
  
-- All titles availability

SELECT
  f.title,
  CASE WHEN IFNULL(inv.copies, 0) > 0
       THEN 'Available'
       ELSE 'NOT available'
  END AS availability
FROM film f
LEFT JOIN (
  SELECT film_id, COUNT(*) AS copies
  FROM inventory
  GROUP BY film_id
) AS inv
  ON inv.film_id = f.film_id
ORDER BY f.title;

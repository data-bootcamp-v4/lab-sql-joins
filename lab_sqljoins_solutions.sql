USE sakila;
SELECT 
  c.name AS category,
  COUNT(*) AS film_count
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY film_count DESC, category ASC;
SELECT
  s.store_id,
  ci.city,
  co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci   ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
ORDER BY s.store_id;
SELECT
  s.store_id,
  ROUND(SUM(p.amount), 2) AS revenue_usd
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s  ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY s.store_id;
SELECT
  c.name AS category,
  ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f          ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_minutes DESC;
WITH cat_avg AS (
  SELECT c.category_id, c.name AS category, AVG(f.length) AS avg_len
  FROM category c
  JOIN film_category fc ON c.category_id = fc.category_id
  JOIN film f          ON fc.film_id = f.film_id
  GROUP BY c.category_id, c.name
)
SELECT category, ROUND(avg_len, 2) AS avg_length_minutes
FROM cat_avg
WHERE avg_len = (SELECT MAX(avg_len) FROM cat_avg);
SELECT
  f.title,
  COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f      ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC, f.title
LIMIT 10;
SELECT
  CASE WHEN COUNT(*) > 0 THEN 'Available' ELSE 'NOT available' END AS can_be_rented,
  COUNT(*) AS available_copies
FROM inventory i
LEFT JOIN rental r 
  ON r.inventory_id = i.inventory_id
  AND r.return_date IS NULL
WHERE i.store_id = 1
  AND i.film_id = (SELECT film_id FROM film WHERE title = 'Academy Dinosaur')
  AND r.rental_id IS NULL;
SELECT
  f.title,
  CASE 
    WHEN IFNULL(COUNT(i.inventory_id), 0) > 0 THEN 'Available'
    ELSE 'NOT available'
  END AS availability
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY availability DESC, f.title;

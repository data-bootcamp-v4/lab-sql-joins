USE sakila;
-- 1
SELECT * FROM film;
SELECT 
    c.name AS category,
    COUNT(fc.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY film_count DESC;

-- 2
SELECT
  s.store_id,
  ci.city,
  co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
ORDER BY s.store_id;

-- 3
SELECT
  st.store_id,
  ROUND(SUM(p.amount), 2) AS total_revenue
FROM store st
JOIN staff sf ON st.store_id = sf.store_id
JOIN payment p ON sf.staff_id = p.staff_id
GROUP BY st.store_id
ORDER BY total_revenue DESC;

-- 4
SELECT
  c.name AS category,
  ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_minutes DESC;

-- 5
SELECT
  c.name AS category,
  ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_minutes DESC
LIMIT 1;

-- 6
SELECT
  f.film_id,
  f.title,
  COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC
LIMIT 10;

-- 7
SELECT
  i.inventory_id,
  CASE WHEN r.rental_id IS NULL THEN 'Available' ELSE 'Rented (currently out)' END AS status
FROM inventory i
JOIN film f ON i.film_id = f.film_id
LEFT JOIN rental r
  ON i.inventory_id = r.inventory_id
  AND r.return_date IS NULL   -- currently rented if return_date IS NULL
WHERE i.store_id = 1
  AND f.title = 'Academy Dinosaur';


-- 8
SELECT
  f.title,
  CASE WHEN IFNULL(inv.cnt, 0) > 0 THEN 'Available' ELSE 'NOT available' END AS availability
FROM film f
LEFT JOIN (
  SELECT film_id, COUNT(*) AS cnt
  FROM inventory
  GROUP BY film_id
) AS inv ON f.film_id = inv.film_id
ORDER BY availability DESC, f.title;
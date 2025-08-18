USE sakila;
SELECT 
  c.name AS category,
  COUNT(*) AS film_count
FROM category c
JOIN film_category fc  ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY film_count DESC, category;

SELECT 
  s.store_id,
  ci.city,
  co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci   ON a.city_id    = ci.city_id
JOIN country co ON ci.country_id = co.country_id
ORDER BY s.store_id;

SELECT 
  s.store_id,
  ROUND(SUM(p.amount), 2) AS revenue_usd
FROM payment p
JOIN rental r   ON p.rental_id   = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s    ON i.store_id    = s.store_id
GROUP BY s.store_id
ORDER BY s.store_id;

SELECT 
  st.store_id,
  ROUND(SUM(p.amount), 2) AS revenue_usd
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
GROUP BY st.store_id
ORDER BY st.store_id;

SELECT
  c.name AS category,
  ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f          ON f.film_id      = fc.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_minutes DESC;

SELECT
  c.name AS category,
  ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f          ON f.film_id      = fc.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_minutes DESC
LIMIT 1;

SELECT 
  f.title,
  COUNT(*) AS rentals
FROM film f
JOIN inventory i ON i.film_id      = f.film_id
JOIN rental r    ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rentals DESC, f.title
LIMIT 10;

SELECT 
  CASE WHEN SUM(CASE WHEN r.rental_id IS NULL THEN 1 ELSE 0 END) > 0
       THEN 'Available' ELSE 'NOT available' END AS status,
  SUM(CASE WHEN r.rental_id IS NULL THEN 1 ELSE 0 END) AS available_copies
FROM inventory i
LEFT JOIN rental r 
  ON r.inventory_id = i.inventory_id
 AND r.return_date IS NULL      -- only treat not-yet-returned rentals as "out"
WHERE i.store_id = 1
  AND i.film_id = (SELECT film_id FROM film WHERE title = 'Academy Dinosaur');

SELECT 
  f.title,
  CASE 
    WHEN IFNULL(COUNT(i.inventory_id), 0) > 0 
      THEN 'Available' 
      ELSE 'NOT available' 
  END AS availability
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;

USE sakila;

-- 1) Number of films per category
SELECT c.name AS category, COUNT(fc.film_id) AS film_count
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY film_count DESC, category;

-- 2) Store ID, city, country for each store
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON a.address_id = s.address_id
JOIN city ci   ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
ORDER BY s.store_id;

-- 3) Total revenue by store (USD)
SELECT s.store_id, ROUND(SUM(p.amount), 2) AS total_revenue_usd
FROM payment p
JOIN rental r    ON r.rental_id = p.rental_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN store s     ON s.store_id = i.store_id
GROUP BY s.store_id
ORDER BY total_revenue_usd DESC;

-- 4) Average running time of films per category (minutes)
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length_min
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f           ON f.film_id = fc.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_min DESC;

-- ===== Bonus =====

-- B1) Film categories with the longest average running time (handles ties)
WITH avg_len AS (
  SELECT c.category_id, c.name, AVG(f.length) AS avg_len
  FROM category c
  JOIN film_category fc ON fc.category_id = c.category_id
  JOIN film f           ON f.film_id = fc.film_id
  GROUP BY c.category_id, c.name
)
SELECT name, ROUND(avg_len,2) AS avg_length_min
FROM avg_len
WHERE avg_len = (SELECT MAX(avg_len) FROM avg_len);

-- B2) Top 10 most frequently rented movies
SELECT f.film_id, f.title, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f      ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC, f.title
LIMIT 10;

-- B3) Can "Academy Dinosaur" be rented from Store 1 right now?
WITH last_rental AS (
  SELECT i.inventory_id,
         MAX(r.rental_id) AS last_rental_id
  FROM inventory i
  LEFT JOIN rental r ON r.inventory_id = i.inventory_id
  GROUP BY i.inventory_id
),
status AS (
  SELECT i.inventory_id,
         CASE
           WHEN lr.last_rental_id IS NULL THEN 1
           WHEN r.return_date IS NOT NULL THEN 1
           ELSE 0
         END AS is_available
  FROM inventory i
  LEFT JOIN last_rental lr ON lr.inventory_id = i.inventory_id
  LEFT JOIN rental r ON r.rental_id = lr.last_rental_id
  JOIN film f ON f.film_id = i.film_id
  WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
)
SELECT
  CASE WHEN SUM(is_available) > 0 THEN 'Available'
       ELSE 'NOT available'
  END AS academy_dinosaur_store1_status,
  IFNULL(SUM(is_available),0) AS available_copies
FROM status;

-- B4) All distinct titles with availability status in inventory (42 are NOT in inventory)
SELECT
  f.title,
  CASE WHEN IFNULL(COUNT(i.inventory_id),0) > 0
       THEN 'Available'
       ELSE 'NOT available'
  END AS availability
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY availability DESC, f.title;

USE SAKILA;
SELECT
  c.name AS category,
  COUNT(*) AS film_count
FROM category AS c
JOIN film_category AS fc ON fc.category_id = c.category_id
JOIN film AS f ON f.film_id = fc.film_id
GROUP BY c.category_id, c.name
ORDER BY film_count DESC, category;

SELECT
  s.store_id,
  ci.city,
  co.country
FROM store AS s
JOIN address AS a   ON a.address_id = s.address_id
JOIN city    AS ci  ON ci.city_id = a.city_id
JOIN country AS co  ON co.country_id = ci.country_id
ORDER BY s.store_id;

SELECT
  st.store_id,
  ROUND(SUM(p.amount), 2) AS total_revenue_usd
FROM payment AS p
JOIN staff   AS sf ON sf.staff_id = p.staff_id
JOIN store   AS st ON st.store_id = sf.store_id
GROUP BY st.store_id
ORDER BY st.store_id;

SELECT
  c.name AS category,
  ROUND(AVG(f.length), 2) AS avg_running_time_minutes
FROM category AS c
JOIN film_category AS fc ON fc.category_id = c.category_id
JOIN film AS f           ON f.film_id = fc.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_running_time_minutes DESC;

WITH cat_avg AS (
  SELECT
    c.category_id,
    c.name,
    AVG(f.length) AS avg_len
  FROM category AS c
  JOIN film_category AS fc ON fc.category_id = c.category_id
  JOIN film AS f           ON f.film_id = fc.film_id
  GROUP BY c.category_id, c.name
)

SELECT
  name AS category,
  ROUND(avg_len, 2) AS avg_running_time_minutes
FROM cat_avg
WHERE avg_len = (SELECT MAX(avg_len) FROM cat_avg);

SELECT
  f.film_id,
  f.title,
  COUNT(*) AS rental_count
FROM rental AS r
JOIN inventory AS i ON i.inventory_id = r.inventory_id
JOIN film     AS f ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC, f.title
LIMIT 10;

SELECT
  CASE
    WHEN SUM(CASE WHEN ro.inventory_id IS NULL THEN 1 ELSE 0 END) > 0
      THEN 'Available'
    ELSE 'NOT available'
  END AS can_be_rented_from_store_1
FROM inventory AS i
JOIN film AS f ON f.film_id = i.film_id
LEFT JOIN (
  SELECT inventory_id
  FROM rental
  WHERE return_date IS NULL   -- open (unreturned) rentals
) AS ro ON ro.inventory_id = i.inventory_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1;

SELECT
  f.title,
  CASE
    WHEN IFNULL(inv.copies, 0) > 0 THEN 'Available'
    ELSE 'NOT available'
  END AS availability
FROM film AS f
LEFT JOIN (
  SELECT film_id, COUNT(*) AS copies
  FROM inventory
  GROUP BY film_id
) AS inv ON inv.film_id = f.film_id
ORDER BY f.title;
USE sakila;
SELECT c.name AS category, COUNT(*) AS film_count
FROM category AS c
JOIN film_category AS fc ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY film_count DESC, category;

SELECT s.store_id, ci.city, co.country
FROM store AS s
JOIN address AS a   ON a.address_id = s.address_id
JOIN city    AS ci  ON ci.city_id   = a.city_id
JOIN country AS co  ON co.country_id = ci.country_id
ORDER BY s.store_id;

SELECT s.store_id, ROUND(SUM(p.amount), 2) AS total_revenue_usd
FROM payment AS p
JOIN staff   AS st ON st.staff_id = p.staff_id
JOIN store   AS s  ON s.store_id  = st.store_id
GROUP BY s.store_id
ORDER BY s.store_id;

SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length_min
FROM film AS f
JOIN film_category AS fc ON fc.film_id = f.film_id
JOIN category      AS c  ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY avg_length_min DESC, category;

SELECT category, ROUND(avg_length_min, 2) AS avg_length_min
FROM (
  SELECT c.name AS category,
         AVG(f.length) AS avg_length_min,
         DENSE_RANK() OVER (ORDER BY AVG(f.length) DESC) AS rnk
  FROM film AS f
  JOIN film_category AS fc ON fc.film_id = f.film_id
  JOIN category      AS c  ON c.category_id = fc.category_id
  GROUP BY c.name
) AS t
WHERE t.rnk = 1;

SELECT f.title, COUNT(r.rental_id) AS times_rented
FROM film AS f
JOIN inventory AS i ON i.film_id = f.film_id
JOIN rental   AS r ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC, f.title
LIMIT 10;

SELECT CASE
         WHEN EXISTS (
           SELECT 1
           FROM inventory AS i
           JOIN film AS f ON f.film_id = i.film_id
           WHERE f.title = 'Academy Dinosaur'
             AND i.store_id = 1
             AND NOT EXISTS (
               SELECT 1
               FROM rental AS r
               WHERE r.inventory_id = i.inventory_id
                 AND r.return_date IS NULL
             )
         )
         THEN 'Available'
         ELSE 'NOT available'
       END AS status_for_store_1;

SELECT
  f.title,
  CASE WHEN IFNULL(inv.copies, 0) > 0 THEN 'Available' ELSE 'NOT available' END AS availability
FROM film AS f
LEFT JOIN (
  SELECT i.film_id, COUNT(*) AS copies
  FROM inventory AS i
  GROUP BY i.film_id
) AS inv
ON inv.film_id = f.film_id
ORDER BY availability DESC, f.title;
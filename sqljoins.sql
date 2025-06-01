USE sakila; 
-- TASK 1

SELECT c.name AS category, COUNT(fc.film_id) AS film_count
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY film_count DESC;

-- TASK 2
select * from store;

SELECT
  s.store_id,
  ci.city,
  co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- TASK 3
SELECT * FROM store;

SELECT
  s.store_id,
  ROUND(SUM(p.amount), 2) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- TASK 4

SELECT
  c.name AS category,
  ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;
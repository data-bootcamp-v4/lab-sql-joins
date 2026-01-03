use sakila;
SELECT
  c.name AS category,
  COUNT(fc.film_id) AS number_of_films
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY number_of_films DESC;
-----
SELECT
  s.store_id,
  ci.city,
  co.country
FROM store AS s
JOIN address AS a
  ON s.address_id = a.address_id
JOIN city AS ci
  ON a.city_id = ci.city_id
JOIN country AS co
  ON ci.country_id = co.country_id
ORDER BY s.store_id;
-----
SELECT
  s.store_id,
  ROUND(SUM(p.amount), 2) AS total_revenue
FROM store AS s
JOIN staff AS st
  ON s.store_id = st.store_id
JOIN payment AS p
  ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;
-----
SELECT
  c.name AS category,
  ROUND(AVG(f.length), 2) AS avg_running_time_minutes
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
JOIN film AS f
  ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_running_time_minutes DESC;


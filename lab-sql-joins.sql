USE sakila;

SELECT name as categoria, 
count(*) as num_films
FROM category
JOIN film_category USING (category_id)
GROUP BY name;


-- store_id y address_id en store
-- address_id y city_id en address
-- city_id, city y country_ id en city
-- country_id y country en country


SELECT 
st.store_id,
c.city,
co.country
FROM country AS co
INNER JOIN city AS c
ON c.country_id = co.country_id
INNER JOIN address AS ad
ON c.city_id = ad.city_id
INNER JOIN store AS st
ON ad.address_id = st.address_id;

SELECT *
FROM store;

SELECT 
store.store_id, 
SUM(payment.amount) AS total_revenue
FROM store
JOIN staff 
ON store.store_id = staff.store_id
JOIN payment 
ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

SELECT *
FROM film_category;

SELECT
c.name,
ROUND(AVG(length),2) AS avg_length
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY avg_length DESC;

SELECT
c.name,
ROUND(AVG(length),2) AS avg_length
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 1;

SELECT *
FROM inventory;

SELECT 
title,
COUNT(rental_id) AS num_rental
FROM rental AS r
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id
INNER JOIN film as f
ON f.film_id = i.film_id
GROUP BY title
ORDER BY num_rental DESC
LIMIT 10;

SELECT
  CASE
    WHEN COUNT(*) > 0 THEN 'Available'
    ELSE 'Not Available'
  END AS availability
FROM inventory
WHERE film_id = 1 AND store_id = 1;

SELECT *
FROM inventory;

SELECT 
title,
  CASE
    WHEN i.inventory_id IS NOT NULL THEN 'Available'
    ELSE 'NOT available'
  END AS availability
FROM film AS f
LEFT JOIN inventory AS i
  ON f.film_id = i.film_id;



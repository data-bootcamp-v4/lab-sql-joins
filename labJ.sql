USE sakila;

-- Script 1
 
SELECT category_id, COUNT(film_id) AS movieCNTbycat
FROM film_category
GROUP BY category_id
order by  category_id;

-- Script 1
SELECT
  c.category_id,
  COUNT(fc.film_id) AS movieCNTbycat
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id;

-- Script 2
SELECT
  s.store_id,
  ci.city,
  cc.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country cc ON ci.country_id = cc.country_id;

-- Script 3
 
SELECT
  s.store_id,
  sum(p.amount) as revenue
FROM store s
JOIN customer cst ON s.store_id = cst.store_id
JOIN payment p ON cst.customer_id = p.customer_id
GROUP BY s.store_id;

-- Script 4

SELECT
  c.category_id,
  COUNT(fc.film_id) AS movieCNTbycat,
  AVG(fi.length) as avgfilmdur
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film fi ON fc.film_id= fi.film_id
GROUP BY c.category_id;

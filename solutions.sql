USE sakila;

SHOW tables;

# 1.
SELECT c.name AS category,
	   COUNT(*) AS films
FROM category c
JOIN film_category fc ON fc.category_id= c.category_id
GROUP BY c.name
ORDER BY films DESC, category;

# 2.
SELECT s.store_id,
	   ci.city,
       co.country
FROM store s
JOIN address a ON a.address_id = s.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
ORDER BY s.store_id;

# 3.
SELECT s.store_id,
       ROUND(SUM(p.amount), 2) AS total_revenue
FROM store s
JOIN inventory i ON i.store_id = s.store_id
JOIN rental r    ON r.inventory_id = i.inventory_id
JOIN payment p   ON p.rental_id    = r.rental_id
GROUP BY s.store_id
ORDER BY s.store_id;

# 4.
SELECT c.name AS category,
       ROUND(AVG(f.length), 1) AS avg_minutes
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f           ON f.film_id      = fc.film_id
GROUP BY c.name
ORDER BY avg_minutes DESC;

# 5.
SELECT c.name AS category,
       ROUND(AVG(f.length), 1) AS avg_minutes
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f           ON f.film_id      = fc.film_id
GROUP BY c.name
ORDER BY avg_minutes DESC
LIMIT 1;

# 6.
SELECT f.title,
	   COUNT(*) AS rentals
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f 	 ON f.film_id	   = i.film_id
GROUP BY f.film_id, f.title
ORDER BY rentals DESC, f.title
LIMIT 10;

# 7.
SELECT CASE WHEN EXISTS (
         SELECT 1
         FROM inventory i
         JOIN film f ON f.film_id = i.film_id
         WHERE f.title = 'Academy Dinosaur'
           AND i.store_id = 1
       )
       THEN 'Yes' ELSE 'No' END AS rentable_from_store_1;

# 8.
SELECT f.title,
       CASE WHEN IFNULL(inv.copies, 0) > 0
            THEN 'Available' ELSE 'NOT available' END AS availability
FROM film f
LEFT JOIN (
  SELECT film_id, COUNT(*) AS copies
  FROM inventory
  GROUP BY film_id
) inv ON inv.film_id = f.film_id
ORDER BY availability DESC, f.title;

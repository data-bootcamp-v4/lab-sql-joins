USE sakila;

SELECT c.name AS category, COUNT(*) AS films_per_category
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

SELECT s.store_id, ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;

SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 1;

SELECT f.title, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT CASE
         WHEN (
           SELECT COUNT(*) FROM inventory i
           JOIN film f ON i.film_id = f.film_id
           WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1
         ) - (
           SELECT COUNT(*) FROM rental r
           JOIN inventory i2 ON r.inventory_id = i2.inventory_id
           JOIN film f2 ON i2.film_id = f2.film_id
           WHERE f2.title = 'ACADEMY DINOSAUR' AND i2.store_id = 1 AND r.return_date IS NULL
         ) > 0
       THEN 'Available' ELSE 'NOT available' END AS academy_dinosaur_store_1;

SELECT f.title,
       CASE WHEN IFNULL(inv.copies, 0) > 0 THEN 'Available' ELSE 'NOT available' END AS availability
FROM film f
LEFT JOIN (
  SELECT film_id, COUNT(*) AS copies
  FROM inventory
  GROUP BY film_id
) inv ON inv.film_id = f.film_id
ORDER BY f.title;
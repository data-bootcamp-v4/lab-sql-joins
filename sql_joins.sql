USE sakila;

-- 1. Number of films per category
SELECT c.name AS category,
       COUNT(fc.film_id) AS number_of_films
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;

-- 2. Store ID, city, and country
SELECT s.store_id,
       ci.city,
       co.country
FROM store s
JOIN address a
    ON s.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
JOIN country co
    ON ci.country_id = co.country_id;

-- 3. Total revenue by store
SELECT s.store_id,
       ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN customer c
    ON p.customer_id = c.customer_id
JOIN store s
    ON c.store_id = s.store_id
GROUP BY s.store_id;

-- 4. Average running time per category
SELECT c.name AS category,
       ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

-- Bonus 1: Categories with longest average running time
SELECT c.name AS category,
       ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc
    ON f.film_id = fc.film_id
JOIN category c
    ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 3;

-- Bonus 2: Top 10 most rented movies
SELECT f.title,
       COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i
    ON r.inventory_id = i.inventory_id
JOIN film f
    ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- Bonus 3: Availability of "Academy Dinosaur" in Store 1
SELECT COUNT(*) AS copies_in_store_1
FROM inventory i
JOIN film f
    ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1;

-- Bonus 4: Film availability status
SELECT f.title,
       CASE
           WHEN IFNULL(COUNT(i.inventory_id), 0) > 0
           THEN 'Available'
           ELSE 'NOT available'
       END AS availability_status
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;

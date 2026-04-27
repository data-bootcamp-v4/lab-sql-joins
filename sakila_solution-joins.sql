use sakila;
-- Challenge 1: Join & Agg methods

-- Part 1: Number of films by category name 
-- AS statements are OPTIONAL when aliasing (like c for category_name)
SELECT c.name AS category_name, COUNT(fc.film_id) AS number_of_films
FROM category AS c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- Part 2: Store ID, City & Country
-- Connect store s > address a > city ci > country co 
SELECT s.store_id, ci.city, co.country
FROM store AS s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- Part 3: Total revenue per store
-- Connect store s > payment p > staff st > back to store
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store AS s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- Part 4: Avg runtime by category
SELECT c.name AS category_name, ROUND(AVG(f.length), 2) 
AS avg_running_time 
FROM category AS c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- BONUS: Longest avg runtime 
-- same as 4, but order output by avg_running_time 
SELECT c.name AS category_name, AVG(f.length) 
AS avg_running_time
FROM category AS c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 1;
-- returns Sports 128.2 mins

-- Find 10 most rented movies
-- Connect film f -> inventory i -> rental r
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;
-- returns BUCKET BROTHERHOOD, ROCKETEER MOTHER, RIDGEMONT SUBMARINE, etc. 

-- Is 'Academy Dinosaur' movie available at Store 1?
SELECT f.title, s.store_id, COUNT(i.inventory_id) AS copies_in_stock
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
WHERE f.title = 'ACADEMY DINOSAUR' AND s.store_id = 1
GROUP BY f.title, s.store_id;
-- Yes, 4 copies available

-- Compare titles list to Inventory
-- LEFT Join to include all movies, not just ones in inventory (some films are missing in i)
SELECT 
    f.title,
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;
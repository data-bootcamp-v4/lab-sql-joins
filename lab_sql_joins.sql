-- number of films per category - challenge - joining tables
SELECT 
    c.name AS category,
    COUNT(fc.film_id) AS film_count
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY film_count DESC;

-- grab store data
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- total revenue at each store
SELECT 
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;

-- average running film time by cat
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_duration DESC;

-- bonus first challenge
-- call the film cats with the longest run time
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_duration DESC;

-- top 10 most frequently rented (descending)
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- can Academy Dinosaur be rented from store loc 1
SELECT 
    f.title,
    s.store_id,
    COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY f.title, s.store_id;

-- list distinct titles and their availability
SELECT 
    f.title,
    CASE 
        WHEN IFNULL(inv.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film f
LEFT JOIN inventory inv ON f.film_id = inv.film_id
GROUP BY f.title, availability
ORDER BY f.title;

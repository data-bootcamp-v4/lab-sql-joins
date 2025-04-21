SELECT c.name AS category, COUNT(fc.film_id) AS number_of_films
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id;
SELECT s.store_id, 
       SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_duration DESC;
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_duration DESC
LIMIT 1;
SELECT f.title AS film_title, 
       COUNT(r.rental_id) AS times_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 10;
SELECT 
    f.title,
    i.store_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;
SELECT 
    f.title,
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title;




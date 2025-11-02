SELECT  c.name AS category, COUNT(f.film_id) AS number_of_films
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY number_of_films DESC;
-- 2
SELECT s.store_id, ci.city, co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id
ORDER BY s.store_id;
-- 3
SELECT s.store_id,SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN staff AS st ON p.staff_id = st.staff_id
JOIN store AS s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;
-- 4
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_running_time DESC;
-- 5
SELECT f.title,COUNT(r.rental_id) AS rental_count
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;
-- 6
SELECT CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1;
  -- 7
  SELECT f.title, CASE 
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;
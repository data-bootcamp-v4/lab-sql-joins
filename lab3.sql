-- ============================================
-- LAB: SQL Joins - Sakila Database
-- ============================================

-- 1. Número de films por categoría
SELECT c.name AS category, COUNT(fc.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;


-- 2. Store ID, ciudad y país de cada tienda
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


-- 3. Revenue total generado por cada tienda (en dólares)
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;


-- 4. Duración promedio de films por categoría
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;


-- ============================================
-- BONUS
-- ============================================

-- 5. Categorías con mayor duración promedio
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 5;


-- 6. Top 10 películas más alquiladas (orden descendente)
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;


-- 7. ¿Puede "Academy Dinosaur" alquilarse desde Store 1?
SELECT f.title, s.store_id,
    CASE 
        WHEN COUNT(r.return_date IS NOT NULL OR r.rental_id IS NULL) > 0 
        THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
    AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY f.title, s.store_id;


-- 8. Todos los títulos con su disponibilidad en inventario
SELECT DISTINCT f.title,
    CASE 
        WHEN i.film_id IS NULL THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
ORDER BY availability, f.title;



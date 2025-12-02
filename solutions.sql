USE sakila;

---------------------------------------------------
-- 1. Número de películas por categoría
---------------------------------------------------
SELECT 
    c.name AS category,
    COUNT(fc.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY number_of_films DESC;


---------------------------------------------------
-- 2. Store ID, ciudad y país de cada tienda
---------------------------------------------------
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci   ON a.city_id     = ci.city_id
JOIN country co ON ci.country_id = co.country_id
ORDER BY s.store_id;


---------------------------------------------------
-- 3. Ingresos totales generados por cada tienda
---------------------------------------------------
SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r    ON p.rental_id   = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s     ON i.store_id     = s.store_id
GROUP BY s.store_id
ORDER BY s.store_id;


---------------------------------------------------
-- 4. Duración media de las películas por categoría
---------------------------------------------------
SELECT 
    c.name AS category,
    AVG(f.length) AS avg_length_minutes
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f           ON fc.film_id    = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_minutes DESC;


---------------------------------------------------
-- BONUS 5. Categorías con la mayor duración media
---------------------------------------------------
SELECT 
    c.name AS category,
    AVG(f.length) AS avg_length_minutes
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f           ON fc.film_id    = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_minutes DESC
LIMIT 5;


---------------------------------------------------
-- BONUS 6. Top 10 películas más alquiladas
---------------------------------------------------
SELECT 
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f      ON i.film_id      = f.film_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC
LIMIT 10;


---------------------------------------------------
-- BONUS 7. ¿"Academy Dinosaur" disponible en Store 1?
---------------------------------------------------
SELECT 
    CASE 
        WHEN COUNT(*) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS academy_dinosaur_store1_status
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1
  AND inventory_in_stock(i.inventory_id);


---------------------------------------------------
-- BONUS 8. Todos los títulos + estado de disponibilidad
---------------------------------------------------
SELECT 
    f.title,
    CASE
        WHEN IFNULL(COUNT(i.inventory_id), 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;

USE sakila;

-- 1. Listar el número de películas por categoría
SELECT
    c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY number_of_films DESC;

-- 2. Obtener el store ID, ciudad y país de cada tienda
SELECT
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a
    ON s.address_id = a.address_id
JOIN city ci
    ON a.city_id = ci.city_id
JOIN country co
    ON ci.country_id = co.country_id;

-- 3. Calcular los ingresos totales generados por cada tienda
SELECT
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st
    ON s.store_id = st.store_id
JOIN payment p
    ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

-- 4. Determinar la duración media de películas por categoría
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_running_time
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC;

-- 5. BONUS: identificar las categorías con mayor duración media
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_running_time
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC
LIMIT 5;

-- 6. BONUS: mostrar las 10 películas más alquiladas
SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- 7. BONUS: determinar si "Academy Dinosaur" puede alquilarse en Store 1
SELECT
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS copies_available
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1
GROUP BY f.title, i.store_id;

-- 8. BONUS: listar todos los títulos con su estado de disponibilidad
SELECT
    f.title,
    CASE
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title ASC;
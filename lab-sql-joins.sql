USE sakila;

-- Challenge - Joining on multiple tables
-- 1. Número de películas por categoría

select
    c.name AS category,
    COUNT(fc.film_id) AS total_films
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY total_films DESC;

-- 2. Store ID, ciudad y país de cada tienda

SELECT
    s.store_id,
    ci.city,
    co.country
FROM store AS s
JOIN address AS a
    ON s.address_id = a.address_id
JOIN city AS ci
    ON a.city_id = ci.city_id
JOIN country AS co
    ON ci.country_id = co.country_id;

-- 3. Ingresos totales generados por cada tienda

SELECT
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM store AS s
JOIN inventory AS i
    ON s.store_id = i.store_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY s.store_id;

-- 4. Duración media de las películas por categoría

SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_running_time DESC;


-- 5. Bonus: Categoría con la mayor duración media

SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_running_time DESC
LIMIT 1;

-- 6. Bonus: Top 10 películas más alquiladas

SELECT
    f.title,
    COUNT(r.rental_id) AS total_rentals
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY total_rentals DESC
LIMIT 10;

-- 7. Bonus: Comprobar si Academy Dinosaur está disponible en Store 1

SELECT
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS copies
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
    AND i.store_id = 1
GROUP BY f.title, i.store_id;

-- 8. Bonus: Disponibilidad de todas las películas en el inventario

SELECT DISTINCT
    f.title,
    CASE
        WHEN i.inventory_id IS NULL THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
ORDER BY f.title;


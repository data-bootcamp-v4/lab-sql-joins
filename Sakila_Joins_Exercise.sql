
-- 1. Listar el número de películas por categoría
SELECT 
    c.name AS category_name,
    COUNT(f.film_id) AS total_films
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 2. Obtener el ID de la tienda, ciudad y país para cada tienda
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 3. Calcular los ingresos totales generados por cada tienda en dólares
SELECT 
    p.store_id,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY p.store_id;

-- 4. Determinar el tiempo promedio de duración de las películas por categoría
SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

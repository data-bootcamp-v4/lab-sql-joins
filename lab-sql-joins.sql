-- 1. Número de películas por categoría
SELECT category_id
    c.name AS categoria,
    COUNT(f.film_id) AS cantidad_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- 2. ID de la tienda, ciudad y país de cada tienda
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 3. Ingresos totales generados por cada tienda
SELECT 
    p.store_id,
    SUM(p.amount) AS ingresos_totales
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
GROUP BY p.store_id;

-- 4. Tiempo promedio de ejecución de las películas por categoría
SELECT 
    c.name AS categoria,
    ROUND(AVG(f.length), 2) AS duracion_promedio
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- BONUS 1: Categorías con tiempo promedio más largo
SELECT 
    c.name AS categoria,
    ROUND(AVG(f.length), 2) AS duracion_promedio
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY duracion_promedio DESC;

-- BONUS 2: Las 10 películas más alquiladas
SELECT 
    f.title,
    COUNT(r.rental_id) AS veces_alquilada
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY veces_alquilada DESC
LIMIT 10;

-- BONUS 3: Verificar si 'Academy Dinosaur' está disponible en la Tienda 1
SELECT 
    f.title,
    i.store_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;

-- BONUS 4: Títulos de películas con disponibilidad
SELECT 
    f.title,
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Disponible'
        ELSE 'NO disponible'
    END AS disponibilidad
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;

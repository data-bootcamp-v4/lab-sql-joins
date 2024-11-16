USE sakila;

# 1. Listar el número de películas por categoría

SELECT c.name AS categoria, COUNT(f.film_id) AS numero_de_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY numero_de_peliculas DESC;

# 2. Recuperar el ID de tienda, la ciudad y el país de cada tienda

SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

# 3. Calcular los ingresos totales generados por cada tienda en dólares

SELECT s.store_id, SUM(p.amount) AS ingresos_totales
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id
ORDER BY ingresos_totales DESC;

# 4. Determinar la duración media de las películas de cada categoríalter

SELECT c.name AS categoria, AVG(f.length) AS duracion_media
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY duracion_media DESC;

# BONUS

# 1. Identificar las categorías de películas con mayor duración media

SELECT c.name AS categoria, AVG(f.length) AS duracion_media
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY duracion_media DESC;

# 2. Mostrar las 10 películas alquiladas con más frecuencia en orden descendente

SELECT f.title AS titulo_pelicula, COUNT(r.rental_id) AS veces_alquilada
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY veces_alquilada DESC
LIMIT 10;

# 3. Determinar si «Academy Dinosaur» puede alquilarse en la Tienda 1

SELECT 
    f.title AS titulo_pelicula,
    i.store_id,
    CASE 
        WHEN i.inventory_id IS NOT NULL AND (SELECT COUNT(*) FROM rental r WHERE r.inventory_id = i.inventory_id AND r.return_date IS NULL) = 0 THEN 'Disponible'
        ELSE 'NOT available'
    END AS estado_disponibilidad
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;

# 4. Proporcionar una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad en el inventario

SELECT 
    f.title AS titulo_pelicula,
    CASE 
        WHEN COUNT(i.inventory_id) = 0 THEN 'NOT available'
        WHEN COUNT(r.rental_id) > 0 THEN 'NOT available'
        ELSE 'Available'
    END AS estado_disponibilidad
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
GROUP BY f.title
ORDER BY f.title;
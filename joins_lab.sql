USE sakila;

DESCRIBE category;
DESCRIBE film_category;
DESCRIBE film;
DESCRIBE store;
DESCRIBE address;
DESCRIBE city;
DESCRIBE country;
DESCRIBE payment;
DESCRIBE staff;

USE sakila;

-- Consulta 1: Número de películas por categoría
SELECT c.name AS Categoria, COUNT(f.film_id) AS Numero_de_Peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- Consulta 2: Recuperar el ID de la tienda, ciudad y país para cada tienda
SELECT s.store_id AS ID_Tienda, ci.city AS Ciudad, co.country AS Pais
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- Consulta 3: Calcular los ingresos totales generados por cada tienda en dólares
SELECT s.store_id AS ID_Tienda, SUM(p.amount) AS Ingreso_Total
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- Consulta 4: Determinar el tiempo promedio de ejecución de las películas por categoría
SELECT c.name AS Categoria, AVG(f.length) AS Duracion_Promedio
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- Consulta 5 (Bonus): Identificar las categorías de películas con el mayor tiempo promedio de ejecución
SELECT c.name AS Categoria, AVG(f.length) AS Duracion_Promedio
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY Duracion_Promedio DESC
LIMIT 1;

-- Consulta 6 (Bonus): Mostrar las 10 películas más frecuentemente alquiladas en orden descendente
SELECT f.title AS Titulo, COUNT(r.rental_id) AS Frecuencia
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY Frecuencia DESC
LIMIT 10;

-- Consulta 7 (Bonus): Determinar si "Academy Dinosaur" puede ser alquilada en la Tienda 1
SELECT f.title AS Titulo, CASE
    WHEN i.inventory_id IS NOT NULL THEN 'Disponible'
    ELSE 'NO disponible'
END AS Disponibilidad
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;

-- Consulta 8 (Bonus): Proveer una lista de todos los títulos de películas distintos, con su estado de disponibilidad en el inventario
SELECT DISTINCT f.title AS Titulo, 
    CASE 
        WHEN i.inventory_id IS NULL THEN 'NO disponible'
        ELSE 'Disponible'
    END AS Disponibilidad
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id;
-- Desafío - Unirse a varias mesas
USE Sakila;
-- Escriba consultas SQL para realizar las siguientes tareas utilizando la base de datos Sakila:
-- Enumere el número de películas por categoría.

SELECT COUNT(f.film_id), c.name
FROM film_category f
JOIN category c
ON c.category_id = f.category_id
GROUP BY c.name;

-- Recupere el ID de la tienda, la ciudad y el país de cada tienda.

SELECT s.store_id, c.city, co.country
FROM address a
JOIN city c
USING( city_id)
JOIN country co
USING (country_id)
JOIN store s
USING (address_id);

-- Calcule los ingresos totales generados por cada tienda en dólares.
SELECT SUM(p.amount), st.store_id
FROM staff s
JOIN store st
USING (store_id)
JOIN payment p
USING (staff_id)
GROUP BY st.store_id;
-- Determinar el tiempo promedio de ejecución de las películas para cada categoría.

SELECT AVG(fi.length) AS avg_length, c.name
FROM film_category fc
JOIN category c 
USING (category_id)
JOIN film fi 
USING (film_id)
GROUP BY c.name;

-- Bono :Identifique las categorías de películas con el tiempo de ejecución promedio más largo.

SELECT AVG(fi.length) AS avg_length, c.name
FROM film_category fc
JOIN category c 
USING (category_id)
JOIN film fi 
USING (film_id)
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 3;
-- Muestra las 10 películas más alquiladas en orden descendente.

SELECT COUNT(r.rental_id) as rented , f.title
FROM inventory i
JOIN film f
USING (film_id)
JOIN rental r
USING (inventory_id)
GROUP BY f.title
ORDER BY rented DESC
LIMIT 10;

-- Determinar si "Academy Dinosaur" se puede alquilar en la Tienda 1.

SELECT f.title
FROM film f
JOIN inventory i
USING (film_id)
WHERE store_id = 1 AND f.title = 'Academy Dinosaur';

-- Proporcione una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad en el inventario. Incluya una columna que indique si cada título está "Disponible" o "NO disponible". Tenga en cuenta que hay 42 títulos que no están en el inventario y esta información se puede obtener utilizando una CASEdeclaración combinada con IFNULL".
-- A continuación se ofrecen algunos consejos que le ayudarán a completar con éxito el laboratorio:


SELECT DISTINCT(f.title), CASE
WHEN i.film_id IS NULL THEN 'Not Available'
ELSE 'Available'
END AS Availability
FROM film f
LEFT JOIN inventory i
USING (film_id);

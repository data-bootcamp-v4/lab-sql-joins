-- Escriba consultas SQL para realizar las siguientes tareas utilizando la base de datos Sakila:

-- 1. Enumere el número de películas por categoría.

SELECT c.name AS Category, COUNT(f.film_id) AS Number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY Number_of_films DESC;


-- 2. Recupere el ID de la tienda, la ciudad y el país de cada tienda.

SELECT store_id, city, country
FROM store
JOIN address a ON store.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;


-- 3. Calcule los ingresos totales generados por cada tienda en dólares.

SELECT store_id, SUM(amount) AS Total_revenue
FROM payment
JOIN rental r ON payment.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY store_id;

-- 4. Determinar el tiempo promedio de ejecución de las películas para cada categoría.

SELECT c.name AS Category, AVG(f.length) AS Average_runtime
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY Average_runtime DESC;

-- Bono :
-- 5. Identifique las categorías de películas con el tiempo de ejecución promedio más largo.

SELECT c.name AS Category, AVG(f.length) AS Average_runtime
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > (SELECT AVG(f.length) FROM film)
ORDER BY Average_runtime DESC;

-- 6. Muestra las 10 películas más alquiladas en orden descendente.

SELECT f.title, COUNT(r.rental_id) AS Rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY Rental_count DESC
LIMIT 10;

-- 7. Determinar si "Academy Dinosaur" se puede alquilar en la Tienda 1.

SELECT f.title, i.store_id, COUNT(r.rental_id) AS Rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id    
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
GROUP BY f.title, i.store_id
ORDER BY Rental_count DESC;

-- 8. Proporcione una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad en el inventario. 
-- Incluya una columna que indique si cada título está "Disponible" o "NO disponible". 
-- Tenga en cuenta que hay 42 títulos que no están en el inventario y esta información 
-- se puede obtener utilizando una CASE declaración combinada con IF NULL".

SELECT f.title, CASE WHEN i.inventory_id IS NOT NULL THEN 'Disponible' ELSE 'No disponible' END AS Availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;





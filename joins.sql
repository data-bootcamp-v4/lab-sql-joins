USE sakila;


-- 1. Enumere el número de películas por categoría.

SELECT c.name AS categoria, COUNT(f.film_id) AS num_peliculas
FROM category c
JOIN film_category fc 
ON c.category_id = fc.category_id
JOIN film f 
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY num_peliculas DESC;


-- 2. Recupere el ID de la tienda, la ciudad y el país de cada tienda.
SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a 
ON s.address_id = a.address_id
JOIN city c 
ON a.city_id = c.city_id
JOIN country co 
ON c.country_id = co.country_id;


-- 3. Calcule los ingresos totales generados por cada tienda en dólares.


SELECT s.store_id, SUM(p.amount) as total_revenue
FROM customer
JOIN store as s
USING(store_id)
JOIN payment as p
USING(customer_id)
GROUP BY s.store_id
ORDER BY total_revenue DESC;

-- 4. Determinar el tiempo promedio de ejecución de las películas para cada categoría.

SELECT c.name, ROUND(AVG(f.length)) as average_running_time
FROM film as f
JOIN film_category
USING(film_id)
JOIN category as c
USING(category_id)
GROUP BY c.name
ORDER BY average_running_time DESC;

-- 5. Identifique las categorías de películas con el tiempo de ejecución promedio más largo.

SELECT c.name, ROUND(AVG(f.length)) as average_running_time
FROM film as f
JOIN film_category
USING(film_id)
JOIN category as c
USING(category_id)
GROUP BY c.name
ORDER BY average_running_time DESC
LIMIT 2;

-- 6. Muestra las 10 películas más alquiladas en orden descendente.

SELECT f.title, COUNT(r.rental_id) as num_rentals
FROM rental as r
JOIN inventory
USING(inventory_id)
JOIN film as f
USING(film_id)
GROUP BY f.title
ORDER BY num_rentals DESC
LIMIT 10;

-- 7. Determinar si "Academy Dinosaur" se puede alquilar en la Tienda 1.

SELECT store_id, title, 
  CASE
    WHEN COUNT(*) > 0 THEN 'YES'
    ELSE 'NO'
    END AS is_available
FROM store
JOIN inventory
USING(store_id)
JOIN film
USING(film_id)
WHERE store_id = 1 AND title='Academy Dinosaur';


-- 8.  Proporcione una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad en el inventario. 
-- Incluya una columna que indique si cada título está "Disponible" o "NO disponible". 
-- Tenga en cuenta que hay 42 títulos que no están en el inventario y esta información se puede obtener utilizando una CASEdeclaración combinada con IFNULL".

SELECT DISTINCT(f.title),
    CASE
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film f
LEFT JOIN inventory i
USING (film_id)
ORDER BY title;
USE sakila;
-- 1. Enumere la cantidad de películas por categoría.

SELECT name as category_name, COUNT(*) as num_films FROM category 
JOIN film_category USING (category_id) GROUP BY name ORDER BY num_films DESC;

-- 2. Recupere el ID de la tienda, la ciudad y el país de cada tienda.

SELECT s.store_id, c.city, co.country FROM store s 
JOIN address a ON s.address_id = a.address_id 
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

-- 3. Calcule los ingresos totales generados por cada tienda en dólares.

SELECT store.store_id, SUM(payment.amount) AS total FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 4. Determine el tiempo de exhibición promedio de las películas para cada categoría.

SELECT category.name, ROUND(AVG(film.length), 2) AS average_running_time
FROM category JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id GROUP BY category.name;


-- BONUS: 
-- 5. Identifique las categorías de películas con el tiempo de exhibición promedio más largo.

-- 6. Muestre las 10 películas más alquiladas en orden descendente.

SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY rental_count DESC
LIMIT 10;

-- 7. Determine si "Academy Dinosaur" se puede alquilar en la Tienda 1.

-- 8. Proporcione una lista de todos los títulos de películas diferentes, junto con su estado de disponibilidad en el inventario. Incluya una columna que indique si cada título está "Disponible" o "NO disponible". Tenga en cuenta que hay 42 títulos que no están en el inventario y esta información se puede obtener utilizando una declaración CASE combinada con IFNULL.city
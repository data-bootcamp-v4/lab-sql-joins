USE sakila;	

-- 1. Listar el número de películas por categoría

SELECT c.name, COUNT(f.film_id) AS numero_de_peliculas
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 2. Recuperar el ID de la tienda, ciudad y país de cada tienda.

SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 3. Calcular el ingreso total generado por cada tienda en dólares.

SELECT store.store_id,
       city.city AS city,
       SUM(payment.amount) AS total_revenue
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
JOIN store ON staff.store_id = store.store_id
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
GROUP BY store.store_id, city.city
ORDER BY total_revenue DESC;

-- 4. Determinar la duración promedio de las películas por categoría.

SELECT c.name AS category,
       AVG(f.length) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name;

-- Bonus:

-- 5. Identificar las categorías de películas con mayor duración promedio.
SELECT c.name AS category,
       AVG(f.length) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY avg_length DESC;

-- 6. Mostrar las 10 películas más alquiladas en orden descendente.
SELECT f.title,
       COUNT(r.rental_id) AS total_rentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY total_rentals DESC
LIMIT 10;

-- 7. Determinar si "Academy Dinosaur" puede ser alquilada desde la Tienda 1.
SELECT f.title,
       i.store_id,
       COUNT(i.inventory_id) AS copies_available
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
GROUP BY f.title, i.store_id;


-- 8. Proporcionar una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad en el inventario.
--    Incluir una columna que indique si cada título está 'Disponible' o 'NO disponible'.
--    Nota: Hay 42 títulos que no están en el inventario, y esta información se puede obtener usando una sentencia CASE combinada con IFNULL.

SELECT f.title AS film_title,
    CASE
        WHEN IFNULL(COUNT(i.inventory_id), 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY availability_status DESC, f.title;


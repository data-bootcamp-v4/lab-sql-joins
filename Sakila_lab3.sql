-- Enumere la cantidad de películas por categoría
SELECT c.category_id, c.name AS category_name, COUNT(f.film_id) AS num_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name;

-- Recupere el ID de la tienda, la ciudad y el país de cada tienda
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- Calcule los ingresos totales generados por cada tienda en dólares
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

-- Determine el tiempo de exhibición promedio de las películas para cada categoría
SELECT c.category_id, c.name AS category_name, AVG(f.rental_duration) AS avg_rental_duration
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name;

--  Identifique las categorías de películas con el tiempo de exhibición promedio más largo
SELECT c.category_id, c.name AS category_name, AVG(f.rental_duration) AS avg_rental_duration
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_rental_duration DESC
LIMIT 1;

-- Muestre las 10 películas más alquiladas en orden descendente
SELECT f.title, COUNT(p.payment_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;

-- Determine si "Academy Dinosaur" se puede alquilar en la Tienda 1
SELECT CASE
           WHEN COUNT(i.inventory_id) > 0 THEN 'Sí'
           ELSE 'No'
       END AS available
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;

-- Proporcione una lista de todos los títulos de películas diferentes, junto con su estado de disponibilidad en el inventario
SELECT f.title,
       CASE
           WHEN COUNT(i.inventory_id) > 0 THEN 'Disponible'
           ELSE 'NO disponible'
       END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;






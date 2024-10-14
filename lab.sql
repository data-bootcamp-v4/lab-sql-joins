-- 1. Listar el número de películas por categoría
SELECT c.name AS category, COUNT(f.title) AS num_films
FROM film_category fc
INNER JOIN category c ON fc.category_id = c.category_id
INNER JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- 2. Obtener el ID de la tienda, la ciudad y el país para cada tienda
SELECT s.store_id, ci.city, co.country
FROM store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id;

-- 3. Calcular los ingresos totales generados por cada tienda
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
INNER JOIN rental r ON p.rental_id = r.rental_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

-- 4. Determinar el tiempo promedio de duración de las películas por categoría
SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- BONUS 5. Categorías de películas con el mayor tiempo promedio de duración
SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 1;

-- BONUS 6. Las 10 películas más rentadas
SELECT f.title, COUNT(r.rental_id) AS times_rented
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 10;

-- BONUS 7. Verificar si "Academy Dinosaur" se puede alquilar en la tienda 1
SELECT f.title, s.store_id
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN store s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;

-- BONUS 8. Lista de títulos de películas con su estado de disponibilidad
SELECT f.title, 
CASE 
  WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
  ELSE 'Available'
END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id;
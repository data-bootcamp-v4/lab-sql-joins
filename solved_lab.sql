-- 1. Número de películas por categoría
SELECT c.name AS category, COUNT(f.film_id) AS film_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 2. ID de la tienda, ciudad y país de cada tienda
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 3. Ingresos totales generados por cada tienda en dólares
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;

-- 4. Tiempo promedio de ejecución de las películas para cada categoría
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_runtime
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- BONUS 5. Categorías de películas con el tiempo de ejecución promedio más largo
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_runtime
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_runtime DESC
LIMIT 1;

-- BONUS 6. Las 10 películas más alquiladas
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- BONUS 7. Determinar si "Academy Dinosaur" se puede alquilar en la Tienda 1
SELECT f.title, i.store_id, COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1 AND r.rental_id IS NULL
GROUP BY f.title, i.store_id;

-- BONUS 8. Lista de todas las películas con disponibilidad
SELECT f.title,
       CASE 
           WHEN COUNT(i.inventory_id) > 0 THEN 'Disponible'
           ELSE 'NO disponible'
       END AS disponibilidad
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;

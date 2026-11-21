-- =====================================================
-- LAB | SQL Joins (sakila)
-- =====================================================
USE sakila;

-- 1. Número de películas por categoría
SELECT c.name AS category, COUNT(fc.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;

-- 2. ID de la tienda, ciudad y país de cada tienda
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a  ON s.address_id = a.address_id
JOIN city ci    ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 3. Ingresos totales de cada tienda (en dólares)
--    pago -> alquiler -> copia del inventario -> tienda
SELECT i.store_id, ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN rental r    ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY i.store_id;

-- 4. Duración media de las películas de cada categoría
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f           ON fc.film_id = f.film_id
GROUP BY c.name;

-- ---------------- BONUS ----------------

-- 5. Categorías con la duración media más larga
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f           ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 5;

-- 6. Top 10 películas más alquiladas
SELECT f.title, COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 10;

-- 7. ¿Se puede alquilar "Academy Dinosaur" en la tienda 1?
--    Copias de la tienda 1 que NO están alquiladas ahora (alquiler sin fecha de devolución)
SELECT COUNT(*) AS copies_available_store_1,
       CASE WHEN COUNT(*) > 0 THEN 'Yes' ELSE 'No' END AS can_be_rented
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1
  AND i.inventory_id NOT IN (SELECT inventory_id FROM rental WHERE return_date IS NULL);

-- 8. Todas las películas con su disponibilidad en el inventario
--    LEFT JOIN para incluir también las 42 que no tienen ninguna copia
SELECT DISTINCT f.title,
       CASE
           WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
           ELSE 'Available'
       END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
ORDER BY f.title;

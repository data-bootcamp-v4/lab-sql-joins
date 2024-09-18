-- 1. Enumere el número
use sakila;
SELECT c.name AS category, COUNT(f.film_id) AS num_films
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 2. Recupere el ID de la tienda, la ciudad y el país de cada tienda.

SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;



-- 3 Para calcular los ingresos por tienda, deberá unirse a payment,rental,inventory, ystoremesas
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;


-- 4 Para calcular el tiempo promedio de ejecución por categoría, deberás unirte a film,film_category,categoryMesas.
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 5. Identificar
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 1;


-- 6. Para obtener las 10 películas más alquiladas, deberás unirte a film,rental,inventorymesas
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;


-- 7. Determinar si Para consultar la disponibilidad de la película "Academia Dinosaurio" en la Tienda 1, deberás unirte al film, `inventarioinventory,storeMesas.
SELECT COUNT(i.inventory_id) AS availability
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;



-- 8 Para obtener el estado de disponibilidad de la película, puede unirse a filmy inventory mesas CASE declaración

SELECT f.title,
       CASE 
           WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
           ELSE 'NOT available'
       END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;






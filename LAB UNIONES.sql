USE sakila;

-- Para sacar el numero de peliculas por categoria
-- Inner join
-- Agruparlas con el group by 

SELECT 
    c.name AS category_name,
    COUNT(fc.film_id) AS total_films
FROM film_category fc
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_films DESC;

-- Id de la tienda, ciudad y pais
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id;

-- Ingresos de cada una de las tiendas el total de ingresos en dolares
SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store s
INNER JOIN inventory i ON s.store_id = i.store_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

-- Determinar la duración media de las películas para cada categoría 
SELECT 
    c.name AS category,
    AVG(f.length) AS avg_duration
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_duration DESC;

-- Categoría con mayor duración media
SELECT
	c.name AS category,
    AVG(f.length) AS avg_duration
FROM film f 
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_duration DESC
LIMIT 5; 

-- Las 10 peliculas más alquiladas
SELECT
	film.title,
    COUNT(rental.rental_id) AS rental_count
FROM film 
INNER JOIN inventory on film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 10;

-- Academy Dinosaur se puede alquilar en la tienda 1?????
SELECT
	film.title,
    store.store_id,
    COUNT(inventory.inventory_id) AS copies_available
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN store ON inventory.store_id = store.store_id
WHERE film.title = 'Academy Dinosaur' AND store.store_id = 1
GROUP BY film.title, store.store_id;

-- Lista de todas las películas con estado de disponibilidad
SELECT
	film.title,
    CASE
		WHEN IFNULL(inventory.inventory_id, 0) = 0 THEN 'NO DISPONIBLE'
        ELSE 'DISPONIBLE'
	END AS availability
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title
ORDER BY availability DESC, film.title;
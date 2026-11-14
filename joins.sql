
-- LAB: SQL JOINS
-- Base de datos: Sakila

USE sakila;


-- ==========================================
-- CHALLENGE 1: JOINING ON MULTIPLE TABLES
-- ==========================================


-- EJERCICIO 1
-- Listar el número de películas por categoría.

SELECT
    c.name AS category,
    COUNT(fc.film_id) AS total_films
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY total_films DESC;


-- EJERCICIO 2
-- Obtener el identificador de cada tienda,
-- su ciudad y su país.

SELECT
    s.store_id,
    ci.city,
    co.country
FROM store AS s
INNER JOIN address AS a
    ON s.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS co
    ON ci.country_id = co.country_id
ORDER BY s.store_id;


-- EJERCICIO 3
-- Calcular los ingresos totales generados
-- por cada tienda, en dólares.

SELECT
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store AS s
INNER JOIN inventory AS i
    ON s.store_id = i.store_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
INNER JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;


-- EJERCICIO 4
-- Calcular la duración media de las películas
-- de cada categoría.

SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_duration DESC;


-- ==========================================
-- BONUS
-- ==========================================


-- EJERCICIO 5
-- Identificar las categorías con mayor
-- duración media de películas.

SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_duration DESC;


-- EJERCICIO 6
-- Mostrar las 10 películas más alquiladas,
-- ordenadas de mayor a menor número de alquileres.

SELECT
    f.title,
    COUNT(r.rental_id) AS total_rentals
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY total_rentals DESC
LIMIT 10;


-- EJERCICIO 7
-- Comprobar si "Academy Dinosaur" se puede alquilar
-- en la tienda número 1.
-- Se cuentan las copias disponibles para alquilar,
-- no solamente las copias registradas en inventario.

SELECT
    f.title,
    s.store_id,
    COUNT(i.inventory_id) AS total_copies,
    SUM(
        CASE
            WHEN i.inventory_id IS NOT NULL
                 AND inventory_in_stock(i.inventory_id) = 1
            THEN 1
            ELSE 0
        END
    ) AS available_copies,
    CASE
        WHEN SUM(
            CASE
                WHEN i.inventory_id IS NOT NULL
                     AND inventory_in_stock(i.inventory_id) = 1
                THEN 1
                ELSE 0
            END
        ) > 0
        THEN 'Yes'
        ELSE 'No'
    END AS can_be_rented
FROM film AS f
INNER JOIN store AS s
    ON s.store_id = 1
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
    AND s.store_id = i.store_id
WHERE f.title = 'Academy Dinosaur'
GROUP BY f.film_id, f.title, s.store_id;


-- EJERCICIO 8
-- Mostrar todos los títulos de películas
-- e indicar si aparecen en el inventario.
-- Se utiliza LEFT JOIN para conservar las películas
-- aunque no tengan copias registradas en inventory.

SELECT
    f.title,
    CASE
        WHEN IFNULL(inv.total_copies, 0) > 0
        THEN 'In inventory'
        ELSE 'Not in inventory'
    END AS availability_status
FROM film AS f
LEFT JOIN (
    SELECT
        film_id,
        COUNT(*) AS total_copies
    FROM inventory
    GROUP BY film_id
) AS inv
    ON f.film_id = inv.film_id
ORDER BY f.title;

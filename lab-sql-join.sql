USE sakila;

-- 1. Listar las películas por categoría

SELECT
    f.title,
    c.name AS category
FROM film AS f

INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id

INNER JOIN category AS c
    ON fc.category_id = c.category_id

ORDER BY c.name, f.title;

-- 2. Recuperar el ID de la tienda, la ciudad y el país de cada tienda
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
    ON ci.country_id = co.country_id;

-- 3. Calcula los ingresos totales generados por cada tienda en dólares
SELECT
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM store AS s

INNER JOIN staff AS st
    ON s.store_id = st.store_id

INNER JOIN payment AS p
    ON st.staff_id = p.staff_id

GROUP BY s.store_id;

-- 4. Determina la duración media de las películas para cada categoría
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length
FROM film AS f

INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id

INNER JOIN category AS c
    ON fc.category_id = c.category_id

GROUP BY c.name;

-- 5. Identifica las categorías de películas con la mayor duración media
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length
FROM film AS f

INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id

INNER JOIN category AS c
    ON fc.category_id = c.category_id

GROUP BY c.name

ORDER BY avg_length DESC;

-- 6. Muestra las 10 películas más alquiladas en orden descendente

SELECT
    f.title,
    COUNT(r.rental_id) AS num_rentals
FROM film AS f

INNER JOIN inventory AS i
    ON f.film_id = i.film_id

INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id

GROUP BY
    f.film_id,
    f.title

ORDER BY num_rentals DESC

LIMIT 10;

-- 7. Determina si “ACADEMY DINOSAUR” se puede alquilar en la Tienda 1

SELECT
    f.title,
    i.store_id,
    i.inventory_id
FROM film AS f

INNER JOIN inventory AS i
    ON f.film_id = i.film_id

WHERE f.title = 'ACADEMY DINOSAUR'
    AND i.store_id = 1;

-- 8. Proporcione una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad en el inventario. Incluya una columna que indique si cada título está "Disponible" o "No disponible". Tenga en cuenta que hay 42 títulos que no están en el inventario, y esta información se puede obtener utilizando una CASEdeclaración combinada con IFNULL
-- Mostrar todos los títulos distintos y una columna que indique si están “Available” o “Not Available” según aparezcan o no en inventory
-- Sabemos además que hay 42 títulos que no están en inventario

SELECT DISTINCT
    f.title,

    CASE
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'Not Available'
        ELSE 'Available'
    END AS availability

FROM film AS f

LEFT JOIN inventory AS i
    ON f.film_id = i.film_id

ORDER BY f.title;

-- Las que NO están disponibles

SELECT
    COUNT(DISTINCT f.film_id) AS not_available_films
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;


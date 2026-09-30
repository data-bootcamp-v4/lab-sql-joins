-- =====================================================================
-- Lab | SQL Joins (base de datos sakila)
-- Método para cada consulta (el de clase): 1) qué tablas tienen los datos,
-- 2) qué columna las une, 3) qué tipo de JOIN necesito, 4) alias cortos.
-- =====================================================================
USE sakila;


-- ---------------------------------------------------------------------
-- 1. Número de películas por categoría
-- ---------------------------------------------------------------------
-- El nombre de la categoría está en category y la relación película-categoría en film_category.
-- Se unen por category_id. INNER JOIN (JOIN a secas) porque solo me interesan
-- categorías que tienen películas.
-- Resultado: Sports es la que más tiene (74) y Music la que menos (51).
SELECT c.name   AS category,
       COUNT(*) AS number_of_films
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;


-- ---------------------------------------------------------------------
-- 2. ID, ciudad y país de cada tienda
-- ---------------------------------------------------------------------
-- No hay una columna común directa entre store y country, así que encadeno tablas:
-- store -> address (address_id) -> city (city_id) -> country (country_id).
-- Resultado: tienda 1 en Lethbridge (Canada) y tienda 2 en Woodridge (Australia).
SELECT s.store_id,
       ci.city,
       co.country
FROM store AS s
JOIN address AS a  ON s.address_id = a.address_id
JOIN city    AS ci ON a.city_id    = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;


-- ---------------------------------------------------------------------
-- 3. Ingresos totales de cada tienda, en dólares
-- ---------------------------------------------------------------------
-- Los importes están en payment. Cada pago lo registra un empleado (staff_id) y cada
-- empleado pertenece a una tienda (staff.store_id). Camino: payment -> staff -> store.
-- Resultado: tienda 1 = 33 489.47 $, tienda 2 = 33 927.04 $.
SELECT st.store_id,
       ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment AS p
JOIN staff AS st ON p.staff_id = st.staff_id
GROUP BY st.store_id;

-- Alternativa: atribuir cada pago a la tienda donde estaba la copia alquilada
-- (payment -> rental -> inventory). Da cifras un poco distintas (33 679.79 y 33 726.77)
-- porque algunos empleados cobraron alquileres de la otra tienda, y 5 pagos no tienen alquiler asociado.
-- Me quedo con la primera, que refleja dónde entró el dinero.
SELECT i.store_id,
       ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment AS p
JOIN rental    AS r ON p.rental_id    = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
GROUP BY i.store_id;


-- ---------------------------------------------------------------------
-- 4. Duración media de las películas por categoría
-- ---------------------------------------------------------------------
-- category -> film_category -> film, para llegar a length.
SELECT c.name                  AS category,
       ROUND(AVG(f.length), 2) AS avg_length
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film          AS f  ON fc.film_id    = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC;


-- =====================================================================
-- BONUS
-- =====================================================================

-- ---------------------------------------------------------------------
-- 5. Categorías con la duración media más larga
-- ---------------------------------------------------------------------
-- Es la consulta anterior limitada a las primeras. Muestro las 3 primeras para ver la distancia.
-- Resultado: Sports (128.20), Games (127.84), Foreign (121.70).
SELECT c.name                  AS category,
       ROUND(AVG(f.length), 2) AS avg_length
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film          AS f  ON fc.film_id    = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 3;


-- ---------------------------------------------------------------------
-- 6. Las 10 películas más alquiladas
-- ---------------------------------------------------------------------
-- Un alquiler (rental) apunta a una copia (inventory), y la copia a una película (film).
-- Agrupo por film_id y no solo por title: el id es único, un título podría repetirse.
-- Nota: en el puesto 10 hay empate a 31 alquileres entre varias películas; el orden
-- alfabético decide cuáles entran en el resultado.
-- Resultado: la primera es BUCKET BROTHERHOOD, con 34 alquileres.
SELECT f.title,
       COUNT(r.rental_id) AS times_rented
FROM film AS f
JOIN inventory AS i ON f.film_id      = i.film_id
JOIN rental    AS r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC, f.title
LIMIT 10;


-- ---------------------------------------------------------------------
-- 7. ¿Se puede alquilar "Academy Dinosaur" en la tienda 1?
-- ---------------------------------------------------------------------
-- Se puede si la tienda 1 tiene alguna copia que no esté alquilada ahora mismo.
-- Una copia está fuera si tiene un alquiler sin fecha de devolución (return_date IS NULL).
-- LEFT JOIN con rental (filtrando en el ON solo los alquileres abiertos) mantiene todas
-- las copias: las que no tienen alquiler abierto quedan con r.rental_id = NULL, es decir, disponibles.
-- Por qué el filtro va en el ON y no en el WHERE: en el WHERE, el LEFT JOIN se comportaría
-- como un INNER JOIN y perdería justo las copias disponibles.
-- Resultado: la tienda 1 tiene 4 copias y ninguna está alquilada -> sí se puede alquilar.
SELECT f.title,
       i.store_id,
       COUNT(i.inventory_id)                       AS copies_in_store,
       COUNT(i.inventory_id) - COUNT(r.rental_id)  AS copies_available,
       CASE
           WHEN COUNT(i.inventory_id) - COUNT(r.rental_id) > 0 THEN 'Yes'
           ELSE 'No'
       END AS can_be_rented
FROM film AS f
JOIN inventory AS i
     ON f.film_id = i.film_id
LEFT JOIN rental AS r
     ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1
GROUP BY f.title, i.store_id;


-- ---------------------------------------------------------------------
-- 8. Todas las películas con su estado en el inventario
-- ---------------------------------------------------------------------
-- LEFT JOIN desde film: así aparecen TODAS las películas, también las que no tienen
-- ninguna copia (para ellas, i.inventory_id queda en NULL).
-- Con INNER JOIN esas 42 películas desaparecerían del resultado.
-- Como sugiere el enunciado, IFNULL convierte ese NULL en 0 y CASE decide el texto.
-- DISTINCT: una película con 8 copias saldría 8 veces (una por copia); DISTINCT deja una fila por título.
-- Resultado: 1000 títulos, 42 de ellos 'NOT available'.
SELECT DISTINCT f.title,
       CASE
           WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
           ELSE 'Available'
       END AS availability
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
ORDER BY f.title;

-- Comprobación: cuántos títulos hay en cada estado.
SELECT availability,
       COUNT(*) AS number_of_titles
FROM (
    SELECT DISTINCT f.title,
           CASE
               WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
               ELSE 'Available'
           END AS availability
    FROM film AS f
    LEFT JOIN inventory AS i ON f.film_id = i.film_id
) AS film_status
GROUP BY availability;

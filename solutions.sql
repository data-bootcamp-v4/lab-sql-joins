use sakila;

--  1: Número de películas por categoría
--  Listar cuántas pelis tiene cada género.
--  Tablas: category -> film_category

SELECT 
    c.name AS category_name, 
    COUNT(fc.film_id) AS film_count
FROM film_category AS fc
RIGHT JOIN category AS c 
    ON c.category_id = fc.category_id
GROUP BY 
    c.name;


--  2: Ubicación de las tiendas
--  Sacar ID tienda, ciudad y país.
--  Tablas: store -> address -> city -> country

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


--  3: Ingresos por tienda
--  Total de dinero recaudado por tienda.
--  store -> staff -> payment

SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue
FROM store AS s
INNER JOIN staff AS st 
    ON s.store_id = st.store_id
INNER JOIN payment AS p 
    ON st.staff_id = p.staff_id
GROUP BY 
    s.store_id;


--   4: Duración media por categoría
--   Calcular la duración media de las películas de cada género.
--   Tablas: category -> film_category -> film

SELECT 
    c.name AS category_name, 
    AVG(f.length) AS average_duration
FROM category AS c
INNER JOIN film_category AS fc 
    ON c.category_id = fc.category_id
INNER JOIN film AS f 
    ON fc.film_id = f.film_id
GROUP BY 
    c.name;
    
    
-- 5: Categorías más largas
-- Identificar qué géneros tienen la mayor duración media.
-- Tablas: category -> film_category -> film

SELECT 
    c.name AS category_name, 
    AVG(f.length) AS average_duration
FROM category AS c
INNER JOIN film_category AS fc 
    ON c.category_id = fc.category_id
INNER JOIN film AS f 
    ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    average_duration DESC;    


--  6 : Top 10 películas más alquiladas
--  Mostrar los títulos que más veces se han alquilado.
--  Tablas: film -> inventory -> rental
SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM film AS f
INNER JOIN inventory AS i 
    ON f.film_id = i.film_id           
INNER JOIN rental AS r 
    ON i.inventory_id = r.inventory_id 
GROUP BY 
    f.title
ORDER BY 
    rental_count DESC                  
LIMIT 10;

--   7: Disponibilidad de pelicula en en tienda 1
--   Comprobar si 'Academy Dinosaur' está en el inventario de la tienda 1.
--   Tablas: film -> inventory
SELECT 
    f.title, 
    i.store_id, 
    i.inventory_id
FROM film AS f
INNER JOIN inventory AS i 
    ON f.film_id = i.film_id
WHERE 
    f.title = 'ACADEMY DINOSAUR' 
    AND i.store_id = 1;
    

--   8: Estado del inventario (Available / NOT available)
--   Listar todos los títulos y etiquetar si tenemos copias o no.
--   Tablas: film -> inventory

SELECT DISTINCT 
    f.title,
    CASE 
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i 
    ON f.film_id = i.film_id;    
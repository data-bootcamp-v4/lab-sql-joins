USE sakila;

-- EJERCICIO 1
-- Enumere el número de películas por categoría.

-- número de películas - film table                     categoria | # peliculas
-- categorías - film_category table

SELECT
c.name,
COUNT(DISTINCT fc.film_id) AS film_num
FROM category AS c
LEFT JOIN film_category AS fc
ON c.category_id = fc.category_id
GROUP BY
c.name;

-- EJERCICIO 2
-- Recupera el ID de la tienda, la ciudad y el país de cada tienda.

-- store_id - store
-- city - city
-- country - contrry
-- columnas de unión: adress_id / city_id / contry_id

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

-- EJERCICIO 3
-- Calcula los ingresos totales generados por cada tienda en dólares.

-- amount - payment
-- manager_staff_id - store  El manager_staff_id será el vínculo en común 

SELECT
s.store_id,
SUM(p.amount) AS total_amount
FROM store AS s
INNER JOIN staff AS st 
ON s.manager_staff_id = st.staff_id 
INNER JOIN payment AS p 
ON st.staff_id = p.staff_id      
GROUP BY
s.store_id;

-- EJERCICIO 4
-- Determina la duración media de las películas para cada categoría.

-- categorías - film_category table
-- AVG_length - film
-- category_id - category
-- film_id / category_id en común

SELECT
c.name AS category,
AVG(f.length) AS avg_length
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY
c.name;

-- EJERCICIO 5

-- Identifica las categorías de películas con la mayor duración media.

-- categorías - category 
-- AVG_length - film

SELECT
c.name AS category,
AVG(f.length) AS avg_length
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY
c.name
LIMIT 3;

-- EJERCICIO 6

-- Muestra las 10 películas más alquiladas en orden descendente.

SELECT
f.title AS movie_name,
COUNT(r.rental_id) AS total_rent
FROM film AS f 
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
INNER JOIN rental AS r 
ON i.inventory_id = r.inventory_id
GROUP BY
f.title
ORDER BY
total_rent DESC
LIMIT 10;

-- EJERCICIO 7
-- Determina si "Academy Dinosaur" se puede alquilar en la Tienda 1

SELECT
f.title,
i.store_id
FROM film AS f
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1;  

-- EJERCICIO 8 
-- Proporcione una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad en 
-- el inventario. Incluya una columna que indique si cada título está «Disponible» o «No disponible». 
-- Tenga en cuenta que hay 42 títulos que no están en el inventario, y esta información se puede obtener 
-- mediante una CASEdeclaración combinada con IFNULL.



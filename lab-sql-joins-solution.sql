-- listar el número de películas por categoría

SELECT c.name AS category_name, COUNT(*) AS number_of_films
FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
GROUP BY c.name;

-- recuperar la ID de la tienda, ciudad y país para cada tienda
SELECT s.store_id, ci.city, co.country
FROM sakila.store AS s
JOIN sakila.address AS a
ON s.address_id = a.address_id
JOIN sakila.city AS ci
ON a.city_id = ci.city_id
JOIN sakila.country AS co
ON ci.country_id = co.country_id;

--  calcular los ingresos totales generados por cada tienda
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM sakila.payment AS p
JOIN sakila.staff AS st
ON p.staff_id = st.staff_id
JOIN sakila.store AS s
ON st.store_id = s.store_id
GROUP BY s.store_id;

-- determinar la longitud promedio de las películas para cada categoría

SELECT c.name AS category_name, ROUND(AVG(f.length), 2) AS average_running_time
FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
JOIN sakila.film AS f
ON fc.film_id = f.film_id
GROUP BY c.name;

-- identificar las categorías de películas con el tiempo promedio de duración más largo

SELECT c.name AS category_name, ROUND(AVG(f.length), 2) AS average_running_time
FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
JOIN sakila.film AS f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC
LIMIT 1;

-- las 10 películas más rentadas
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM sakila.film AS f
JOIN sakila.inventory AS i
ON f.film_id = i.film_id
JOIN sakila.rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- determinar si 'Academy Dinosaur' es rentable desde la Tienda 1

SELECT f.title, 
       CASE 
           WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
           ELSE 'NOT available'
       END AS availability_status
FROM sakila.film AS f
LEFT JOIN sakila.inventory AS i ON f.film_id = i.film_id AND i.store_id = 1
WHERE f.title = 'Academy Dinosaur'
GROUP BY f.title;

-- Proporcionar una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad.
SELECT f.title, 
       CASE 
           WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
           ELSE 'NOT available'
       END AS availability_status
FROM sakila.film AS f
LEFT JOIN sakila.inventory AS i
ON f.film_id = i.film_id
GROUP BY f.title;

USE sakila;

-- 1 ENUMERE EL NÚMERO DE PELICULAS POR CATEGORIA 

SELECT 
c.name AS categoria, 
COUNT(fc.film_id) AS cantidad_films
FROM category AS c
LEFT JOIN film_category AS fc 
ON c.category_id = fc.category_id
GROUP BY categoria;

-- 2 Recupere el id de la tienda, la ciudad y el país de la tienda

SELECT
s.store_id,
ci.city, 
co.country
FROM store AS s
LEFT JOIN address AS a 
ON s.address_id = a.address_id
LEFT JOIN city AS ci 
ON a.city_id = ci.city_id
LEFT JOIN country AS co 
ON ci.country_id = co.country_id;

-- 3 calcule los ingresos generados por cada tienda en dólares

SELECT
s.store_id,
SUM(p.amount) AS ingresos_totales
FROM payment AS p
LEFT JOIN staff AS st
ON p.staff_id = st.staff_id
LEFT JOIN store AS s
ON st.store_id = s.store_id
GROUP by s.store_id;


-- 4 determine el tiempo promedio de ejecución de la pelicula para cada categoria

SELECT
c.name AS categoria,
AVG(f.length) AS promedio_duración
FROM category AS c
LEFT JOIN film_category AS fc
ON c.category_id = fc.category_id
LEFT JOIN film AS f
ON fc.film_id = f.film_id
group by categoria;

-- 5 identifique la categorías de películas con más tiempo de ejecución

SELECT
c.name AS categoria,
AVG(f.length) AS promedio_duración
FROM category AS c
LEFT JOIN film_category AS fc
ON c.category_id = fc.category_id
LEFT JOIN film AS f
ON fc.film_id = f.film_id
group by categoria
ORDER by promedio_duración DESC;

-- 6 las 10 películas más alquiladas

SELECT 
f.title, 
COUNT(r.rental_id) AS Arriendos
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id = i.film_id
LEFT JOIN rental AS r 
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY Arriendos DESC
LIMIT 10;

-- 7 determinar si "Academy Dinosaur" se puede arrendar en la tienda 1

SELECT 
f.title, 
i.store_id, 
COUNT(i.inventory_id) AS pelis_inventario
FROM film AS f
LEFT JOIN inventory AS i 
ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1
GROUP BY f.title, i.store_id;

-- 8 

SELECT 
    f.title AS titulo,
	CASE 
        WHEN IFNULL(COUNT(i.inventory_id),0) > 0 
        THEN 'Disponible'
        ELSE 'NO disponible'
    END AS disponibilidad
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY titulo ASC;

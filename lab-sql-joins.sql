-- cuantas peliculas hay en cada categoria
USE sakila;
SELECT c.name AS category, COUNT(fc.film_id) AS number_of_films
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- id, ciudad y pais de cada tienda
SELECT s.store_id, ci.city, co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

-- ingresos totales por tienda
SELECT s.store_id, CONCAT('$', ROUND(SUM(p.amount), 2)) AS total_revenue
FROM payment AS p
JOIN staff AS st ON p.staff_id = st.staff_id
JOIN store AS s ON st.store_id = s.store_id
GROUP BY s.store_id;

-- duracion media de las peliculas por categoria
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name;

-- 5. categorias con la duracion media mas larga
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC;

-- 6. top 10 peliculas mas alquiladas
SELECT f.title, COUNT(r.rental_id) AS times_rented
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC
LIMIT 10;

-- 7. se puede alquilar Academy Dinosaur en la tienda 1
SELECT f.title, i.store_id, COUNT(i.inventory_id) AS copies
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1
GROUP BY f.title, i.store_id;

-- 8. titulos y su disponibilidad en el inventario
SELECT DISTINCT f.title,
       CASE WHEN IFNULL(i.inventory_id, 0) > 0 THEN 'Available'
            ELSE 'NOT available'
       END AS availability
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id;



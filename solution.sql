USE sakila;

SELECT c.name AS category_name,
COUNT(fc.film_id) AS number_of_films
FROM category AS c
JOIN film_category AS fc 
ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;

SELECT s.store_id, a.address
FROM store AS s
INNER JOIN address AS a ON s.address_id = a.address_id;

SELECT s.store_id, c.city
FROM store AS s
INNER JOIN address AS a ON s.address_id = a.address_id
INNER JOIN city AS c ON a.city_id = c.city_id;

SELECT s.store_id, c.city, co.country
FROM store AS s
INNER JOIN address AS a ON s.address_id = a.address_id
INNER JOIN city AS c ON a.city_id = c.city_id
INNER JOIN country AS co ON c.country_id = co.country_id;

SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue
FROM store AS s
-- Unimos la tienda con sus pagos a través del staff_id
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
-- Agrupamos por tienda para que la suma no sea un solo total global
GROUP BY s.store_id;

SELECT c.name AS category_name, AVG(f.length) AS average_running_time
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name;

-- bonus la duración promedio más larga --
SELECT c.name AS category_name, AVG(f.length) AS average_running_time
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC;

-- Bonus - Las 10 películas más alquiladas --
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- bonus ¿Se puede alquilar "Academy Dinosaur" en la Tienda 1? --
SELECT f.title, i.store_id, COUNT(i.inventory_id) AS copies_available
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
GROUP BY f.title, i.store_id;

-- Bonus Lista de títulos y su disponibilidad --
SELECT DISTINCT f.title,
    CASE 
        WHEN i.inventory_id IS NULL THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id;
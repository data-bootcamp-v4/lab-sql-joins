USE sakila;

SELECT*
FROM film_category
LIMIT 5; 

SELECT*
FROM category
LIMIT 5; 

SELECT
category.name,
COUNT(film_category.film_id)
FROM film_category
INNER JOIN category
	ON film_category.category_id = category.category_id
GROUP BY category.name;

SELECT*
FROM store
LIMIT 5;

SELECT*
FROM address
LIMIT 5;

SELECT
store.store_id,
city.city,
country.country
FROM store
INNER JOIN address
	ON store.address_id = address.address_id
    INNER JOIN city
    ON address.city_id = city.city_id
    INNER JOIN country
    ON city.country_id = country.country_id;

SELECT*
FROM payment
LIMIT 5;

SELECT*
FROM staff
LIMIT 5;

SELECT
SUM(payment.amount),
staff.store_id
FROM payment
INNER JOIN staff
	ON payment.staff_id = staff.staff_id
    GROUP BY staff.store_id;

SELECT
category.name,
AVG(film.length)
FROM film_category
INNER JOIN film
	ON film_category.film_id = film.film_id
    INNER JOIN category
    ON film_category.category_id = category.category_id
GROUP BY category.name;

SELECT
category.name,
AVG(film.length)
FROM film_category
INNER JOIN film
	ON film_category.film_id = film.film_id
    INNER JOIN category
    ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY AVG(film.length) DESC;

SELECT*
FROM rental
LIMIT 5;

SELECT*
FROM inventory
LIMIT 5;

SELECT
film.title,
COUNT(rental.rental_id) AS total_alquileres
FROM rental
INNER JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
    INNER JOIN film
    ON inventory.film_id = film.film_id
GROUP BY film.film_id, film.title
ORDER BY total_alquileres DESC
LIMIT 10;

SELECT
film.title,
inventory.store_id
FROM film
INNER JOIN inventory
	ON inventory.film_id = film.film_id
    WHERE film.title = "ACADEMY DINOSAUR" AND inventory.store_id = 1;
    
SELECT DISTINCT
    film.title,
    CASE
        WHEN IFNULL(inventory.inventory_id, 0) = 0
            THEN 'NOT available'
        ELSE 'Available'
    END AS disponibilidad
FROM film
LEFT JOIN inventory
    ON film.film_id = inventory.film_id
ORDER BY film.title ASC;

SELECT
    COUNT(DISTINCT film.film_id) AS peliculas_sin_inventario
FROM film
LEFT JOIN inventory
    ON film.film_id = inventory.film_id
WHERE inventory.inventory_id IS NULL;
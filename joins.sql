SELECT
    category.name AS category_name,
    COUNT(film_category.film_id) AS number_of_films
FROM category
INNER JOIN film_category
    ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY number_of_films DESC;


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
    ON city.country_id = country.country_id
ORDER BY store.store_id;


SELECT
    store.store_id,
    ROUND(SUM(payment.amount), 2) AS total_revenue_dollars
FROM store
INNER JOIN staff
    ON store.store_id = staff.store_id
INNER JOIN payment
    ON staff.staff_id = payment.staff_id
GROUP BY store.store_id
ORDER BY total_revenue_dollars DESC;


SELECT
    category.name AS category_name,
    ROUND(AVG(film.length), 2) AS average_running_time_minutes
FROM category
INNER JOIN film_category
    ON category.category_id = film_category.category_id
INNER JOIN film
    ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY average_running_time_minutes DESC;


SELECT
    film.title,
    COUNT(rental.rental_id) AS number_of_rentals
FROM film
INNER JOIN inventory
    ON film.film_id = inventory.film_id
INNER JOIN rental
    ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY number_of_rentals DESC
LIMIT 10;


SELECT
    film.title,
    COUNT(inventory.inventory_id) AS copies_in_store_1
FROM film
INNER JOIN inventory
    ON film.film_id = inventory.film_id
WHERE film.title = 'ACADEMY DINOSAUR'
  AND inventory.store_id = 1
GROUP BY film.title;

SELECT
    film.title,
    CASE
        WHEN IFNULL(COUNT(inventory.inventory_id), 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film
LEFT JOIN inventory
    ON film.film_id = inventory.film_id
GROUP BY film.film_id, film.title
ORDER BY film.title ASC;

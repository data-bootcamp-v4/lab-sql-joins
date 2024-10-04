USE sakila;

SELECT category.name AS category, COUNT(film.film_id) AS number_of_films
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

SELECT store.store_id, SUM(payment.amount) AS total_revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN store ON inventory.store_id = store.store_id
GROUP BY store.store_id;

SELECT category.name AS category, ROUND(AVG(film.length), 2) AS avg_running_time
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

SELECT category.name AS category, ROUND(AVG(film.length), 2) AS avg_running_time
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY avg_running_time DESC
LIMIT 1;

SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT 
    film.title, 
    store.store_id, 
    IF(COUNT(inventory.inventory_id) > 0, 'Available', 'Not Available') AS availability
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id AND rental.return_date IS NULL
WHERE film.title = 'Academy Dinosaur'
AND store.store_id = 1
GROUP BY film.title, store.store_id;

SELECT 
    film.title,
    CASE
        WHEN COUNT(inventory.inventory_id) = 0 THEN 'NOT Available'
        ELSE 'Available'
    END AS availability_status
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title
ORDER BY film.title ASC;


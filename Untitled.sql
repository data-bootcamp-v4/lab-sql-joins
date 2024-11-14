USE sakila;
-- 1:
SELECT category_id, COUNT(film.title) AS number_of_films FROM film_category
JOIN film 
ON film_category.film_id = film.film_id
GROUP BY category_id
ORDER BY category_id;

-- 2:
SELECT city, country FROM city
JOIN country 
ON country.country_id=city.country_id
GROUP BY city, country;
-- City and country doesn't have any common colummn with store.

-- 3:
SELECT store.store_id, SUM(amount) AS total_amount
FROM payment
JOIN staff ON payment.staff_id = staff.staff_id
JOIN store ON staff.staff_id = store.manager_staff_id
GROUP BY store.store_id;

-- 4:
SELECT category_id, AVG(length) AS average_length FROM film
JOIN film_category ON film_category.film_id = film.film_id
GROUP BY category_id;


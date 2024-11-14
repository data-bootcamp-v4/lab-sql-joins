-- 1.
SELECT c.name, COUNT(*)
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 2.
SELECT store_id, city, country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 3.
SELECT store.store_id, ROUND(SUM(amount)) AS revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN store ON inventory.store_id = store.store_id
GROUP BY store.store_id;

-- 4.
SELECT name AS category_name, AVG(length) AS average_duration
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category_name;

--  5.
SELECT name AS category_name, AVG(length) AS average_duration
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category_name
ORDER BY average_duration DESC
LIMIT 1;

-- 6.
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 10;

-- 7.
SELECT COUNT(*) AS inventory
FROM inventory
JOIN film ON film.film_id = inventory.film_id
JOIN store ON store.store_id = inventory.store_id
WHERE store.store_id = 1 AND title ="Academy Dinosaur";

-- 8.
SELECT title, CASE WHEN return_date IS NULL THEN "Not available" ELSE "Available" END AS availability
FROM inventory
INNER JOIN film ON film.film_id = inventory.film_id
INNER JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY title, availability;
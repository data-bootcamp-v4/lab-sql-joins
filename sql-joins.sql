/*Write SQL queries to perform the following tasks using the Sakila database:

1. List the number of films per category.*/
SELECT category_id, COUNT(*) AS num_films
FROM sakila.film_category
GROUP BY category_id;

# 2. Retrieve the store ID, city, and country for each store.
CREATE TEMPORARY TABLE sakila.city_store_country
SELECT city.city_id, city.city, country.country
FROM sakila.city
INNER JOIN sakila.country
ON city.country_id = country.country_id;


SELECT store.store_id, address.address, city_store_country.city, city_store_country.country
FROM sakila.store
	INNER JOIN sakila.address
	ON store.address_id = address.address_id
	INNER JOIN sakila.city_store_country
	ON address.city_id = city_store_country.city_id;

# 3. Calculate the total revenue generated by each store in dollars.
SELECT store_id, ROUND(SUM(amount), 2) AS total_amount_revenue
	FROM sakila.payment
	INNER JOIN sakila.rental
	ON payment.rental_id = rental.rental_id
    INNER JOIN sakila.staff
    ON rental.staff_id = staff.staff_id
    GROUP BY store_id;
    
# 4. Determine the average running time of films for each category.
SELECT film_category.category_id as category , AVG(film.length) as avg_duration
FROM sakila.film
INNER JOIN sakila.film_category
ON film.film_id = film_category.film_id
GROUP BY film_category.category_id; 

# 5. Identify the film categories with the longest average running time.
SELECT film_category.category_id as category , AVG(film.length) as avg_duration
FROM sakila.film
INNER JOIN sakila.film_category
ON film.film_id = film_category.film_id
GROUP BY film_category.category_id
ORDER BY avg_duration DESC;

# 6. Display the top 10 most frequently rented movies in descending order.
SELECT film.film_id, film.title, COUNT(*) as freq_rented
	FROM sakila.rental
	INNER JOIN sakila.inventory 
	ON rental.inventory_id = inventory.inventory_id
		INNER JOIN sakila.film
		ON inventory.film_id = film.film_id
GROUP BY film.film_id
ORDER BY freq_rented DESC
LIMIT 10;

# 7. Determine if "Academy Dinosaur" can be rented from Store 1.
/*SELECT title, film_id
FROM sakila.film
WHERE film.title = "Academy Dinosaur";*/

SELECT DISTINCT inventory.store_id, film.film_id, film.title
FROM sakila.film
INNER JOIN sakila.inventory
ON film.film_id = inventory.film_id
WHERE film.title = "Academy Dinosaur";

#SQL Joins Lab

#1

SELECT category_id, COUNT(category_id)
FROM sakila.film_category
GROUP BY category_id;

#2

    
/* WITH store_address AS (
	SELECT  store.*, address.city_id
	FROM sakila.store
	INNER JOIN sakila.address
	ON store.address_id = address.address_id
    ),
store_city AS (
	SELECT city, country_id
	FROM store_address
	INNER JOIN sakila.city
	ON store_address.city_id = city.city_id
    )
SELECT *
FROM store_city
	INNER JOIN sakila.country
    ON store_city.country_id = country.country_id; */
    


   
SELECT store_id, city, country
FROM
	(SELECT store_id, adress_city.city_id, sakila.city.city, sakila.city.country_id
	FROM
		(SELECT city_id, store_id
		FROM sakila.store
		INNER JOIN sakila.address
		ON sakila.store.address_id = sakila.address.address_id) AS adress_city
	INNER JOIN sakila.city
	ON 	sakila.city.city_id = adress_city.city_id) AS adress_store
INNER JOIN sakila.country
ON sakila.country.country_id = adress_store.country_id;

#3 

SELECT sakila.staff.store_id, SUM(sakila.staff_amount.amount)
FROM sakila.staff
INNER JOIN (
		SELECT sakila.rental.rental_id, pay_amount.amount, sakila.rental.staff_id
		FROM sakila.rental
		INNER JOIN (
					SELECT rental_id, amount
					FROM sakila.payment
					) as pay_amount
		ON sakila.pay_amount.rental_id = sakila.rental.rental_id) as staff_amount
ON sakila.staff_amount.staff_id = sakila.staff.staff_id
GROUP BY store_id;

#4 Determine the average running time of films for each category

SELECT AVG(length)
FROM sakila.film;

SELECT category_id, AVG(length)
FROM sakila.film_category
	INNER JOIN (
				SELECT length, film.film_id
				FROM sakila.film) AS average_length
	ON sakila.film_category.film_id = sakila.average_length.film_id
GROUP BY category_id;

#5 Identify the film categories with the longest average running time


SELECT category_id, AVG(length)
FROM sakila.film_category
	INNER JOIN (
				SELECT length, film.film_id
				FROM sakila.film) AS average_length
	ON sakila.film_category.film_id = sakila.average_length.film_id
GROUP BY category_id
ORDER BY AVG(length)
LIMIT 5;


#6.Display the top 10 most frequently rented movies in descending order.

SELECT *
FROM sakila.rental;

SELECT inventory_id, COUNT(inventory_id)
FROM sakila.rental
GROUP BY inventory_id;


SELECT film_id, COUNT(film_id)
FROM sakila.inventory
	INNER JOIN (
				SELECT inventory_id, COUNT(inventory_id) 
				FROM sakila.rental
				GROUP BY inventory_id) AS rental_count
	ON sakila.inventory.inventory_id = sakila.rental_count.inventory_id
GROUP BY film_id
ORDER BY COUNT(film_id) DESC
LIMIT 10;

SELECT film.film_id, film.title, COUNT(*) as freq_rented
	FROM sakila.rental
	INNER JOIN sakila.inventory
	ON rental.inventory_id = inventory.inventory_id
		INNER JOIN sakila.film
		ON inventory.film_id = film.film_id
GROUP BY film.film_id
ORDER BY freq_rented DESC
LIMIT 10;
				

#7 Determine if "Academy Dinosaur" can be rented from Store 1.

SELECT store_id, title, COUNT(title)
FROM sakila.inventory 
	LEFT JOIN sakila.film
    ON sakila.film.film_id= sakila.inventory.film_id
WHERE title = 'Academy Dinosaur'
GROUP BY store_id
    
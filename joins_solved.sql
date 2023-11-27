/*1*/
SELECT category.name, COUNT(film_category.film_id)
FROM film_category
INNER JOIN sakila.category
ON film_category.category_id = category.category_id
GROUP BY category.category_id;

/*2*/
SELECT store_city.store_id, store_city.city, country.country
FROM sakila.country
INNER JOIN
			(SELECT store_id,city.city,country_id
			FROM sakila.city
			INNER JOIN
						(SELECT store_id, city_id
						FROM sakila.staff
						LEFT JOIN sakila.address
						ON staff.address_id = address.address_id) store_address
			ON city.city_id = store_address.city_id) store_city
ON store_city.country_id = country.country_id;

/*3*/
SELECT  staff.store_id, COUNT(amount)
FROM sakila.payment
INNER JOIN sakila.staff
ON payment.staff_id = staff.staff_id
GROUP BY staff.store_id;

/*4*/
SELECT category.name, round(AVG(length),2)
FROM sakila.category
INNER JOIN
	(SELECT film.title,length,film_category.category_id
	FROM sakila.film
	INNER JOIN sakila.film_category
	ON film.film_id = film_category.film_id) categories_film
ON category.category_id = categories_film.category_id
GROUP BY category.name;

/*5*/
SELECT category.name, round(AVG(length),2)
FROM sakila.category
INNER JOIN
	(SELECT film.title,length,film_category.category_id
	FROM sakila.film
	INNER JOIN sakila.film_category
	ON film.film_id = film_category.film_id) categories_film
ON category.category_id = categories_film.category_id
GROUP BY category.name
ORDER BY length DESC
LIMIT 1;
/*6*/
SELECT film_inv.title, COUNT(rental.rental_id)
FROM sakila.rental
INNER JOIN
	(SELECT title, inventory_id
	FROM sakila.film
	INNER JOIN sakila.inventory
	ON film.film_id = inventory.film_id) film_inv
ON rental.inventory_id = film_inv.inventory_id
GROUP BY film_inv.title
ORDER BY COUNT(rental.rental_id) DESC
LIMIT 10;
/*7*/
SELECT title
FROM rental
INNER JOIN
	(SELECT title, inventory_id, store_id
	FROM sakila.film
	INNER JOIN sakila.inventory
	ON film.film_id = inventory.film_id) film_inv
ON film_inv.inventory_id = rental.inventory_id AND film_inv.title LIKE "Academy Dinosaur"
WHERE rental_date < return_date
LIMIT 1
#Yes, it can be rented 
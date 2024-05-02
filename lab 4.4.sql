USE sakila;
SELECT COUNT(film_category.film_id), category.name 
FROM film_category
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY film_category.category_id;

SELECT store.store_id, city.city, country.country
FROM store
INNER JOIN address
ON store.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id;

SELECT SUM(payment.amount), store.store_id
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
INNER JOIN store
ON staff.store_id = store.store_id
GROUP BY store.store_id;

SELECT AVG(film.length), category.category_id
FROM category 
INNER JOIN film_category 
ON category.category_id = film_category.category_id
INNER JOIN film
ON film.film_id = film_category.film_id
GROUP BY category.category_id;
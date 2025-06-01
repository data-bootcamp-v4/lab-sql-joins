USE sakila;


SELECT category.name, count(DISTINCT film_category.film_id) as amt_films
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
GROUP BY category.name;

SELECT store.store_id, address.address, address.address2, city.city, country.country
FROM store
INNER JOIN address
ON store.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id;

SELECT staff.store_id, sum(payment.amount) as total_revenue
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.store_id;

SELECT category.name, floor(AVG(film.length)) as avg_film_length
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN film
ON film_category.film_id = film.film_id
GROUP BY category.name;

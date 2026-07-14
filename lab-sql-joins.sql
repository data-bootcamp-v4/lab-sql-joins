USE Sakila

-- 1 films per category
SELECT 
	category.name,
    COUNT(film_category.film_id) AS number_of_films
FROM  film_category
JOIN category
	ON film_category.category_id = category.category_id
GROUP BY category.name;

-- 2 STORE location
SELECT
	store.store_id,
    address.address,
    city.city,
    country.country
FROM store
JOIN address
	ON store.address_id = address.address_id
JOIN city
	ON address.city_id = city.city_id
JOIN country
	ON city.country_id = country.country_id;
   
-- 3 Revenue per store
SELECT
	staff.store_id,
    SUM(payment.amount) AS revenue
FROM staff
JOIN payment
	ON staff.staff_id = payment.staff_id
GROUP BY staff.store_id;
    
-- 4 AVG running time of fils 4 each cat

SELECT
	category.name,
	ROUND(AVG(film.length)) AS avg_runing_time
FROM film_category
JOIN film
	ON film_category.film_id = film.film_id
JOIN category
	ON film_category.category_id= category.category_id 
GROUP BY category.name;

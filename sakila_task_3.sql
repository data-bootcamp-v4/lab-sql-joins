USE sakila;

SELECT title
FROM film
WHERE film_id IN (SELECT film_id 
					FROM film_category
                    WHERE category_id IN (SELECT category_id
											FROM category
                                            WHERE name = "Action"));
                                            
SELECT name, COUNT(title)
FROM category
JOIN film_category
USING(category_id)
JOIN film
USING(film_id)
GROUP BY category_id;

SELECT store.store_id, ci.city, co.country
FROM store
JOIN address
USING(address_id)
JOIN city as ci
USING(city_id)
JOIN country as co
USING(country_id);

SELECT store_id, SUM(amount)
FROM store
JOIN customer
USING(store_id)
JOIN payment
USING(customer_id)
GROUP BY store_id;

SELECT rating, ROUND(AVG(length),2) as length_movies
FROM film
GROUP BY rating
ORDER BY length_movies DESC;
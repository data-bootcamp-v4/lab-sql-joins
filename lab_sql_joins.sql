# Challenge 1

SELECT category.name, SUM(film_category.film_id)
FROM film_category
LEFT JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY category.name;

# Challenge 2

SELECT 
	store.store_id, 
    city.city,
    country.country
FROM store
LEFT JOIN address ON  store.address_id = address.address_id
LEFT JOIN city ON address.city_id = city.city_id
LEFT JOIN country ON city.country_id = country.country_id;

# Challenge 3

SELECT
	store.store_id,
    SUM(payment.amount)
FROM store
LEFT JOIN customer ON store.store_id = customer.store_id
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;

# Challenge 4/5

SELECT
	category.name,
    AVG(film.length)
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
LEFT JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY AVG(film.length) desc;

# Challenge 7

SELECT
	film.title,
    store.store_id
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN store ON inventory.store_id = store.store_id
WHERE film.title = "Academy Dinosaur";

    
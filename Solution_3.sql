SELECT
  COUNT(film_category.film_id) AS film_count,
  category.category_id,
  category.name
FROM category
LEFT JOIN film_category
  ON category.category_id = film_category.category_id
GROUP BY 
  category.category_id,
  category.name; -- 1
  
SELECT
	store.store_id, -- store
    city.city, -- city name
    country.country -- country name
FROM store
LEFT JOIN address
	ON store.address_id = address.address_id -- joining store and address tables 
LEFT JOIN city
    ON address.city_id = city.city_id -- joining address and city tables
LEFT JOIN country
	ON city.country_id = country.country_id; -- joining city and country tables -- 2


SELECT 
	store.store_id,
    SUM(payment.amount) AS total_revenue_in_dollars
FROM store
LEFT JOIN staff
	ON store.store_id = staff.store_id -- joining store and staff tables
LEFT JOIN payment
	ON staff.staff_id = payment.staff_id -- joining staff and payment tables
GROUP BY store.store_id; -- 3

SELECT
	category.category_id,
    category.name,
    AVG(film.length) AS avg_running_time
FROM category
LEFT JOIN film_category
	ON category.category_id = film_category.category_id -- joining category and film_category tables
LEFT JOIN film
	ON film_category.film_id = film.film_id -- joining film_category and film tables
GROUP BY category.category_id, category.name; -- 4

SELECT
    category.name,
    AVG(film.length) AS avg_running_time
FROM category
LEFT JOIN film_category
	ON category.category_id = film_category.category_id -- joining category and film_category tables
LEFT JOIN film
	ON film_category.film_id = film.film_id -- joining film_category and film tables
GROUP BY category.name
ORDER BY avg_running_time DESC
LIMIT 8; -- 5

SELECT
	film.film_id,
    film.title,
    COUNT(*) AS most_rented
FROM rental
LEFT JOIN inventory
	ON rental.inventory_id = inventory.inventory_id -- joining rental and inventory
LEFT JOIN film
	ON inventory.film_id = film.film_id -- joining inventory and film
GROUP BY film.film_id, film.title
ORDER BY most_rented DESC
LIMIT 10; -- 6

SELECT 
	film.title,
    store_id
FROM film
LEFT JOIN inventory
	ON film.film_id = inventory.film_id -- joining film and inventory
LEFT JOIN rental
	ON inventory.inventory_id = rental.inventory_id -- joining inventory and rental
	WHERE inventory.store_id = 1
		  AND film.title = 'Academy Dinosaur'; -- 7

SELECT
	film.title,
    CASE
		WHEN inventory.inventory_id IS NULL THEN "Not Available"
		ELSE "Available"
	END AS Availability
FROM film
LEFT JOIN inventory
	ON film.film_id = inventory.film_id; -- joining film and inventory -- 8
	


	

	


    
    
    
    
    
    
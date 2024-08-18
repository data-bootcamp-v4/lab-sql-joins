#lab4
USE sakila;

#SELECT category.name AS category_name, 
		#COUNT(film.film_id) AS number_of_films
#FROM category
#JOIN film_category ON category.category_id = film_category.category_id
#JOIN film ON film_category.film_id = film.film_id
#GROUP BY category_name;
# order by NUMBER_OF_FILMS desc; extra

SELECT name as category_name, count(*) as num_films
FROM category
JOIN film_category USING (category_id)
GROUP BY name
ORDER BY num_films desc;

# Break down:

SELECT * FROM film_category

JOIN film ON film_category.film_id = film.film_id;


SELECT * FROM category

JOIN film_category ON category.category_id = film_category.category_id;



#2
SELECT 
    store.store_id, 
    city.city, 
    country.country
FROM 
    store
JOIN 
    address ON store.address_id = address.address_id
JOIN 
    city ON address.city_id = city.city_id
JOIN 
    country ON city.country_id = country.country_id;
    
#3
SELECT 
    store.store_id, 
    SUM(payment.amount) AS total_revenue
FROM 
    payment
JOIN 
    rental ON payment.rental_id = rental.rental_id
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    store ON inventory.store_id = store.store_id
GROUP BY 
    store.store_id;

#4
SELECT 
    category.name AS category_name, 
    AVG(film.length) AS average_running_time
FROM 
    category
JOIN 
    film_category ON category.category_id = film_category.category_id
JOIN 
    film ON film_category.film_id = film.film_id
GROUP BY 
    category.name
ORDER BY 
    average_running_time DESC;
    
    
    ## Bonus:
# 5. Identify the film categories with the longest average running time.

SELECT category.name AS Category, 
	   AVG(film.length) AS Average_Run_Time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY Average_Run_Time DESC
LIMIT 1;

# 6. Display the top 10 most frequently rented movies in descending order.

SELECT film.title, 
       COUNT(rental.rental_id) AS Rental_Count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY Rental_Count DESC
LIMIT 10;

# 7. Determine if "Academy Dinosaur" can be rented from Store 1.

SELECT film.title, 
	   inventory.store_id,
	   CASE WHEN COUNT(inventory.inventory_id) > 0 
       THEN 'Yes' 
       ELSE 'No' 
       END AS Available_for_Rental
FROM film
JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title = 'Academy Dinosaur' AND inventory.store_id = 1
GROUP BY film.title, inventory.store_id;

# 8. Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."

SELECT 
    DISTINCT film.title,
    CASE 
        WHEN inventory.film_id IS NOT NULL THEN 'Available' 
        ELSE 'NOT available' 
    END AS availability_status
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id;

Use sakila;
SELECT 
    c.name AS cat_name, COUNT(fc.film_id) AS film_per_category
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

SELECT 
    s.store_id, c.city, co.country
FROM
    store s
        JOIN
    address a ON s.address_id = a.address_id
        JOIN
    city c ON a.city_id = c.city_id
        JOIN
    country co ON c.country_id = co.country_id;

SELECT 
s.store_id,
SUM(p.amount) AS total_revenue
FROM store s
JOIN
	staff st ON s.store_id = st.store_id
JOIN 
	payment p ON st.staff_id = p.staff_id
GROUP BY store_id;

SELECT
c.name AS category,
ROUND(AVG(f.length),2) AS avg_running_time
FROM
	category c
JOIN
	film_category fc ON c.category_id = fc.category_ID
JOIN
	film f ON fc.film_id = f.film_id
GROUP BY c.name;

SELECT
c.name AS category,
ROUND(AVG(f.length),2) AS avg_running_time
FROM
	category c
JOIN
	film_category fc ON c.category_id = fc.category_ID
JOIN
	film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

SELECT 
	f.title,
    COUNT(rental_id) AS number_rent
FROM film f
JOIN
	inventory i ON f.film_id = i.film_id
JOIN
	rental r ON i.inventory_id = r.inventory_id
 GROUP BY f.title   
ORDER BY number_rent DESC
LIMIT 10;

SELECT
f.title,
s.store_id
FROM inventory i
JOIN store s ON i.store_id = s.store_id
JOIN film f ON i.film_id = f.film_id
WHERE f.title ='Academy Dinosaur' AND s.store_id =1;

SELECT
DISTINCT(f.title) AS film_title,
CASE
	WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
    ELSE 'NOT Available'
END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id=i.film_id
GROUP BY f.title    

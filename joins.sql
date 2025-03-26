USE sakila;

SELECT *
FROM film_category;

SELECT category_id,
COUNT(film_id) AS number_of_films
FROM sakila.film_category
GROUP BY category_id
ORDER BY category_id;

SELECT *
FROM sakila.store;

SELECT *
FROM sakila.city;

SELECT *
FROM sakila.country;

SELECT *
FROM sakila.address; 

SELECT s.store_id,
c.city_id,
co.country_id
FROM sakila.store AS s
JOIN sakila.address a on s.address_id=a.address_id
JOIN sakila.city as c on c.city_id=a.city_id
JOIN sakila.country as co on co.country_id=c.country_id;

SELECT *
FROM sakila.payment;

SELECT *
FROM sakila.store;

SELECT *
FROM sakila.staff;

SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM sakila.payment p
JOIN sakila.staff st ON p.staff_id = st.staff_id
JOIN sakila.store s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY s.store_id;

SELECT *
FROM sakila.film;

SELECT *
FROM sakila.film_category;

SELECT 
fc.category_id,
AVG(f.length) AS average_running_time
FROM sakila.film f
JOIN sakila.film_category fc
ON fc.film_id=f.film_id
GROUP BY category_id
ORDER BY category_id;

SELECT c.name AS category_name,
AVG(f.length) AS average_running_time
FROM sakila.film f
JOIN sakila.film_category fc on f.film_id=fc.film_id
JOIN sakila.category c ON fc.category_id=c.category_id
GROUP BY c.name
ORDER BY average_running_time DESC
LIMIT 1;

SELECT *
FROM sakila.rental;

SELECT *
FROM sakila.inventory;

SELECT *
FROM sakila.film;

SELECT
f.film_id,
f.title,
COUNT(r.inventory_id) AS rental_count
FROM sakila.rental r
JOIN sakila.inventory i 
ON r.inventory_id=i.inventory_id
JOIN sakila.film f 
ON f.film_id=i.film_id
GROUP BY f.film_id,f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT f.title,
i.store_id
FROM sakila.film f
JOIN sakila.inventory i 
ON f.film_id=i.film_id
WHERE f.title='Academy Dinosaur'
And i.store_id=1;



SELECT 
    f.title,
    CASE 
        WHEN IFNULL(inv.count_in_inventory, 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM sakila.film f
LEFT JOIN (
    SELECT 
        film_id,
        COUNT(*) AS count_in_inventory
    FROM sakila.inventory
    GROUP BY film_id
) AS inv ON f.film_id = inv.film_id
ORDER BY f.title;


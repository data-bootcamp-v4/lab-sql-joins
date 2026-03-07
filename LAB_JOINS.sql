USE sakila; 

SELECT c.name AS 'Category', COUNT(distinct(fc.film_id)) AS 'Number_of_films' FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
GROUP BY c.name;

SELECT s.store_id, c.city, co.country FROM sakila.store AS s
JOIN sakila.address AS a
ON s.address_id = a.address_id
JOIN sakila.city AS c 
ON c.city_id = a.city_id
JOIN sakila.country AS co
ON co.country_id = c.country_id;


SELECT s.store_id, CONCAT('$', SUM(p.amount)) AS 'Revenue' FROM sakila.payment AS p 
JOIN sakila.rental AS r 
ON p.rental_id = r.rental_id
JOIN  sakila.inventory AS i 
ON i.inventory_id = r.inventory_id
JOIN sakila.store AS s 
ON s.store_id = i.store_id
GROUP BY s.store_id, 'Revenue';


SELECT c.name AS 'Category', ROUND(AVG(f.length),2) AS 'Average Duration' FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
JOIN sakila.film AS f
ON f.film_id = fc.film_id
GROUP BY c.name;


#BONUS 

SELECT c.name AS 'Category', ROUND(AVG(f.length),2) AS 'Average Duration' FROM sakila.category AS c
JOIN sakila.film_category AS fc
ON c.category_id = fc.category_id
JOIN sakila.film AS f
ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY ROUND(AVG(f.length),2) DESC;

SELECT f.title, COUNT(distinct(r.rental_id)) AS 'rental_frequency' FROM sakila.rental AS r
JOIN sakila.inventory AS i 
ON r.inventory_id = i.inventory_id
JOIN sakila.film AS f 
ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY COUNT(distinct(r.rental_id)) DESC
LIMIT 10;

SELECT film.film_id, film.title, store.store_id, inventory.inventory_id
FROM inventory
JOIN store USING (store_id)
JOIN film USING (film_id)
WHERE film.title = 'Academy Dinosaur'
AND store.store_id = 1;


SELECT DISTINCT f.title,
CASE
    WHEN i.film_id IS NULL THEN 'Not Available'
    ELSE 'Available'
END AS Availability
FROM sakila.inventory AS i
RIGHT JOIN sakila.film AS f
ON i.film_id = f.film_id;
USE sakila;


SELECT COUNT(*) AS film_count, c.name
FROM film_category AS fc
JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY COUNT(*) DESC;


SELECT s.store_id, ct.city, cn.country
FROM store AS s
LEFT JOIN address AS a ON s.address_id = a.address_id
LEFT JOIN city AS ct ON a.city_id = ct.city_id
LEFT JOIN country AS cn ON ct.country_id = cn.country_id;


SELECT SUM(amount), str.store_id
FROM payment AS p
LEFT JOIN staff AS stf ON p.staff_id = stf.staff_id
LEFT JOIN store AS str ON stf.staff_id = str.manager_staff_id
GROUP BY str.store_id;

SELECT AVG(length), c.name
FROM film as f
LEFT JOIN film_category as fc ON f.film_id = fc.film_id
LEFT JOIN category as c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY AVG(length) DESC;


SELECT i.inventory_id, COUNT(r.rental_id) AS rental_count
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
GROUP BY i.inventory_id;

SELECT COUNT(r.rental_id) AS rental_count, f.film_id, title
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 10;

SELECT f.title, s.store_id
FROM film AS f
JOIN inventory as i ON f.film_id = i.film_id
JOIN store as s ON i.store_id = s.store_id
HAVING store_id = 1;

SELECT DISTINCT title FROM film;

SELECT * FROM inventory;
SELECT * FROM rental;

SELECT f.title, f.film_id, SUM(i.inventory_id) AS inventory_count
FROM film as f
LEFT JOIN inventory as i ON f.film_id = i.film_id
GROUP BY film_id
CASE
	WHEN IFNULL(inventory_count) THEN inventory_count = 'NOT Available'
    ELSE inventory_count
    END;
    
SELECT 
	f.title, 
	f.film_id, 
    CASE
        WHEN SUM(i.inventory_id) IS NULL THEN 'NOT Available'
        ELSE 'Available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title;


SELECT f.title, f.film_id, IFNULL(SUM(i.inventory_id), 'NOT Available') AS inventory_count
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title;

SELECT 
    f.title, 
    f.film_id, 
    CASE 
        WHEN IFNULL(SUM(i.inventory_id), 0) > 0 THEN 'Available'
        ELSE 'NOT Available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title;


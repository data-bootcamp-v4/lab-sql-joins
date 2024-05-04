# 1
SELECT COUNT(f.film_id) AS 'Number of Film', c.name
FROM film_category f
INNER JOIN category c
ON c.category_id = f.category_id
GROUP BY c.name;

# 2
SELECT s.store_id, c.city, y.country
FROM store s
INNER JOIN address a 
ON s.address_id = a.address_id
INNER JOIN city c 
ON a.city_id = c.city_id
INNER JOIN country y
ON c.country_id = y.country_id;

#3
SELECT store_id, SUM(amount)
FROM rental r
INNER JOIN inventory s 
ON s.inventory_id = r.inventory_id
INNER JOIN payment x
ON r.rental_id = x.rental_id
GROUP BY store_id;

#4
SELECT c.name, AVG(length)
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
INNER JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name;

# 5
SELECT c.name, AVG(length)
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
INNER JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY AVG(length) DESC
LIMIT 1;

# 6
SELECT length, title, f.film_id
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN film f
ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY length DESC
LIMIT 10;

# 7 
SELECT *
FROM inventory i 
INNER JOIN store s 
ON s.store_id = i.store_id
INNER JOIN film f
ON f.film_id = i.film_id
WHERE title = 'Academy Dinosaur' AND s.store_id = 1;

# 8 Unreasonable. 
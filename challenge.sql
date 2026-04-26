USE SAKILA;

-- 1.
SELECT c.name, COUNT(f.film_id) as number_of_films
FROM category as c
LEFT JOIN film_category as fc
ON c.category_id=fc.category_id
LEFT JOIN film as f
ON fc.film_id=f.film_id
GROUP BY c.name
ORDER BY number_of_films DESC;

-- 2.
SELECT s.store_id,city.city,country.country
FROM store as s
INNER JOIN address as addr 
ON s.address_id=addr.address_id
INNER JOIN city as city 
ON addr.city_id=city.city_id
INNER JOIN country as country
ON city.country_id=country.country_id;

-- 3.

SELECT store.store_id, sum(p.amount) as total_revenue
FROM payment as p
LEFT JOIN staff 
ON p.staff_id=staff.staff_id
LEFT JOIN store
ON staff.store_id=store.store_id
GROUP BY store.store_id;

-- 4.
SELECT c.name, Round(AVG(f.length),2) as avg_length
FROM category as c
LEFT JOIN film_category as fc
ON c.category_id=fc.category_id
LEFT JOIN film as f
ON fc.film_id=f.film_id
GROUP BY c.name;


USE sequila;

## 1 ##
SELECT f.title, c.name 
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id; 

## 2 ##
SELECT s.store_id, c.city, co.country 
FROM store AS s
JOIN address AS a
ON s.address_id = a.address_id
JOIN city AS c
ON a.city_id = c.city_id
JOIN country AS co
ON c.country_id = co.country_id;

## 3 ##
SELECT s.store_id, SUM(p.amount)
FROM store AS s
JOIN customer AS c
ON s.store_id = c.store_id
JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY s.store_id
;

## 4 ##
SELECT c.name, round(AVG(f.length),2)
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c.name
;




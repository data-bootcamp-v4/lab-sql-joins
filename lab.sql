USE sakila;
SELECT c.name as 'name_category', count(*) AS total FROM film_category AS fc
JOIN category AS c
JOIN film as f
ON c.category_id = fc.category_id AND f.film_id = fc.film_id
GROUP BY c.name;
SELECT s.store_id, c.city,co.country FROM store AS s
JOIN address AS a
JOIN city AS c
JOIN country as co
ON s.address_id = a.address_id AND c.city_id = a.city_id AND c.country_id = co.country_id;
select st.store_id, sum(p.amount) AS 'revenue($)' from payment AS p
JOIN rental as r
JOIN staff as s
JOIN store as st
ON p.rental_id = r.rental_id AND r.staff_id = s.staff_id AND s.store_id = st.store_id
GROUP BY st.store_id;

SELECT c.name as 'name_category', AVG(f.length) AS 'avg_min_duration' FROM film_category AS fc
JOIN category AS c
JOIN film as f
ON c.category_id = fc.category_id AND f.film_id = fc.film_id
GROUP BY c.name;

SELECT c.name as 'name_category', AVG(f.length) AS 'avg_min_duration' FROM film_category AS fc
JOIN category AS c
JOIN film as f
ON c.category_id = fc.category_id AND f.film_id = fc.film_id
GROUP BY c.name
ORDER BY avg_min_duration DESC
LIMIT 5;

show tables;
select * from inventory;
select f.title, count(*) as total from rental AS r
JOIN inventory AS i
JOIN film AS f
ON i.inventory_id = r.inventory_id AND f.film_id = i.film_id
GROUP BY i.film_id
ORDER BY total DESC LIMIT 10;

SELECT * FROM Inventory WHERE store_id = 1 AND film_id = (SELECT film_id FROM FILM WHERE title like('%Academy Dinosaur%'));
-- Si se puede alquilar ya que hay 4 en el inventario --
select f.title, (CASE WHEN count(i.film_id) = 0 THEN 'NOT AVAILABLE' ELSE 'AVAILABLE' END) from inventory as i
RIGHT JOIN film as f
ON i.film_id  = f.film_id
GROUP BY f.title;
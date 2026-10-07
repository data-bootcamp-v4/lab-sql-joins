use sakila;

  
  
  SELECT ca.name, COUNT(c.film_id) FROM category as ca
  JOIN film_category as c
  ON ca.category_ID = c.category_id
  group by ca.name
  ;
  
  
  SELECT s.store_id from store as s
JOIN address AS a
  ON s.address_id = a.address_id
JOIN city AS c
  ON a.city_id = c.city_id
JOIN country AS co
  ON c.country_id = co.country_id;
  
  SELECT s.store_id, c.city, co.country
FROM store AS s
JOIN address AS a
  ON s.address_id = a.address_id
JOIN city AS c
  ON a.city_id = c.city_id
JOIN country AS co
  ON c.country_id = co.country_id;
SELECT * FROM staff;
SELECT * FROM payment;
SELECT * FROM store;

-- s.manager_staff_id = p.staff_id


SELECT s.store_id, ROUND(SUM(p.amount), 2) as totale_revenue FROM payment as p
join staff as st
on p.staff_id = st.staff_id
JOIN store as s
ON st.store_id = s.store_id
GROUP BY s.store_id;

SELECT ca.name, ROUND(AVG(length), 2) as AVG_length
FROM film AS f
JOIN film_category AS c
  ON f.film_id = c.film_id
JOIN category AS ca
  ON c.category_id = ca.category_id
group by ca.name;



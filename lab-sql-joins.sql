USE SAKILA;

#1
SELECT  
		 fc.category_id,
         c.name AS category_name,
         count(fc.film_id) AS film_count
FROM film_category fc
INNER JOIN category c
	ON c.category_id = fc.category_id
GROUP BY fc.category_id, c.name
ORDER BY fc.category_id;

#2
SELECT s.store_id,
    c.city,
    co.country
FROM store s
INNER JOIN address a
	ON a.address_id = s.address_id
INNER JOIN city c
	ON c.city_id = a.city_id
INNER JOIN country co
	ON c.country_id = co.country_id;

#3
SELECT 
	  st.store_id,
	  SUM(p.amount) as revenue
FROM payment p
INNER JOIN staff s
	ON p.staff_id = s.staff_id
INNER JOIN store st 
	ON s.store_id = st.store_id
GROUP BY st.store_id
ORDER BY st.store_id;

#4
SELECT c.name,
	  COUNT(f.film_id) AS film_count,
	   ROUND(AVG(f.length),2) AS avg_length
FROM film f
INNER JOIN film_category fc
	ON f.film_id = fc.film_id
INNER JOIN category c
	ON fc.category_id = c.category_id
GROUP BY c.name;


#5
SELECT c.name,
	   ROUND(AVG(f.length),2) AS avg_length
FROM film f
INNER JOIN film_category fc
	ON f.film_id = fc.film_id
INNER JOIN category c
	ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 5;

#6
SELECT f.film_id,
	f.title, 
COUNT(r.inventory_id) AS rental_count
FROM rental r
INNER JOIN inventory i
	ON r.inventory_id = i.inventory_id
INNER JOIN film f
	ON i.film_id = f.film_id
GROUP BY f.title, f.film_id
ORDER BY rental_count DESC
LIMIT 10;

#7
SELECT *
FROM inventory
WHERE film_id = 1 
	 AND store_id = 1;
     
#8     
SELECT 
    f.title,
    CASE 
        WHEN COUNT(i.inventory_id) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;

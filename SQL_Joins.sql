SELECT 
	c.name, 
    COUNT(*) AS total_films
FROM film AS f
JOIN film_category AS fc 
ON f.film_id = fc.film_id 
JOIN category AS c
ON c.category_id = fc.category_id
GROUP BY c.name 
ORDER BY total_films DESC;

SELECT 
	s.store_id,
    c.city,
    co.country
    
FROM store AS s
JOIN address AS  a 
	ON s.address_id = a.address_id 
JOIN city AS c 
	ON a.city_id = c.city_id 
JOIN country AS co
	ON c.country_id = co.country_id
GROUP BY s.store_id

SELECT 
	s.store_id, 
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM store AS s
JOIN staff AS st
	ON s.store_id = st.store_id
JOIN payment as p
	ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

SELECT
	c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
JOIN film_category AS fc
	ON c.category_id = fc.category_id
JOIN film AS f
	ON fc.film_id = f.film_id 
GROUP BY c.name;


SELECT
	c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
JOIN film_category AS fc
	ON c.category_id = fc.category_id
JOIN film AS f
	ON fc.film_id = f.film_id
GROUP BY c.name 
ORDER BY avg_running_time DESC;

SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT
    s.store_id,
    f.title,
    COUNT(i.inventory_id) AS copies_available
FROM store AS s
JOIN inventory AS i
    ON s.store_id = i.store_id
JOIN film AS f
    ON i.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
  AND s.store_id = 1
GROUP BY s.store_id, f.title;

SELECT
    f.title,
    CASE
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;
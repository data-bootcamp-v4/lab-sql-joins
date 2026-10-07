SELECT 
	c.name,
    COUNT(fc.film_id) AS total_films
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name;

SELECT 
	s.store_id,
    c.city,
    co.country
FROM address AS a
JOIN city AS c
ON a.city_id = c.city_id
JOIN country AS CO
ON CO.country_id = c.country_id
JOIN store AS s
ON a.address_id = s.address_id;


SELECT 
	SUM(p.amount) AS total_revenue,
    s.store_id
FROM store AS s
JOIN staff AS st
ON s.store_id = st.store_id
JOIN payment AS p
ON st.staff_id = p.staff_id
GROUP BY s.store_id;


SELECT 
	AVG(f.length) AS avg_length,
    c.name
FROM film AS f
JOIN film_category AS fc
ON f.film_id = fc.film_id
JOIN category AS c
ON fC.category_id = c.category_id
GROUP BY c.category_id, c.name;







	-- 1

SELECT 
	c.name AS category,
	COUNT(f.film_id) AS number_of_films
    
FROM
	category AS c
    
JOIN
	film_category AS fc
    ON c.category_id = fc.category_id
    
JOIN
	film AS f
    ON fc.film_id = f.film_id

GROUP BY
	c.name
    
ORDER BY
	number_of_films DESC;
    
    -- 2
    
SELECT
	s.store_id,
    ci.city,
    co.country
FROM
	store AS s
JOIN
	address AS a
    ON s.address_id = a.address_id
JOIN
	city AS ci
    ON a.city_id = ci.city_id
JOIN
	country AS co
    ON ci.country_id = co.country_id
ORDER BY
	s.store_id;
    
    -- 3

SELECT
	s.store_id,
    SUM(p.amount) AS total_revenue
FROM
	payment AS p
JOIN
	staff AS st
    ON p.staff_id = st.staff_id
JOIN
	store AS s
    ON st.store_id = s.store_id
GROUP BY
	s.store_id
ORDER BY
	total_revenue DESC;
    
		-- 4
        
SELECT
	c.name AS category,
    AVG(f.length) AS average_running_time
FROM
	category AS c
JOIN
	film_category AS fc
    ON c.category_id = fc.category_id
JOIN
	film AS f
	ON fc.film_id = f.film_id
GROUP BY
	c.name
ORDER BY
	average_running_time DESC;
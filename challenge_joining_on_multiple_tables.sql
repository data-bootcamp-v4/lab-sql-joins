use sakila;

SELECT 
    c.name AS category_name, COUNT(fc.film_id) AS film_count
FROM
    sakila.film_category AS fc
        JOIN
    sakila.category AS c ON fc.category_id = c.category_id
GROUP BY c.name;




SELECT 
    s.store_id AS st_id,
    ci.city AS cty,
    co.country AS cot
FROM
    sakila.store AS s
        JOIN
    sakila.address AS a ON s.address_id = a.address_id
        JOIN
    sakila.city AS ci ON a.city_id = ci.city_id
        JOIN
    sakila.country AS co ON ci.country_id = co.country_id
ORDER BY s.store_id;


select * from film_category;

SELECT 
    st.store_id,
    SUM(p.amount) AS total_revenue
FROM
    sakila.payment AS p
        JOIN
    sakila.staff AS st ON p.staff_id = st.staff_id
GROUP BY st.store_id;


select * from category;

SELECT 
    c.name AS category_name,
    round(AVG(f.length),2) AS avg_film_length
FROM
    sakila.film AS f
        JOIN
    sakila.film_category AS fc ON f.film_id = fc.film_id
        JOIN
    sakila.category AS c ON fc.category_id = c.category_id
GROUP BY 
	c.name;

SELECT 
    c.name AS category_name,
    round(AVG(f.length),2) AS avg_film_length
FROM
    sakila.film AS f
        JOIN
    sakila.film_category AS fc ON f.film_id = fc.film_id
        JOIN
    sakila.category AS c ON fc.category_id = c.category_id
GROUP BY 
	c.name
ORDER BY
	avg_film_length desc;
    
SELECT 
    title, 
    rental_rate
FROM
    film
ORDER BY 
	rental_rate DESC
LIMIT 10;

select * from inventory;
select * from film;
select * from rental;

SELECT 
    f.title AS film_title,
    i.store_id
FROM 
    sakila.film AS f
JOIN 
    sakila.inventory AS i ON f.film_id = i.film_id
WHERE 
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1
LIMIT 1;

SELECT 
    f.title,
    CASE 
        WHEN IFNULL(MAX(i.inventory_id), 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM 
    sakila.film AS f
LEFT JOIN 
    sakila.inventory AS i ON f.film_id = i.film_id
GROUP BY 
    f.title;

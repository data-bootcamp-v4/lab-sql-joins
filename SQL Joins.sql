select category_id,count(*) as num_films
from film_category
group by category_id
order by num_films DESC;

select *
from address;

select *
from store;

SELECT 
    s.store_id,
    a.city_id,
    co.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id;

select *
from payment;

SELECT
    s.store_id,
    CONCAT(a.city_id, ', ', co.country) AS store_location,
    SUM(p.amount) AS total_revenue
FROM
    store s
JOIN
    staff st ON s.manager_staff_id = st.staff_id
JOIN
    address a ON st.address_id = a.address_id
JOIN
    city ci ON a.city_id = ci.city_id
JOIN
    country co ON ci.country_id = co.country_id
JOIN
    payment p ON s.store_id = p.store_id
GROUP BY
    s.store_id,
    store_location
ORDER BY
    total_revenue DESC;
    
    
SELECT
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM
    film f
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id
GROUP BY
    c.name
ORDER BY
    average_running_time DESC;
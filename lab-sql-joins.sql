use sakila; 
-- 1
select
category_table.name as category, 
COUNT(film_table.film_id) AS number_of_films
from category category_table 
join film_category film_category_table
on category_table.category_id = film_category_table.category_id
join film film_table 
on film_category_table.film_id = film_table.film_id
group by category_table.name 
order by number_of_films desc;

-- 2 
SELECT 
store_table.store_id,
city_table.city,
country_table.country
FROM store store_table
JOIN address address_table
ON store_table.address_id = address_table.address_id
JOIN city city_table
ON address_table.city_id = city_table.city_id
JOIN country country_table
ON city_table.country_id = country_table.country_id;

-- 3
SELECT 
store_table.store_id,
SUM(payment_table.amount) AS total_revenue
FROM store store_table
JOIN staff staff_table
ON store_table.store_id = staff_table.store_id
JOIN payment payment_table
ON staff_table.staff_id = payment_table.staff_id
GROUP BY store_table.store_id
ORDER BY total_revenue DESC;

-- 4
SELECT 
category_table.name AS category,
ROUND(AVG(film_table.length), 2) AS average_running_time
FROM category category_table
JOIN film_category film_category_table
ON category_table.category_id = film_category_table.category_id
JOIN film film_table
ON film_category_table.film_id = film_table.film_id
GROUP BY category_table.name
ORDER BY average_running_time DESC;
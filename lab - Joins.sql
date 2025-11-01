#1
USE SAKILA;

select * from film_category;
select * from category;

SELECT name, COUNT(film_id) AS num_film_cat
FROM category c
JOIN film_category fc
on c.category_id = fc.category_id
GROUP BY`name`
ORDER BY num_film_cat DESC;

#2
SELECT store_id, city, country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id= c.city_id
JOIN country co ON c.country_id= co.country_id
ORDER BY s.store_id ASC;


select * from store;

#3
SELECT
    s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

# 4

SELECT
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS avg_time
FROM
    category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_time DESC;










































SELECT 
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY film_count DESC;
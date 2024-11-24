USE sakila;

SELECT 
    c.name AS category_name,
    COUNT(fc.film_id) AS films_per_category
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name;

SELECT s.store_id,
       ci.city,
       co.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id;
    
SELECT 
    so.store_id,
    SUM(p.amount) AS total_revenue
FROM store so
JOIN staff sa ON so.store_id = sa.store_id
JOIN payment p ON sa.staff_id = p.staff_id
GROUP BY so.store_id;

SELECT AVG(f.length) AS average_film_length,
       c.name AS category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY category;
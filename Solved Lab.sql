USE sakila;

SELECT 
    c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
JOIN film f 
    ON fc.film_id = f.film_id
GROUP BY c.name;

SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a 
    ON s.address_id = a.address_id
JOIN city ci 
    ON a.city_id = ci.city_id
JOIN country co 
    ON ci.country_id = co.country_id;
    
    SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st 
    ON s.store_id = st.store_id
JOIN payment p 
    ON st.staff_id = p.staff_id
GROUP BY s.store_id;

SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
JOIN film f 
    ON fc.film_id = f.film_id
GROUP BY c.name;






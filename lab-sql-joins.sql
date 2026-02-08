SELECT 
    c.name AS category_name, 
    COUNT(fc.film_id) AS number_of_films
FROM 
    sakila.category c
JOIN 
    sakila.film_category fc ON c.category_id = fc.category_id
JOIN 
    sakila.film f ON fc.film_id = f.film_id
GROUP BY 
    c.name;
    
    SELECT 
    s.store_id, 
    ci.city, 
    co.country 
FROM 
    sakila.store s
JOIN 
    sakila.address a ON s.address_id = a.address_id
JOIN 
    sakila.city ci ON a.city_id = ci.city_id
JOIN 
    sakila.country co ON ci.country_id = co.country_id;
    
    SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue
FROM 
    sakila.payment p
JOIN 
    sakila.rental r ON p.rental_id = r.rental_id
JOIN 
    sakila.inventory i ON r.inventory_id = i.inventory_id
JOIN 
    sakila.store s ON i.store_id = s.store_id
GROUP BY 
    s.store_id;
    
    SELECT 
    c.name AS category_name,
    AVG(f.length) AS avg_running_time
FROM 
    sakila.category c
JOIN 
    sakila.film_category fc ON c.category_id = fc.category_id
JOIN 
    sakila.film f ON fc.film_id = f.film_id
GROUP BY 
    c.name;
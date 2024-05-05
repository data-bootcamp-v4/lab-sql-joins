USE sakila;
select * from film;

SELECT 
    c.name AS category_name, 
    COUNT(f.film_id) AS film_count 
FROM 
    film f 
INNER JOIN 
    film_category fc 
ON 
    f.film_id = fc.film_id 
INNER JOIN 
    category c 
ON 
    fc.category_id = c.category_id 
GROUP BY 
    c.name;


SELECT 
    s.store_id, 
    a.city, 
    a.country 
FROM 
    store s 
INNER JOIN 
    address a 
ON 
    s.address_id = a.address_id;
    
    
    
    SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue  -- Total revenue for each store
FROM 
    rental r 
INNER JOIN 
    payment p 
ON 
    r.rental_id = p.rental_id  -- Linking rental with payment
INNER JOIN 
    inventory i 
ON 
    r.inventory_id = i.inventory_id  -- Linking rental with inventory
INNER JOIN 
    store s 
ON 
    i.store_id = s.store_id  -- Linking inventory with store
GROUP BY 
    s.store_id;
    
SELECT 
    c.name AS category_name, 
    AVG(f.length) AS average_running_time  -- Average running time
FROM 
    film f 
INNER JOIN 
    film_category fc 
ON 
    f.film_id = fc.film_id 
INNER JOIN 
    category c 
ON 
    fc.category_id = c.category_id 
GROUP BY 
    c.name;



USE sakila;

-- This query joins the film, film_category, and category tables to count how many films belong to each category.
SELECT 
    c.name AS category_name, 
    COUNT(film.film_id) AS film_count
FROM 
    film
JOIN 
    film_category fc ON film.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    film_count DESC;
    
    
-- This query retrieves store details by joining the store, address, city, and country tables.
SELECT 
    s.store_id, 
    c.city, 
    country.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city c ON a.city_id = c.city_id
JOIN 
    country ON c.country_id = country.country_id;

-- This query sums up the amount column from the payment table and groups the results by store_id to calculate the revenue for each store.
SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue
FROM 
    payment p
JOIN 
    rental r ON p.rental_id = r.rental_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    store s ON i.store_id = s.store_id
GROUP BY 
    s.store_id
ORDER BY 
    total_revenue DESC;

-- This query calculates the average film length for each category using the AVG() function.
SELECT 
    c.name AS category_name, 
    AVG(f.length) AS avg_running_time
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    avg_running_time DESC;

-- This query identifies the category with the longest average running time by sorting the results in descending order and limiting the output to the top result.
SELECT 
    c.name AS category_name, 
    AVG(f.length) AS avg_running_time
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    avg_running_time DESC
LIMIT 1;

-- This query counts the number of rentals for each film and orders the result in descending order to show the top 10 most rented movies.
SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
GROUP BY 
    f.title
ORDER BY 
    rental_count DESC
LIMIT 10;

-- This query checks if the film titled "Academy Dinosaur" has an entry in the inventory table for store 1. If it exists, it is considered available.
SELECT 
    CASE 
        WHEN i.inventory_id IS NOT NULL THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    f.title = 'Academy Dinosaur' 
    AND i.store_id = 1;
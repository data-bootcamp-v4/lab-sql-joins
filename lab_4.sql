-- Question 1
SELECT name, COUNT(name) AS n_movies
FROM sakila.film_category
LEFT JOIN sakila.category
ON film_category.category_id = category.category_id
GROUP BY name;

-- Question 2
SELECT 
    s.store_id,
    c.city,
    co.country
FROM sakila.store s
JOIN sakila.address a ON s.address_id = a.address_id
JOIN sakila.city c ON a.city_id = c.city_id
JOIN sakila.country co ON c.country_id = co.country_id;

-- Quesiton 3
SELECT 
    i.store_id,
    SUM(p.amount) AS total_revenue
FROM sakila.inventory i
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
JOIN sakila.payment p ON r.rental_id = p.rental_id
GROUP BY i.store_id;

-- Question 4
-- Determine the average running time of films for each category.
SELECT 
    c.name AS category_name,
    AVG(f.length) AS average_running_time
FROM sakila.film f
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY c.name

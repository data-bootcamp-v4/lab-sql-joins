USE sakila;

-- Get category information with the count of films in each category
SELECT c.category_id, c.name AS category_name, 
COUNT(*) AS film_count 
FROM category c 
LEFT JOIN film_category fc ON c.category_id = fc.category_id 
GROUP BY c.category_id, c.name 
ORDER BY film_count DESC;

-- Get store information along with associated city and country
SELECT s.store_id, a.city, a.country 
FROM store s 
JOIN address a ON s.address_id = a.address_id;

-- Calculate total revenue by store
SELECT s.store_id, 
	SUM(p.amount) AS total_revenue 
FROM store s 
JOIN customer c ON s.store_id = c.store_id 
JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY s.store_id;

-- Get average running time of films by category
SELECT fc.category_id, c.name AS category_name, 
    AVG(f.length) AS avg_running_time 
FROM film_category fc 
JOIN film f ON fc.film_id = f.film_id 
JOIN category c ON fc.category_id = c.category_id 
GROUP BY fc.category_id, c.name 
ORDER BY avg_running_time DESC;

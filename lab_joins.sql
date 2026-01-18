USE SAKILA;

SELECT 
    c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY number_of_films DESC;


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
    ROUND(SUM(p.amount), 2) AS total_revenue
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

SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

SELECT 
    f.title,
    COUNT(r.rental_id) AS total_rentals
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY total_rentals DESC
LIMIT 10;

SELECT 
    f.title,
    COUNT(i.inventory_id) AS copies_in_store_1
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1;
  
  
  SELECT 
    f.title,
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
GROUP BY f.title;





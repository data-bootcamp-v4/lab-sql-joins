USE sakila;

SELECT 
    c.name AS category_name,
    COUNT(f.film_id) AS film_count
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
JOIN film f 
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY film_count DESC;

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
    ON ci.country_id = co.country_id
ORDER BY s.store_id;

SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st 
    ON s.store_id = st.store_id
JOIN payment p 
    ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;


SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS avg_runtime
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
JOIN film f 
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_runtime DESC;


SELECT 
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS avg_runtime
FROM category c
JOIN film_category fc 
    ON c.category_id = fc.category_id
JOIN film f 
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_runtime DESC;

SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;


SELECT 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1;


SELECT 
    f.title,
    CASE 
        WHEN IFNULL(inv.inventory_count, 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM film f
LEFT JOIN (
    SELECT 
        i.film_id,
        COUNT(i.inventory_id) AS inventory_count
    FROM inventory i
    GROUP BY i.film_id
) inv 
    ON f.film_id = inv.film_id
ORDER BY f.title;


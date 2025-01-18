SELECT 
    c.name AS category_name, 
    COUNT(f.film_id) AS film_count
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    film_count DESC;
SELECT 
    s.store_id, 
    c.city, 
    co.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city c ON a.city_id = c.city_id
JOIN 
    country co ON c.country_id = co.country_id;
SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue
FROM 
    payment p
JOIN 
    staff st ON p.staff_id = st.staff_id
JOIN 
    store s ON st.store_id = s.store_id
GROUP BY 
    s.store_id
ORDER BY 
    total_revenue DESC;

SELECT 
    c.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_running_time
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
SELECT 
    c.name AS category_name, 
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
HAVING 
    AVG(f.length) = (SELECT MAX(avg_length) 
                     FROM (SELECT AVG(f.length) AS avg_length
                           FROM film f
                           JOIN film_category fc ON f.film_id = fc.film_id
                           GROUP BY fc.category_id) subquery);
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
SELECT 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Yes'
        ELSE 'No'
    END AS is_rentable
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
WHERE 
    f.title = 'Academy Dinosaur' AND i.store_id = 1;
SELECT 
    f.title, 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT Available'
    END AS availability_status
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.title
ORDER BY 
    f.title;

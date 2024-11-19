SELECT 
    c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM 
    film_category fc
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    number_of_films DESC;

SELECT 
    s.store_id,
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
	SUM(p.amount) AS total_revenue,
    s.store_id
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
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_length
FROM 
    film_category fc
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    average_length DESC;






SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_length
FROM 
    film_category fc
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    average_length DESC
LIMIT 5;

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
    COUNT(*) AS available
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE 
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1
    AND r.inventory_id IS NULL;


SELECT 
    f.title,
    CASE 
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.title
ORDER BY 
    f.title;


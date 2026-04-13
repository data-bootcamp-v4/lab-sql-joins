USE sakila;

SELECT 
    c.category_id,
    ca.name AS category_name,
    COUNT(f.film_id) AS film_count
FROM film f
JOIN film_category c
    ON f.film_id = c.film_id
JOIN category ca
    ON c.category_id = ca.category_id
GROUP BY 
    c.category_id, 
    ca.name
ORDER BY 
    film_count DESC;
    
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
SUM(p.amount) AS revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;

SELECT category.name, ROUND(AVG(film.length),2) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

SELECT 
    ca.category_id,
    ca.name AS category_name,
    AVG(f.length) AS avg_length
FROM film f
JOIN film_category c
    ON f.film_id = c.film_id
JOIN category ca
    ON c.category_id = ca.category_id
GROUP BY 
    ca.category_id, 
    ca.name
ORDER BY 
    avg_length DESC
LIMIT 3;

SELECT 
COUNT(r.rental_id) AS rental_count,
i.film_id,
f.title
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY 
	f.title,
	i.film_id
ORDER BY 
rental_count DESC
LIMIT 10
;

SELECT 
i.film_id,
f.title,
i.store_id
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN store AS s
ON i.store_id = s.store_id
WHERE f.title = "ACADEMY DINOSAUR" AND i.store_id = 1
;

SELECT 
    f.title,
    CASE 
        WHEN COUNT(i.inventory_id) = 0 THEN 'NOT available'
        WHEN SUM(CASE WHEN r.return_date IS NULL THEN 1 ELSE 0 END) > 0 
            THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film f
LEFT JOIN inventory i 
    ON f.film_id = i.film_id
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id, 
    f.title;
#1
SELECT 
    c.name AS category,
    COUNT(fc.film_id) AS number_of_films
FROM 
    film_category fc
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name;
    
#2
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

#3
SELECT 
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;

#4
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_length DESC;

#5 
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_length DESC
LIMIT 1;

#6
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;
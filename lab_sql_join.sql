use sakila;

/*1/
SELECT 
    c.name AS category, 
    COUNT(*) AS num_films
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;
/*2/
SELECT 
    s.store_id, 
    ci.city, 
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;
/*3/
SELECT 
    i.store_id, 
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY i.store_id;
/*4/
SELECT 
    c.name AS category, 
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;
/*5/
SELECT 
    c.name AS category, 
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;
/*6/
SELECT 
    f.title, 
    COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;
/*7/
SELECT 
    IF(COUNT(*) > 0, 
       'Academy Dinosaur is available for rent from Store 1', 
       'Academy Dinosaur is NOT available for rent from Store 1'
    ) AS rental_status
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1;
/*8/
SELECT 
    f.title,
    CASE 
        WHEN IFNULL(i.inv_count, 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM film f
LEFT JOIN (
    SELECT film_id, COUNT(*) AS inv_count
    FROM inventory
    GROUP BY film_id
) i ON f.film_id = i.film_id;
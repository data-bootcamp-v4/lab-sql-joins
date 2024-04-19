#LAB SQL JOINS
#1
SELECT c.name AS category,
    COUNT(*) AS num_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;
#2
SELECT store_id, city, country
FROM store
JOIN address
JOIN city 
JOIN country;
#3
SELECT store_id, 
	   SUM(amount) AS total_revenue
FROM store
JOIN payment ON store_id = store_id
GROUP BY store_id;
#4


SELECT     c.name AS category,
           AVG(f.length) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

#Bonus
SELECT c.name AS category,
       AVG(f.length) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;
#Bonus 2
SELECT f.title AS film_title,
       COUNT(*) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;
#Bonus 3
SELECT 
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM film f
            JOIN inventory i ON f.film_id = i.film_id
            JOIN store s ON i.store_id = s.store_id
            WHERE f.title = 'Academy Dinosaur'
            AND s.store_id = 1
        )
        THEN 'Yes'
        ELSE 'No'
    END AS rental_available;
#Bonus 4
SELECT f.title,
    CASE 
        WHEN IFNULL(SUM(CASE WHEN i.inventory_id IS NOT NULL THEN 1 ELSE 0 END), 0) > 0
        THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;




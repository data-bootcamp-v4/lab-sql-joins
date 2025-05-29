USE sakila;

#1
	SELECT c.name as 'Category', COUNT(f.film_id) as 'Film count' 
    FROM film f
    JOIN film_category fc ON fc.film_id = f.film_id
    JOIN category c ON c.category_id = fc.category_id
    GROUP BY fc.category_id
    ORDER BY COUNT(f.film_id) DESC;
    
#2
	SELECT s.store_id as 'Store', ci.city as 'City', co.country as 'Country'
    FROM store s
    JOIN address a ON a.address_id = s.address_id
    JOIN city ci ON ci.city_id = a.city_id
    JOIN country co ON co.country_id = ci.country_id;
    
#3
	SELECT 
    s.store_id AS 'Store',
    ci.city AS 'City',
    co.country AS 'Country',
    SUM(p.amount) AS 'Total Revenue (Local Currency)',
    CASE 
        WHEN co.country = 'Canada' THEN ROUND(SUM(p.amount / 1.35), 2)
        WHEN co.country = 'Australia' THEN ROUND(SUM(p.amount / 1.50), 2)
        ELSE SUM(p.amount)
    END AS 'Total Revenue (USD)'
	FROM store s
	JOIN address a ON a.address_id = s.address_id
	JOIN city ci ON ci.city_id = a.city_id
	JOIN country co ON co.country_id = ci.country_id
	JOIN staff st ON st.store_id = s.store_id
	JOIN payment p ON p.staff_id = st.staff_id
	GROUP BY s.store_id, ci.city, co.country;
    
#4    
	SELECT c.name as 'Category', ROUND(AVG(f.length), 2) as 'Average Running Time' 
    FROM film f
    JOIN film_category fc ON fc.film_id = f.film_id
    JOIN category c ON c.category_id = fc.category_id
    GROUP BY fc.category_id
    ORDER BY AVG(f.length) DESC;
    
#5
	SELECT c.name as 'Category', ROUND(AVG(f.length), 2) as 'Average Running Time' 
    FROM film f
    JOIN film_category fc ON fc.film_id = f.film_id
    JOIN category c ON c.category_id = fc.category_id
    GROUP BY fc.category_id
    ORDER BY AVG(f.length) DESC
    LIMIT 1;
    
#6
	SELECT 
    f.title AS 'Title',
    COUNT(r.rental_id) AS 'Rental count'
	FROM film f
	JOIN inventory i ON i.film_id = f.film_id
	LEFT JOIN rental r ON r.inventory_id = i.inventory_id
	GROUP BY f.film_id, f.title
	ORDER BY COUNT(r.rental_id) DESC
	LIMIT 10;

#7
	SELECT 
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM inventory i
            JOIN film f ON f.film_id = i.film_id
            WHERE f.title = 'Academy Dinosaur' 
              AND i.store_id = 1
        ) THEN 'Yes, available'
        ELSE 'No, not available'
    END AS "'Academy Dinosaur' availability in store 1";

#8
	SELECT 
    f.title as 'Film',
    CASE 
        WHEN SUM(CASE WHEN i.store_id = 1 THEN 1 ELSE 0 END) > 0
         AND SUM(CASE WHEN i.store_id = 2 THEN 1 ELSE 0 END) > 0 THEN 'In both stores'         
        WHEN SUM(CASE WHEN i.store_id = 1 THEN 1 ELSE 0 END) > 0 THEN 'Only in store 1'        
        WHEN SUM(CASE WHEN i.store_id = 2 THEN 1 ELSE 0 END) > 0 THEN 'Only in store 2'        
        ELSE 'NOT available'
    END AS Available
	FROM film f
	LEFT JOIN inventory i ON i.film_id = f.film_id
	GROUP BY f.film_id, f.title
	ORDER BY f.title;

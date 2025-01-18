--EXERCISE1
SELECT 
    c.name AS Category, 
    COUNT(f.film_id) AS NumberOfFilms
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    NumberOfFilms DESC;


--EXERCISE 2
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



--EXERCISE 3
SELECT 
    p.store_id, 
    ROUND(SUM(p.amount), 2) AS TotalRevenue
FROM 
    payment p
GROUP BY 
    p.store_id
ORDER BY 
    TotalRevenue DESC;


--EXERCISE 4
SELECT 
    c.name AS Category, 
    ROUND(AVG(f.length), 2) AS AverageRunningTime
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    AverageRunningTime DESC;


--BONUS 5
SELECT 
    c.name AS Category, 
    ROUND(AVG(f.length), 2) AS AverageRunningTime
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    AverageRunningTime DESC
LIMIT 1;


--BONUS 6

SELECT 
    f.title AS MovieTitle, 
    COUNT(r.rental_id) AS RentalCount
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.title
ORDER BY 
    RentalCount DESC
LIMIT 10;


--BONUS 7

SELECT 
    f.title AS MovieTitle, 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS Availability
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
WHERE 
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1;




--BONUS 8

SELECT 
    f.title AS MovieTitle, 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS Availability
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.title
ORDER BY 
    MovieTitle;

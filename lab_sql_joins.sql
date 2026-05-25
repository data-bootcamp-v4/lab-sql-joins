USE sakila;

SHOW TABLES;

SELECT c.name AS category_name, COUNT(fc.film_id) AS num_films
FROM category AS c
INNER JOIN film_category AS fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY num_films DESC;

SELECT s.store_id, ci.city, co.country
FROM store AS s
INNER JOIN address AS a ON s.address_id = a.address_id
INNER JOIN city AS ci ON a.city_id = ci.city_id
INNER JOIN country AS co ON ci.country_id = co.country_id
ORDER BY s.store_id;


SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store AS s
INNER JOIN staff AS st ON s.store_id = st.store_id
INNER JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;


SELECT c.name AS category_name, ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
INNER JOIN film_category AS fc ON c.category_id = fc.category_id
INNER JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;


SELECT c.name, ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
INNER JOIN film_category AS fc ON c.category_id = fc.category_id
INNER JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
HAVING ROUND(AVG(f.length), 2) = (
    SELECT MAX(avg_length)
    FROM (
        SELECT ROUND(AVG(f2.length), 2) AS avg_length
        FROM film_category AS fc2
        INNER JOIN film AS f2 ON fc2.film_id = f2.film_id
        GROUP BY fc2.category_id
    ) AS subquery
);

SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film AS f
INNER JOIN inventory AS i ON i.film_id = f.film_id
INNER JOIN rental AS r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;


SELECT f.title, i.inventory_id, i.store_id, r.return_date
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id
                      AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1;

SELECT f.title,
       CASE WHEN IFNULL(MAX(i.inventory_id), 0) = 0 THEN 'NOT available'
            ELSE 'Available'
       END AS availability
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;
USE sakila;

SHOW FULL TABLES;
SHOW COLUMNS FROM category;
SHOW COLUMNS FROM film;

SELECT
    category.name AS category,
    COUNT(film.film_id) AS film_count
FROM
    category
JOIN film_category 
ON category.category_id = film_category.category_id
JOIN film
ON film_category.film_id = film.film_id
GROUP BY category.name;

SELECT
	s.store_id,
	ci.city,
    co.country
FROM
	store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

SELECT
	s.store_id AS store,
    SUM(p.amount) AS total_revenue
FROM
	store AS s
JOIN customer AS c 
ON s.store_id = c.store_id
JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

SELECT
    (FORMAT(AVG(f.length), 2)) AS avg_running_time,
    c.name AS category
FROM
    category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.name, f.length;

SELECT
    (FORMAT(AVG(f.length), 2)) as avg_running_time,
    c.name AS category
FROM
    category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.name, f.length
ORDER BY f.length DESC;

SELECT
    f.title AS film,
	COUNT(r.rental_id) AS rental_count
FROM
	rental AS r
JOIN inventory AS i
	ON r.inventory_id = i.inventory_id
JOIN film AS f
	ON i.film_id = f.film_id
GROUP BY 
	f.title
ORDER BY
	rental_count DESC
LIMIT 10;

SELECT
    s.store_id AS store,
    f.title AS film,
    i.inventory_id
FROM
    store AS s
JOIN
    inventory AS i ON s.store_id = i.store_id
JOIN
    film AS f ON i.film_id = f.film_id
LEFT JOIN
    rental AS r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE
    f.title = 'Academy Dinosaur'
    AND s.store_id = 1
    AND r.rental_id IS NULL;

SELECT
    f.title,
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM
    film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;

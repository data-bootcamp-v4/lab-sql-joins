USE sakila;
SELECT
    c.name AS category,
    COUNT(fc.film_id) AS number_of_films
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY number_of_films DESC;
SELECT
    s.store_id,
    ci.city,
    co.country
FROM store AS s
JOIN address AS a
    ON s.address_id = a.address_id
JOIN city AS ci
    ON a.city_id = ci.city_id
JOIN country AS co
    ON ci.country_id = co.country_id;
    SELECT
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store AS s
JOIN inventory AS i
    ON s.store_id = i.store_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY s.store_id;
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_running_time
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC;
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_running_time
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC
LIMIT 5;
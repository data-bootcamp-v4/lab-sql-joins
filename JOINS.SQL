USE sakila;

SELECT
    c.name AS category,
    f.title
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
ORDER BY c.name, f.title;

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
    ROUND(SUM(p.amount), 2) AS total_revenue_dollars
FROM payment AS p
JOIN staff AS s
    ON p.staff_id = s.staff_id
GROUP BY s.store_id
ORDER BY s.store_id;
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS average_duration_minutes
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY average_duration_minutes DESC;
WITH category_averages AS (
    SELECT
        c.name AS category,
        AVG(f.length) AS avg_duration
    FROM category AS c
    JOIN film_category AS fc
        ON c.category_id = fc.category_id
    JOIN film AS f
        ON fc.film_id = f.film_id
    GROUP BY c.category_id, c.name
)
SELECT
    category,
    ROUND(avg_duration, 2) AS average_duration_minutes
FROM category_averages
WHERE avg_duration = (
    SELECT MAX(avg_duration)
    FROM category_averages
);
SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;
SELECT
    f.title,
    CASE
        WHEN SUM(
            CASE
                WHEN i.inventory_id IS NOT NULL
                     AND r.rental_id IS NULL THEN 1
                ELSE 0
            END
        ) > 0 THEN 'Disponible'
        ELSE 'No disponible'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
   AND i.store_id = 1
LEFT JOIN rental AS r
    ON i.inventory_id = r.inventory_id
   AND r.return_date IS NULL
WHERE f.title = 'ACADEMY DINOSAUR'
GROUP BY f.film_id, f.title;
SELECT
   f.title,
    CASE
        WHEN IFNULL(COUNT(i.inventory_id), 0) > 0
            THEN 'Disponible'
        ELSE 'No disponible'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;
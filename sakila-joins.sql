USE sakila;

-- 1
SELECT
    c.name AS category,
    COUNT(fc.film_id) AS number_of_films
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY number_of_films DESC, c.name ASC;

-- 2
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
    ON ci.country_id = co.country_id
ORDER BY s.store_id;

-- 3
SELECT
    st.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM store AS st
JOIN staff AS sf
    ON st.store_id = sf.store_id
JOIN payment AS p
    ON sf.staff_id = p.staff_id
GROUP BY st.store_id
ORDER BY st.store_id;

-- 4
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_running_time DESC;

-- 5
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
HAVING AVG(f.length) = (
    SELECT MAX(avg_length)
    FROM (
        SELECT AVG(f2.length) AS avg_length
        FROM category AS c2
        JOIN film_category AS fc2
            ON c2.category_id = fc2.category_id
        JOIN film AS f2
            ON fc2.film_id = f2.film_id
        GROUP BY c2.category_id, c2.name
    AS category_avg
    )
);

-- 6
SELECT
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC, f.title ASC
LIMIT 10;

-- 7
SELECT
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS copies_in_store,
    CASE
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
    AND i.store_id = 1
WHERE f.title = 'ACADEMY DINOSAUR'
GROUP BY f.film_id, f.title, i.store_id;

-- 8
SELECT
    f.title,
    CASE
        WHEN IFNULL(inv.copies, 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM film AS f
LEFT JOIN (
    SELECT
        film_id,
        COUNT(*) AS copies
    FROM inventory
    GROUP BY film_id
) AS inv
    ON f.film_id = inv.film_id
ORDER BY f.title ASC;
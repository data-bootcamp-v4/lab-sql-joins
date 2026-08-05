USE sakila;


-- ==================================================
-- 1. LIST THE NUMBER OF FILMS PER CATEGORY
-- ==================================================

SELECT
    c.name AS category_name,
    COUNT(fc.film_id) AS number_of_films
FROM category AS c
LEFT JOIN film_category AS fc
    ON c.category_id = fc.category_id
GROUP BY
    c.category_id,
    c.name
ORDER BY
    number_of_films DESC,
    category_name ASC;


-- ==================================================
-- 2. RETRIEVE THE STORE ID, CITY, AND COUNTRY
-- FOR EACH STORE
-- ==================================================

SELECT
    s.store_id AS store_id,
    ci.city AS city,
    co.country AS country
FROM store AS s
INNER JOIN address AS a
    ON s.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS co
    ON ci.country_id = co.country_id
ORDER BY
    s.store_id;


-- ==================================================
-- 3. CALCULATE THE TOTAL REVENUE GENERATED
-- BY EACH STORE
-- ==================================================

SELECT
    s.store_id AS store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM store AS s
INNER JOIN staff AS st
    ON s.store_id = st.store_id
INNER JOIN payment AS p
    ON st.staff_id = p.staff_id
GROUP BY
    s.store_id
ORDER BY
    s.store_id;


-- ==================================================
-- 4. DETERMINE THE AVERAGE RUNNING TIME
-- OF FILMS FOR EACH CATEGORY
-- ==================================================

SELECT
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS average_running_time
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY
    c.category_id,
    c.name
ORDER BY
    average_running_time DESC,
    category_name ASC;


-- ==================================================
-- BONUS 1
-- IDENTIFY THE FILM CATEGORY WITH THE LONGEST
-- AVERAGE RUNNING TIME
-- ==================================================

SELECT
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS average_running_time
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY
    c.category_id,
    c.name
ORDER BY
    average_running_time DESC
LIMIT 1;


-- ==================================================
-- BONUS 1 ALTERNATIVE
-- RETURN ALL CATEGORIES TIED FOR THE LONGEST
-- AVERAGE RUNNING TIME
-- ==================================================

WITH category_averages AS
(
    SELECT
        c.category_id,
        c.name AS category_name,
        AVG(f.length) AS average_running_time
    FROM category AS c
    INNER JOIN film_category AS fc
        ON c.category_id = fc.category_id
    INNER JOIN film AS f
        ON fc.film_id = f.film_id
    GROUP BY
        c.category_id,
        c.name
)

SELECT
    category_name,
    ROUND(average_running_time, 2) AS average_running_time
FROM category_averages
WHERE average_running_time =
(
    SELECT MAX(average_running_time)
    FROM category_averages
);


-- ==================================================
-- BONUS 2
-- DISPLAY THE TOP 10 MOST FREQUENTLY RENTED MOVIES
-- IN DESCENDING ORDER
-- ==================================================

SELECT
    f.title AS film_title,
    COUNT(r.rental_id) AS number_of_rentals
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title
ORDER BY
    number_of_rentals DESC,
    film_title ASC
LIMIT 10;


-- ==================================================
-- BONUS 3
-- DETERMINE WHETHER ACADEMY DINOSAUR CAN CURRENTLY
-- BE RENTED FROM STORE 1
-- ==================================================

SELECT
    f.title AS film_title,
    1 AS store_id,

    COUNT(DISTINCT i.inventory_id) AS total_copies_in_store,

    COUNT(
        DISTINCT CASE
            WHEN r.rental_id IS NULL
            THEN i.inventory_id
        END
    ) AS available_copies,

    CASE
        WHEN COUNT(
            DISTINCT CASE
                WHEN r.rental_id IS NULL
                THEN i.inventory_id
            END
        ) > 0
        THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status

FROM film AS f

LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
    AND i.store_id = 1

LEFT JOIN rental AS r
    ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL

WHERE LOWER(f.title) = 'academy dinosaur'

GROUP BY
    f.film_id,
    f.title;


-- ==================================================
-- BONUS 4
-- PROVIDE ALL DISTINCT FILM TITLES AND THEIR
-- INVENTORY AVAILABILITY STATUS
-- THIS CHECKS WHETHER A FILM EXISTS IN INVENTORY
-- ==================================================

SELECT
    f.title AS film_title,

    CASE
        WHEN COUNT(i.inventory_id) > 0
        THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status

FROM film AS f

LEFT JOIN inventory AS i
    ON f.film_id = i.film_id

GROUP BY
    f.film_id,
    f.title

ORDER BY
    f.title;


-- ==================================================
-- OPTIONAL CHECK
-- COUNT FILMS THAT DO NOT EXIST IN INVENTORY
-- EXPECTED RESULT: 42
-- ==================================================

SELECT
    COUNT(*) AS films_not_in_inventory
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;
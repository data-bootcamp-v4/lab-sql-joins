USE sakila;

SELECT
    c.name AS category,
    COUNT(*) AS film_count
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY film_count DESC, category ASC;
    
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

SELECT 
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue_usd
FROM payment AS p
JOIN  staff AS st
    ON p.staff_id = st.staff_id
JOIN store AS s
    ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY s.store_id;

SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length_min
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_min DESC, category ASC;

SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length_min
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_min DESC
LIMIT 1;


SELECT
    f.title,
    COUNT(*) AS rental_count
FROM rental AS r
JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
JOIN film AS f
    ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC, f.title ASC
LIMIT 10;

SELECT
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM inventory AS i
            JOIN film AS f
                ON f.film_id = i.film_id
            WHERE f.title = 'ACADEMY DINOSAUR'
              AND i.store_id = 1
              AND NOT EXISTS (
                  SELECT 1
                  FROM rental AS r
                  WHERE r.inventory_id = i.inventory_id
                    AND r.return_date IS NULL
              )
        )
        THEN 'Available'
        ELSE 'NOT available'
    END AS academy_dinosaur_store1_status;



SELECT
    f.title,
    CASE
        WHEN IFNULL(inv.inventory_count, 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM film AS f
LEFT JOIN (
    SELECT film_id, COUNT(*) AS inventory_count
    FROM inventory
    GROUP BY film_id
) AS inv
    ON f.film_id = inv.film_id
ORDER BY f.title;

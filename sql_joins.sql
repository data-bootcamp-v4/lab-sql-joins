USE SAKILA;

SELECT
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM
    category AS c
JOIN
    film_category AS fc ON c.category_id = fc.category_id
GROUP BY
    c.name
ORDER BY
    film_count DESC;
    
SELECT
    s.store_id,
    cy.city,
    co.country
FROM
    store AS s
JOIN
    address AS a ON s.address_id = a.address_id
JOIN
    city AS cy ON a.city_id = cy.city_id
JOIN
    country AS co ON cy.country_id = co.country_id
ORDER BY
    s.store_id;
    
SELECT
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM
    store AS s
JOIN
    staff AS st ON s.store_id = st.store_id
JOIN
    payment AS p ON st.staff_id = p.staff_id
GROUP BY
    s.store_id
ORDER BY
    total_revenue DESC;
    
SELECT
    c.name AS category_name,
    -- Round the average duration to 2 decimal places
    ROUND(AVG(f.length), 2) AS average_running_time
FROM
    category AS c
JOIN
    film_category AS fc ON c.category_id = fc.category_id
JOIN
    film AS f ON fc.film_id = f.film_id
GROUP BY
    c.name
ORDER BY
    average_running_time DESC;
    
SELECT
    c.name AS category_name,
    ROUND(AVG(f.length), 2) AS average_running_time
FROM
    category AS c
JOIN
    film_category AS fc ON c.category_id = fc.category_id
JOIN
    film AS f ON fc.film_id = f.film_id
GROUP BY
    c.name
ORDER BY
    average_running_time DESC
LIMIT 1;

SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM
    film AS f
JOIN
    inventory AS i ON f.film_id = i.film_id
JOIN
    rental AS r ON i.inventory_id = r.inventory_id
GROUP BY
    f.title
ORDER BY
    rental_count DESC
LIMIT 10;

SELECT
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS available_copies
FROM
    film AS f
JOIN
    inventory AS i ON f.film_id = i.film_id
WHERE
    f.title = 'ACADEMY DINOSAUR'
    AND i.store_id = 1
GROUP BY
    f.title, i.store_id;

-- Interpretation: If the 'available_copies' count is > 0, it can be rented.
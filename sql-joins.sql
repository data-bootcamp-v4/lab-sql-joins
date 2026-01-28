USE sakila;

LAB #1
SELECT
    cat.name AS category,
    COUNT(fc.film_id) AS num_films
FROM category AS cat
JOIN film_category AS fc
    ON cat.category_id = fc.category_id
GROUP BY cat.name;

#2
SELECT
    s.store_id,
    ci.city,
    cy.country
FROM store AS s
JOIN address AS a
    ON s.address_id = a.address_id
JOIN city AS ci
    ON a.city_id = ci.city_id
JOIN country AS cy
    ON ci.country_id = cy.country_id;

#3    
SELECT
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store AS s
JOIN staff AS sf
    ON s.store_id = sf.store_id
JOIN payment AS p
    ON sf.staff_id = p.staff_id
GROUP BY s.store_id;

#4
SELECT
    cat.name AS category,
    AVG(f.length) AS avg_length
FROM category AS cat
JOIN film_category AS fc
    ON cat.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY cat.name;

#5    
SELECT
    cat.name AS category,
    AVG(f.length) AS avg_length
FROM category AS cat
JOIN film_category AS fc
    ON cat.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY cat.name
ORDER BY avg_length DESC
LIMIT 10;

#6
SELECT
    f.title,
    COUNT(r.rental_id) AS total_rentals
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY total_rentals DESC
LIMIT 10;

#7
SELECT
    f.title,
    COUNT(i.inventory_id) AS availability_store_1
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1;

#8
SELECT
    f.title,
    CASE
        WHEN COUNT(i.inventory_id) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;

SELECT availability, COUNT(*)
FROM (
    SELECT
        f.title,
        CASE
            WHEN COUNT(i.inventory_id) = 0 THEN 'NOT available'
            ELSE 'Available'
        END AS availability
    FROM film AS f
    LEFT JOIN inventory AS i
        ON f.film_id = i.film_id
    GROUP BY f.title
) t
GROUP BY availability;
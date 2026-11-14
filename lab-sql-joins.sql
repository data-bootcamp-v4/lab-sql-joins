USE sakila;
#Challenge 1
SELECT *
FROM category;
SELECT *
FROM film_category;
SELECT
    c.name AS category,
    fc.film_id
FROM film_category AS fc
INNER JOIN category AS c
    ON fc.category_id = c.category_id;
SELECT
    c.name AS category,
    COUNT(fc.film_id) AS number_of_films
FROM film_category AS fc
INNER JOIN category AS c
    ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;
#Challenge 2
SELECT *
FROM store;
SELECT *
FROM address;
SELECT *
FROM city;
SELECT *
FROM country;
SELECT
    s.store_id,
    a.address,
    ci.city
FROM store AS s
INNER JOIN address AS a
    ON s.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id;
    SELECT
    s.store_id,
    ci.city,
    co.country
FROM store AS s
INNER JOIN address AS a
    ON s.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS co
    ON ci.country_id = co.country_id;
    #Challenge 3
    SELECT *
FROM payment;
SELECT *
FROM rental;
SELECT *
FROM inventory;
SELECT
    p.payment_id,
    p.amount,
    r.rental_id,
    r.inventory_id
FROM payment AS p
INNER JOIN rental AS r
    ON p.rental_id = r.rental_id;
SELECT
    i.store_id,
    SUM(p.amount) AS total_revenue
FROM payment AS p
INNER JOIN rental AS r
    ON p.rental_id = r.rental_id
INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
GROUP BY i.store_id;
SELECT
    i.store_id,
    SUM(p.amount) AS total_revenue
FROM payment AS p
INNER JOIN rental AS r
    ON p.rental_id = r.rental_id
INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
GROUP BY i.store_id
ORDER BY total_revenue DESC;
#Challenge 4
SELECT *
FROM film;
SELECT *
FROM film_category;
SELECT *
FROM category;
SELECT
    f.title,
    f.length,
    fc.category_id
FROM film AS f
INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id;
SELECT
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM film AS f
INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id
INNER JOIN category AS c
    ON fc.category_id = c.category_id
GROUP BY c.name;
SELECT
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM film AS f
INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id
INNER JOIN category AS c
    ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_running_time DESC;
#Bonus 1
SELECT *
FROM film;
SELECT *
FROM inventory;
SELECT *
FROM rental;
SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title;
SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;
#Bonus 2
SELECT *
FROM film
WHERE title = 'Academy Dinosaur';
SELECT
    i.inventory_id,
    i.film_id,
    i.store_id
FROM inventory AS i
WHERE i.film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Academy Dinosaur'
)
AND i.store_id = 1;
SELECT
    i.inventory_id,
    i.store_id,
    r.rental_id,
    r.return_date
FROM inventory AS i
LEFT JOIN rental AS r
    ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL
WHERE i.film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Academy Dinosaur'
)
AND i.store_id = 1;
#Bonus 3
SELECT *
FROM film;
SELECT *
FROM inventory;
SELECT
    f.title,
    CASE
        WHEN i.inventory_id IS NULL THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id;
    SELECT
    f.title,
    IFNULL(i.inventory_id, 0) AS inventory_id,
    CASE
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id;
    SELECT
    COUNT(*) AS unavailable_films
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;
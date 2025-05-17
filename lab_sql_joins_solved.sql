USE sakila;
SELECT
    c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY number_of_films DESC;
SELECT
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;
SELECT
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_duration DESC;
SELECT
    first_name,
    last_name
FROM customer
WHERE email IS NULL;
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.amount AS payment_amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id;
SELECT DISTINCT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action';
SELECT
    cat.name AS category,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY total_rentals DESC
LIMIT 1;
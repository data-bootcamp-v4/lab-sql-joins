use sakila;

/*1.*/
SELECT c.name AS category,
       COUNT(f.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY number_of_films DESC;

/*2.*/
SELECT s.store_id,
       ci.city,
       co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

/*3.*/
SELECT s.store_id,
       SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

/*4.*/
SELECT c.name AS category,
       ROUND(AVG(f.length), 2) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

/*5.*/
SELECT c.name AS category,
       ROUND(AVG(f.length), 2) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 1;

/*6.*/
SELECT f.title,
       COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC
LIMIT 10;

/*7.*/
SELECT f.title,
       CASE
           WHEN COUNT(i.inventory_id) > 0 THEN 'Available in Store 1'
           ELSE 'NOT Available'
       END AS status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id AND i.store_id = 1
WHERE f.title = 'Academy Dinosaur'
GROUP BY f.title;

/*8.*/
SELECT f.title,
       CASE
           WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
           ELSE 'Available'
       END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY f.title;



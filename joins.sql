use sakila;


#challenge
#1
SELECT c.name AS category, COUNT(f.film_id) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY film_count DESC;
#2
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;
#3
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;
#4
SELECT category.name, ROUND(AVG(film.length), 2) AS avg_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

#bonus
#1
SELECT category.name, ROUND(AVG(film.length),2) AS avg_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY avg_running_time DESC;
#2
SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY rental_count DESC
LIMIT 10;
#3
SELECT film.title, store.store_id, inventory.inventory_id
FROM inventory
JOIN store ON inventory.store_id = store.store_id
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Academy Dinosaur' AND store.store_id = 1;

#4
SELECT film.title, COUNT(inventory.film_id) AS num_copies,
CASE WHEN ISNULL(inventory.film_id) THEN 'NOT available' ELSE 'Available' END AS availability_status
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.film_id;





-- 6. Top 10 películas más alquiladas
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;

-- 7. ¿Se puede alquilar "Academy Dinosaur" en la tienda 1?
SELECT f.title, COUNT(i.inventory_id) AS copies_in_store_1
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
GROUP BY f.title;

-- 8. Disponibilidad de todos los títulos
SELECT f.title,
  CASE WHEN IFNULL(COUNT(i.inventory_id), 0) > 0
       THEN 'Available' ELSE 'NOT available' END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;
SELECT *
FROM film F JOIN film_category FM ON F.film_id = FM.film_id;


SELECT store_id S, city C, country C
FROM store S 
JOIN address A ON S.address_id = A.address_id
JOIN city C ON A.city_id = C.city_id
JOIN country CY ON C.country_id = CY.country_id;

SELECT SS.store_id , SUM(amount) AS revenue_generated
FROM payment P
JOIN staff S ON P.staff_id = S.staff_id
JOIN store SS ON S.store_id = SS.store_id
GROUP BY SS.store_id;

SELECT AVG(length)
FROM film;

SELECT C.name, ROUND(AVG(F.length),0) AS average_running_time
FROM film F 
JOIN film_category FC ON F.film_id = FC.film_id
JOIN category C ON FC.category_id = C.category_id
GROUP BY C.name
ORDER BY AVG(F.length) DESC;

SELECT *
FROM film


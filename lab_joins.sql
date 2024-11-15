use sakila;

-- write number of films per category--


SELECT c.name AS category_name, COUNT(f.film_id) AS num_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY num_films DESC;

-- store id, city, and country for each store
SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

 -- total revenue
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id;
 
 
-- determine averagee runing time for each film
select c.name as category_name,avg(f.length) as avg_time
from category c
join film_category fc on c.category_id= fc.category_id
join film f on fc.film_id = f.film_id
group by c.name
order by avg_time desc;


-- Bonus--
-- longest average time
select c.name as category_name,avg(f.length) as avg_time
from category c
join film_category fc on c.category_id= fc.category_id
join film f on fc.film_id = f.film_id
group by c.name
order by avg_time desc
LIMIT 1;

-- most frequent rented movies in desc

select f.title, count(r.rental_id) most_rented_movie
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id= r.inventory_id
group by f.title
order by most_rented_movie desc
limit 10;


-- academy dino if it is available
select title, film_id from film where title like "%academy%";
select * from inventory;

select ifnull (i.inventory_id, "Not Available") as availability
from film f
left join inventory i on f.film_id and i.store_id=1
where f.title = 'Academy Dinosaur';



SELECT CASE 
           WHEN i.inventory_id IS NOT NULL THEN 'Available'
           ELSE 'Not Available'
       END AS availability
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;


-- distinct film and availble

SELECT f.title,
CASE 
           WHEN i.inventory_id IS NOT NULL THEN 'Available'
           ELSE 'Not Available'
       END AS availability
FROM film f
JOIN inventory i ON f.film_id = i.film_id

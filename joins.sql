use sakila;


#challenge
#1
select c.category_id,count(f.title) as number_of_films from film as f
join film_category as c
on f.film_id=c.category_id
group by c.category_id;
#2
select i.store_id,c.city,co.country from inventory i
join city c
on c.city_id=i.inventory_id
join country co
on i.store_id=co.country_id;
#3
select i.store_id,sum(p.amount) as total_amount from inventory i
join payment p
on i.inventory_id=p.payment_id
group by i.store_id;
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





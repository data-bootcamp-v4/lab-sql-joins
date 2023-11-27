1. Challenge - Joining on multiple tables

use sakila

 Write SQL queries to perform the following tasks using the Sakila database:

3. List the number of films per category.

select category_id, count(film_id) as number_of_filmes_in_category
from film_category
group by category_id

4. Retrieve the store ID, city, and country for each store.

-- Join tables city, country
select * from sakila.country as co
join sakila.city as ci
on co.country_id = ci.country_id;

-- Join talbles address, store
select * from sakila.store as s
join sakila.address as a 
on s.address_id = a.address_id;

-- Final join
select * from sakila.store as s
join sakila.address as a 
on s.address_id = a.address_id
join sakila.city as ci
on a.city_id = ci.city_id
join sakila.country as co
on ci.country_id = co.country_id;

5. Calculate the total revenue generated by each store in dollars.

select sto.store_id, count(pay.amount) as payment_count
from payment as pay
join staff as stf 
on stf.staff_id = pay.staff_id
join store as sto 
on sto.store_id = stf.store_id
group by sto.store_id;

6. Determine the average running time of films for each category.

select round(avg(length), 2) as average_movie_duration, rating, count(*) as film_count
from film
group by rating
order by film_count desc;

7. Identify the film categories with the longest average running time.

select c.name as category, round(avg(f.length), 2) as average_running_time
from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
group by c.name;



8. Display the top 10 most frequently rented movies in descending order.

select f.film_id, f.title, COUNT(r.rental_id) AS rental_count
from film as f
join inventory as i on f.film_id = i.film_id
join rental as r on i.inventory_id = r.inventory_id
group by f.film_id, f.title 
order by rental_count desc
limit 10;

9. Determine if "Academy Dinosaur" can be rented from Store 1.

select film.title, inventory.inventory_id
from film
join inventory on film.film_id = inventory.film_id
join store on inventory.store_id = store.store_id
where film.title = 'Academy Dinosaur' and store.store_id = 1;

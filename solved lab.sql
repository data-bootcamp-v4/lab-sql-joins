use sakila;

select rating, count(title)
from film
group by rating;

select inventory.store_id, sum(rental_rate) as "total revenue"
from rental
left join inventory on rental.inventory_id = inventory.inventory_id
left join film on inventory.film_id = film.film_id
group by inventory.store_id;

select film.title, inventory.store_id
from inventory
left join film on inventory.film_id = film.film_id
where film.title LIKE "ACADEMY DINOSAUR";

select distinct film.title, inventory.store_id, IF(return_date > CURDATE(), 'not available', 'available') as 'availability'
from inventory
left join film on inventory.film_id = film.film_id
left join rental on rental.inventory_id = inventory.inventory_id



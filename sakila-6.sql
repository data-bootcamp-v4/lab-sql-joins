use sakila;

select title, rental_duration
from film
order by rental_duration desc
limit 10;
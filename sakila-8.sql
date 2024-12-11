use sakila;

select distinct title,
case
when b.film_id is not null then 'Available'
when b.film_id is null then 'NOT available'
end as avalaible
from film a 
left join inventory b
on a.film_id = b.film_id
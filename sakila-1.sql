use sakila;

select `name`, count(category) as recuento
from film_list a 
join category b
on a.category = b.`name`
group by `name`
order by recuento desc




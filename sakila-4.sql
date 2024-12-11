use sakila;

select category, round(avg(b.length), 2) as avg_length
from film_list a
join film b 
on a.title = b.title
group by category
order by avg_length desc
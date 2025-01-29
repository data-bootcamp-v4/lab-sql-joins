use sakila;

select count(film_id), name
from film 
inner join film_category
using (film_id)
inner join category
using (category_id)
group by name;

select store_id, city, country
from store
inner join address
using(address_id)
inner join city
using(city_id)
inner join country
using(country_id);

select sum(amount), store_id
from store
inner join staff
using(store_id)
inner join payment
using(staff_id)
group by store_id;

select avg(length), name
from film
inner join film_category
using(film_id)
inner join category
using(category_id)
group by name
order by avg(length) desc;

select count(rental_date), title
from film
inner join inventory
using (film_id)
inner join rental
using(inventory_id)
group by title
order by count(rental_date) desc
limit 10;
limit 5;

select store_id, title
from film
inner join inventory
using(film_id)
where title="ACADEMY DINOSAUR" and store_id=1;

select title,


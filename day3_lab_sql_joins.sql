/*day3 lab joins*/

/* challenge task 1*/
select count(film_id) as number_of_films, c.name
from film f
inner join film_category fc
using(film_id)
inner join category c
using(category_id)
group by c.name;

/* challenge task 2*/
select store_id, ci.city, co.country
from store s
inner join address a using(address_id)
inner join city ci using(city_id)
inner join country co using(country_id);

/* challenge task 3*/
select store.store_id, sum(amount) as revenue
from payment p
inner join customer c using(customer_id)
inner join staff using(staff_id)
inner join store on staff.store_id=store.store_id
group by store.store_id;

/* challenge task 4*/
select round(avg(f.length), 2) as average_runtime, c.name
from film f
inner join film_category fc using(film_id)
inner join category c using(category_id)
group by c.name;

/* bonus task 5*/
select avg(f.length) as avg_length, c.name
from film f
inner join film_category using(film_id)
inner join category c using(category_id)
group by c.name
order by avg_length desc
limit 3;

/* bonus task 6*/
select f.title, count(f.film_id) as frequency
from film f
inner join inventory i using(film_id)
inner join rental r using(inventory_id)
group by f.title
order by frequency desc
limit 10;

/* bonus task 7*/
select store_id, f.title
from store s
inner join inventory i using(store_id)
inner join film f using(film_id)
where s.store_id = 1 and f.title like 'Academy Dinosaur';

/* bonus task 8*/
select distinct f.title,
	case
		when isnull(i.film_id) then 'NOT available' else 'Available' end as availability
from film f
left join inventory i using(film_id)
group by f.title, availability
order by f.title;
select c.category_id, c.name, count(film_id) as n_of_film
from sakila.category as c
join sakila.film_category as fc on c.category_id = fc.category_id
group by c.category_id, c.name;

select s.store_id, c.city, co.country
from sakila.store as s
join sakila.address as ad on s.address_id = ad.address_id
join sakila.city as c on c.city_id = ad.city_id
join sakila.country as co on co.country_id = c.country_id
order by s.store_id;

select store_id, sum(amount) as tot_revenue
from sakila.payment as p
join sakila.rental as r on r.rental_id = p.rental_id
join sakila.inventory as i on i.inventory_id = r.inventory_id
group by store_id;




select name, avg(length)
from sakila.film as f
join sakila.film_category as fc on f.film_id = fc.film_id
join sakila.category as c on c.category_id = fc.category_id
group by name;

-- Bonus

select name, avg(length) as avg_duration
from sakila.film as f
join sakila.film_category as fc on f.film_id = fc.film_id
join sakila.category as c on c.category_id = fc.category_id
group by name
order by avg_duration desc;

select title, count(rental_id) as count_rentals
from sakila.rental as r
join sakila.inventory as i on i.inventory_id = r.inventory_id
join sakila.film as f on f.film_id = i.film_id
group by title
order by count_rentals desc
limit 10;

-- Determine if "Academy Dinosaur" can be rented from Store 1.
select f.title, s.store_id,
  case 
     when title like '%Academy Dinosaur%' then 'included'
     else 'not'
 end as rentable
   
from sakila.store as s -- left table 
join sakila.inventory as i on i.store_id = s.store_id. -- right table 
join sakila.film as f on f.film_id = i.film_id
where s.store_id = 1 AND f.title LIKE '%Academy Dinosaur%';

select distinct(f.title), f.film_id,
  case 
   when i.inventory_id is null then 'not available'
   else 'available'
  end as availability

from sakila.film as f
left join sakila.inventory as i on i.film_id = f.film_id
;
 


## 1
select c.name as category_name,
count(f.film_id) as film_qty
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.name;

## 2
select st.store_id,
       co.country,
       ci.city 
from store st
join address ad
on st.address_id = ad.address_id 
join city ci 
on ad.city_id = ci.city_id  
join country co 
on ci.country_id = co.country_id;

## 3
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

## 4
select c.name as film_category,
       avg(f.length) as avg_run_time
from film f
join film_category fc 
on f.film_id = fc.film_id
join category c
on fc.category_id =c.category_id
group by film_category;



### BONUS:
# 5 
select c.name as film_category,
       avg(f.length) as avg_run_time
from film f
join film_category fc 
on f.film_id = fc.film_id
join category c
on fc.category_id =c.category_id
group by film_category
order by avg_run_time desc
LIMIT 1;

# 6
select f.title as movie_name,
       count(r.rental_id) as rental_qty
from rental r
join inventory i 
on r.inventory_id = i.inventory_id
join film f 
on i.film_id = f.film_id
group by f.title
order by rental_qty desc
LIMIT 10;

# 7
select CASE
         when count(i.inventory_id) > 0 then 'YES, available'
         else 'Not available'
       end as  Availability
from inventory i 
join film f 
on i.film_id = f.film_id
where f.title = 'Academy Dinosaur' and i.store_id = 1;

# 8
select distinct f.title,
       CASE
          when i.inventory_id is not null then 'YES, available'
         else 'Not available'
       end as  Availability
from film f
left join inventory i
on f.film_id =i.film_id;







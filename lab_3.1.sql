-- 1
select count(*) as number_of_film, category.name
from film_category
join category 
on film_category.category_id = category.category_id
group by 2;

-- 2 
select s.store_id, ci.city, co.country
from store as s
join address as ad
on s.address_id = ad.address_id
join city as ci
on ad.city_id = ci.city_id
join country as co
on ci.country_id = co.country_id;

-- 3
select sta.store_id, sum(p.amount) as revenue_genered
from payment as p
join staff as sta
on p.staff_id = sta.staff_id
join store as sto
on sta.staff_id = sto.manager_staff_id
group by 1;

-- 4
select round(avg(f.length),2) as running_time, c.name
from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on fc.category_id = c.category_id
group by 2;

-- bonus
-- 5
select round(avg(f.length),2) as running_time, c.name
from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on fc.category_id = c.category_id
group by 2
order by 1 desc
limit 1;

-- 6
select count(re.inventory_id) as number_of_rental, f.title
from rental as re
join inventory as inv
on re.inventory_id = inv.inventory_id
join film as f
on inv.film_id = f.film_id
group by 2
order by 1 desc
limit 10;

-- 7
select title, store_id
from film as f
join inventory as inv
on f.film_id = inv.film_id
where title = 'ACADEMY DINOSAUR';
-- here we can see that "Academy Dinosaur" can be rented in both store

-- 8 distinct film, available ?(inventory)
select distinct(f.title), case
when inv.film_id is not null then 'Available'
when inv.film_id is null then 'Not Available'
end as is_available
from film as f
left join inventory as inv
on f.film_id = inv.film_id;









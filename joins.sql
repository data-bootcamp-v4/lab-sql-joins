use sakila;



#1
select c.category_id,count(f.title) as number_of_films from film as f
join film_category as c
on f.film_id=c.category_id
group by c.category_id;
#2
select i.store_id,c.city,co.country from inventory i
join city c
on c.city_id=i.inventory_id
join country co
on i.store_id=co.country_id;
#3
select*from payment;
select i.store_id,sum(p.amount) as total_amount from inventory i
join payment p
on i.inventory_id=p.payment_id
group by i.store_id;
#4
select c.category_id,avg(f.length) as avg_running_time from film_category as c
join film f
on f.film_id=c.film_id
group by c.category_id;

#bonus
#1
select c.category_id,avg(f.length) as avg_running_time from film_category as c
join film f
on f.film_id=c.film_id
group by c.category_id
order by avg_running_time desc
limit 5;
#2
select f.film_id,ft.title,f.rental_rate from film as f
join film_text as ft
on f.film_id=ft.film_id
order by rental_rate desc
limit 10;
#3
select f.film_id,f.title,r.rental_id,s.store_id from film as f
join rental as r
on f.film_id=r.rental_id
join store as s
on s.store_id=f.film_id
where title="Academy Dinosaur";

#4
select distinct title,i.inventory_id,
case
when  isnull(i.inventory_id)=0 then 'Available' 
else 'NOT available' 
end as availability_status
from film_text as ft
left join inventory as i
on i.film_id=ft.film_id
;





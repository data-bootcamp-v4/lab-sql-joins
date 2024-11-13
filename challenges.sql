USE sakila;

select c.category_id, count(*) as 'number of film' from sakila.film as f
right join sakila.film_category as c
on c.film_id = f.film_id
group by c.category_id;

select s.store_id, c.city, co.country from sakila.store as s
join sakila.address as a
on s.address_id = a.address_id
join sakila.city as c
on a.city_id = c.city_id
join sakila.country as co
on c.country_id = co.country_id;

select s.store_id, sum(p.amount) from sakila.payment as p
join sakila.staff as s
on s.staff_id = p.staff_id
group by s.store_id;

select c.category_id, round(avg(f.length), 2) as 'average_running_time' from sakila.film as f
right join sakila.film_category as c
on c.film_id = f.film_id
group by c.category_id;

select c.category_id, round(avg(f.length), 2) as 'average_running_time' from sakila.film as f
right join sakila.film_category as c
on c.film_id = f.film_id
group by c.category_id
order by average_running_time desc;

select f.title, count(*) as "number_rentals" from sakila.inventory as i 
join sakila.film as f
on f.film_id = i.film_id
join sakila.rental as r 
on r.inventory_id = i.inventory_id
group by i.film_id
order by number_rentals desc
limit 10;

select i.inventory_id, f.title, s.store_id from sakila.film as f
join sakila.inventory as i 
on i.film_id = f.film_id
join sakila.store as s
on s.store_id = i.store_id
where f.title = "Academy Dinosaur" and s.store_id=1;
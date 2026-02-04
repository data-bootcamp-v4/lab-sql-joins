-- sql joins lab

use sakila;

-- 1. number of films per category
select 
    c.name as category,
    count(f.film_id) as num_films
from category c
join film_category fc on c.category_id=fc.category_id
join film f on fc.film_id=f.film_id
group by c.name
order by num_films desc;

-- 2. store id, city and country for each store
select 
    s.store_id,
    ci.city,
    co.country
from store s
join address a on s.address_id=a.address_id
join city ci on a.city_id=ci.city_id
join country co on ci.country_id=co.country_id;

-- 3. total revenue per store
select 
    s.store_id,
    sum(p.amount) as total_revenue
from payment p
join rental r on p.rental_id=r.rental_id
join inventory i on r.inventory_id=i.inventory_id
join store s on i.store_id=s.store_id
group by s.store_id;

-- 4. average running time of films for each category
select 
    c.name as category,
    round(avg(f.length),2) as avg_runtime
from category c
join film_category fc on c.category_id=fc.category_id
join film f on fc.film_id=f.film_id
group by c.name
order by avg_runtime desc;

-- bonus questions

-- 5. categories with longest average running time
select 
    c.name as category,
    round(avg(f.length),2) as avg_runtime
from category c
join film_category fc on c.category_id=fc.category_id
join film f on fc.film_id=f.film_id
group by c.name
order by avg_runtime desc
limit 5;

-- 6. top 10 most frequently rented movies
select 
    f.title,
    count(r.rental_id) as rental_count
from film f
join inventory i on f.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
group by f.title
order by rental_count desc
limit 10;

-- 7. can academy dinosaur be rented from store 1
select 
    f.title,
    i.store_id,
    count(i.inventory_id) as copies_available
from film f
join inventory i on f.film_id=i.film_id
where f.title='Academy Dinosaur' and i.store_id=1
group by f.title,i.store_id;

-- 8. all film titles with availability status
select 
    f.title,
    case 
        when ifnull(i.inventory_id,0)=0 then 'NOT available'
        else 'Available'
    end as availability_status
from film f
left join inventory i on f.film_id=i.film_id
group by f.title,availability_status
order by f.title;
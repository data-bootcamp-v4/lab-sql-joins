use sakila;

select c.name, f.title
from film as f
join film_category as fc
on f.film_id = fc.film_id
right join category as c
on fc.category_id = c.category_id
group by c.name, f.title;

select * from city;

select s.store_id, c.city, co.country
from store as s
join address as a
on s.address_id = a.address_id
join city as c
on a.city_id = c.city_id
join country as co
on c.country_id = co.country_id
group by s.store_id;


select c.store_id, SUM(p.amount) as total_revenue
from customer as c
join payment as p
on c.customer_id = p.customer_id
group by c.store_id;

select c.name, avg(f.length) as average_running_time
from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on fc.category_id = c.category_id
group by c.name;

select c.name, avg(f.length) as average_running_time
from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on fc.category_id = c.category_id
group by c.name
order by average_running_time desc
limit 1;

select * from rental;

select f.title, count(r.rental_id) as Rented
from film as f
join inventory as i
on f.film_id = i.film_id
join rental as r
on i.inventory_id = r.inventory_id
group by f.title
order by rented desc
limit 10;

select f.title, i.store_id, count(i.inventory_id) AS copies_available
from film as f
join inventory as i 
on f.film_id = i.film_id
join store as s
on i.store_id = s.store_id
where f.title = 'Academy Dinosaur'
group by f.title, i.store_id;

SELECT 
    f.title,
    CASE 
        WHEN IFNULL(COUNT(i.inventory_id), 0) > 0 
            THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i 
    ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY f.title;
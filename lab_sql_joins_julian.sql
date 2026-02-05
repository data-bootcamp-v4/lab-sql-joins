use sakila;

-- Q1
select c.name, 
	count(*)
from film_category fc
join category c on fc.category_id = c.category_id
group by c.name, c.category_id
;

-- Q2
select * from store;
select * from address;

select s.store_id, c.city, cy.country
from store s
join address a on s.address_id = a.address_id
join city c on a.city_id = c.city_id
join country cy on cy.country_id = c.country_id
;


-- Q3

select ad.address as store_name,
	sum(p.amount) as revenue
from payment p
join staff s on s.staff_id = p.staff_id
join store str on str.store_id = s.store_id
join address ad on ad.address_id = str.address_id
group by store_name
;


-- Q4
select c.name as movie_category,
	avg(flm.length) as movie_length
from film_category fc
join category c on fc.category_id = c.category_id
join film flm on flm.film_id = fc.film_id
group by c.name
order by movie_length desc
;


-- 5
select c.name as movie_category,
	avg(flm.length) as movie_length
from film_category fc
join category c on fc.category_id = c.category_id
join film flm on flm.film_id = fc.film_id
group by c.name
order by movie_length desc
limit 1
;















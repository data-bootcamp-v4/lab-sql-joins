# Lab SQL Joins
#1.
SELECT * from sakila.film;
SELECT * from sakila.category;
SELECT * FROM sakila.film_category;

SELECT c.name, count(fc.film_id) as films from sakila.category as c
inner join sakila.film_category as fc
on c.category_id = fc.category_id
group by c.name
order by films ASC;

#2

SELECT * FROM sakila.store;
SELECT * FROM sakila.address;
SELECT * FROM sakila.country;
SELECT * FROM sakila.city;

WITH stores AS(
SELECT store.store_id, city_id from sakila.address
INNER JOIN sakila.store
on address.address_id = store.address_id)

SELECT store_id, city.city, country.country FROM stores
INNER JOIN sakila.city
on stores.city_id = city.city_id
INNER JOIN sakila.country
on city.country_id = country.country_id;

#3
SELECT * FROM sakila.store;
SELECT * FROM sakila.customer;
SELECT * FROM sakila.payment;

SELECT store.store_id, sum(payment.amount) as total_revenue
from sakila.store
inner join sakila.customer
on store.store_id = customer.store_id
inner join sakila.payment
on customer.customer_id = payment.customer_id
group by store_id;

#4 
SELECT * FROM sakila.film;
SELECT c.name, AVG(f.length) as avg_runtime from sakila.category as c
inner join sakila.film_category as fc
on c.category_id = fc.category_id
inner join sakila.film as f
on fc.film_id = f.film_id
group by c.name
order by avg_runtime ASC;

## Bonus

#5
SELECT * FROM sakila.film;
SELECT c.name, AVG(f.length) as avg_runtime from sakila.category as c
inner join sakila.film_category as fc
on c.category_id = fc.category_id
inner join sakila.film as f
on fc.film_id = f.film_id
group by c.name
order by avg_runtime DESC
LIMIT 3;

#6 
SELECT * FROM sakila.rental;
SELECT * FROM sakila.inventory;

SELECT title, count(rental_id) as frequence
from sakila.rental
inner join sakila.inventory as i
on rental.inventory_id = i.inventory_id 
inner join sakila.film
on i.film_id = film.film_id
group by title
order by frequence DESC
LIMIT 10 ;
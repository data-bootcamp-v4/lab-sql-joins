use sakila;
## 1 List the number of films per category.

SELECT c.name AS category,
    COUNT(f.film_id) AS number_of_films
FROM  film f
JOIN  film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY number_of_films DESC;

#2 Display the first and the last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address
FROM staff s
JOIN address a ON s.address_id = a.address_id;

## 3 Display the total amount rung up (rental) by each staff member in August 2005.
Select s.first_name, s.last_name, sum(amount) as total_amount
from rental r 
join payment p on r.rental_id= p.rental_id
join staff s on p.staff_id = s.staff_id
where r.rental_date BETWEEN '2005-08-01' AND '2005-08-31'
group by s.first_name, s.last_name, s.staff_id;

## 4 List all films and the number of actors who are listed for each film.
select f.title as film_titel, count(fa.actor_id) as actors_numbers
from film f
join film_actor fa on f.film_id = fa.film_id
group by f.title
order by f.title
limit 10;

#5 Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.

select c.first_name, c.last_name, sum(p.amount) as total_amount
from customer c
join payment p on c.customer_id= p.customer_id
group by c.first_name, c.last_name
order by c.last_name asc;
  
    
    
    

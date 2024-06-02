SELECT category.name, count(film_category.film_id) 
from film_category 
join category on category.category_id=film_category.category_id
group by category.name;

SELECT store.store_id, city.city, country.country
from store 
join address on store.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;

SELECT store.store_id, sum(payment.amount)
FROM store
join customer on store.store_id= customer.store_id
join payment on customer.customer_id=payment.customer_id
group by store.store_id;


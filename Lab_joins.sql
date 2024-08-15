USE sakila;

SELECT c.name AS category, COUNT(*) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

SELECT category.name AS category, COUNT(*) as film_count
FROM category, film_category
WHERE category.category_id = film_category.category_id
GROUP BY category.name;

SELECT category.name, COUNT(*) AS film_count
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY film_count DESC;


select * from store;
select * from address;
select * from city;

SELECT store.store_id as StoreId, city.city as City, country.country as Country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

SELECT
    store.store_id, city.city, country.country, sum(payment.amount) as revenue
FROM
    payment
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
JOIN staff ON store.staff_id = staff.staff_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

SELECT
    store.store_id,
    city.city,
    country.country,
    SUM(payment.amount) AS revenue
FROM
    store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
JOIN staff ON store.manager_staff_id = staff.staff_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id, city.city, country.country;


select staff.staff_id, count(payment.staff_id) as pmt_count, sum(payment.amount) as pmt_sum
from payment
join staff on payment.staff_id = staff.staff_id
group by staff.staff_id
order by pmt_count desc; 

SELECT
    category.name AS category,
    AVG(film.length) AS avg_running_time
FROM
    category
JOIN
    film_category ON category.category_id = film_category.category_id
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY category.name;

SELECT
    category.name AS category,
    AVG(film.length) AS avg_running_time
FROM
    category
JOIN
    film_category ON category.category_id = film_category.category_id
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY avg_running_time DESC
LIMIT 1;

SELECT
    film.title,
    COUNT(rental.rental_id) AS rental_count
FROM
    film
JOIN
    inventory ON film.film_id = inventory.film_id
JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT
    film.title,
    CASE
        WHEN COUNT(rental.rental_id) > 0 THEN 'Yes'
        ELSE 'No'
    END AS available_at_store_1
FROM
    film
JOIN
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
WHERE
    film.title = 'Academy Dinosaur'
    AND inventory.store_id = 1;
    
    SELECT
    film.title,
    CASE
        WHEN COUNT(inventory.inventory_id) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability_status
FROM
    film
LEFT JOIN
    inventory ON film.film_id = inventory.film_id
GROUP BY
    film.title;







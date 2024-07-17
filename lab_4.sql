USE sakila;
-- 1
SELECT category.name AS category, -- name column from category table
COUNT(film_category.film_id) AS film_count -- number of films per category from film_category table
FROM 
	film_category
JOIN 
	category 
ON 
	film_category.category_id = category.category_id
GROUP BY category.name;

-- 2
SELECT
	store_id,
    city.city,
    country.country
FROM
    store
JOIN
    address
ON
    store.address_id = address.address_id
JOIN
    city
ON
    address.city_id = city.city_id
JOIN
	country
ON
	city.country_id = country.country_id;
    
 -- with aliases
 SELECT
    s.store_id,
    ci.city,
    co.country
FROM
    store AS s
JOIN
    address AS a ON s.address_id = a.address_id
JOIN
    city AS ci ON a.city_id = ci.city_id
JOIN
    country AS co ON ci.country_id = co.country_id;

-- 3
SELECT 
	store.store_id,
	SUM(payment.amount) AS revenue
FROM
	store
JOIN
	staff
ON
	store.manager_staff_id = staff.staff_id
JOIN
	payment
ON
	staff.staff_id = payment.staff_id
GROUP BY
	store.store_id;
    
-- with aliases
SELECT 
    s.store_id,
    SUM(p.amount) AS revenue
FROM
    store s
JOIN
    staff st ON s.manager_staff_id = st.staff_id
JOIN
    payment p ON st.staff_id = p.staff_id
GROUP BY
    s.store_id;

-- 4

SELECT 
	ROUND(AVG(film.length), 2) AS average_length,
    category.name
FROM 
	film
JOIN
	film_category
ON 
	film.film_id = film_category.film_Id
JOIN 
	category
ON
	film_category.category_id = category.category_id
GROUP BY
	category.name;
    
-- 5
SELECT 
	ROUND(AVG(film.length), 2) AS average_length,
    category.name
FROM 
	film
JOIN
	film_category
ON 
	film.film_id = film_category.film_Id
JOIN 
	category
ON
	film_category.category_id = category.category_id
GROUP BY
	category.name
ORDER BY 
	average_length DESC;
    
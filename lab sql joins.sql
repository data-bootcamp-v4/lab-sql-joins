-- 1
select b.name as category, count(*) as number_of_films
from film_category as a
inner join category as b
on a.category_id = b.category_id
group by b.name;

-- 2
select a.store_id, b.address, c.city, d.country
from store a
inner join address b 
on a.address_id = b.address_id
inner join city c
on b.city_id = c.city_id
inner join country d
on c.country_id = d.country_id;
-- 3
select sum(a.amount), b.store_id
from payment a
join staff b
on a.staff_id = b.staff_id
group by b.store_id;
-- 4
SELECT b.name as category, COUNT(a.film_id) AS number_of_films, round(AVG(c.length)) AS average_length
FROM film_category AS a
INNER JOIN category AS b
    ON a.category_id = b.category_id
INNER JOIN film AS c
    ON a.film_id = c.film_id
GROUP BY b.name;
-- 5
SELECT b.name as category, COUNT(a.film_id) AS number_of_films, round(AVG(c.length)) AS average_length
FROM film_category AS a
INNER JOIN category AS b
    ON a.category_id = b.category_id
INNER JOIN film AS c
    ON a.film_id = c.film_id
GROUP BY b.name
ORDER BY average_length DESC;

-- 6
SELECT 
    m.title AS Movie_Title, 
    COUNT(r.inventory_id) AS Rental_Count
FROM 
    rental r
JOIN 
    inventory i 
ON 
    r.inventory_id = i.inventory_id
JOIN 
    film m 
ON 
    i.film_id = m.film_id
GROUP BY 
    m.title
ORDER BY 
    Rental_Count DESC
LIMIT 10;
-- 7
SELECT 
    COUNT(i.inventory_id) AS Number_of_Copies,
    CASE 
        WHEN COUNT(r.inventory_id) < COUNT(i.inventory_id) THEN 'Available in Store 1'
        ELSE 'Not Available in Store 1'
    END AS Availability
FROM 
    inventory i
JOIN 
    film m 
ON 
    i.film_id = m.film_id
LEFT JOIN 
    rental r 
ON 
    i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE 
    m.title = 'Academy Dinosaur'
    AND i.store_id = 1;
-- 8
SELECT 
    f.title AS Film_Title,
    CASE 
        WHEN IFNULL(COUNT(i.inventory_id), 0) > 0 THEN 'Available'
        ELSE 'NOT Available'
    END AS Availability_Status
FROM 
    film f
LEFT JOIN 
    inventory i 
ON 
    f.film_id = i.film_id
GROUP BY 
    f.title
ORDER BY 
    Availability_Status DESC, f.title;

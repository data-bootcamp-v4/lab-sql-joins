USE sakila;

SELECT 
	c.name AS category,
    COUNT(*) AS num_films
FROM film_category AS fc
JOIN category AS c
	ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY num_films DESC, category ASC;

SELECT
	s.store_id,
    ci.city,
    co.country
FROM store AS s
JOIN address AS a
	ON s.address_id = a.address_id
JOIN city AS ci
	ON a.city_id = ci.city_id
JOIN country AS co
	ON ci.country_id = co.country_id
ORDER BY s.store_id;

SELECT
	s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue_usd
FROM payment AS p
JOIN staff AS st
	ON p.staff_id = st.staff_id
JOIN store AS s
	ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY s.store_id;

SELECT 
	c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM category AS c
JOIN film_category AS fc
	ON c.category_id = fc.category_id
JOIN film As f
	ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_minutes DESC, category ASC;

SELECT t.category, ROUND(t.avg_len,2) AS avg_length_minutes
FROM (
	SELECT c.name AS category, AVG(f.length) AS avg_len
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    GROUP BY c.name
) AS t
WHERE t.avg_len = (
	SELECT MAX(x.avg_len)
    FROM (
		SELECT AVG(f.length) AS avg_len
        FROM category c
        JOIN film_category fc ON c.category_id = fc.category_id
        JOIN film f ON fc.film_id = f.film_id
        GROUP BY c.name
	) AS x
);

SELECT 
	f.title,
    COUNT(*) AS times_rented
FROM rental AS r
JOIN inventory AS i 
    ON r.inventory_id = i.inventory_id
JOIN film AS f 
    ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC, f.title ASC
LIMIT 10;

SELECT 
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM inventory i
            JOIN film f ON f.film_id = i.film_id
            LEFT JOIN rental r 
                ON r.inventory_id = i.inventory_id
               AND r.return_date IS NULL       -- aluguel em aberto
            WHERE i.store_id = 1
              AND f.title = 'ACADEMY DINOSAUR'
              AND r.rental_id IS NULL          -- sem aluguel em aberto = disponível
        )
        THEN 'Yes' ELSE 'No'
	END AS can_be_rented_in_store_1;
    
SELECT 
    f.title,
    CASE 
        WHEN IFNULL(COUNT(i.inventory_id), 0) > 0 THEN 'Available'
        ELSE 'NOT available'
    END AS availability
FROM film AS f
LEFT JOIN inventory AS i 
    ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title ASC;
-- Selecionar o banco que queremos 
USE sakila;
SELECT DATABASE();

-- Lista de filmes por categoria
SELECT
    c.name,
    COUNT(fc.film_id) AS total_filmes
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.name;

-- Recupere o ID, cidade e país
SELECT
    s.store_id,
    ci.city,
    co.country
FROM store AS s
INNER JOIN address AS a
    ON s.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS co
    ON ci.country_id = co.country_id;

-- Calcular a receita    
SELECT
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM payment AS p
INNER JOIN rental AS r
    ON p.rental_id = r.rental_id
INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
INNER JOIN store AS s
    ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY s.store_id;

-- Duração média dos filmes
SELECT
    c.name AS category,
    AVG(f.length) AS average_duration
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_duration DESC;

-- Bonus: 
-- Categoria com maior duração
SELECT
    c.name AS category,
    AVG(f.length) AS average_duration
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_duration DESC
LIMIT 1;

-- 10 filmes mais alugados
SELECT
    f.title,
    COUNT(r.rental_id) AS total_rentals
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY total_rentals DESC
LIMIT 10;

-- Academy Dinosaur pode ser alugada na loja 1
SELECT
    f.title,
    i.store_id,
    i.inventory_id
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1;

-- Disponibilidade dos filmes no invetário
SELECT DISTINCT
    f.title,
    CASE
        WHEN IFNULL(i.inventory_id, 0) = 0
        THEN 'NOT available'
        ELSE 'Available'
    END AS availability_status
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
ORDER BY f.title;

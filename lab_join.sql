USE sakila;


-- 1

SELECT
    c.category_id,
    c.name AS category,
    COUNT(fc.film_id) AS n_films
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY n_films DESC, category ASC;


-- 2

SELECT
    s.store_id,
    ci.city     AS city,
    co.country  AS country
FROM store   AS s
JOIN address AS a   ON s.address_id = a.address_id
JOIN city    AS ci  ON a.city_id     = ci.city_id
JOIN country AS co  ON ci.country_id = co.country_id
ORDER BY s.store_id;


-- 3

SELECT
    st.store_id,
    ROUND(SUM(p.amount), 2) AS ingresos_usd
FROM payment AS p
JOIN staff   AS s  ON p.staff_id = s.staff_id
JOIN store   AS st ON s.store_id = st.store_id
GROUP BY st.store_id
ORDER BY st.store_id;


-- 4

SELECT
    c.name AS categoria,
    ROUND(AVG(f.length), 2) AS duracion_media_min
FROM film AS f
JOIN film_category AS fc
    ON f.film_id = fc.film_id
JOIN category AS c
    ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY duracion_media_min DESC; 





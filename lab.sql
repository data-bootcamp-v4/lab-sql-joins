-- 1. Enumere el número de películas por categoría.
SELECT c.name, COUNT(f.film_id)
FROM sakila.category as c
LEFT JOIN sakila.film_category as f
ON c.category_id = f.category_id
GROUP BY c.name;

-- 2. Recupere el ID de la tienda, la ciudad y el país de cada tienda.
SELECT st.store_id, ci.city, co.country
FROM store as st
JOIN address as ad 
ON st.address_id = ad.address_id
JOIN city as ci 
ON ad.city_id = ci.city_id
JOIN country as co
ON ci.country_id = co.country_id;

-- 3. Calcule los ingresos totales generados por cada tienda en dólares
SELECT st.store_id, SUM(pa.amount) as total
FROM sakila.payment as pa
JOIN staff as s
ON pa.staff_id = s.staff_id
JOIN sakila.store as st
ON s.store_id = st.store_id
GROUP BY store_id;

-- 4. Determinar el tiempo promedio de ejecución de las películas para cada categoría.
SELECT c.name AS category, AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c 
ON fc.category_id = c.category_id
GROUP BY c.name;

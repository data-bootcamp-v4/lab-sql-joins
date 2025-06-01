-- 1. Количество фильмов по категориям
SELECT 
    c.name AS category,
    COUNT(f.film_id) AS film_count
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    film_count DESC;


-- 2. Магазин, город и страна
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id;


-- 3. Общая выручка по магазину
SELECT 
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM 
    payment p
JOIN 
    staff st ON p.staff_id = st.staff_id
JOIN 
    store s ON st.store_id = s.store_id
GROUP BY 
    s.store_id;


-- 4. Средняя продолжительность фильма по категории
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_duration
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    avg_duration DESC;

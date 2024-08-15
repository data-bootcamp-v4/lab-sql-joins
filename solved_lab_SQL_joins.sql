SELECT
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM
    film_category fc
JOIN
    category c ON fc.category_id = c.category_id
GROUP BY
    c.name
ORDER BY
    film_count DESC;
    
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
    
SELECT
    st.store_id,
    SUM(p.amount) AS total_revenue
FROM
    payment p
JOIN
    staff sf ON p.staff_id = sf.staff_id
JOIN
    store st ON sf.store_id = st.store_id
GROUP BY
    st.store_id
ORDER BY
    total_revenue DESC;
    
SELECT
    c.name AS category_name,
    AVG(f.length) AS average_length
FROM
    film_category fc
JOIN
    category c ON fc.category_id = c.category_id
JOIN
    film f ON fc.film_id = f.film_id
GROUP BY
    c.name
ORDER BY
    average_length DESC;

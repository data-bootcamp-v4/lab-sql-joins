USE Sakila;



SELECT * FROM payment LIMIT 10;


SELECT * FROM staff;


SELECT s.store_id, st.staff_id
FROM store s
INNER JOIN staff st ON s.store_id = st.store_id;


SELECT s.store_id, p.amount
FROM store s
INNER JOIN staff st ON s.store_id = st.store_id
INNER JOIN payment p ON st.staff_id = p.staff_id;


SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
INNER JOIN staff st ON s.store_id = st.store_id
INNER JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;
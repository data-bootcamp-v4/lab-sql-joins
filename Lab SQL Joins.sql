-- ============================================================
-- LAB | SQL Joins - Sakila Database
-- ============================================================

USE sakila;

-- ============================================================
-- 1. Nombre de films par catégorie
-- ============================================================
SELECT 
    c.name AS category,
    COUNT(fc.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY number_of_films DESC;

-- ============================================================
-- 2. Store ID, ville et pays pour chaque magasin
-- ============================================================
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- ============================================================
-- 3. Revenu total généré par chaque magasin (en dollars)
-- ============================================================
SELECT 
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

-- ============================================================
-- 4. Durée moyenne des films par catégorie
-- ============================================================
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_running_time DESC;

-- ============================================================
-- BONUS
-- ============================================================

-- ============================================================
-- 5. Catégorie avec la plus longue durée moyenne
-- ============================================================
SELECT 
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_running_time DESC
LIMIT 1;

-- ============================================================
-- 6. Top 10 des films les plus loués
-- ============================================================
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 10;

-- ============================================================
-- 7. "Academy Dinosaur" disponible au Store 1 ?
-- ============================================================
SELECT 
    f.title,
    s.store_id,
    COUNT(i.inventory_id) AS copies_available
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
WHERE f.title = 'ACADEMY DINOSAUR'
  AND s.store_id = 1
GROUP BY f.title, s.store_id;

-- ============================================================
-- 8. Titres distincts avec statut de disponibilité
-- ============================================================
SELECT DISTINCT
    f.title,
    CASE
        WHEN IFNULL(i.inventory_id, 0) = 0 THEN 'NOT available'
        ELSE 'Available'
    END AS availability
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
ORDER BY f.title;
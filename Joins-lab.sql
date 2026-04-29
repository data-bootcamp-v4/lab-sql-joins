USE sakila;

-- 1. Lista el número de películas por categoría
SELECT c.name AS category,       
       COUNT(fc.film_id) AS number_of_films  
FROM category c                   
JOIN film_category fc             
  ON c.category_id = fc.category_id  
GROUP BY c.name                   
ORDER BY number_of_films DESC;   

-- 2. Obten el ID de tienda, ciudad y país de cada tienda
SELECT s.store_id,        
       ci.city,           
       co.country        
FROM store s             
JOIN address a            
  ON s.address_id = a.address_id   
JOIN city ci              
  ON a.city_id = ci.city_id        
JOIN country co           
  ON ci.country_id = co.country_id 
  
-- 3. Calcula el ingreso total generado por cada tienda en dólares
SELECT s.store_id,                    -- ID de la tienda
       SUM(p.amount) AS total_revenue -- Suma de todos los pagos
FROM store s                          -- Empezamos en store
JOIN staff st                         -- store no tiene pagos, tiene staff
  ON s.store_id = st.store_id         -- unimos por store_id
JOIN payment p                        -- staff tiene los pagos asociados
  ON st.staff_id = p.staff_id         -- unimos por staff_id
GROUP BY s.store_id;                  -- agrupamos por tienda

-- 4. Calcula el tiempo medio de duración de las películas por categoría
SELECT c.name AS category,              -- Nombre de la categoría
       ROUND(AVG(f.length), 2)          -- Media de duración, redondeada
         AS avg_running_time            -- a 2 decimales
FROM category c                         -- Empezamos en category
JOIN film_category fc                   -- tabla puente (ya la conocemos!)
  ON c.category_id = fc.category_id    -- unimos por category_id
JOIN film f                             -- ahora llegamos a film
  ON fc.film_id = f.film_id            -- unimos por film_id
GROUP BY c.name                         -- agrupamos por categoría
ORDER BY avg_running_time DESC;         -- las más largas primero
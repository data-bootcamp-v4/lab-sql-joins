USE sakila;

# ==================================================
# CHALLENGE 1
# List the number of films per category
# ==================================================

SELECT
    c.name AS Category_name,
    COUNT(fc.film_id) AS Number_of_films
FROM category AS c
LEFT JOIN film_category AS fc
    ON c.category_id = fc.category_id
GROUP BY
    c.category_id,
    c.name
ORDER BY
    Number_of_films DESC;


# ==================================================
# CHALLENGE 2
# Retrieve the store ID, city, and country
# for each store
# ==================================================

SELECT
    s.store_id AS Store_ID,
    ci.city AS City,
    co.country AS Country
FROM store AS s
INNER JOIN address AS a
    ON s.address_id = a.address_id
INNER JOIN city AS ci
    ON a.city_id = ci.city_id
INNER JOIN country AS co
    ON ci.country_id = co.country_id
ORDER BY
    s.store_id;


# ==================================================
# CHALLENGE 3
# Calculate the total revenue generated
# by each store
# ==================================================

SELECT
    st.store_id AS Store_ID,
    ROUND(SUM(p.amount), 2) AS Total_revenue
FROM store AS st
INNER JOIN staff AS sf
    ON st.store_id = sf.store_id
INNER JOIN payment AS p
    ON sf.staff_id = p.staff_id
GROUP BY
    st.store_id
ORDER BY
    st.store_id;


# ==================================================
# CHALLENGE 4
# Determine the average running time
# of films for each category
# ==================================================

SELECT
    c.name AS Category_name,
    ROUND(AVG(f.length), 2) AS Average_running_time
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY
    c.category_id,
    c.name
ORDER BY
    Average_running_time DESC;


# ==================================================
# BONUS 1
# Identify the film category with the longest
# average running time
# ==================================================

SELECT
    c.name AS Category_name,
    ROUND(AVG(f.length), 2) AS Average_running_time
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY
    c.category_id,
    c.name
ORDER BY
    Average_running_time DESC
LIMIT 1;


# ==================================================
# BONUS 2
# Display the top 10 most frequently rented movies
# ==================================================

SELECT
    f.title AS Film_title,
    COUNT(r.rental_id) AS Number_of_rentals
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY
    f.film_id,
    f.title
ORDER BY
    Number_of_rentals DESC,
    f.title
LIMIT 10;


# ==================================================
# BONUS 3
# Determine whether Academy Dinosaur can currently
# be rented from Store 1
# ==================================================

SELECT
    f.title AS Film_title,
    i.store_id AS Store_ID,
    COUNT(DISTINCT i.inventory_id) AS Available_copies,
    CASE
        WHEN COUNT(DISTINCT i.inventory_id) > 0
            THEN 'Available'
        ELSE 'NOT available'
    END AS Availability_status
FROM film AS f
INNER JOIN inventory AS i
    ON f.film_id = i.film_id
LEFT JOIN rental AS r
    ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL
WHERE
    f.title = 'ACADEMY DINOSAUR'
    AND i.store_id = 1
    AND r.rental_id IS NULL
GROUP BY
    f.film_id,
    f.title,
    i.store_id;


# ==================================================
# BONUS 4
# List all film titles and indicate whether each
# film exists in the inventory
# ==================================================

SELECT
    f.title AS Film_title,
    CASE
        WHEN IFNULL(COUNT(i.inventory_id), 0) > 0
            THEN 'Available'
        ELSE 'NOT available'
    END AS Availability_status
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
GROUP BY
    f.film_id,
    f.title
ORDER BY
    f.title;


# ==================================================
# OPTIONAL CHECK
# Confirm the number of films not found in inventory
# Expected result is 42
# ==================================================

SELECT
    COUNT(*) AS Films_not_in_inventory
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL;
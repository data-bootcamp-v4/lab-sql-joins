#Determine the average running time of films for each category
# I need 3 tables:
#film (film_id is the key with film category and the table gives me the lengh)
#film category (category_id is the key with category)
#cateory (gives me the name of the category)

USE sakila;

SELECT c.name AS Category, AVG(f.length) AS Average_Running_Time # List of the columns I need
FROM film f #table where columns are needed (film_id and lenght)
JOIN film_category fc ON f.film_id = fc.film_id #first table I need to join with the film (the key os film_id)
JOIN category c ON fc.category_id = c.category_id #second tablE I need to join with film and film_category (the key is category_id)
GROUP BY c.name;#grouping by the name of the category

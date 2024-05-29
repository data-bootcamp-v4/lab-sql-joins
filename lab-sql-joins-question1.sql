USE sakila;

#1. List the number of films per category.
#I need 3 tables
#film (film_id is the key with the table film_category)
#film_category (category_id is the key with the table category)
#category (gives me the name of the category)

SELECT c.name AS Category, COUNT(f.film_id) AS Number_of_Films #list of the columns I need 
FROM film f #table where is the first column is needed (film_id)
JOIN film_category fc ON f.film_id = fc.film_id #first table I need to join with the key film_id
JOIN category c ON fc.category_id = c.category_id #second table I need to join with the key category_id
GROUP BY c.name; #grouping by the name of the category
#2. Retrieve the store ID, city, and country for each store.
#I need 4 tables: 
# store (address_id is the with the table address)
# address (city_id is the key with the table city)
# city (country_id is the key with country and gives me the name of the city)
# country (gives the name of the country)


USE sakila;

SELECT s.store_id, c.city, co.country #list of the columns I need 
FROM store s #table where is the first column is needed (store_id)
JOIN address a ON s.address_id = a.address_id #first table I need to join with store (the key is adress_id)
JOIN city c ON a.city_id = c.city_id #second table I need to join with store and adress (the key is city_id)
JOIN country co ON c.country_id = co.country_id; #third table I need to join with store, adress and city (the key is country_id)
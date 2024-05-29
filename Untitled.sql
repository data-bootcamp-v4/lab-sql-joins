USE sakila;

#1. Indiquez le nombre de films par catégorie: d'un côté la categorie et de l'autre le nombre
# Donc il faut avoir la liste des categories puis le nombre de film_id
#la colonne film_id dans la table film me donne la liste de tous les films
#la colonne category_id dans la table film_ category me donne l'id de la categorie et le film_id
#la colonne name dans la table category me donne le category_id et le name de la categorie

SELECT c.name AS Category, COUNT(f.film_id) AS Number_of_Films
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;
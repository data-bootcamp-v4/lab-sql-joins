-- 1 : 
SELECT 
c.name, 
count(distinct film_id) as nb_movie 
FROM sakila.film_category fc 
LEFT join category c on c.category_id = fc.category_id 
group by c.name;

-- 2 : Récupérez l’ID du magasin, la ville et le pays pour chaque magasin
select
store_id,
city.city,
country.country
from store left join address ad on store.address_id = ad.address_id
			left join city on ad.city_id = city.city_id
            left join country on city.country_id = country.country_id;
            
-- 3: Calculez le revenu total généré par chaque magasin en dollars
select 
store_id,
Concat(sum(amount),'$') as total
FROM payment py left join staff on py.staff_id = staff.staff_id
Group by store_id;

-- 4 : Déterminez la durée moyenne de diffusion des films pour chaque catégorie.
SELECT 
c.name, 
avg(film.length) as avg_duration 
FROM sakila.film_category fc 
LEFT join category c on c.category_id = fc.category_id 
left join film on fc.film_id = film.film_id
group by c.name;

-- 5 : 
SELECT 
c.name, 
avg(film.length) as avg_duration 
FROM sakila.film_category fc 
LEFT join category c on c.category_id = fc.category_id 
left join film on fc.film_id = film.film_id
group by c.name
order by avg_duration desc limit 5 ;

-- 6 : Affichez les 10 films les plus fréquemment loués par ordre décroissant.
select 
fm.title,
count(rt.rental_id) as nb_rental
from rental rt 
left join inventory iv on rt.inventory_id = iv.inventory_id
left join film fm on iv.film_id = fm.film_id
group by fm.title
order by  nb_rental desc limit 10;

-- 7 : Déterminez si « Academy Dinosaur » peut être loué dans le magasin 1.
select 
fm.title,
iv.store_id
from film fm
left join inventory iv on fm.film_id = iv.film_id
WHERE fm.title = 'Academy Dinosaur'
and iv.store_id = 1 ;

-- 8 : 

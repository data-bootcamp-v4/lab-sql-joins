use sakila; 

#Solution_1

select 
	c.name,
	count(fc.film_id) as number_of_films
from
	film_category as fc
inner join
	category as c on c.category_id = fc.category_id
group by 
	c.name;
    
    
#Solution_2
    
    select 
		store.store_id,
        city.city as city,
        country.country as country
	from 
		store 
	inner join 
		address on address.address_id = store.address_id
	inner join 
		city city on address.city_id = city.city_id
	inner join 
		country on country.country_id = city.country_id;
    
    
#Solution_3
    
    select 
		store.store_id,
        sum(amount) as total_revenue
    from 
		store
	inner join 
		payment on payment.staff_id = store.manager_staff_id
	group by
		store.store_id;
     
     
#Solution_4

select 
	c.name,
	round(avg(f.length)) as avg_running_time
from
	film_category as fc
inner join
	category as c on c.category_id = fc.category_id
inner join
	film as f on f.film_id = fc.film_id
group by 
	c.name;
	
    
#Solution_5

select
	category,
    avg_running_time
from
	 (select 
			c.name as category,
			round(avg(f.length)) as avg_running_time
		from
			film_category as fc
		inner join
			category as c on c.category_id = fc.category_id
		inner join
			film as f on f.film_id = fc.film_id
		group by 
			c.name) as avg_time
where 
	avg_running_time = (select 
							max(avg_running_time) 
						from 
							(select 
								c.name as category,
								round(avg(f.length)) as avg_running_time
							from
								film_category as fc
							inner join
								category as c on c.category_id = fc.category_id
							inner join
								film as f on f.film_id = fc.film_id
							group by 
								c.name) as max_time);
                                
                                
#Solution_6

select
	film.title,
	count(rental_id) as number_of_rentals
from
	rental
inner join 
	inventory on inventory.inventory_id = rental.inventory_id
inner join
	film on film.film_id = inventory.film_id
group by 
	film.title
order by 
	number_of_rentals desc, title asc
limit 10;


#Solution_7

select
	count(*) as available_for_rent
from
	inventory 
inner join
	film on film.film_id = inventory.film_id
where 
	inventory.store_id = 1
	and film.title = "Academy Dinosaur";
    

#Solution_8
select 
	distinct title,
    CASE 
		WHEN inventory.inventory_id is not null 
			then 'Available'
		ELSE 'NOT available' 
	END as availability_status
			
from 
	film
left join 
	inventory on film.film_id = inventory.film_id;





select
	distinct availability_status,
    count(availability_status)
from

	(select 
		distinct title,
		CASE 
			WHEN inventory.inventory_id is not null 
				then 'Available'
			ELSE 'NOT available' 
		END as availability_status
				
	from 
		film
	left join 
		inventory on film.film_id = inventory.film_id) as list_of_films
        
group by availability_status
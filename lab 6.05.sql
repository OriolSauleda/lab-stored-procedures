select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
  DELIMITER //

create procedure customer_action()
begin
select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action";
end //
DELIMITER ;

call customer_action();

DELIMITER //
create procedure procedure2 (in param1 varchar(100))
begin
  select first_name, last_name, email, category.name
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name COLLATE utf8mb4_general_ci = param1
  group by first_name, last_name, email, name;
end //
DELIMITER ;

call procedure2("Action");
drop procedure if exists procedure2;


select count(film.film_id), category.name from film
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
group by category.name
order by count(film.film_id) desc;

DELIMITER //
create procedure movies_relesead_by_category (in param3 int)
begin
  select count(film.film_id), category.name
  from film
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where (
	select count(film.film_id) as number_of_movies from film) COLLATE utf8mb4_general_ci > param3
  group by category.name;
  -- order by count(film.film_id) desc
end //
DELIMITER ;

call movies_relesead_by_category(60);
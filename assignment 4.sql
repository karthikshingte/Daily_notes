-- 1. List all customers along with the films they have rented.
select c.first_name,c.last_name, f.title
from sakila.customer as c
join sakila.rental as r
on c.customer_id=r.customer_id
join sakila.inventory as i
on r.inventory_id = i.inventory_id
join sakila.film as f
on i.film_id = f.film_id
;

-- 2. List all customers and show their rental count, including those who haven't rented any films.


select c.customer_id,
    c.first_name,
    c.last_name,
    count(r.rental_id) as rental_count
from sakila.customer as c
left join sakila.rental as r
on c.customer_id = r.customer_id
group by c.customer_id,
    c.first_name,
    c.last_name;

-- 3. Show all films along with their category. Include films that don't have a category assigned.
select * from sakila.film;
select * from sakila.film_category;
select * from sakila.category;

select f.title,fc.category_id,c.name as category_name
from sakila.film as f
left join sakila.film_category as fc
on f.film_id = fc.film_id
left join sakila.category as c on fc.category_id = c.category_id;

-- 4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).

select * from sakila.customer;
select * from sakila.staff;

select c.email as customer_email,s.email as staff_email
from sakila.customer as c
left join sakila.staff as s
on c.store_id = s.store_id
union
select c.email as customer_email,s.email as staff_email
from sakila.customer as c
right join sakila.staff as s
on c.store_id = s.store_id;

-- 5. Find all actors who acted in the film "ACADEMY DINOSAUR".
select * from sakila.film;
select * from sakila.actor;
select * from sakila.film_actor;

select a.first_name, a.last_name
from sakila.actor as a
left join sakila.film_actor as fa
on a.actor_id = fa.actor_id
left join sakila.film as f
on fa.film_id = f.film_id
where title = "ACADEMY DINOSAUR";

-- 6. List all stores and the total number of staff members working in each store, even if a store has no staff.

select * from sakila.store;
select * from sakila.staff;

select 
    s.store_id,
    count(st.staff_id) as staff_count
from sakila.store as s
left join sakila.staff as st 
    on s.store_id = st.store_id
group by s.store_id;

-- 7. List the customers who have rented films more than 5 times. Include their name and total rental count.

select c.customer_id,
    c.first_name,
    c.last_name,
    count(r.rental_id) as rental_count
from sakila.customer as c
left join sakila.rental as r
on c.customer_id = r.customer_id
group by c.customer_id,
    c.first_name,
    c.last_name
having rental_count > 5;
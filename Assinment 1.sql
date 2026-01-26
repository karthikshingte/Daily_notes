-- Question1

select * from sakila.customer
where active = 1 and first_name like "J%";

-- uestion 2

select * from sakila.film
where title like "%ACTION%" or description like '%WAR%';

-- Question 3

select * from sakila.customer
where last_name != "SMITH" and first_name like '%a';

-- Question 4

select * from sakila.film
where rental_rate > 3.0 and replacement_cost is not NULL;

-- Question 5

select store_id, count(*),active
from sakila.customer
group by store_id
having active = 1;

-- Question 6

select distinct(rating)
from sakila.film;

-- Question 7

select rental_duration, count(*) as film_count
from sakila.film
group by rental_duration
having avg(length) > 100;

-- Question 8

select Date(payment_date) as pay_date, count(*) as num_payment, sum(amount)
from sakila.payment
group by Date(payment_date)
having Count(*) > 100;

-- Question 9

select customer_id, first_name, last_name,email
from sakila.customer
where email is NULL or email LIKE '%.org';

-- Question 10

select film_id, rental_rate
from sakila.film
where rating = 'PG' or rating = 'G'
order by rental_rate desc;

-- Question 11

select length, count(*) as film_count
from sakila.film
where title like 'T%'
group by length
having count(*) > 5;

-- Question 12

select 	a.actor_id, a.first_name,a.last_name, count(fa.film_id) as film_count
from sakila.actor as a
join sakila.film_actor as fa
on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
having count(fa.film_id) > 10
order by film_count desc;

-- Question 13

select film_id,title,rental_rate,length
from sakila.film
order by rental_rate desc, length desc
limit 5;

-- Question 14

select c.customer_id, c.first_name,c.last_name,count(r.rental_id) as total_rentals
from sakila.customer as c
join sakila.rental as r
on c.customer_id = r.customer_id
group by c.customer_id, c.first_name,c.last_name
order by total_rentals desc;

-- Question 15

SELECT DISTINCT
    f.title
FROM sakila.film AS f
LEFT JOIN sakila.inventory AS i 
    ON f.film_id = i.film_id
LEFT JOIN sakila.rental AS r
    ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL
ORDER BY f.title;

-- Question 1 
#display all customer details who have made more than 5 payments.

select *
from sakila.customer
where customer_id in (
	select customer_id
    from sakila.payment
    group by customer_id
    having count(payment_date) > 5
);

-- Question 2

#Find the names of actors who have acted in more than 10 films.

select *
from sakila.actor
where actor_id in (
	select actor_id
    from sakila.film_actor
    group by actor_id
    having count(film_id) > 10
);


-- Question 3
-- 3. Find the names of customers who never made a payment.

select * from sakila.payment;
select * from sakila.customer;

select *
from sakila.customer
where customer_id not in (
	select distinct customer_id
    from sakila.payment
);



-- Question 4
-- 4. List all films whose rental rate is higher than the average rental rate of all films.

select * from sakila.film;

select title
from sakila.film
where rental_rate > (
	select avg(rental_rate)
    from sakila.film
);

-- Question 5
-- 5. List the titles of films that were never rented.


select title
from sakila.film
where film_id not in (
	select distinct film_id
    from sakila.inventory
    where inventory_id in (
			select inventory_id
            from sakila.inventory
	)
);

-- Question 6
-- 6. Display the customers who rented films in the same month as customer with ID 5.


select * from sakila.rental;
select * from sakila.customer;

select *
from sakila.customer
where customer_id in (
	select distinct customer_id
    from sakila.rental
    where month(rental_date) in (
	select  distinct(month(rental_date))
    from sakila.rental
    where customer_id = 5)
    order by customer_id
);

-- Question 7
-- 7. Find all staff members who handled a payment greater than the average payment amount.
select * from sakila.staff;


select *
from sakila.staff
where staff_id in (
	select distinct staff_id
    from sakila.payment
    where amount > (
		select avg(amount)
		from sakila.payment
    )
);

-- Question 8
-- 8. Show the title and rental duration of films whose rental duration is greater than the average.

select * from sakila.film;

select title, rental_duration
from sakila.film
where rental_duration > (
	select avg(rental_duration)
    from sakila.film
);

-- Question 9
-- 9. Find all customers who have the same address as customer with ID 1.

select * from sakila.address;
select * from sakila.customer;

select * 
from sakila.customer
where address_id = (
	select address_id
    from sakila.customer
    where customer_id = 1
);

-- Question 10
-- 10. List all payments that are greater than the average of all payments.

select *
from sakila.payment
where amount > (
	select avg(amount)
    from sakila.payment
);









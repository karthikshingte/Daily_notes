-- Question 1

select count(distinct(first_name))
from sakila.customer;

-- Question 3

select description, char_length(description) as length, char_length(replace(description, 'a', '')) as new_length
from sakila.film;



select description, char_length(description)  - char_length(replace(description, 'a', '')) as new_length
from sakila.film;


select sum(new_length)
from (
select char_length(description)  - char_length(replace(description, 'a', '')) as new_length
from sakila.film) as t;

-- Question 4

select 
	sum(a_count) as total_a,
    sum(e_count) as total_e,
	sum(i_count) as total_i,
    sum(o_count) as total_o,
    sum(u_count) as total_u
from (
	select 
    char_length(lower(description)) - char_length(replace(lower(description),'a','')) as a_count,
    char_length(lower(description)) - char_length(replace(lower(description),'e','')) as e_count,
    char_length(lower(description)) - char_length(replace(lower(description),'i','')) as i_count,
    char_length(lower(description)) - char_length(replace(lower(description),'o','')) as o_count,
    char_length(lower(description)) - char_length(replace(lower(description),'u','')) as u_count
from sakila.film)
as k;

-- Question 4


select customer_id, year(payment_date) as week, sum(amount)
from sakila.payment
group by  customer_id,year(payment_date)
order by customer_id asc;

select customer_id,year(payment_date) as year ,week(payment_date) as week, sum(amount)
from sakila.payment
group by  customer_id,week(payment_date)
order by customer_id asc;

select customer_id, month(payment_date) as week, sum(amount)
from sakila.payment
group by  customer_id,month(payment_date)
order by customer_id asc;

select
    case
    when mod(2018,400) = 0 then 'leap year'
    when mod(2018,100) = 0 then 'not leap year'
    when mod(2018,4) = 0 then 'leap year'
    else 'not leap year'
    end as leap_year;

-- Question 6

SELECT DATEDIFF(
           MAKEDATE(YEAR(CURDATE()), 365)
           + interval (CASE
                           WHEN DAYOFYEAR(MAKEDATE(YEAR(CURDATE()), 365)) = 365
                                THEN 0    -- normal year
                           ELSE 1         -- leap year (needs day 366)
                       END) DAY,
           CURDATE()
       ) AS days_remaining;
       
-- Question 7

select month(payment_date),
	case
    when month(payment_date) between 1 and 3 then 'Q1'
    when month(payment_date) between 4 and 6 then 'Q2'
    when month(payment_date) between 7 and 9 then 'Q3'
    else 'Q4'
    end as quater
from sakila.payment;

-- Question 8










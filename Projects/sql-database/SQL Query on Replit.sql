/* Crate Restaurant data tables */

CREATE TABLE CUSTOMER (id int,name text,city text) ;
INSERT INTO CUSTOMER VALUES
(1,'Nut','Bangkok') ,
(2,'Maywich','Bangkok') ,
(3,'John','London') ;

CREATE TABLE FOODS (id int,name text,price real) ;
INSERT INTO FOODS VALUES
(1,'Hamnburger',100) ,
(2,'Pizza',120) ,
(3,'Pasta',100) ,
(4,'Fried Chicken',50) ,
(5,'French Fried',50) ;

CREATE TABLE DRINKS (id int,name text,price real) ;
INSERT INTO DRINKS VALUES
(1,'Water',10) ,
(2,'Pepsi',30) ,
(3,'Coke',30) , 
(4,'Beer',100) ;

CREATE TABLE DATE_INVOICES (id int,invoicedate date) ;
INSERT INTO DATE_INVOICES VALUES
(1,2023-03-24) ,
(2,2023-06-15) ,
(3,2023-02-16) ;

CREATE TABLE TRANSACTIONS (id int,foods_name text,foods_price real,drinks_name text,drinks_price real) ;
INSERT INTO TRANSACTIONS VALUES
(1,'Hamburger',100,'Beer',100) ,
(2,'Pasta',100,'Pepsi',30) ,
(3,'Pizza',120,'Coke',30) ;

/* SQL Query */

select
  sub1.name,
  sub2.foods_price
from (select * from customer
  where name ='Nut') as sub1
join (select * from transactions
  where id = 1) as sub2
on sub1.id = sub2.id ;

select
  sub1.name,
  sub2.foods_price,
  sub2.drinks_price,
  sub2.foods_price + sub2.drinks_price as total
from (select * from customer
  where name ='Nut') as sub1
join (select * from transactions
  where id = 1) as sub2
on sub1.id = sub2.id ;

with sub1 as (select * from customer
  where customer.id = 2),
sub2 as (select * from transactions
  where id = 2)
select 
  sub1.name,
  sub2.foods_price,
  sub2.drinks_price,
  sum(sub2.foods_price + sub2.drinks_price) as total
  from sub1
  join sub2
  on sub1.id = sub2.id ;

create view full_transactions as
select 
  inv.id as id,
  inv.invoicedate as date,
  cus.name cus_name,
  tf.foods_name foods,
  tf.foods_price Fprice,
  tf.drinks_name drinks,
  tf.drinks_price Dprice,
  tf.foods_price + tf.drinks_price as total_rev
  from (select * from date_invoices ) as inv 
join (select * from transactions ) as tf
on inv.id = tf.id 
join (select * from customer) as cus 
on tf.id = cus.id ;

select 
  date_invoices.id,
  strftime("%Y",invoicedate) as year,
  strftime("%m",invoicedate) as month,
  strftime("%d",invoicedate) as date,
  transactions.foods_name,
  transactions.foods_price,
  transactions.drinks_name,
  transactions.drinks_price,
  transactions.foods_price + transactions.drinks_price as total_rev
  from date_invoices
join transactions
on date_invoices.id = transactions.id ;

select
  sum(fprice) as sum_fp,
  round(avg(fprice),2) as avg_fp,
  min(fprice) as min_fp, 
  max(fprice) as max_fp,
  count(foods) as count_f
from full_transactions ;

select
  id,
  foods,
  count(foods) as count_f
from full_transactions
group by foods ;

















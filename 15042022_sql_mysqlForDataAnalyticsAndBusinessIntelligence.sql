
create table sales.customers
(
customer_id int,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
number_of_complains int
);

create table if not exists sales.sales 
(
purchase_number int not null auto_increment,
date_of_purchase date not null,
customer_id int,
item_code varchar(10) not null,
primary key(purchase_number)
);
alter table sales.sales
add foreign key (customer_id) references customers(customer_id) on delete cascade;

alter table sales.sales
drop foreign key sales_ibfk_1;

-- select*from sales;
-- select*from sales.sales;
-- DROP table sales;
-- drop table customers;

drop table sales.customers;

create table sales.customers
(
customer_id int,
first_name varchar(255),
last_name varchar(255),
email_address varchar(255),
number_of_complaints int,
primary key(customer_id)
);

create table sales.items
(
item_code varchar(255),
item varchar(255),
unit_price numeric(10,2),
company_id varchar(255),
primary key(item_code)
);


create table sales.companies
(
company_id varchar(255),
company_name varchar(255),
headquarters_phone_no int,
primary key (company_id)
);

-- drop table sales.items;
-- drop table sales.companies;


-- DROP TABLE sales.sales;
 drop table sales.customers;
-- drop table sales.items;
-- drop tables sales.companies;

create table sales.customers
(
	customer_id int,
	first_name varchar(255),
	last_name varchar(255),
	email_address varchar(255),
	number_of_complains int,
 primary KEY (customer_id)
);

alter table sales.customers
add unique key (email_address);

alter table sales.customers
drop index email_address;

 drop table sales.customers;

create table sales.customers
(
	customer_id int auto_increment,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar (255),
    number_of_complaints int,
primary key(customer_id)
);
alter table sales.customers
add column gender enum('M','F') after last_name;


insert into sales.customers (first_name, last_name, gender, email_address, number_of_complaints)
values ('Linda', 'ochwada', 'F', 'linda.ochwada@gmx.de', 0) ;

alter table sales.customers
change column number_of_complaints number_of_complaints int default 0 ;

insert into sales.customers (first_name, last_name, gender, email_address)
values ('Philipp', 'Freisleben', 'M', 'philipp.freisleben.gmx.de');

insert into sales.customers(first_name, last_name, gender)
values ('Shammah','Freisleben', 'M');

select* from sales.customers;

-- alter table sales.customers
-- alter column number_of_complaints Drop default;


create table sales.companies
(
	company_id varchar(255),
	company_name varchar(255) default 'X',
	headquarters_phone_number varchar(255),
primary key (company_id),
unique key (headquarters_phone_number) 
);

DROP TABLE sales.companies;

create table sales.companies
(
	company_id int auto_increment,
    headquarters_phone_number varchar(255),
	company_name varchar(255) not null,
primary key (company_id)
);
alter table sales.companies
modify company_name varchar(255) null;

alter table sales.companies
change column company_name company_name varchar(255) not null;

insert into sales.companies(headquarters_phone_number, company_name)
value ('+49 (148) 239868', 'AfroAI');

SELECT* FROM sales.companies;

alter table sales.companies
modify headquarters_phone_number varchar(255) null;

alter table sales.companies 
modify headquarters_phone_number varchar(255) not null;
-- change column headquarters_phone_number headquarters_phone_number varchar(255) not null;

select* from sales.companies;


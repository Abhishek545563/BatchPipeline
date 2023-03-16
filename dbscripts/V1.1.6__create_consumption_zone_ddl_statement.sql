CREATE OR REPLACE PROCEDURE create_consumption_zone_ddl_statement() 
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
BEGIN

create table if not exists leaplogic_cicd.consumption_zone.item_dim (
    item_dim_key number autoincrement,
    item_id varchar(16),
    item_desc varchar,
    start_date date,
    end_date date,
    price number(7,2),
    item_class varchar(50),
    item_category varchar(50),
    added_timestamp timestamp default current_timestamp() ,
    updated_timestamp timestamp default current_timestamp() ,
    active_flag varchar(1) default 'Y'
) comment ='this is item table with in consumption schema';

create table if not exists leaplogic_cicd.consumption_zone.customer_dim (
    customer_dim_key number autoincrement,
    customer_id varchar(18),
    salutation varchar(10),
    first_name varchar(20),
    last_name varchar(30),
    birth_day number,
    birth_month number,
    birth_year number,
    birth_country varchar(20),
    email_address varchar(50),
    added_timestamp timestamp default current_timestamp() ,
    updated_timestamp timestamp default current_timestamp() ,
    active_flag varchar(1) default 'Y'
) comment ='this is customer table with in consumption schema';

create table if not exists leaplogic_cicd.consumption_zone.order_fact (
  order_fact_key number autoincrement,
  order_date date,
  customer_dim_key number,
  item_dim_key number,
  order_count number,
  order_quantity number,
  sale_price number(20,2),
  disount_amt number(20,2),
  coupon_amt number(20,2),
  net_paid number(20,2),
  net_paid_tax number(20,2),
  net_profit number(20,2)
) comment ='this is order table with in consumption schema';
   
END
$$;
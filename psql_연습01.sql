select * 
from retail_sales 
order by sales_month desc 
limit 100;

select current_timestamp;

select current_timestamp at time zone 'utc';

select * from pg_catalog.pg_timezone_names;

select localtimestamp;

select now();

select date_trunc('week', now() - interval '5 days');

select extract('day' from current_timestamp);

select to_char(current_timestamp, 'day');

select make_date(2024, 6, 3);

select sales_month
, sales
from retail_sales rs 
where kind_of_business = 'Retail and food services sales, total'
order by 1;

select date_part('year', sales_month)::text  as sales_year
, sum(sales) as sales
from retail_sales rs 
where kind_of_business = 'Retail and food services sales, total'
group by 1
order by 1;


select date_part('year', sales_month)::text as sales_year
, kind_of_business
, sum(sales) as sales
from retail_sales rs
where kind_of_business in ('Book stores'
, 'Sporting goods stores', 'Hobby, toy, and game stores')
group by 1, 2
order by 1, 2;

select date_part('year', sales_month)::text as sales_year
, sum(case when kind_of_business = 'Women''s clothing stores'
		then sales
		end) as womens_sales
, sum(case when kind_of_business = 'Men''s clothing stores'
		then sales
		end) as mens_sales
from retail_sales rs 
where kind_of_business in ('Men''s clothing stores'
, 'Women''s clothing stores')
group by 1
order by 1 desc;



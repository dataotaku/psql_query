-- 구간비교
select kind_of_business, sales_month, sales
,lag(sales_month) over (partition by kind_of_business
	order by sales_month) as prev_month
,lag(sales) over (partition by kind_of_business
	order by sales_month) as prev_month_sales
from retail_sales 
where kind_of_business = 'Book stores'
;

-- 이전 값대비 비율 변화
select kind_of_business, sales_month, sales
,round((sales / lag(sales) over (partition by kind_of_business
							order by sales_month)
 - 1) * 100,2) as pct_growth_from_previous
from retail_sales 
where kind_of_business = 'Book stores'
;

-- 연도별 매출 집계
select date_part('year', sales_month) as sales_year
,sum(sales) as yearly_sales
from retail_sales 
where kind_of_business = 'Book stores'
group by 1
;

-- YoY
select sales_year, yearly_sales
,lag(yearly_sales) over (order by sales_year) as prev_year_sales
,(yearly_sales / lag(yearly_sales) over (order by sales_year)
  - 1) * 100 as pct_growth_from_previous_year
from 
(
	select date_part('year', sales_month) as sales_year
	,sum(sales) as yearly_sales
	from retail_sales 
	where kind_of_business = 'Book stores'
	group by 1
) a 
;

-- 전년 동월 대비 비교
select sales_month
,date_part('month', sales_month)
from retail_sales 
where kind_of_business = 'Book stores'
;

select sales_month, sales
,lag(sales_month) over (partition by date_part('month', sales_month)
						order by sales_month) as prev_year_month
,lag(sales) over (partition by date_part('month', sales_month)
						order by sales_month) as prev_year_sales
from retail_sales 
where kind_of_business = 'Book stores'
;

select sales_month, sales
,sales - lag(sales) over (partition by date_part('month', sales_month)
							order by sales_month) as absolute_diff
,(sales / lag(sales) over (partition by date_part('month', sales_month)
							order by sales_month)
  - 1) * 100 as pct_diff
from retail_sales 
where kind_of_business = 'Book stores'
;

-- 집계함수를 활용한 피벗
select date_part('Month', sales_month) as month_number
,to_char(sales_month, 'Month') as month_name
,max(case when date_part('year', sales_month) = 1992 then sales end) as sales_1992
,max(case when date_part('year', sales_month) = 1993 then sales end) as sales_1993
,max(case when date_part('year', sales_month) = 1994 then sales end) as sales_1994
from retail_sales 
where kind_of_business = 'Book stores'
  and sales_month between '1992-01-01' and '1994-12-01'
group by 1, 2
;

-- 다중구간 비교
select sales_month, sales
,lag(sales, 1) over (partition by date_part('month', sales_month)
						order by sales_month) as prev_sales_1
,lag(sales, 2) over (partition by date_part('month', sales_month)
						order by sales_month) as prev_sales_2
,lag(sales, 3) over (partition by date_part('month', sales_month)
						order by sales_month) as prev_sales_3
from retail_sales 
where kind_of_business = 'Book stores'
;

select sales_month,sales
, sales / ((prev_sales_1 + prev_sales_2 + prev_sales_3) / 3)*100 as pct_of_3_prev
from
(
select sales_month, sales
,lag(sales, 1) over (partition by date_part('month', sales_month)
						order by sales_month) as prev_sales_1
,lag(sales, 2) over (partition by date_part('month', sales_month)
						order by sales_month) as prev_sales_2
,lag(sales, 3) over (partition by date_part('month', sales_month)
						order by sales_month) as prev_sales_3
from retail_sales 
where kind_of_business = 'Book stores'
) a 
;

-- frame절 활용
select sales_month, sales
,sales / avg(sales) over (partition by date_part('month', sales_month)
							order by sales_month
							rows between 3 preceding and 1 preceding
							) * 100 as pct_of_prev_3
from retail_sales 
where kind_of_business = 'Book stores'
;


select date('2024-06-30') - date('2024-05-31') as days;

select age(date('2024-06-30'), date('2024-01-01')); --인터벌 자료형의 반환

-- 인터벌 자료 내의 숫자는 date_part 함수로 추출 필요
select date_part('day', age(date('2024-06-30'), date('2024-01-01')));
select date_part('month', age(date('2024-06-30'), date('2024-01-01')));

-- 시간 계산 (겹따옴표는 가능하나, 홑따옴표는 안됨.)
select time '05:00' + interval '2 hours' as new_time;

select a.sales_month, a.kind_of_business, a.sales
, sum(b.sales) as total_sales
from retail_sales a
join retail_sales b on a.sales_month = b.sales_month 
and b.kind_of_business in ('Men''s clothing stores'
, 'Women''s clothing stores')
where a.kind_of_business in ('Men''s clothing stores'
, 'Women''s clothing stores')
group by 1,2,3;

-- 셀프 조인 함수의 이용
select sales_month
, kind_of_business
,sales * 100 / total_sales as pct_total_sales
from (
	select a.sales_month, a.kind_of_business, a.sales
	, sum(b.sales) as total_sales
	from retail_sales a
	join retail_sales b on a.sales_month = b.sales_month 
	and b.kind_of_business in ('Men''s clothing stores'
	, 'Women''s clothing stores')
	where a.kind_of_business in ('Men''s clothing stores'
	, 'Women''s clothing stores')
	group by 1,2,3
) aa
order by 1,2
;

-- partition BY 절의 이용
select sales_month, kind_of_business, sales
, sum(sales) over (partition by sales_month) as total_sales
, sales * 100 / sum(sales) over (partition by sales_month) as pct_total
from retail_sales rs 
where kind_of_business in ('Men''s clothing stores'
, 'Women''s clothing stores')
order by 1,2
;

-- 업종별 연 매출 대비 월간매출 비율
select sales_month
, kind_of_business
,sales * 100 / yearly_sales as pct_yearly
from (
	select a.sales_month, a.kind_of_business, a.sales
	, sum(b.sales) as yearly_sales
	from retail_sales a
	join retail_sales b on 
	date_part('year', a.sales_month) = date_part('year', b.sales_month)  
	and a.sales_month = b.sales_month 
	and b.kind_of_business in ('Men''s clothing stores'
	, 'Women''s clothing stores')
	where a.kind_of_business in ('Men''s clothing stores'
	, 'Women''s clothing stores')
	group by 1,2,3
) aa
order by 1,2
;

select sales_month, kind_of_business, sales
, sum(sales) over (partition by date_part('year', sales_month)
								,kind_of_business) as yearly_sales
, sales * 100 /
  sum(sales) over (partition by date_part('year', sales_month)
  , kind_of_business) as pct_yearly
from retail_sales rs 
where kind_of_business in ('Men''s clothing stores'
, 'Women''s clothing stores')
order by 1,2
;

--인덱싱을 시계열 변화 이해하기
select date_part('year', sales_month) as sales_year
, sum(sales) as sales
from retail_sales rs 
where kind_of_business = 'Women''s clothing stores'
group by 1
;

select sales_year, sales
, first_value(sales) over (order by sales_year desc) as index_sales
from 
(
	select date_part('year', sales_month) as sales_year
	, sum(sales) as sales
	from retail_sales rs 
	where kind_of_business = 'Women''s clothing stores'
	group by 1
) a
;

-- 셀프 조인 활용 사례
-- 1)
select min(date_part('year',sales_month)) as first_year
from retail_sales rs 
where kind_of_business = 'Women''s clothing stores'
;

--2)
select first_year, sum(a.sales) as index_sales
from retail_sales a
join
(
	select min(date_part('year',sales_month)) as first_year
	from retail_sales rs 
	where kind_of_business = 'Women''s clothing stores'
) b on date_part('year', a.sales_month) = b.first_year
where a.kind_of_business = 'Women''s clothing stores'
group by 1
;

--3)
select date_part('year', aa.sales_month) as sales_year
, bb.index_sales
, sum(aa.sales) as sales
from retail_sales aa
join
(
	select first_year, sum(a.sales) as index_sales
from retail_sales a
join
(
	select min(date_part('year',sales_month)) as first_year
	from retail_sales rs 
	where kind_of_business = 'Women''s clothing stores'
	) b on date_part('year', a.sales_month) = b.first_year
	where a.kind_of_business = 'Women''s clothing stores'
	group by 1
) bb on 1=1
where aa.kind_of_business = 'Women''s clothing stores'
group by 1,2
;

--4)
select sales_year, sales
,(sales / index_sales -1) * 100 as pct_from_index
from
(
	select date_part('year', aa.sales_month) as sales_year
	, bb.index_sales
	, sum(aa.sales) as sales
	from retail_sales aa
	join
	(
		select first_year, sum(a.sales) as index_sales
	from retail_sales a
	join
	(
		select min(date_part('year',sales_month)) as first_year
		from retail_sales rs 
		where kind_of_business = 'Women''s clothing stores'
		) b on date_part('year', a.sales_month) = b.first_year
		where a.kind_of_business = 'Women''s clothing stores'
		group by 1
	) bb on 1=1
	where aa.kind_of_business = 'Women''s clothing stores'
	group by 1,2
) aaa
order by 1
;

select sales_year, kind_of_business, sales
,(sales / first_value(sales) over (partition by kind_of_business
	order by sales_year) -1) * 100 as pct_from_index
from 
(
	select date_part('year', sales_month) as sales_year
	, kind_of_business
	,sum(sales) as sales
	from retail_sales rs 
	where kind_of_business in ('Men''s clothing stores'
	, 'Women''s clothing stores')
	and sales_month <= '2019-12-31'
	group by 1,2
) a
order by 1,2
;

-- 시간 윈도우 롤링 계산
select a.sales_month
, a.sales
, b.sales_month as rolling_sales_month
, b.sales as rolling_sales
from retail_sales a
join retail_sales b on
	a.kind_of_business = b.kind_of_business 
and b.sales_month between a.sales_month - interval '11 months'
	and a.sales_month
and b.kind_of_business = 'Women''s clothing stores'
where a.kind_of_business = 'Women''s clothing stores'
and a.sales_month = '2019-12-01'
;

select a.sales_month
,a.sales
,avg(b.sales) as moving_avg
,count(b.sales) as records_count
from retail_sales a
join retail_sales b 
on a.kind_of_business = b.kind_of_business 
 and b.sales_month between a.sales_month - interval '11 months'
 	and a.sales_month
 and b.kind_of_business = 'Women''s clothing stores'
where a.kind_of_business = 'Women''s clothing stores'
 and a.sales_month >= '1993-01-01'
group by 1,2
order by 1
;

-- 파티션 바이 절과 윈도우 프레임절을 활용한 샘플코드
select sales_month
,avg(sales) over (order by sales_month
	rows between 11 preceding and current row
	) as moving_avg
,count(sales) over (order by sales_month
	rows between 11 preceding and current row
	) as records_count
from retail_sales 
where kind_of_business = 'Women''s clothing stores'
;

select * 
from date_dim 
order by date desc limit 100;

-- 희소(sparse)데이터 처리 관련
select a.date, b.sales_month, b.sales
from date_dim a
join
(
	select sales_month, sales
	from retail_sales 
	where kind_of_business = 'Women''s clothing stores'
	  and date_part('month', sales_month) in (1, 7)
) b on b.sales_month between a.date - interval '11 months' and a.date
where a.date = a.first_day_of_month 
  and a.date between '1993-01-01' and '2020-12-01'
order by 1,2
;



-- avg집계함수를 활용한 이동 평균
select a.date
,avg(b.sales) as moving_avg
,count(b.sales) as records
,max(case when a.date = b.sales_month then b.sales end) as sales_in_month
from date_dim a
join
(
	select sales_month, sales
	from retail_sales 
	where kind_of_business = 'Women''s clothing stores'
	  and date_part('month', sales_month) in (1, 7)
) b on b.sales_month between a.date - interval '11 months' and a.date
where a.date = a.first_day_of_month 
  and a.date between '1993-01-01' and '2020-12-01'
group by 1
order by 1
;

-- 누적값 계산
select sales_month, sales
,sum(sales) over (partition by date_part('year', sales_month)
	order by sales_month
	) as sales_ytd
from retail_sales 
where kind_of_business = 'Women''s clothing stores'
;

-- 누적값 계산 : 셀프조인
select a.sales_month, a.sales
,sum(b.sales) as sales_ytd
from retail_sales a
join retail_sales b on
  date_part('year', a.sales_month) = date_part('year', b.sales_month)
  and b.sales_month <= a.sales_month
  and b.kind_of_business = 'Women''s clothing stores'
where a.kind_of_business = 'Women''s clothing stores'
group by 1, 2
;


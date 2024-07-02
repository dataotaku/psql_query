select id_bioguide
,min(term_start) as first_term
from legislators_terms 
group by 1
;

-- 각 구간마다 재임중인 의원의 수
select date_part('year', age(b.term_start, a.first_term)) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
	select id_bioguide
	,min(term_start) as first_term
	from legislators_terms 
	group by 1
)a
join legislators_terms b 
 on a.id_bioguide = b.id_bioguide
group by 1
;

-- 구간별 재임중인 의원의 비율
select period
,first_value(cohort_retained) over (order by period) as cohort_size
,cohort_retained
, cohort_retained * 1.0 /
 first_value(cohort_retained) over (order by period) as pct_retained
from 
(
select date_part('year', age(b.term_start, a.first_term)) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
	select id_bioguide
	,min(term_start) as first_term
	from legislators_terms 
	group by 1
)a
join legislators_terms b 
 on a.id_bioguide = b.id_bioguide
group by 1
) aa
;

select cohort_size
, max(case when period=0 then pct_retained end) as yr0
, max(case when period=1 then pct_retained end) as yr1
, max(case when period=2 then pct_retained end) as yr2
, max(case when period=3 then pct_retained end) as yr3
, max(case when period=4 then pct_retained end) as yr4
from
(
select period
,first_value(cohort_retained) over (order by period) as cohort_size
,cohort_retained
, cohort_retained * 1.0 /
 first_value(cohort_retained) over (order by period) as pct_retained
from 
(
select date_part('year', age(b.term_start, a.first_term)) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
	select id_bioguide
	,min(term_start) as first_term
	from legislators_terms 
	group by 1
)a
join legislators_terms b 
 on a.id_bioguide = b.id_bioguide
group by 1
) aa
) aaa
group by 1
;

select * 
from date_dim 
limit 5
;
select id_bioguide, min(term_start) as first_term
from legislators_terms 
group by 1
;
select a.id_bioguide, a.first_term
,b.term_start, b.term_end
,c.date
,date_part('year', age(c.date, a.first_term)) as period
from
(
select id_bioguide, min(term_start) as first_term
from legislators_terms 
group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide
left join date_dim  c on c.date between b.term_start and b.term_end
  and c.month_name = 'December' and c.day_of_month = 31
;
select generate_series::date as date
from generate_series('2010-12-31'::date, '2024-12-31'::date, interval '1 year')
limit 10
;
select distinct make_date(date_part('year', term_start)::int, 12,31) as date
from legislators_terms
order by 1 desc
;
select 
coalesce (date_part('year', age(c.date, a.first_term)),0) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
select id_bioguide, min(term_start) as first_term
from legislators_terms 
group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide 
left join date_dim c on c.date between b.term_start and b.term_end 
  and c.month_name = 'December' and c.day_of_month = 31
group by 1
;
select period 
,first_value (cohort_retained) over (order by period) as cohort_size
,cohort_retained
,cohort_retained * 1.0/
first_value (cohort_retained) over (order by period) as pct_retained
from 
(
select 
coalesce (date_part('year', age(c.date, a.first_term)),0) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
select id_bioguide, min(term_start) as first_term
from legislators_terms 
group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide 
left join date_dim c on c.date between b.term_start and b.term_end 
  and c.month_name = 'December' and c.day_of_month = 31
group by 1
) aa 
;
select 
date_part('year', a.first_term) as first_year 
,coalesce (date_part('year', age(c.date, a.first_term)),0) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
select id_bioguide, min(term_start) as first_term
from legislators_terms 
group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide 
left join date_dim c on c.date between b.term_start and b.term_end 
  and c.month_name = 'December' and c.day_of_month = 31
group by 1,2
;
select first_year
,period
,first_value (cohort_retained) over (partition by first_year
order by period) as cohort_size
,cohort_retained
,cohort_retained * 1.0 /
first_value (cohort_retained) over (partition by first_year 
order by period) as pct_retained
from 
(
select 
date_part('year', a.first_term) as first_year 
,coalesce (date_part('year', age(c.date, a.first_term)),0) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
select id_bioguide, min(term_start) as first_term
from legislators_terms 
group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide 
left join date_dim c on c.date between b.term_start and b.term_end 
  and c.month_name = 'December' and c.day_of_month = 31
group by 1,2
) aa 
;

-- century 인터벌 기준
select first_century
,period
,first_value (cohort_retained) over (partition by first_century
order by period) as cohort_size
,cohort_retained
,cohort_retained * 1.0 /
first_value (cohort_retained) over (partition by first_century
order by period) as pct_retained
from 
(
select 
date_part('century', a.first_term) as first_century 
,coalesce (date_part('year', age(c.date, a.first_term)),0) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
select id_bioguide, min(term_start) as first_term
from legislators_terms 
group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide 
left join date_dim c on c.date between b.term_start and b.term_end 
  and c.month_name = 'December' and c.day_of_month = 31
group by 1,2
) aa 
order by 1,2
;
select distinct id_bioguide
,min(term_start) over (partition by id_bioguide) as first_term
,first_value (state) over (partition by id_bioguide
order by term_start) as first_state
from legislators_terms 
;
select first_state
,period
,first_value (cohort_retained) over (partition by first_state
order by period) as cohort_size
,cohort_retained
,cohort_retained * 1.0 /
first_value (cohort_retained) over (partition by first_state
order by period) as pct_retained
from 
(
select 
a.first_state 
,coalesce (date_part('year', age(c.date, a.first_term)),0) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
select distinct id_bioguide
,min(term_start) over (partition by id_bioguide) as first_term
,first_value (state) over (partition by id_bioguide
order by term_start) as first_state
from legislators_terms 
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide 
left join date_dim c on c.date between b.term_start and b.term_end 
  and c.month_name = 'December' and c.day_of_month = 31
group by 1,2
) aa 
order by 1,2
;
-- 의원의 성별 리텐션 차이 여부 분석
select d.gender
,coalesce (date_part('year', age(c.date, a.first_term)), 0) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide
left join date_dim c on c.date between b.term_start and b.term_end
  and c.month_name = 'December' and c.day_of_month = 31
join legislators d on a.id_bioguide = d.id_bioguide
group by 1, 2
order by 2,1
;

select gender
,period 
,first_value (cohort_retained) over (partition by gender 
order by period) as cohort_size
,cohort_retained
,cohort_retained * 1.0 /
first_value(cohort_retained) over (partition by gender 
order by period) as pct_retained
from 
(
select d.gender
,coalesce (date_part('year', age(c.date, a.first_term)), 0) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide
left join date_dim c on c.date between b.term_start and b.term_end
  and c.month_name = 'December' and c.day_of_month = 31
join legislators d on a.id_bioguide = d.id_bioguide
group by 1, 2
) aa 
order by 2,1
;

select gender
,period 
,first_value (cohort_retained) over (partition by gender 
order by period) as cohort_size
,cohort_retained
,cohort_retained * 1.0 /
first_value(cohort_retained) over (partition by gender 
order by period) as pct_retained
from 
(
select d.gender
,coalesce (date_part('year', age(c.date, a.first_term)), 0) as period
,count(distinct a.id_bioguide) as cohort_retained
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide
left join date_dim c on c.date between b.term_start and b.term_end
  and c.month_name = 'December' and c.day_of_month = 31
join legislators d on a.id_bioguide = d.id_bioguide
where a.first_term between '1917-01-01' and '1999-12-31'
group by 1, 2
) aa 
order by 2,1
;
-- 다중 속성 코호트 분석
select first_state, gender, period 
,first_value (cohort_retained) over (partition by first_state, gender 
order by period) as cohort_size
,cohort_retained
,cohort_retained * 1.0 /
first_value(cohort_retained) over (partition by first_state, gender
order by period) as pct_retained
from 
(
	select a.first_state, d.gender
	,coalesce (date_part('year', age(c.date, a.first_term)), 0) as period
	,count(distinct a.id_bioguide) as cohort_retained
	from 
	(
		select distinct id_bioguide
		,min(term_start) over (partition by id_bioguide) as first_term
		,first_value(state) over (partition by id_bioguide
		order by term_start) as first_state
		from legislators_terms 
	) a 
	join legislators_terms b on a.id_bioguide = b.id_bioguide
	left join date_dim c on c.date between b.term_start and b.term_end
	  and c.month_name = 'December' and c.day_of_month = 31
	join legislators d on a.id_bioguide = d.id_bioguide
	where a.first_term between '1917-01-01' and '1999-12-31'
	group by 1,2,3
) aa
;

-- 두 서브쿼리가 동일한 필드를 갖지않는 경우
select aa.gender, aa.first_state, cc.period, aa.cohort_size
from
(
	select b.gender, a.first_state
	,count(distinct a.id_bioguide) as cohort_size
	from
	(
		select distinct id_bioguide
		,min(term_start) over (partition by id_bioguide) as first_term
		,first_value(state) over (partition by id_bioguide
		order by term_start) as first_state
		from legislators_terms 
	) a 
	join legislators b on a.id_bioguide = b.id_bioguide
	where a.first_term between '1917-01-01' and '1999-12-31'
	group by 1, 2
) aa 
join 
(
	select generate_series as period
	from generate_series(0, 20, 1)
) cc on 1=1
order by 1,2,3
;
-- 코호트의 멤버가 없는 경우에도 0이 생성되도록 함.
select aaa.gender, aaa.first_state, aaa.period, aaa.cohort_size
,coalesce(ddd.cohort_retained, 0) as cohort_retained
,coalesce (ddd.cohort_retained, 0) * 1.0 / aaa.cohort_size as pct_retained
from 
(
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
) aaa
left join 
(
	select d.first_state, g.gender
	,coalesce (date_part('year', age(f.date, d.first_term)),0) as period
	,count(distinct d.id_bioguide) as cohort_retained
	from
	(
		select distinct id_bioguide
		,min(term_start) over (partition by id_bioguide) as first_term
		,first_value(state) over (partition by id_bioguide
		order by term_start) as first_state
		from legislators_terms 
	) d 
	join legislators_terms e on d.id_bioguide = e.id_bioguide
	left join date_dim f on f.date between e.term_start and e.term_end
	  and f.month_name = 'December' and f.day_of_month = 31
	join legislators g on d.id_bioguide = g.id_bioguide
	where d.first_term between '1917-01-01' and '1999-12-31'
	group by 1,2,3
) ddd on aaa.gender = ddd.gender and aaa.first_state = ddd.first_state
and aaa.period = ddd.period
order by 1,2,3
;

-- 결과를 피벗해 보는 코드
select gender, first_state, cohort_size
,max(case when period=0 then pct_retained end) as yr0
,max(case when period=2 then pct_retained end) as yr2
,max(case when period=4 then pct_retained end) as yr4
,max(case when period=6 then pct_retained end) as yr6
,max(case when period=8 then pct_retained end) as yr8
,max(case when period=10 then pct_retained end) as yr10
from
(
select aaa.gender, aaa.first_state, aaa.period, aaa.cohort_size
,coalesce(ddd.cohort_retained, 0) as cohort_retained
,coalesce (ddd.cohort_retained, 0) * 1.0 / aaa.cohort_size as pct_retained
from 
(
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
) aaa
left join 
(
	select d.first_state, g.gender
	,coalesce (date_part('year', age(f.date, d.first_term)),0) as period
	,count(distinct d.id_bioguide) as cohort_retained
	from
	(
		select distinct id_bioguide
		,min(term_start) over (partition by id_bioguide) as first_term
		,first_value(state) over (partition by id_bioguide
		order by term_start) as first_state
		from legislators_terms 
	) d 
	join legislators_terms e on d.id_bioguide = e.id_bioguide
	left join date_dim f on f.date between e.term_start and e.term_end
	  and f.month_name = 'December' and f.day_of_month = 31
	join legislators g on d.id_bioguide = g.id_bioguide
	where d.first_term between '1917-01-01' and '1999-12-31'
	group by 1,2,3
) ddd on aaa.gender = ddd.gender and aaa.first_state = ddd.first_state
and aaa.period = ddd.period
) a 
group by 1,2,3
;

-- 2000년에 재임중이던 의원의 리텐션
select distinct id_bioguide,term_type, date('2000-01-01') as first_term
,min(term_start) as min_start
from legislators_terms 
where term_start <= '2000-12-31' and term_end >= '2000-01-01'
group by 1,2,3
;

-- min_start이후의 임기만 반환, 2000년 이후의 데이터만 반환
select term_type, period 
,first_value (cohort_retained) over (partition by term_type
order by period) as cohort_size
,cohort_retained
,cohort_retained * 1.0 /
first_value (cohort_retained) over (partition by term_type
order by period) as pct_retained
from 
(
	select a.term_type
	,coalesce (date_part('year', age(c.date, a.first_term)), 0) as period
	,count(distinct a.id_bioguide) as cohort_retained
	from
	(
		select distinct id_bioguide,term_type, date('2000-01-01') as first_term
		,min(term_start) as min_start
		from legislators_terms 
		where term_start <= '2000-12-31' and term_end >= '2000-01-01'
		group by 1,2,3		
	) a 
	join legislators_terms b on a.id_bioguide = b.id_bioguide
	  and b.term_start >= a.min_start
	left join date_dim c on c.date between b.term_start and b.term_end
	  and c.month_name = 'December' and c.day_of_month = 31
	  and c.year >= 2000
	group by 1, 2
) aa
order by 2, 1
;

-- 생존자 분석
select id_bioguide
,min(term_start) as first_term
,max(term_start) as last_term
from legislators_terms 
group by 1
;

select id_bioguide
,date_part('century', min(term_start)) as first_century
,min(term_start) as first_term
,max(term_start) as last_term
,date_part('year', age(max(term_start),min(term_start))) as tenure
from legislators_terms 
group by 1
order by tenure desc
;

-- 시작일로부터 10년뒤에도 재임한 의원수
select first_century
,count(distinct id_bioguide) as coort_size
,count(distinct case when tenure >= 10 then id_bioguide end) as survived_10
,count(distinct case when tenure >= 10 then id_bioguide end) * 1.0 /
count(distinct id_bioguide) as pct_survived_10
from
(
select id_bioguide
,date_part('century', min(term_start)) as first_century
,min(term_start) as first_term
,max(term_start) as last_term
,date_part('year', age(max(term_start),min(term_start))) as tenure
from legislators_terms 
group by 1
) a 
group by 1
;

select a.first_century, b.terms
,count(distinct id_bioguide) as cohort
,count(distinct case when a.total_terms >= b.terms then id_bioguide end) 
as cohort_survived
,count(distinct case when a.total_terms >= b.terms then id_bioguide end) * 1.0 /
count(distinct id_bioguide) as pct_survived
from
(
select id_bioguide
,date_part('century', min(term_start)) as first_century
,count(term_start) as total_terms
from legislators_terms 
group by 1
) a
join 
(
	select generate_series as terms
	from generate_series(1, 20, 1)
) b on 1=1
group by 1, 2
;

-- 리턴십 분석
-- 세기별 임기를 시작한 하원의원수
select date_part('century', a.first_term) as cohort_century
,count(id_bioguide) as reps
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	where term_type = 'rep'
	group by 1
) a 
group by 1
order by 1
;

select date_part('century', a.first_term) as cohort_century
,count(distinct a.id_bioguide) as rep_and_sen
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	where term_type = 'rep'
	group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide
  and b.term_type = 'sen' and b.term_start > a.first_term
group by 1
;

select aa.cohort_century
,bb.rep_and_sen * 1.0 / aa.reps as pct_rep_and_sen
from 
(
select date_part('century', a.first_term) as cohort_century
,count(id_bioguide) as reps
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	where term_type = 'rep'
	group by 1
) a 
group by 1
) aa 
left join 
(
select date_part('century', a.first_term) as cohort_century
,count(distinct a.id_bioguide) as rep_and_sen
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	where term_type = 'rep'
	group by 1
) a 
join legislators_terms b on a.id_bioguide = b.id_bioguide
  and b.term_type = 'sen' and b.term_start > a.first_term
group by 1
) bb on aa.cohort_century = bb.cohort_century
;

select aa.cohort_century
,bb.rep_and_sen * 1.0 / aa.reps as pct_rep_and_sen
from 
(
select date_part('century', a.first_term) as cohort_century
,count(id_bioguide) as reps
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	where term_type = 'rep'
	group by 1
) a 
where first_term <= '2009-12-31'
group by 1
) aa 
left join 
(
select date_part('century', b.first_term) as cohort_century
,count(distinct b.id_bioguide) as rep_and_sen
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	where term_type = 'rep'
	group by 1
) b 
join legislators_terms c on b.id_bioguide = c.id_bioguide
  and c.term_type = 'sen' and c.term_start > b.first_term
where age(c.term_start, b.first_term) <= interval '10 years'
group by 1
) bb on aa.cohort_century = bb.cohort_century
;

select aa.cohort_century
,bb.rep_and_sen_5_yrs * 1.0 / aa.reps as pct_5_yrs
,bb.rep_and_sen_10_yrs * 1.0 / aa.reps as pct_10_yrs
,bb.rep_and_sen_15_yrs * 1.0 / aa.reps as pct_15_yrs
from 
(
select date_part('century', a.first_term) as cohort_century
,count(id_bioguide) as reps
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	where term_type = 'rep'
	group by 1
) a 
where first_term <= '2009-12-31'
group by 1
) aa 
left join 
(
select date_part('century', b.first_term) as cohort_century
,count(distinct case when age(c.term_start, b.first_term)
<= interval '5 years' then b.id_bioguide end) as rep_and_sen_5_yrs
,count(distinct case when age(c.term_start, b.first_term)
<= interval '10 years' then b.id_bioguide end) as rep_and_sen_10_yrs
,count(distinct case when age(c.term_start, b.first_term)
<= interval '15 years' then b.id_bioguide end) as rep_and_sen_15_yrs
from
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	where term_type = 'rep'
	group by 1
) b 
join legislators_terms c on b.id_bioguide = c.id_bioguide
  and c.term_type = 'sen' and c.term_start > b.first_term
group by 1
) bb on aa.cohort_century = bb.cohort_century
;

-- 누적 계산
select date_part('century', a.first_term) as century
,first_type
,count(distinct a.id_bioguide) as cohort
,count(b.term_start) as terms
from
(
	select distinct id_bioguide
	,first_value(term_type) over (partition by id_bioguide
	order by term_start) as first_type
	,min(term_start) over (partition by id_bioguide) as first_term
	,min(term_start) over (partition by id_bioguide) + interval '10 years'
	as first_plus_10
	from legislators_terms 
) a 
left join legislators_terms b on a.id_bioguide = b.id_bioguide 
  and b.term_start between a.first_term and a.first_plus_10
group by 1, 2
;

select century
,max(case when first_type = 'rep' then cohort end) as rep_cohort
,max(case when first_type = 'rep' then terms_per_leg end) as avg_rep_terms
,max(case when first_type = 'sen' then cohort end) as sen_cohort
,max(case when first_type = 'sen' then terms_per_leg end) as avg_sen_terms
from 
(
	select date_part('century', a.first_term) as century
	,first_type
	,count(distinct a.id_bioguide) as cohort
	,count(b.term_start) as terms
	,count(b.term_start) * 1.0 /
	count(distinct a.id_bioguide) as terms_per_leg
	from
	(
		select distinct id_bioguide
		,first_value(term_type) over (partition by id_bioguide
		order by term_start) as first_type
		,min(term_start) over (partition by id_bioguide) as first_term
		,min(term_start) over (partition by id_bioguide) + interval '10 years'
		as first_plus_10
		from legislators_terms 
	) a 
	left join legislators_terms b on a.id_bioguide = b.id_bioguide 
	  and b.term_start between a.first_term and a.first_plus_10
	group by 1, 2
) aa 
group by 1
;
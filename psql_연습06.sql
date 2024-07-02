select b.date
,count(distinct id_bioguide) as legislators
from legislators_terms a
join date_dim b on b.date between a.term_start and a.term_end 
  and b.month_name = 'December' and b.day_of_month = 31
  and b.year <= 2019
group by 1
;

select b.date
,date_part('century', first_term) as century
,count(distinct a.id_bioguide) as legislators
from legislators_terms a
join date_dim b on b.date between a.term_start and a.term_end 
  and b.month_name = 'December' and b.day_of_month = 31
  and b.year <= 2019
join 
(
	select id_bioguide, min(term_start) as first_term
	from legislators_terms 
	group by 1
) c on a.id_bioguide = c.id_bioguide
group by 1, 2
;

select date 
,century
,legislators
,sum(legislators) over (partition by date) as cohort
,legislators * 1.0 / sum(legislators) over (partition by date) as pct_century
from 
(
	select b.date
	,date_part('century', first_term) as century
	,count(distinct a.id_bioguide) as legislators
	from legislators_terms a
	join date_dim b on b.date between a.term_start and a.term_end
	  and b.month_name = 'December' and b.day_of_month = 31
	  and b.year <= 2019
	join 
	(
		select id_bioguide, min(term_start) as first_term
		from legislators_terms 
		group by 1
	) c on a.id_bioguide = c.id_bioguide
	group by 1, 2
) a
order by date desc
;

select date 
,coalesce(sum(case when century = 18 then legislators end)
				/ sum(legislators), 0) as pct_18
,coalesce(sum(case when century = 19 then legislators end)
				/ sum(legislators), 0) as pct_19
,coalesce(sum(case when century = 20 then legislators end)
				/ sum(legislators), 0) as pct_20
,coalesce(sum(case when century = 21 then legislators end)
				/ sum(legislators), 0) as pct_21
from 
(
	select b.date
	,date_part('century', first_term) as century
	,count(distinct a.id_bioguide) as legislators
	from legislators_terms a
	join date_dim b on b.date between a.term_start and a.term_end
	  and b.month_name = 'December' and b.day_of_month = 31
	  and b.year <= 2019
	join 
	(
		select id_bioguide, min(term_start) as first_term
		from legislators_terms 
		group by 1
	) c on a.id_bioguide = c.id_bioguide
	group by 1, 2	
) aa 
group by 1
order by date desc
;

select id_bioguide, date 
,count(date) over (partition by id_bioguide
order by date rows between unbounded preceding
and current row) as cume_years
from 
(
	select distinct a.id_bioguide, b.date
	from legislators_terms a
	join date_dim b on b.date between a.term_start and a.term_end
	  and b.month_name = 'December' and b.day_of_month = 31
	  and b.year <= 2019
) aa
order by cume_years desc
;

-- 누적 재임연수 분포
select date 
,cume_years
,count(distinct id_bioguide) as legislators
from 
(
	select id_bioguide, date 
,count(date) over (partition by id_bioguide
order by date rows between unbounded preceding
and current row) as cume_years
from 
(
	select distinct a.id_bioguide, b.date
	from legislators_terms a
	join date_dim b on b.date between a.term_start and a.term_end
	  and b.month_name = 'December' and b.day_of_month = 31
	  and b.year <= 2019
	group by 1, 2
) aa	
) aaa
group by 1, 2
;

select date 
,count(*) as tenures
from
(
select date 
,cume_years
,count(distinct id_bioguide) as legislators
from 
(
	select id_bioguide, date 
,count(date) over (partition by id_bioguide
order by date rows between unbounded preceding
and current row) as cume_years
from 
(
	select distinct a.id_bioguide, b.date
	from legislators_terms a
	join date_dim b on b.date between a.term_start and a.term_end
	  and b.month_name = 'December' and b.day_of_month = 31
	  and b.year <= 2019
	group by 1, 2
) aa	
) aaa
group by 1, 2
) aaaa
group by 1
order by 1
;

select date 
,tenure
,legislators / sum(legislators) over (partition by date) as pct_legislators
from 
(
	select date 
	,case when cume_years <= 4 then '1 to 4'
			when cume_years <= 10 then '5 to 10'
			when cume_years <= 20 then '11 to 20'
			else '21+' end as tenure
	,count(distinct id_bioguide) as legislators
	from
	(
		select id_bioguide, date 
		,count(date) over (partition by id_bioguide
		order by date rows between unbounded preceding
		and current row) as cume_years
		from 
		(
			select distinct a.id_bioguide, b.date
			from legislators_terms a
			join date_dim b on b.date between a.term_start and a.term_end
			  and b.month_name = 'December' and b.day_of_month = 31
			  and b.year <= 2019
			group by 1, 2
		) a
	) aa
	group by 1,2
) aaa
order by date desc
;
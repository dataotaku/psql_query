select *
from videogame_sales 
limit 10
;

-- 플랫폼, 장르, 배급사별 global_sales 합계를 (세가지 필드로
-- 조합된 그룹이 아니라, 필드마다 따로 계산하되, 
-- 단 한번의 쿼리로 모든 결과를 확인해 봅니다.

(
select platform
,null as genre
,null as publisher
,sum(global_sales) as global_sales
from videogame_sales 
group by 1,2,3
	union 
select null as platform
,genre
,null as publisher
,sum(global_sales) as global_sales
from videogame_sales 
group by 1,2,3
	union 
select null as platform
,null as genre
,publisher
,sum(global_sales) as global_sales
from videogame_sales 
group by 1,2,3
)
order by 1,2,3
;

select platform, genre, publisher
,sum(global_sales) as global_sales
from videogame_sales 
group by grouping sets (platform, genre, publisher)
order by 1,2,3
;

select coalesce (platform, 'All') as platform
,coalesce (genre, 'All') as genre
,coalesce (publisher, 'All') as publisher
,sum(global_sales) as global_sales
from videogame_sales 
group by grouping sets ((), platform, genre, publisher)
order by 1,2,3
;

select coalesce (platform, 'All') as platform
,coalesce (genre, 'All') as genre
,coalesce (publisher, 'All') as publisher
,sum(global_sales) as global_sales
from videogame_sales 
group by cube (platform, genre, publisher)
order by 1,2,3
;

select coalesce (platform, 'All') as platform
,coalesce (genre, 'All') as genre
,coalesce (publisher, 'All') as publisher
,sum(global_sales) as global_sales
from videogame_sales 
group by rollup (platform, genre, publisher)
order by 1,2,3
;

select 
case when state in ('CA', 'TX', 'FL', 'NY', 'PA') then state
     else 'Other' end as state_group
,count(*) as terms
from legislators_terms 
group by 1
order by 2 desc 
;

select 
case when b.rank <= 5 then a.state
	 else 'Other' end as state_group
,count(distinct id_bioguide) as legislators
from legislators_terms a
join
(
	select state 
	,count(distinct id_bioguide)
	,rank() over (order by count(distinct id_bioguide) desc)
	from legislators_terms 
	group by 1
) b on a.state = b.state
group by 1
order by 2 desc
;

select state 
,count(distinct id_bioguide)
,rank() over (order by count(distinct id_bioguide) desc)
from legislators_terms 
group by 1
;

select 
case when terms >= 2 then true else false end as two_terms_flag
,count(*) as legislators
from
(
	select id_bioguide
	,count(term_id) as terms
	from legislators_terms 
	group by 1
) a 
group by 1
;

select 
case when terms >= 10 then '10+'
	 when terms >= 2 then '2 - 9'
	 else '1' end as terms_level
,count(*) as legislators
from
(
	select id_bioguide
	,count(term_id) as terms
	from legislators_terms 
	group by 1
) a 
group by 1
;


select avg(gap_interval) as avg_gap
from
(
	select id_bioguide, term_start
	,lag(term_start) over (partition by id_bioguide 
	 					   order by term_start) as prev
	,age(term_start,
		 lag(term_start) over (partition by id_bioguide
		 					   order by term_start)) as gap_interval
	from legislators_terms 
	where term_type = 'rep'
) a 
where gap_interval is not null 
;

select gap_months, count(*) as instances
from
(
	select id_bioguide, term_start
	,lag(term_start) over (partition by id_bioguide
						   order by term_start) as prev
	,age(term_start,
		 lag(term_start) over (partition by id_bioguide
		 					   order by term_start)
		 ) as gap_interval
	,date_part('year',
				age(term_start,
					lag(term_start) over (partition by id_bioguide
						order by term_start))
				) * 12 
	 +
	 date_part('month',
	 			age(term_start, 
	 				lag(term_start) over (partition by id_bioguide
	 					order by term_start))
	 			) as gap_months
	from legislators_terms 
	where term_type = 'rep'
) a 
group by 1
order by 2 desc
;

select id_bioguide, term_start
,lag(term_start) over (partition by id_bioguide 
 					   order by term_start) as prev
,age(term_start,
	 lag(term_start) over (partition by id_bioguide
	 					   order by term_start)) as gap_interval
from legislators_terms 
where term_type = 'rep'
;


CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE step_one (
    user_id INT PRIMARY KEY,
    step_one_completed BOOLEAN
);

CREATE TABLE step_two (
    user_id INT PRIMARY KEY,
    step_two_completed BOOLEAN
);

-- 사용자 데이터 삽입
INSERT INTO users (user_id, name) VALUES
(1, 'User A'),
(2, 'User B'),
(3, 'User C'),
(4, 'User D'),
(5, 'User E');

-- 첫 번째 단계를 완료한 사용자 데이터 삽입
INSERT INTO step_one (user_id, step_one_completed) VALUES
(1, TRUE),
(2, TRUE),
(3, TRUE);

-- 두 번째 단계를 완료한 사용자 데이터 삽입
INSERT INTO step_two (user_id, step_two_completed) VALUES
(1, TRUE),
(2, TRUE);

SELECT count(a.user_id) as all_users
,count(b.user_id) as step_one_users
,count(b.user_id) / count(a.user_id) as pct_step_one
,count(c.user_id) as step_two_users
,count(c.user_id) / count(b.user_id) as pct_one_to_two
FROM users a
LEFT JOIN step_one b on a.user_id = b.user_id
LEFT JOIN step_two c on b.user_id = c.user_id
;
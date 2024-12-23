select *
from game_users 
limit 10
;

select *
from game_actions 
limit 10
;

select action, count(*)
from game_actions
group by "action"
;

select *
from game_purchases 
limit 10
;

select user_id, sum(amount::int)
from game_purchases 
group by user_id 
order by 2 desc
;

select *
from exp_assignment 
limit 10
;

select variant, exp_name, count(*)
from exp_assignment 
group by variant, exp_name 
;

select a.variant
,count(case when b.user_id is not null then a.user_id end) as completed
,count(case when b.user_id is null then a.user_id end) as not_completed
from exp_assignment a
left join game_actions b on a.user_id = b.user_id 
 and b.action = 'onboarding complete'
where a.exp_name = 'Onboarding'
group by 1
;

select a.variant
,count(a.user_id) as total_cohorted
,count(b.user_id) as completions
,count(b.user_id) * 1.0 / count(a.user_id) as pct_completed
from exp_assignment a
left join game_actions b on a.user_id = b.user_id 
 and b.action = 'onboarding complete'
where a.exp_name = 'Onboarding'
group by 1
;

-- 새로운 온보딩경험자가 기존보다 더 많은 금액을 소비하는가?
select variant
,count(user_id) as total_cohorted
,avg(amount) as mean_amount
,stddev(amount) as stddev_amount
from
(
	select a.variant
	,a.user_id
	,sum(coalesce(b.amount, 0)) as amount
	from exp_assignment a
	left join game_purchases b on a.user_id = b.user_id
	where a.exp_name = 'Onboarding'
	group by 1, 2
) a 
group by 1
;

-- 더 많은 금액을 소비했는지?
select variant
,count(user_id) as total_cohorted
,avg(amount) as mean_amount
,stddev(amount) as stddev_amount
from
(
	select a.variant
	,a.user_id
	,sum(coalesce(b.amount,0)) as amount
	from exp_assignment a
	left join game_purchases b on a.user_id = b.user_id
	join game_actions c on a.user_id = c.user_id
	 and c.action = 'onboarding complete'
	where a.exp_name = 'Onboarding'
	group by 1, 2
) a 
group by 1
;

-- 대조군과 실험군의 구매 전환율 비교
select a.variant
,count(distinct a.user_id) as total_cohorted
,count(distinct b.user_id) as purchasers
,count(distinct b.user_id) * 1.0 / count(distinct a.user_id)
 as pct_purchased
from exp_assignment a
left join game_purchases b on a.user_id = b.user_id 
join game_actions c on a.user_id = c.user_id 
 and c.action = 'onboarding complete'
where a.exp_name = 'Onboarding'
group by 1
;

-- 시작 날짜 부터 일정한 범위의 시간 윈도우안에 액션을 완료했는지?
select variant
,count(user_id) as total_cohorted
,avg(amount) as mean_amount
,stddev(amount) as stddev_amount
from
(
	select a.variant
	,a.user_id
	,sum(coalesce(b.amount,0)) as amount
	from exp_assignment a
	left join game_purchases b on a.user_id = b.user_id
	 and b.purch_date <= a.exp_date + interval '7 days'
	where a.exp_name = 'Onboarding'
	group by 1, 2
) a 
group by 1
;

select 
case when a.created between '2020-01-13' and '2020-01-26' then 'pre'
 when a.created between '2020-01-27' and '2020-02-09' then 'post'
 end as variant
,count(distinct a.user_id) as cohorted
,count(distinct b.user_id) as opted_in
,count(distinct b.user_id) * 1.0 / count(distinct a.user_id) as pct_optin
,count(distinct a.created) as days
from game_users a
left join game_actions b on a.user_id = b.user_id 
 and b.action = 'email_optin'
where a.created between '2020-01-13' and '2020-02-09'
group by 1
order by 1 desc 
;

select a.country
,count(distinct a.user_id) as total_cohorted
,count(distinct b.user_id) as purchasers
,count(distinct b.user_id) * 1.0 / count(distinct a.user_id)
 as pct_purchased
from game_users a
left join game_purchases b on a.user_id = b.user_id
where a.country in ('United States', 'Canada')
group by 1
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

select coalesce (platform, 'All') as platform
,coalesce (genre, 'All') as genre
,coalesce (publisher, 'All') as publisher
,sum(global_sales) as global_sales
from videogame_sales 
group by cube (platform, genre, publisher)
order by 1,2,3
;


SELECT count(a.user_id) as all_users
,count(b.user_id) as step_one_users
,count(b.user_id) / count(a.user_id) as pct_step_one
,count(c.user_id) as step_two_users
,count(c.user_id) / count(b.user_id) as pct_one_to_two
FROM users a
LEFT JOIN step_one b on a.user_id = b.user_id
LEFT JOIN step_two c on b.user_id = c.user_id
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
select count(*)
from earthquakes 
;

select *
from earthquakes 
order by time desc
limit 100
;

select mag
from earthquakes
where mag is not null
order by 1 desc 
;

select mag
,count(id) as earthquakes
,round(count(id) * 100 / sum(count(id)) over (partition by 1), 8)
as pct_earthquakes
from earthquakes 
where mag is not null 
group by 1
order by 1 desc 
;

select mag
,count(id) as earthquakes
,round(count(id) * 100 / sum(count(id)) over (partition by 1), 8)
as pct_earthquakes
from earthquakes 
where mag is not null 
group by 1
order by 1 
;

select place
,mag
,count(*)
from earthquakes 
where mag is not null 
 and place = 'Northern California'
group by 1,2
order by 1,2 desc 
;

select place
,mag
,percentile 
,count(*)
from
(
	select place, mag
	,percent_rank() over (partition by place order by mag) as percentile 
	from earthquakes 
	where mag is not null 
	 and place = 'Northern California'
) a 
group by 1,2,3
order by 1,2 desc
;

select place
,mag
,percentile 
,count(*)
from
(
	select place, mag
	,percent_rank() over (partition by place order by mag) as percentile 
	from earthquakes 
	where mag is not null 
) a 
group by 1,2,3
order by 1,2 desc
;

select place, mag
,ntile(100) over (partition by place order by mag) as ntile 
from earthquakes 
where mag is not null 
 and place = 'Central Alaska'
order by 1,2 desc 
;

select place
,ntile 
,max(mag) as maximum
,min(mag) as minimum
from 
(
	select place, mag
	,ntile(4) over (partition by place order by mag) as ntile 
	from earthquakes 
	where mag is not null 
	 and place = 'Central Alaska'
) a 
group by 1,2
order by 1,2 desc
;

select date_trunc('year', time)::date as earthquake_year
,count(*) as earthquakes
from earthquakes 
group by 1
order by 1 desc 
;

select date_trunc('month', time)::date as earthquake_month
,count(*) as earthquakes
from earthquakes  
group by 1
order by 1
;


select  length(sighting_report), count(*) as records
from ufo
group by 1
order by 1
;

select left(sighting_report, 8) as left_digits
,count(*)
from ufo
group by 1
;

select right(left(sighting_report, 25), 14) as occured
from ufo 
;

select split_part(sighting_report, 'Occurred : ', 2) as split_1
from ufo
;

select split_part(sighting_report, ' (Entered', 1) as split_2
from ufo 
;

select split_part(
	split_part(sighting_report, ' (Entered', 1) 
, 'Occurred : ', 2) as occurred
from ufo 
;

select 
split_part(
	split_part(
		split_part(sighting_report, ' (Entered', 1)
		,'Occurred : ', 2)
	,'Reported',1
	) as occurred
,split_part(
	split_part(sighting_report, ')',1)
	,'Entered as : ', 2
) as entered_as 
,split_part(
	split_part(
		split_part(
			split_part(sighting_report, 'Post', 1) 
		,'Reported: ', 2)
	,' AM',1
	)
,'PM', 1
) as reported
,split_part(split_part(sighting_report,'Location',1), 'Posted: ',2) 
as posted
,split_part(split_part(sighting_report,'Shape',1),'Location: ',2)
as location
,split_part(split_part(sighting_report,'Duration',1),'Shape: ',2)
as shape
,split_part(sighting_report,'Duration:',2) as duration
from ufo
;

select distinct shape
,initcap(shape) as shape_clean
from 
(
	select split_part(
	  		split_part(sighting_report,'Duration',1)
	  		,'Shape: ',2
	  		) as shape
	from ufo 
) a 
;

select trim(a.duration) as duration_clean
,count(a.duration) as duration_cnt
from
(
	select split_part(sighting_report, 'Duration:',2) as duration
	from ufo 
) a 
group by a.duration
order by duration_cnt desc
;

set datestyle = mdy;

select occurred::timestamp as occurred
,reported::timestamp as reported
,posted::date as posted
from
(
	select 
split_part(
	split_part(
		split_part(sighting_report, ' (Entered', 1)
		,'Occurred : ', 2)
	,'Reported',1
	) as occurred
,split_part(
	split_part(
		split_part(
			split_part(sighting_report, 'Post', 1) 
		,'Reported: ', 2)
	,' AM',1
	)
,'PM', 1
) as reported
,split_part(split_part(sighting_report,'Location',1), 'Posted: ',2) 
as posted
from ufo  
) a
where length(a.occurred) >= 8
  and length(a.reported) >= 8
  and length(a.posted) >= 8
order by 1 desc
;

select 
case when occurred = '' then null
	 when length(occurred) < 8 then null
	 else occurred::timestamp 
	 end as occurred
,case when length(reported) < 8 then null
	  else reported::timestamp 
	  end as reported
,case when posted = '' then null
	  else posted::date
	  end as posted
from
(
	select 
split_part(
	split_part(
		split_part(sighting_report, ' (Entered', 1)
		,'Occurred : ', 2)
	,'Reported',1
	) as occurred
,split_part(
	split_part(
		split_part(
			split_part(sighting_report, 'Post', 1) 
		,'Reported: ', 2)
	,' AM',1
	)
,'PM', 1
) as reported
,split_part(split_part(sighting_report,'Location',1), 'Posted: ',2) 
as posted
from ufo 	
) a 
;

select location 
,replace(replace(location,'close to','near')
		 ,'outside of', 'near') as location_clean
from
(
	select split_part(split_part(sighting_report,'Shape', 1)
	,'Location', 2) as location
	from ufo 
) a 
order by 1
;

select 
case when occurred = '' then null
when length(occurred) < 8 then null
else occurred::timestamp 
end as occurred
,entered_as
,case when length(reported) < 8 then null
 else reported::timestamp 
 end as reported
,case when posted = '' then null
 else posted::date
 end as posted
,replace(replace(location,'close to', 'near'), 'outside of', 'near')
 as location
,initcap(shape) as shape
,trim(duration) as duration
from
(
    select 
split_part(
	split_part(
		split_part(sighting_report, ' (Entered', 1)
		,'Occurred : ', 2)
	,'Reported',1
	) as occurred
,split_part(
	split_part(sighting_report, ')',1)
	,'Entered as : ', 2
) as entered_as 
,split_part(
	split_part(
		split_part(
			split_part(sighting_report, 'Post', 1) 
		,'Reported: ', 2)
	,' AM',1
	)
,'PM', 1
) as reported
,split_part(split_part(sighting_report,'Location',1), 'Posted: ',2) 
as posted
,split_part(split_part(sighting_report,'Shape',1),'Location: ',2)
as location
,split_part(split_part(sighting_report,'Duration',1),'Shape: ',2)
as shape
,split_part(sighting_report,'Duration:',2) as duration
from ufo
) a 
order by 1
;

-- 와일드카드 매칭
select count(*)
from ufo 
where description like '%wife%'
;
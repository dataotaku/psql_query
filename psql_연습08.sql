select count(*)
from ufo 
where lower(description) like '%wife%'
;

select count(*) 
from ufo 
where description ilike '%wife%'
;

select count(*)
from ufo 
where lower(description) like '%wife%'
  or lower(description) like '%husband%'
  and lower(description) like '%mother%'
;

select count(*)
from ufo 
where ( lower(description) like '%wife%'
  or lower(description) like '%husband%')
  and lower(description) like '%mother%'
;

select 
case when lower(description) like '%driving%' then 'driving'
  when lower(description) like '%walking%' then 'walking'
  when lower(description) like '%running%' then 'running'
  when lower(description) like '%cycling%' then 'cycling'
  when lower(description) like '%swimming%' then 'swimming'
  else 'none' end as activity
,count(*)
from ufo 
group by 1
order by 2 desc
;

select description ilike '%south%' as south
,description ilike '%north%' as north
,description ilike '%east%' as east
,description ilike '%west%' as west
,count(*)
from ufo 
group by 1,2,3,4
order by 1,2,3,4
;

select 
count(case when description ilike '%south%' then 1 end) as south
,count(case when description ilike '%north%' then 1 end) as north
,count(case when description ilike '%west%' then 1 end) as west
,count(case when description ilike '%east%' then 1 end) as east
from ufo 
;

select 
case when lower(first_word) in ('red', 'orange', 'yellow', 'green',
  'blue', 'purple', 'white') then 'Color'
  when lower(first_word) in ('round', 'circular', 'oval', 'cigar')
  then 'Shape'
  when first_word ilike 'triang%' then 'Shape'
  when first_word ilike 'flash%' then 'Motion'
  when first_word ilike 'hover%' then 'Motion'
  when first_word ilike 'pulsat%' then 'Motion'
  else 'Other'
  end as first_word_type
,count(*)
from 
(
	select split_part(description, ' ', 1) as first_word
	,description
	from ufo 
) a 
group by 1
order by 2 desc
;



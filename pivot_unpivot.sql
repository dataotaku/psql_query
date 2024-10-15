
-- 데이터 생성 query

create table sales (regionid integer, q1 integer, q2 integer, q3 integer, q4 integer);
insert into sales values (1,10,12,14,16), (2,20,22,24,26);

select * from sales order by regionid;

 regionid | q1 | q2 | q3 | q4
----------+----+----+----+----
 1        | 10 | 12 | 14 | 16
 2        | 20 | 22 | 24 | 26
(2 rows)


-- pivot query

create table sales_pivoted (regionid, quarter, sales)
as
select regionid, 'Q1', q1 from sales
UNION ALL
select regionid, 'Q2', q2 from sales
UNION ALL
select regionid, 'Q3', q3 from sales
UNION ALL
select regionid, 'Q4', q4 from sales
;

select * from sales_pivoted order by regionid, quarter;

 regionid | quarter | sales 
----------+---------+-------
 1        | Q1      | 10
 1        | Q2      | 12
 1        | Q3      | 14
 1        | Q4      | 16
 2        | Q1      | 20
 2        | Q2      | 22
 2        | Q3      | 24
 2        | Q4      | 26


-- unpivot query

select regionid, sum(Q1) as Q1, sum(Q2) as Q2, sum(Q3) as Q3, sum(Q4) as Q4
from
(select regionid, 
case quarter when 'Q1' then sales else 0 end as Q1,
case quarter when 'Q2' then sales else 0 end as Q2,
case quarter when 'Q3' then sales else 0 end as Q3,
case quarter when 'Q4' then sales else 0 end as Q4
from sales_pivoted)

group by regionid
order by regionid;

 regionid | q1 | q2 | q3 | q4 
----------+----+----+----+----
 1        | 10 | 12 | 14 | 16
 2        | 20 | 22 | 24 | 26
(2 rows)
select *
from 통계청mdis_전입전출행정구역코드_시군구;

select *
from 통계청mdis_전입전출행정구역코드_시도;

select *
from 통계청mdis_국내인구이동
where 전입연도 = '2023'
limit 100;

select min(전입연도||전입월||전입일), max(전입연도||전입월||전입일)
from 통계청mdis_국내인구이동;

select distinct(파일_년도)
from 통계청mdis_국내인구이동;

select count(*)
from 통계청mdis_국내인구이동
where 전입연도 = '2023' and 전입월 = '12';

select count(*)
from 통계청mdis_국내인구이동;

select min(세대uid), max(세대uid)
from uhc_국내이동_인구_all2
limit 100;

create table uhc_2023_인구체크2 as
WITH numbered_2023 AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY 전입연도, 전입월, 전입일) AS 행번호
      , 전입연도
	  , 전입월
	  , 전입일
	  , 전입행정구역_시도코드
	  , 전입행정구역_시군구코드
	  , 전입행정구역_읍면동코드
	  , 전출행정구역_시도코드
	  , 전출행정구역_시군구코드
	  , 전출행정구역_읍면동코드
	  , 전입사유코드
	  , 전입자1_세대주관계코드
	  , 전입자1_만연령
	  , 전입자1_성별코드
	  , 전입자2_세대주관계코드
	  , 전입자2_만연령
	  , 전입자2_성별코드
	  , 전입자3_세대주관계코드
	  , 전입자3_만연령
	  , 전입자3_성별코드
	  , 전입자4_세대주관계코드
	  , 전입자4_만연령
	  , 전입자4_성별코드
	  , 전입자5_세대주관계코드
	  , 전입자5_만연령
	  , 전입자5_성별코드
	  , 전입자6_세대주관계코드
	  , 전입자6_만연령
	  , 전입자6_성별코드
	  , 전입자7_세대주관계코드
	  , 전입자7_만연령
	  , 전입자7_성별코드
	  , 전입자8_세대주관계코드
	  , 전입자8_만연령
	  , 전입자8_성별코드
	  , 전입자9_세대주관계코드
	  , 전입자9_만연령
	  , 전입자9_성별코드
	  , 전입자10_세대주관계코드
	  , 전입자10_만연령
	  , 전입자10_성별코드
    from 통계청mdis_국내인구이동
    where 전입연도 = '2023' 
)
select 전입연도
    , count(distinct 행번호) as 전입세대수
	, sum(case when 전입자1_만연령 is not null then 1 else 0 end) as 전입자1_연령
	, sum(case when 전입자2_만연령 is not null then 1 else 0 end) as 전입자2_연령
	, sum(case when 전입자3_만연령 is not null then 1 else 0 end) as 전입자3_연령
	, sum(case when 전입자4_만연령 is not null then 1 else 0 end) as 전입자4_연령
	, sum(case when 전입자5_만연령 is not null then 1 else 0 end) as 전입자5_연령
	, sum(case when 전입자6_만연령 is not null then 1 else 0 end) as 전입자6_연령
	, sum(case when 전입자7_만연령 is not null then 1 else 0 end) as 전입자7_연령
	, sum(case when 전입자8_만연령 is not null then 1 else 0 end) as 전입자8_연령
	, sum(case when 전입자9_만연령 is not null then 1 else 0 end) as 전입자9_연령
	, sum(case when 전입자10_만연령 is not null then 1 else 0 end) as 전입자10_연령
from numbered_2023
group by 전입연도;


select count(*)
from uhc_국내이동_인구_all2
where 전입연도 = '2023';


select 전입자1_연령 + 전입자2_연령 + 
전입자3_연령 + 전입자4_연령 + 전입자5_연령 + 전입자6_연령 +  
전입자7_연령 + 전입자8_연령 + 
전입자9_연령 + 전입자10_연령 as total_sum
from uhc_2023_인구체크2;

select *
from uhc_2023_인구체크2;


select 전입연도
     , 전입월
     , 전입행정구역_시도코드
	 , 전입행정구역_시군구코드
	 , 전입행정구역_읍면동코드
	 , 전출행정구역_시도코드
	 , 전출행정구역_시군구코드
	 , 전출행정구역_읍면동코드
	 , 전입사유코드
	 , case when 전입자1_세대주관계코드 is not null then '전입자1_세대주관계코드' end AS 전입자구분
	 , case when 전입자1_만연령 is not null then 전입자1_만연령 end AS 전입자연령
	 , case when 전입자1_성별코드 is not null then 전입자1_성별코드 end AS 전입자성별
from 통계청mdis_국내인구이동
where 전입연도 = '2023' and 전입월 = '12'
union all
select 전입연도
     , 전입월
     , 전입행정구역_시도코드
	 , 전입행정구역_시군구코드
	 , 전입행정구역_읍면동코드
	 , 전출행정구역_시도코드
	 , 전출행정구역_시군구코드
	 , 전출행정구역_읍면동코드
	 , 전입사유코드
	 , case when 전입자2_세대주관계코드 is not null then '전입자2_세대주관계코드' end AS 전입자구분
	 , case when 전입자2_만연령 is not null then 전입자2_만연령 end AS 전입자연령
	 , case when 전입자2_성별코드 is not null then 전입자2_성별코드 end AS 전입자성별
from 통계청mdis_국내인구이동
where 전입연도 = '2023' and 전입월 = '12';

select count(*)
from 
(	
	select 전입연도
     , 전입월
     , 전입행정구역_시도코드
	 , 전입행정구역_시군구코드
	 , 전입행정구역_읍면동코드
	 , 전출행정구역_시도코드
	 , 전출행정구역_시군구코드
	 , 전출행정구역_읍면동코드
	 , 전입사유코드
	 , case when 전입자1_세대주관계코드 is not null then '전입자1_세대주관계코드' end AS 전입자구분
	 , case when 전입자1_만연령 is not null then 전입자1_만연령 end AS 전입자연령
	 , case when 전입자1_성별코드 is not null then 전입자1_성별코드 end AS 전입자성별
from 통계청mdis_국내인구이동
where 전입연도 = '2023' and 전입월 = '12'
union all
select 전입연도
     , 전입월
     , 전입행정구역_시도코드
	 , 전입행정구역_시군구코드
	 , 전입행정구역_읍면동코드
	 , 전출행정구역_시도코드
	 , 전출행정구역_시군구코드
	 , 전출행정구역_읍면동코드
	 , 전입사유코드
	 , case when 전입자2_세대주관계코드 is not null then '전입자2_세대주관계코드' end AS 전입자구분
	 , case when 전입자2_만연령 is not null then 전입자2_만연령 end AS 전입자연령
	 , case when 전입자2_성별코드 is not null then 전입자2_성별코드 end AS 전입자성별
from 통계청mdis_국내인구이동
where 전입연도 = '2023' and 전입월 = '12'
union all
select 전입연도
     , 전입월
     , 전입행정구역_시도코드
	 , 전입행정구역_시군구코드
	 , 전입행정구역_읍면동코드
	 , 전출행정구역_시도코드
	 , 전출행정구역_시군구코드
	 , 전출행정구역_읍면동코드
	 , 전입사유코드
	 , case when 전입자3_세대주관계코드 is not null then '전입자3_세대주관계코드' end AS 전입자구분
	 , case when 전입자2_만연령 is not null then 전입자2_만연령 end AS 전입자연령
	 , case when 전입자2_성별코드 is not null then 전입자2_성별코드 end AS 전입자성별
from 통계청mdis_국내인구이동
where 전입연도 = '2023' and 전입월 = '12'
) a
where 전입자구분 is not null;

-- 전입자 일련번호를 추가하여 pivot 하는 코드
-- drop table if exists uhc_국내이동_인구_2023;

create table uhc_국내이동_인구_2023 as
WITH numbered_2023 AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY 전입연도, 전입월, 전입일) AS 행번호
      , 전입연도
	  , 전입월
	  , 전입일
	  , 전입행정구역_시도코드
	  , 전입행정구역_시군구코드
	  , 전입행정구역_읍면동코드
	  , 전출행정구역_시도코드
	  , 전출행정구역_시군구코드
	  , 전출행정구역_읍면동코드
	  , 전입사유코드
	  , 전입자1_세대주관계코드
	  , 전입자1_만연령
	  , 전입자1_성별코드
	  , 전입자2_세대주관계코드
	  , 전입자2_만연령
	  , 전입자2_성별코드
	  , 전입자3_세대주관계코드
	  , 전입자3_만연령
	  , 전입자3_성별코드
	  , 전입자4_세대주관계코드
	  , 전입자4_만연령
	  , 전입자4_성별코드
	  , 전입자5_세대주관계코드
	  , 전입자5_만연령
	  , 전입자5_성별코드
	  , 전입자6_세대주관계코드
	  , 전입자6_만연령
	  , 전입자6_성별코드
	  , 전입자7_세대주관계코드
	  , 전입자7_만연령
	  , 전입자7_성별코드
	  , 전입자8_세대주관계코드
	  , 전입자8_만연령
	  , 전입자8_성별코드
	  , 전입자9_세대주관계코드
	  , 전입자9_만연령
	  , 전입자9_성별코드
	  , 전입자10_세대주관계코드
	  , 전입자10_만연령
	  , 전입자10_성별코드
    from 통계청mdis_국내인구이동
    where 전입연도 = '2023' 
)
select 행번호
     , 전입연도
	 , 전입월
	 , 전입일
	 , 전입행정구역_시도코드
	 , 전입행정구역_시군구코드
	 , 전입행정구역_읍면동코드
	 , 전출행정구역_시도코드
	 , 전출행정구역_시군구코드
	 , 전출행정구역_읍면동코드
	 , 전입사유코드
	 , 전입자구분
	 , 전입자연령
	 , 전입자성별
from 
(	
	select 행번호
	 , 전입연도
	 , 전입월
	 , 전입일
	 , 전입행정구역_시도코드
	 , 전입행정구역_시군구코드
	 , 전입행정구역_읍면동코드
	 , 전출행정구역_시도코드
	 , 전출행정구역_시군구코드
	 , 전출행정구역_읍면동코드
	 , 전입사유코드
	 , case when 전입자1_세대주관계코드 is not null then 전입자1_세대주관계코드 end AS 전입자구분
	 , case when 전입자1_만연령 is not null then 전입자1_만연령 end AS 전입자연령
	 , case when 전입자1_성별코드 is not null then 전입자1_성별코드 end AS 전입자성별
	from numbered_2023
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자2_세대주관계코드 is not null then 전입자2_세대주관계코드 end AS 전입자구분
		 , case when 전입자2_만연령 is not null then 전입자2_만연령 end AS 전입자연령
		 , case when 전입자2_성별코드 is not null then 전입자2_성별코드 end AS 전입자성별
	from numbered_2023
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자3_세대주관계코드 is not null then 전입자3_세대주관계코드 end AS 전입자구분
		 , case when 전입자3_만연령 is not null then 전입자3_만연령 end AS 전입자연령
		 , case when 전입자3_성별코드 is not null then 전입자3_성별코드 end AS 전입자성별
	from numbered_2023
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자4_세대주관계코드 is not null then 전입자4_세대주관계코드 end AS 전입자구분
		 , case when 전입자4_만연령 is not null then 전입자4_만연령 end AS 전입자연령
		 , case when 전입자4_성별코드 is not null then 전입자4_성별코드 end AS 전입자성별
	from numbered_2023
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자5_세대주관계코드 is not null then 전입자5_세대주관계코드 end AS 전입자구분
		 , case when 전입자5_만연령 is not null then 전입자5_만연령 end AS 전입자연령
		 , case when 전입자5_성별코드 is not null then 전입자5_성별코드 end AS 전입자성별
	from numbered_2023
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자6_세대주관계코드 is not null then 전입자6_세대주관계코드 end AS 전입자구분
		 , case when 전입자6_만연령 is not null then 전입자6_만연령 end AS 전입자연령
		 , case when 전입자6_성별코드 is not null then 전입자6_성별코드 end AS 전입자성별
	from numbered_2023
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자7_세대주관계코드 is not null then 전입자7_세대주관계코드 end AS 전입자구분
		 , case when 전입자7_만연령 is not null then 전입자7_만연령 end AS 전입자연령
		 , case when 전입자7_성별코드 is not null then 전입자7_성별코드 end AS 전입자성별
	from numbered_2023
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자8_세대주관계코드 is not null then 전입자8_세대주관계코드 end AS 전입자구분
		 , case when 전입자8_만연령 is not null then 전입자8_만연령 end AS 전입자연령
		 , case when 전입자8_성별코드 is not null then 전입자8_성별코드 end AS 전입자성별
	from numbered_2023
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자9_세대주관계코드 is not null then 전입자9_세대주관계코드 end AS 전입자구분
		 , case when 전입자9_만연령 is not null then 전입자9_만연령 end AS 전입자연령
		 , case when 전입자9_성별코드 is not null then 전입자9_성별코드 end AS 전입자성별
	from numbered_2023
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자10_세대주관계코드 is not null then 전입자10_세대주관계코드 end AS 전입자구분
		 , case when 전입자10_만연령 is not null then 전입자10_만연령 end AS 전입자연령
		 , case when 전입자10_성별코드 is not null then 전입자10_성별코드 end AS 전입자성별
	from numbered_2023
) a
where 전입자구분 is not null
order by 행번호;

-- 데이터 테이블 리뷰 : 데이터 체크 완료
select count(*)
from uhc_국내이동_인구_2023
limit 100;

select *
from uhc_국내이동_인구_2023
limit 100;


select *
from 통계청mdis_국내인구이동
where 전입연도 = '2023' and 전입월 = '01' and 전입일 = '01' and 전입행정구역_읍면동코드 = '56000'
limit 100;

select count(*)
from uhc_국내이동_인구_2023
where 전입자성별 is null;

select 
from uhc_국내이동_인구_2023
where 

-- 전체 국내인구이동을 대상으로 데이터 정리
-- drop table if exists uhc_국내이동_인구_all;

create table uhc_국내이동_인구_all2 as
WITH numbered_all AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY 전입연도, 전입월, 전입일) AS 행번호
      , 전입연도
	  , 전입월
	  , 전입일
	  , 전입행정구역_시도코드
	  , 전입행정구역_시군구코드
	  , 전입행정구역_읍면동코드
	  , 전출행정구역_시도코드
	  , 전출행정구역_시군구코드
	  , 전출행정구역_읍면동코드
	  , 전입사유코드
	  , 전입자1_세대주관계코드
	  , 전입자1_만연령
	  , 전입자1_성별코드
	  , 전입자2_세대주관계코드
	  , 전입자2_만연령
	  , 전입자2_성별코드
	  , 전입자3_세대주관계코드
	  , 전입자3_만연령
	  , 전입자3_성별코드
	  , 전입자4_세대주관계코드
	  , 전입자4_만연령
	  , 전입자4_성별코드
	  , 전입자5_세대주관계코드
	  , 전입자5_만연령
	  , 전입자5_성별코드
	  , 전입자6_세대주관계코드
	  , 전입자6_만연령
	  , 전입자6_성별코드
	  , 전입자7_세대주관계코드
	  , 전입자7_만연령
	  , 전입자7_성별코드
	  , 전입자8_세대주관계코드
	  , 전입자8_만연령
	  , 전입자8_성별코드
	  , 전입자9_세대주관계코드
	  , 전입자9_만연령
	  , 전입자9_성별코드
	  , 전입자10_세대주관계코드
	  , 전입자10_만연령
	  , 전입자10_성별코드
    from 통계청mdis_국내인구이동
)
select 행번호 as 세대uid
     , 전입연도
	 , 전입월
	 , 전입일
	 , 전입행정구역_시도코드
	 , 전입행정구역_시군구코드
	 , 전입행정구역_읍면동코드
	 , 전출행정구역_시도코드
	 , 전출행정구역_시군구코드
	 , 전출행정구역_읍면동코드
	 , 전입사유코드
	 , 전입자_세대주관계
	 , 전입자연령
	 , 전입자성별
from 
(	
	select 행번호
	 , 전입연도
	 , 전입월
	 , 전입일
	 , 전입행정구역_시도코드
	 , 전입행정구역_시군구코드
	 , 전입행정구역_읍면동코드
	 , 전출행정구역_시도코드
	 , 전출행정구역_시군구코드
	 , 전출행정구역_읍면동코드
	 , 전입사유코드
	 , case when 전입자1_세대주관계코드 is not null then 전입자1_세대주관계코드 end AS 전입자_세대주관계
	 , case when 전입자1_만연령 is not null then 전입자1_만연령 end AS 전입자연령
	 , case when 전입자1_성별코드 is not null then 전입자1_성별코드 end AS 전입자성별
	from numbered_all
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자2_세대주관계코드 is not null then 전입자2_세대주관계코드 end AS 전입자_세대주관계
		 , case when 전입자2_만연령 is not null then 전입자2_만연령 end AS 전입자연령
		 , case when 전입자2_성별코드 is not null then 전입자2_성별코드 end AS 전입자성별
	from numbered_all
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자3_세대주관계코드 is not null then 전입자3_세대주관계코드 end AS 전입자_세대주관계
		 , case when 전입자3_만연령 is not null then 전입자3_만연령 end AS 전입자연령
		 , case when 전입자3_성별코드 is not null then 전입자3_성별코드 end AS 전입자성별
	from numbered_all
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자4_세대주관계코드 is not null then 전입자4_세대주관계코드 end AS 전입자_세대주관계
		 , case when 전입자4_만연령 is not null then 전입자4_만연령 end AS 전입자연령
		 , case when 전입자4_성별코드 is not null then 전입자4_성별코드 end AS 전입자성별
	from numbered_all
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자5_세대주관계코드 is not null then 전입자5_세대주관계코드 end AS 전입자_세대주관계
		 , case when 전입자5_만연령 is not null then 전입자5_만연령 end AS 전입자연령
		 , case when 전입자5_성별코드 is not null then 전입자5_성별코드 end AS 전입자성별
	from numbered_all
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자6_세대주관계코드 is not null then 전입자6_세대주관계코드 end AS 전입자_세대주관계
		 , case when 전입자6_만연령 is not null then 전입자6_만연령 end AS 전입자연령
		 , case when 전입자6_성별코드 is not null then 전입자6_성별코드 end AS 전입자성별
	from numbered_all
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자7_세대주관계코드 is not null then 전입자7_세대주관계코드 end AS 전입자_세대주관계
		 , case when 전입자7_만연령 is not null then 전입자7_만연령 end AS 전입자연령
		 , case when 전입자7_성별코드 is not null then 전입자7_성별코드 end AS 전입자성별
	from numbered_all
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자8_세대주관계코드 is not null then 전입자8_세대주관계코드 end AS 전입자_세대주관계
		 , case when 전입자8_만연령 is not null then 전입자8_만연령 end AS 전입자연령
		 , case when 전입자8_성별코드 is not null then 전입자8_성별코드 end AS 전입자성별
	from numbered_all
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자9_세대주관계코드 is not null then 전입자9_세대주관계코드 end AS 전입자_세대주관계
		 , case when 전입자9_만연령 is not null then 전입자9_만연령 end AS 전입자연령
		 , case when 전입자9_성별코드 is not null then 전입자9_성별코드 end AS 전입자성별
	from numbered_all
	union all
	select 행번호
		 , 전입연도
		 , 전입월
		 , 전입일
		 , 전입행정구역_시도코드
		 , 전입행정구역_시군구코드
		 , 전입행정구역_읍면동코드
		 , 전출행정구역_시도코드
		 , 전출행정구역_시군구코드
		 , 전출행정구역_읍면동코드
		 , 전입사유코드
		 , case when 전입자10_세대주관계코드 is not null then 전입자10_세대주관계코드 end AS 전입자_세대주관계
		 , case when 전입자10_만연령 is not null then 전입자10_만연령 end AS 전입자연령
		 , case when 전입자10_성별코드 is not null then 전입자10_성별코드 end AS 전입자성별
	from numbered_all
) a
where 전입자_세대주관계 is not null
order by 행번호;


select count(*)
from uhc_국내이동_인구_all2
where 전입연도 = '2023'
limit 100;


-- 전입/전출 시군구 기준 세대수 및 인구기준 집계
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , count(distinct 행번호) as 전입세대수
    , count(*) as 전입인구수
	, count(case when 전입사유코드 = '1' then 1 end) as 직업_명
	, count(case when 전입사유코드 = '2' then 1 end) as 가족_명
	, count(case when 전입사유코드 = '3' then 1 end) as 주택_명
	, count(case when 전입사유코드 = '4' then 1 end) as 교육_명
	, count(case when 전입사유코드 = '5' then 1 end) as 주거환경_명
	, count(case when 전입사유코드 = '6' then 1 end) as 자연환경_명
	, count(case when 전입사유코드 = '9' then 1 end) as 기타_명
	, count(case when 전입자성별 in ('0','2','4') then 1 end) as 여자_명
	, count(case when 전입자성별 in ('1','3','9') then 1 end) as 남자_명
	, count(case when 전입자연령 between 0 and 9 then 1 end) as 아동기_명
	, count(case when 전입자연령 between 10 and 19 then 1 end) as 청소년기_명
	, count(case when 전입자연령 between 20 and 34 then 1 end) as 청년기_명
	, count(case when 전입자연령 between 35 and 49 then 1 end) as 장년기_명
	, count(case when 전입자연령 between 50 and 59 then 1 end) as 중년기_명
	, count(case when 전입자연령 between 60 and 74 then 1 end) as 초기노년기_명
	, count(case when 전입자연령 >= 75 then 1 end) as 노년기_명
from uhc_국내이동_인구_all
where 전입연도 = '2023'
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드;

-- 전체연도기준 전입/전출 시군구 기준 세대수 및 인구기준 집계
create table uhc_국내이동_총세대_인구_all as
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , count(distinct 행번호) as 전입세대수
    , count(*) as 전입인구수
	, count(case when 전입사유코드 = '1' then 1 end) as 직업_명
	, count(case when 전입사유코드 = '2' then 1 end) as 가족_명
	, count(case when 전입사유코드 = '3' then 1 end) as 주택_명
	, count(case when 전입사유코드 = '4' then 1 end) as 교육_명
	, count(case when 전입사유코드 = '5' then 1 end) as 주거환경_명
	, count(case when 전입사유코드 = '6' then 1 end) as 자연환경_명
	, count(case when 전입사유코드 = '9' then 1 end) as 기타_명
	, count(case when 전입자성별 in ('0','2','4') then 1 end) as 여자_명
	, count(case when 전입자성별 in ('1','3','9') then 1 end) as 남자_명
	, count(case when 전입자연령 between 0 and 9 then 1 end) as 아동기_명
	, count(case when 전입자연령 between 10 and 19 then 1 end) as 청소년기_명
	, count(case when 전입자연령 between 20 and 34 then 1 end) as 청년기_명
	, count(case when 전입자연령 between 35 and 49 then 1 end) as 장년기_명
	, count(case when 전입자연령 between 50 and 59 then 1 end) as 중년기_명
	, count(case when 전입자연령 between 60 and 74 then 1 end) as 초기노년기_명
	, count(case when 전입자연령 >= 75 then 1 end) as 노년기_명
from uhc_국내이동_인구_all
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
;

select *
from uhc_국내이동_총세대_인구_all
limit 1000;


-- 전입사유별 세대수 기준 집계
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	, 전입사유코드
	, count(distinct 행번호) as 전입세대수
from uhc_국내이동_인구_all
where 전입연도 = '2023'
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드;


-- 전입_전출 행정구역별 이주 사유별 이동 세대수 
with 전입사유코드별_세대수 as 
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , 전입사유코드
	    , count(distinct 행번호) as 전입세대수
	from uhc_국내이동_인구_all
	where 전입연도 = '2023'
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드
)
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , sum(a.직업) as 직업_세대
	, sum(a.가족) as 가족_세대
	, sum(a.주택) as 주택_세대
	, sum(a.교육) as 교육_세대
	, sum(a.주거환경) as 주거환경_세대
	, sum(a.자연환경) as 자연환경_세대
	, sum(a.기타) as 기타_세대
from
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , case b.전입사유코드 when '1' then b.전입세대수 else 0 end as 직업
		, case b.전입사유코드 when '2' then b.전입세대수 else 0 end as 가족
		, case b.전입사유코드 when '3' then b.전입세대수 else 0 end as 주택
		, case b.전입사유코드 when '4' then b.전입세대수 else 0 end as 교육
		, case b.전입사유코드 when '5' then b.전입세대수 else 0 end as 주거환경
		, case b.전입사유코드 when '6' then b.전입세대수 else 0 end as 자연환경
		, case b.전입사유코드 when '9' then b.전입세대수 else 0 end as 기타
	from 전입사유코드별_세대수 as b
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드, 전입세대수
) a
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
;

-- 전체 연도 전입_전출 행정구역별 이주 사유별 이동 세대수 
create table uhc_국내이동_이주사유별_세대_2019 as
with 전입사유코드별_세대수 as 
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , 전입사유코드
	    , count(distinct 행번호) as 전입세대수
	from uhc_국내이동_인구_all
	where 전입연도 = '2019'
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드
)
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , sum(a.직업) as 직업_세대
	, sum(a.가족) as 가족_세대
	, sum(a.주택) as 주택_세대
	, sum(a.교육) as 교육_세대
	, sum(a.주거환경) as 주거환경_세대
	, sum(a.자연환경) as 자연환경_세대
	, sum(a.기타) as 기타_세대
from
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , case b.전입사유코드 when '1' then b.전입세대수 else 0 end as 직업
		, case b.전입사유코드 when '2' then b.전입세대수 else 0 end as 가족
		, case b.전입사유코드 when '3' then b.전입세대수 else 0 end as 주택
		, case b.전입사유코드 when '4' then b.전입세대수 else 0 end as 교육
		, case b.전입사유코드 when '5' then b.전입세대수 else 0 end as 주거환경
		, case b.전입사유코드 when '6' then b.전입세대수 else 0 end as 자연환경
		, case b.전입사유코드 when '9' then b.전입세대수 else 0 end as 기타
	from 전입사유코드별_세대수 as b
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드, 전입세대수
) a
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
;

-- 에러체크를 위한 조각코드 (원인파악용)
with 전입사유코드별_세대수 as 
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , 전입사유코드
	    , count(distinct 행번호) as 전입세대수
	from uhc_국내이동_인구_all
	where 전입연도 = '2023'
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드
)
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	, case b.전입사유코드 when '1' then b.전입세대수 else 0 end as 직업
	, case b.전입사유코드 when '2' then b.전입세대수 else 0 end as 가족
	, case b.전입사유코드 when '3' then b.전입세대수 else 0 end as 주택
	, case b.전입사유코드 when '4' then b.전입세대수 else 0 end as 교육
	, case b.전입사유코드 when '5' then b.전입세대수 else 0 end as 주거환경
	, case b.전입사유코드 when '6' then b.전입세대수 else 0 end as 자연환경
	, case b.전입사유코드 when '9' then b.전입세대수 else 0 end as 기타
from 전입사유코드별_세대수 as b
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드, 전입세대수
;

-- 전체 연도 전입_전출 행정구역별 이주 사유별 이동 세대수 2020
create table uhc_국내이동_이주사유별_세대_2020 as
with 전입사유코드별_세대수 as 
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , 전입사유코드
	    , count(distinct 행번호) as 전입세대수
	from uhc_국내이동_인구_all
	where 전입연도 = '2020'
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드
)
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , sum(a.직업) as 직업_세대
	, sum(a.가족) as 가족_세대
	, sum(a.주택) as 주택_세대
	, sum(a.교육) as 교육_세대
	, sum(a.주거환경) as 주거환경_세대
	, sum(a.자연환경) as 자연환경_세대
	, sum(a.기타) as 기타_세대
from
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , case b.전입사유코드 when '1' then b.전입세대수 else 0 end as 직업
		, case b.전입사유코드 when '2' then b.전입세대수 else 0 end as 가족
		, case b.전입사유코드 when '3' then b.전입세대수 else 0 end as 주택
		, case b.전입사유코드 when '4' then b.전입세대수 else 0 end as 교육
		, case b.전입사유코드 when '5' then b.전입세대수 else 0 end as 주거환경
		, case b.전입사유코드 when '6' then b.전입세대수 else 0 end as 자연환경
		, case b.전입사유코드 when '9' then b.전입세대수 else 0 end as 기타
	from 전입사유코드별_세대수 as b
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드, 전입세대수
) a
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
;


-- 전체 연도 전입_전출 행정구역별 이주 사유별 이동 세대수 2021
create table uhc_국내이동_이주사유별_세대_2021 as
with 전입사유코드별_세대수 as 
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , 전입사유코드
	    , count(distinct 행번호) as 전입세대수
	from uhc_국내이동_인구_all
	where 전입연도 = '2021'
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드
)
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , sum(a.직업) as 직업_세대
	, sum(a.가족) as 가족_세대
	, sum(a.주택) as 주택_세대
	, sum(a.교육) as 교육_세대
	, sum(a.주거환경) as 주거환경_세대
	, sum(a.자연환경) as 자연환경_세대
	, sum(a.기타) as 기타_세대
from
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , case b.전입사유코드 when '1' then b.전입세대수 else 0 end as 직업
		, case b.전입사유코드 when '2' then b.전입세대수 else 0 end as 가족
		, case b.전입사유코드 when '3' then b.전입세대수 else 0 end as 주택
		, case b.전입사유코드 when '4' then b.전입세대수 else 0 end as 교육
		, case b.전입사유코드 when '5' then b.전입세대수 else 0 end as 주거환경
		, case b.전입사유코드 when '6' then b.전입세대수 else 0 end as 자연환경
		, case b.전입사유코드 when '9' then b.전입세대수 else 0 end as 기타
	from 전입사유코드별_세대수 as b
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드, 전입세대수
) a
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
;

-- 전체 연도 전입_전출 행정구역별 이주 사유별 이동 세대수 2022
create table uhc_국내이동_이주사유별_세대_2022 as
with 전입사유코드별_세대수 as 
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , 전입사유코드
	    , count(distinct 행번호) as 전입세대수
	from uhc_국내이동_인구_all
	where 전입연도 = '2022'
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드
)
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , sum(a.직업) as 직업_세대
	, sum(a.가족) as 가족_세대
	, sum(a.주택) as 주택_세대
	, sum(a.교육) as 교육_세대
	, sum(a.주거환경) as 주거환경_세대
	, sum(a.자연환경) as 자연환경_세대
	, sum(a.기타) as 기타_세대
from
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , case b.전입사유코드 when '1' then b.전입세대수 else 0 end as 직업
		, case b.전입사유코드 when '2' then b.전입세대수 else 0 end as 가족
		, case b.전입사유코드 when '3' then b.전입세대수 else 0 end as 주택
		, case b.전입사유코드 when '4' then b.전입세대수 else 0 end as 교육
		, case b.전입사유코드 when '5' then b.전입세대수 else 0 end as 주거환경
		, case b.전입사유코드 when '6' then b.전입세대수 else 0 end as 자연환경
		, case b.전입사유코드 when '9' then b.전입세대수 else 0 end as 기타
	from 전입사유코드별_세대수 as b
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드, 전입세대수
) a
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
;


-- 전체 연도 전입_전출 행정구역별 이주 사유별 이동 세대수 2023
create table uhc_국내이동_이주사유별_세대_2023 as
with 전입사유코드별_세대수 as 
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , 전입사유코드
	    , count(distinct 행번호) as 전입세대수
	from uhc_국내이동_인구_all
	where 전입연도 = '2023'
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드
)
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , sum(a.직업) as 직업_세대
	, sum(a.가족) as 가족_세대
	, sum(a.주택) as 주택_세대
	, sum(a.교육) as 교육_세대
	, sum(a.주거환경) as 주거환경_세대
	, sum(a.자연환경) as 자연환경_세대
	, sum(a.기타) as 기타_세대
from
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , case b.전입사유코드 when '1' then b.전입세대수 else 0 end as 직업
		, case b.전입사유코드 when '2' then b.전입세대수 else 0 end as 가족
		, case b.전입사유코드 when '3' then b.전입세대수 else 0 end as 주택
		, case b.전입사유코드 when '4' then b.전입세대수 else 0 end as 교육
		, case b.전입사유코드 when '5' then b.전입세대수 else 0 end as 주거환경
		, case b.전입사유코드 when '6' then b.전입세대수 else 0 end as 자연환경
		, case b.전입사유코드 when '9' then b.전입세대수 else 0 end as 기타
	from 전입사유코드별_세대수 as b
	group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드, 전입세대수
) a
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
;


create table uhc_국내이동_이주사유별_세대_all2 as
select * from uhc_국내이동_이주사유별_세대_2019
union all
select * from uhc_국내이동_이주사유별_세대_2020
union all
select * from uhc_국내이동_이주사유별_세대_2021
union all
select * from uhc_국내이동_이주사유별_세대_2022
union all
select * from uhc_국내이동_이주사유별_세대_2023
;

select count(*)
from uhc_국내이동_이주사유별_세대_all;

select count(*)
from uhc_국내이동_이주사유별_세대_all2;

select *
from uhc_국내이동_이주사유별_세대_all
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
limit 100
;

select *
from uhc_국내이동_이주사유별_세대_all2
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
limit 100
;

-- 단독전입/비단독 전입 세대/인구
-- count case when 구문에서 else 0를 넣고 안넣고의 차이가 있음에 유의할 필요가 있음.
-- drop table if exists uhc_국내이동_전입건당_인원수_2019;
-- drop table if exists uhc_국내이동_전입건당_인원수_2020;
-- drop table if exists uhc_국내이동_전입건당_인원수_2021;
-- drop table if exists uhc_국내이동_전입건당_인원수_2022;

select *
from uhc_국내이동_인구_all2
limit 5;

create table uhc_국내이동_전입건당_인원수_2019 as
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , 세대uid
	, count(*) as 이동세대원수
	, count(case when 전입자성별 in ('0','2','4') then 1 end) as 여자_명
	, count(case when 전입자성별 in ('1','3','9') then 1 end) as 남자_명
	, count(case when 전입자_세대주관계 in ('1') then 1 end) as 세대주_명
	, count(case when 전입자_세대주관계 in ('2','3','4', '5', '6', '7', '8', '9') then 1 end) as 비세대주_명
	, count(case when 전입자연령 between 0 and 9 then 1 end) as 아동기_명
	, count(case when 전입자연령 between 10 and 19 then 1 end) as 청소년기_명
	, count(case when 전입자연령 between 20 and 34 then 1 end) as 청년기_명
	, count(case when 전입자연령 between 35 and 49 then 1 end) as 장년기_명
	, count(case when 전입자연령 between 50 and 59 then 1 end) as 중년기_명
	, count(case when 전입자연령 between 60 and 74 then 1 end) as 초기노년기_명
	, count(case when 전입자연령 >= 75 then 1 end) as 노년기_명
	, count(case when 전입사유코드 = '1' then 1 end) as 직업_명
	, count(case when 전입사유코드 = '2' then 1 end) as 가족_명
	, count(case when 전입사유코드 = '3' then 1 end) as 주택_명
	, count(case when 전입사유코드 = '4' then 1 end) as 교육_명
	, count(case when 전입사유코드 = '5' then 1 end) as 주거환경_명
	, count(case when 전입사유코드 = '6' then 1 end) as 자연환경_명
	, count(case when 전입사유코드 = '9' then 1 else 0 end) as 기타_명
from uhc_국내이동_인구_all2
where 전입연도 = '2019'
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid 
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid
;

select *
from uhc_국내이동_전입건당_인원수_2019
limit 3;

-- 2020년 전입건당 인원수
create table uhc_국내이동_전입건당_인원수_2020 as
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , 세대uid
	, count(*) as 이동세대원수
	, count(case when 전입자성별 in ('0','2','4') then 1 end) as 여자_명
	, count(case when 전입자성별 in ('1','3','9') then 1 end) as 남자_명
	, count(case when 전입자_세대주관계 in ('1') then 1 end) as 세대주_명
	, count(case when 전입자_세대주관계 in ('2','3','4', '5', '6', '7', '8', '9') then 1 end) as 비세대주_명
	, count(case when 전입자연령 between 0 and 9 then 1 end) as 아동기_명
	, count(case when 전입자연령 between 10 and 19 then 1 end) as 청소년기_명
	, count(case when 전입자연령 between 20 and 34 then 1 end) as 청년기_명
	, count(case when 전입자연령 between 35 and 49 then 1 end) as 장년기_명
	, count(case when 전입자연령 between 50 and 59 then 1 end) as 중년기_명
	, count(case when 전입자연령 between 60 and 74 then 1 end) as 초기노년기_명
	, count(case when 전입자연령 >= 75 then 1 end) as 노년기_명
	, count(case when 전입사유코드 = '1' then 1 end) as 직업_명
	, count(case when 전입사유코드 = '2' then 1 end) as 가족_명
	, count(case when 전입사유코드 = '3' then 1 end) as 주택_명
	, count(case when 전입사유코드 = '4' then 1 end) as 교육_명
	, count(case when 전입사유코드 = '5' then 1 end) as 주거환경_명
	, count(case when 전입사유코드 = '6' then 1 end) as 자연환경_명
	, count(case when 전입사유코드 = '9' then 1 else 0 end) as 기타_명
from uhc_국내이동_인구_all2
where 전입연도 = '2020'
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid 
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid
;

-- 2021년 전입건당 인원수
create table uhc_국내이동_전입건당_인원수_2021 as
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , 세대uid
	, count(*) as 이동세대원수
	, count(case when 전입자성별 in ('0','2','4') then 1 end) as 여자_명
	, count(case when 전입자성별 in ('1','3','9') then 1 end) as 남자_명
	, count(case when 전입자_세대주관계 in ('1') then 1 end) as 세대주_명
	, count(case when 전입자_세대주관계 in ('2','3','4', '5', '6', '7', '8', '9') then 1 end) as 비세대주_명
	, count(case when 전입자연령 between 0 and 9 then 1 end) as 아동기_명
	, count(case when 전입자연령 between 10 and 19 then 1 end) as 청소년기_명
	, count(case when 전입자연령 between 20 and 34 then 1 end) as 청년기_명
	, count(case when 전입자연령 between 35 and 49 then 1 end) as 장년기_명
	, count(case when 전입자연령 between 50 and 59 then 1 end) as 중년기_명
	, count(case when 전입자연령 between 60 and 74 then 1 end) as 초기노년기_명
	, count(case when 전입자연령 >= 75 then 1 end) as 노년기_명
	, count(case when 전입사유코드 = '1' then 1 end) as 직업_명
	, count(case when 전입사유코드 = '2' then 1 end) as 가족_명
	, count(case when 전입사유코드 = '3' then 1 end) as 주택_명
	, count(case when 전입사유코드 = '4' then 1 end) as 교육_명
	, count(case when 전입사유코드 = '5' then 1 end) as 주거환경_명
	, count(case when 전입사유코드 = '6' then 1 end) as 자연환경_명
	, count(case when 전입사유코드 = '9' then 1 else 0 end) as 기타_명
from uhc_국내이동_인구_all2
where 전입연도 = '2021'
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid 
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid
;

-- 2022년 전입건당 인원수
create table uhc_국내이동_전입건당_인원수_2022 as
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , 세대uid
	, count(*) as 이동세대원수
	, count(case when 전입자성별 in ('0','2','4') then 1 end) as 여자_명
	, count(case when 전입자성별 in ('1','3','9') then 1 end) as 남자_명
	, count(case when 전입자_세대주관계 in ('1') then 1 end) as 세대주_명
	, count(case when 전입자_세대주관계 in ('2','3','4', '5', '6', '7', '8', '9') then 1 end) as 비세대주_명
	, count(case when 전입자연령 between 0 and 9 then 1 end) as 아동기_명
	, count(case when 전입자연령 between 10 and 19 then 1 end) as 청소년기_명
	, count(case when 전입자연령 between 20 and 34 then 1 end) as 청년기_명
	, count(case when 전입자연령 between 35 and 49 then 1 end) as 장년기_명
	, count(case when 전입자연령 between 50 and 59 then 1 end) as 중년기_명
	, count(case when 전입자연령 between 60 and 74 then 1 end) as 초기노년기_명
	, count(case when 전입자연령 >= 75 then 1 end) as 노년기_명
	, count(case when 전입사유코드 = '1' then 1 end) as 직업_명
	, count(case when 전입사유코드 = '2' then 1 end) as 가족_명
	, count(case when 전입사유코드 = '3' then 1 end) as 주택_명
	, count(case when 전입사유코드 = '4' then 1 end) as 교육_명
	, count(case when 전입사유코드 = '5' then 1 end) as 주거환경_명
	, count(case when 전입사유코드 = '6' then 1 end) as 자연환경_명
	, count(case when 전입사유코드 = '9' then 1 else 0 end) as 기타_명
from uhc_국내이동_인구_all2
where 전입연도 = '2022'
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid 
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid
;

select *
from uhc_국내이동_인구_all
limit 100;

-- 2023년 전입건당 인원수
create table uhc_국내이동_전입건당_인원수_2023 as
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , 세대uid
	, count(*) as 이동세대원수
	, count(case when 전입자성별 in ('0','2','4') then 1 end) as 여자_명
	, count(case when 전입자성별 in ('1','3','9') then 1 end) as 남자_명
	, count(case when 전입자_세대주관계 in ('1') then 1 end) as 세대주_명
	, count(case when 전입자_세대주관계 in ('2','3','4', '5', '6', '7', '8', '9') then 1 end) as 비세대주_명
	, count(case when 전입자연령 between 0 and 9 then 1 end) as 아동기_명
	, count(case when 전입자연령 between 10 and 19 then 1 end) as 청소년기_명
	, count(case when 전입자연령 between 20 and 34 then 1 end) as 청년기_명
	, count(case when 전입자연령 between 35 and 49 then 1 end) as 장년기_명
	, count(case when 전입자연령 between 50 and 59 then 1 end) as 중년기_명
	, count(case when 전입자연령 between 60 and 74 then 1 end) as 초기노년기_명
	, count(case when 전입자연령 >= 75 then 1 end) as 노년기_명
	, count(case when 전입사유코드 = '1' then 1 end) as 직업_명
	, count(case when 전입사유코드 = '2' then 1 end) as 가족_명
	, count(case when 전입사유코드 = '3' then 1 end) as 주택_명
	, count(case when 전입사유코드 = '4' then 1 end) as 교육_명
	, count(case when 전입사유코드 = '5' then 1 end) as 주거환경_명
	, count(case when 전입사유코드 = '6' then 1 end) as 자연환경_명
	, count(case when 전입사유코드 = '9' then 1 else 0 end) as 기타_명
from uhc_국내이동_인구_all2
where 전입연도 = '2023'
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid 
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid
;

create table uhc_국내이동_전입건당_인원수_all as
select * from uhc_국내이동_전입건당_인원수_2019
union all
select * from uhc_국내이동_전입건당_인원수_2020
union all
select * from uhc_국내이동_전입건당_인원수_2021
union all
select * from uhc_국내이동_전입건당_인원수_2022
union all
select * from uhc_국내이동_전입건당_인원수_2023
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 세대uid
;

select *
from uhc_국내이동_전입건당_인원수_all
limit 100;

-- drop table if exists uhc_국내이동_전입건당_인원수_all2;

create table uhc_국내이동_전입건당_인원수_all2 as
select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
    , 세대uid
	, case when 이동세대원수 > 1 then '비단독' else '단독' end as 단독구분
	, case when 전출행정구역_시도코드 = '11' then '서울'
	       when 전출행정구역_시도코드 = '26' then '부산'
		   when 전출행정구역_시도코드 = '27' then '대구'
		   when 전출행정구역_시도코드 = '28' then '인천'
		   when 전출행정구역_시도코드 = '29' then '광주'
		   when 전출행정구역_시도코드 = '30' then '대전'
		   when 전출행정구역_시도코드 = '31' then '울산'
		   when 전출행정구역_시도코드 = '36' then '세종'
		   when 전출행정구역_시도코드 = '41' then '경기'
		   when 전출행정구역_시도코드 = '42' then '강원'
		   when 전출행정구역_시도코드 = '43' then '충북'
		   when 전출행정구역_시도코드 = '44' then '충남'
		   when 전출행정구역_시도코드 = '45' then '전북'
		   when 전출행정구역_시도코드 = '46' then '전남'
		   when 전출행정구역_시도코드 = '47' then '경북'
		   when 전출행정구역_시도코드 = '48' then '경남'
		   when 전출행정구역_시도코드 = '50' then '제주'
		   when 전출행정구역_시도코드 = '51' then '강원'
		   when 전출행정구역_시도코드 = '52' then '전북'
		   else null end as 전출시도명
	, case when 전입행정구역_시도코드 = '11' then '서울'
	       when 전입행정구역_시도코드 = '26' then '부산'
		   when 전입행정구역_시도코드 = '27' then '대구'
		   when 전입행정구역_시도코드 = '28' then '인천'
		   when 전입행정구역_시도코드 = '29' then '광주'
		   when 전입행정구역_시도코드 = '30' then '대전'
		   when 전입행정구역_시도코드 = '31' then '울산'
		   when 전입행정구역_시도코드 = '36' then '세종'
		   when 전입행정구역_시도코드 = '41' then '경기'
		   when 전입행정구역_시도코드 = '42' then '강원'
		   when 전입행정구역_시도코드 = '43' then '충북'
		   when 전입행정구역_시도코드 = '44' then '충남'
		   when 전입행정구역_시도코드 = '45' then '전북'
		   when 전입행정구역_시도코드 = '46' then '전남'
		   when 전입행정구역_시도코드 = '47' then '경북'
		   when 전입행정구역_시도코드 = '48' then '경남'
		   when 전입행정구역_시도코드 = '50' then '제주'
		   when 전입행정구역_시도코드 = '51' then '강원'
		   when 전입행정구역_시도코드 = '52' then '전북'
		   else null end as 전입시도명
	, 여자_명 as 세대_여자_명
	, 남자_명 as 세대_남자_명
	, 세대주_명
	, case when 세대주_명 = 0 then '세대주_미포함' else '세대주_포함' end as 세대주포함_여부
	, 비세대주_명
	, 아동기_명 as 세대_아동기_명
    , 청소년기_명 as 세대_청소년기_명
	, 청년기_명 as 세대_청년기_명
	, 장년기_명 as 세대_장년기_명
	, 중년기_명 as 세대_중년기_명
	, 초기노년기_명 as 세대_초기노년기_명
	, 노년기_명 as 세대_노년기_명
	, 직업_명 as 세대_직업_명
	, 가족_명 as 세대_가족_명
	, 주택_명 as 세대_주택_명
	, 교육_명 as 세대_교육_명
	, 주거환경_명 as 세대_주거환경_명
	, 자연환경_명 as 세대_자연환경_명
	, 기타_명 as 세대_기타_명
from uhc_국내이동_전입건당_인원수_all a
;

select count(*)
from uhc_국내이동_전입건당_인원수_all;

select count(*)
from uhc_국내이동_전입건당_인원수_all2;

select *
from uhc_국내이동_전입건당_인원수_all2
limit 100;

select *
from 통계청mdis_전입전출행정구역코드_시도;

-- 시군구내 이동을 제외한 시군구 단독/비단독 전입 분석
-- 코드체계가 GRDP와 많이 다르고, 행정구, 출장소 등도 들어 있어서 추출후 다시한번 코드정리 및 aggregation이 필요함.
-- drop table if exists uhc_sgg_연간전입_단독_비단독_세대_인구;
-- drop table if exists uhc_sgg_연간전출_단독_비단독_세대_인구;

create table uhc_sgg_연간전입_단독_비단독_세대_인구 as
select 전입연도, 전출행정구역_시도코드, 전출시도명, 전입행정구역_시도코드, 전입시도명, 전입행정구역_시군구코드, 단독구분, 세대주포함_여부
    , 전입행정구역_시도코드 || 전입행정구역_시군구코드 as 전입admin_cd
    , count(*) as 전입세대수
	, sum(세대_여자_명) + sum(세대_남자_명) as 전입인구수
	, sum(세대_여자_명) as 여자_명
	, sum(세대_남자_명) as 남자_명
	, sum(세대_아동기_명) as 아동기_명
	, sum(세대_청소년기_명) as 청소년기_명
	, sum(세대_청년기_명) as 청년기_명
	, sum(세대_장년기_명) as 장년기_명
	, sum(세대_중년기_명) as 중년기_명
	, sum(세대_초기노년기_명) as 초기노년기_명
	, sum(세대_노년기_명) as 노년기_명
	, sum(세대_직업_명) as 사유_직업_명
	, sum(세대_가족_명) as 사유_가족_명
	, sum(세대_주택_명) as 사유_주택_명
	, sum(세대_교육_명) as 사유_교육_명
	, sum(세대_주거환경_명) as 사유_주거환경_명
	, sum(세대_자연환경_명) as 사유_자연환경_명
	, sum(세대_기타_명) as 사유_기타_명
from uhc_국내이동_전입건당_인원수_all2 a
where not(전출행정구역_시도코드||전출행정구역_시군구코드 = 전입행정구역_시도코드||전입행정구역_시군구코드)
group by 전입연도, 전출행정구역_시도코드, 전출시도명, 전입행정구역_시도코드, 전입시도명, 전입행정구역_시군구코드, 단독구분, 세대주포함_여부
;


-- 시군구내 이동을 제외한 시군구 단독/비단독 전출 분석
-- 코드체계가 GRDP와 많이 다르고, 행정구, 출장소 등도 들어 있어서 추출후 다시한번 코드정리 및 aggregation이 필요함.
create table uhc_sgg_연간전출_단독_비단독_세대_인구 as
select 전입연도, 전출행정구역_시도코드, 전출시도명, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입시도명, 단독구분, 세대주포함_여부
    , 전출행정구역_시도코드 || 전출행정구역_시군구코드 as 전출admin_cd
    , count(*) as 전출세대수
	, sum(세대_여자_명) + sum(세대_남자_명) as 전출인구수
	, sum(세대_여자_명) as 여자_명
	, sum(세대_남자_명) as 남자_명
	, sum(세대_아동기_명) as 아동기_명
	, sum(세대_청소년기_명) as 청소년기_명
	, sum(세대_청년기_명) as 청년기_명
	, sum(세대_장년기_명) as 장년기_명
	, sum(세대_중년기_명) as 중년기_명
	, sum(세대_초기노년기_명) as 초기노년기_명
	, sum(세대_노년기_명) as 노년기_명
	, sum(세대_직업_명) as 사유_직업_명
	, sum(세대_가족_명) as 사유_가족_명
	, sum(세대_주택_명) as 사유_주택_명
	, sum(세대_교육_명) as 사유_교육_명
	, sum(세대_주거환경_명) as 사유_주거환경_명
	, sum(세대_자연환경_명) as 사유_자연환경_명
	, sum(세대_기타_명) as 사유_기타_명
from uhc_국내이동_전입건당_인원수_all2 a
where not(전출행정구역_시도코드||전출행정구역_시군구코드 = 전입행정구역_시도코드||전입행정구역_시군구코드)
group by 전입연도, 전출행정구역_시도코드, 전출시도명, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입시도명, 단독구분, 세대주포함_여부
;

select *
from 통계청mdis_전입전출행정구역코드_시군구;

-- 출장소 등의 행정조직 들이 데이터에 들어가 있음.
select *
from uhc_sgg_연간전입_단독_비단독_세대_인구
where 전입행정구역_시도코드||전입행정구역_시군구코드 = '45113' --덕진구
limit 100;

select *
from uhc_sgg_연간전입_단독_비단독_세대_인구
where 전입행정구역_시도코드||전입행정구역_시군구코드 = '45111' --완산구
limit 100;

select *
from uhc_sgg_연간전입_단독_비단독_세대_인구
where 전입행정구역_시도코드||전입행정구역_시군구코드 = '45118' --전주시 효자출장소
limit 100;

select count(*)
from uhc_sgg_연간전입_단독_비단독_세대_인구
limit 100;


select *
from uhc_국내이동_인구_all2
where 전입행정구역_시도코드||전입행정구역_시군구코드 = '45118' --전주시 효자출장소
limit 100;

-- 통계청mdis_인구동향_사망_사망연월일시/시도기준, 교육정도, 국적구분, 사망각세연령, 사망자 혼인상태코드, 사망자 국적구분
select *
from 통계청mdis_인구동향_사망
limit 100;

select min(신고연도||신고월||신고일), max(신고연도||신고월||신고일)
from 통계청mdis_인구동향_사망
limit 100;

select *
from 통계청mdis_인구동향_사망_코드정보
limit 100;

-- 통계청mdis_인구동향_출생신고 년월일/시도기준 --- 부/모 국적/결혼월/임신주수 등 demo정보, 모총출생아수, 모생존아수, 모국적/부국적 
select *
from 통계청mdis_인구동향_출생
limit 100;

select min(신고연도||신고월||신고일), max(신고연도||신고월||신고일)
from 통계청mdis_인구동향_출생
limit 100;

select *
from 통계청mdis_인구동향_출생_코드정보
limit 100;

-- 인구통태건수 데이터임.
-- 출생건수_명, 조출생률_천명당, 사망건수_명, 조사망률_천명당, 자연증가율_천명당, 혼인건수_건,
-- 조혼인률_천명당, 이혼건수_건, 조이혼율_천명당
select *
from 통계청_출생및사망_시군구_연간
limit 100;

select min(시점), max(시점)
from 통계청_출생및사망_시군구_연간;

-- 통계청 시군구 월별 혼인건수
select *
from 통계청_혼인
limit 100;

select distinct(tbl_nm)
from 통계청_혼인
limit 100;

select min(prd_de), max(prd_de)
from 통계청_혼인
limit 100;

-- 통계청 다문화 혼인
select *
from 통계청_다문화
limit 100;

select min(prd_de), max(prd_de)
from 통계청_다문화
limit 100;

-- 법정동코드 정리
select *
from 법정동코드;
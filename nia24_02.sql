select *
from 통계청mdis_전입전출행정구역코드_시군구;

select *
from 통계청mdis_전입전출행정구역코드_시도;

select *
from 통계청mdis_국내인구이동
where 전입년도 = '2023'
limit 100;

select distinct(파일_년도)
from 통계청mdis_국내인구이동;

select count(*)
from 통계청mdis_국내인구이동
where 전입연도 = '2023' and 전입월 = '12';

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
	 , case when 전입자1_세대주관계코드 is not null then '전입자1_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자2_세대주관계코드 is not null then '전입자2_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자3_세대주관계코드 is not null then '전입자3_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자4_세대주관계코드 is not null then '전입자4_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자5_세대주관계코드 is not null then '전입자5_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자6_세대주관계코드 is not null then '전입자6_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자7_세대주관계코드 is not null then '전입자7_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자8_세대주관계코드 is not null then '전입자8_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자9_세대주관계코드 is not null then '전입자9_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자10_세대주관계코드 is not null then '전입자10_세대주관계코드' end AS 전입자구분
		 , case when 전입자10_만연령 is not null then 전입자10_만연령 end AS 전입자연령
		 , case when 전입자10_성별코드 is not null then 전입자10_성별코드 end AS 전입자성별
	from numbered_2023
) a
where 전입자구분 is not null
order by 행번호;

-- 데이터 테이블 리뷰 : 데이터 체크 완료
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

create table uhc_국내이동_인구_all as
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
	 , case when 전입자1_세대주관계코드 is not null then '전입자1_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자2_세대주관계코드 is not null then '전입자2_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자3_세대주관계코드 is not null then '전입자3_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자4_세대주관계코드 is not null then '전입자4_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자5_세대주관계코드 is not null then '전입자5_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자6_세대주관계코드 is not null then '전입자6_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자7_세대주관계코드 is not null then '전입자7_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자8_세대주관계코드 is not null then '전입자8_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자9_세대주관계코드 is not null then '전입자9_세대주관계코드' end AS 전입자구분
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
		 , case when 전입자10_세대주관계코드 is not null then '전입자10_세대주관계코드' end AS 전입자구분
		 , case when 전입자10_만연령 is not null then 전입자10_만연령 end AS 전입자연령
		 , case when 전입자10_성별코드 is not null then 전입자10_성별코드 end AS 전입자성별
	from numbered_all
) a
where 전입자구분 is not null
order by 행번호;

select 전입자연령, count(distinct(전입자연령)) as 연령별_cnt
from uhc_국내이동_인구_all
group by 전입자연령;


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
order by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드;

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
create table uhc_국내이동_이주사유별_세대_all as
with 전입사유코드별_세대수 as 
(
	select 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드
	    , 전입사유코드
	    , count(distinct 행번호) as 전입세대수
	from uhc_국내이동_인구_all
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
group by 전입연도, 전입월, 전출행정구역_시도코드, 전출행정구역_시군구코드, 전입행정구역_시도코드, 전입행정구역_시군구코드, 전입사유코드, 전입세대수;
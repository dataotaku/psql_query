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
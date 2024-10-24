-- 기준연월, 시도명, 시군구명, 생활인구, 성별_계, 성별_남, 성별_여, 연령별_계, 
-- 연령별_20세미만, 연령별_20대, 연령별_30대, 연령별_40대, 연령별_50대, 연령별_60대, 연령별_70세이상, 시군구명2
select * 
from 통계청_생활인구_공표_생활인구_현황;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = '통계청_생활인구_공표_생활인구_현황';

DO $$
DECLARE
    columns TEXT;
BEGIN
    SELECT STRING_AGG(column_name, ', ')
    INTO columns
    FROM information_schema.columns
    WHERE table_name = '통계청_생활인구_공표_생활인구_현황';

    RAISE NOTICE 'Column Names: %', columns;
END $$;

-- 체류인구 배수, 재방문율_%, 평균체류일수_일, 평균체류시간_시간, 평균숙박일수_일, 타시도거주자비중_%, 시군구명
select * 
from 통계청_생활인구_공표_시군별_주요_특성_현황;

DO $$
DECLARE
    columns TEXT;
BEGIN
    SELECT STRING_AGG(column_name, ', ')
    INTO columns
    FROM information_schema.columns
    WHERE table_name = '통계청_생활인구_공표_생활인구_현황';

    RAISE NOTICE 'Column Names: %', columns;
END $$;

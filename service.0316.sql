---------------------------2023.03.16-------------------------
--SELECT 사용법

SELECT 이름, 나이 FROM 직원 WHERE 직원ID = 'A0001';

SELECT 직원ID, 패스워드, 이름, 성별, 연봉       --원하는 컬럼만 가져온다
FROM 직원                                    --데이터를 가져올 테이블을 정한다.
WHERE 성별 = '남' ;                          --원하는 행만 가져오도록 조건을 준다.

SELECT 직원ID, 입사일시, 주민등록번호, 연봉, 부서ID
FROM 직원;

SELECT 부서ID, 부서명, 근무지
FROM 부서;

SELECT 직원ID
     , 구분코드
     , 연락처
  FROM 직원연락처;
  
SELECT * 
  FROM 직원;
  
SELECT *
  FROM 직원주소;
  
-----------------------------------------------------------------------------  

SELECT DISTINCT 성별                                 --DISTINCT는 중복제거
  FROM 직원;
  
SELECT DISTINCT 
       성별
     , 이름
  FROM 직원;
  
SELECT *
  FROM 직원연락처;
  
SELECT DISTINCT
       직원ID
  FROM 직원연락처;
  
---------------------------------------------------------------------------
  
SELECT 직원ID    AS EMP_ID               --AS는 별명주기 컬럼의 이름을 바꿔줌
     , 패스워드  AS PASSWD
     , 이름      AS NAME
  FROM 직원;
  
--SELECT 직원ID   AS EMP ID             --띄어쓰기 불가
--     , 패스워드  AS 100PASSWD          --숫자로 시작 불가
--     , 이름      AS !!!                --특수문자는 $ , _ , #만 가능
--     , 연봉     AS SELECT             -- 예약어 불가
--  FROM 직원 ;
  
SELECT 직원ID   AS EMP_ID             -- 띄어쓰기 불가
     , 패스워드  AS PASSWD100         -- 숫자로 시작 불가
     , 이름      AS NAME              -- 특수문자는 $ , _ , #만 가능
     , 연봉     AS SELECT123          -- 예약어 불가
  FROM 직원 ;
  
SELECT *
  FROM 직원
 WHERE 직원ID = 'A0003';
 
 ------------------------------------------------------------------
 
INSERT INTO 직원 ( 
       직원ID
     , 패스워드
     , 이름
     , 성별
     , 입사일시
     , 주민등록번호
     , 연봉
     , 부서ID
) VALUES (
         'A0011' 
       , 'newman'
       , '신입'
       , '남' 
       , SYSDATE 
       , '940123-1332219' 
       , 3000 
       , 'D004' 
) ;

COMMIT;

SELECT * 
  FROM 직원;

--------------------------------------------------------------------------

CREATE TABLE 테스트테이블(
문자형 VARCHAR2(10),
숫자형 NUMBER,
날짜형 DATE);

SELECT *
  FROM 테스트테이블;
  
INSERT INTO 테스트테이블 ( 문자형 , 숫자형 , 날짜형 ) VALUES ( 'A' , 1 , SYSDATE ); --될까요? O
INSERT INTO 테스트테이블 ( 문자형 , 숫자형 , 날짜형 ) VALUES ( 'A' , '3살' , SYSDATE ); --될까요? X
INSERT INTO 테스트테이블 ( 문자형 , 숫자형 , 날짜형 ) VALUES ( 'A' , 3 , 1 ); --될까요? X
INSERT INTO 테스트테이블 ( 문자형 , 숫자형 , 날짜형 ) VALUES ( 'BB' , '3' , SYSDATE ); --될까요? O
INSERT INTO 테스트테이블 ( 문자형 , 숫자형 , 날짜형 ) VALUES ( 'ABC' , 123 , SYSDATE); -- 될까요? O
  
SELECT *
  FROM 테스트테이블;
  
--------------------------------------------------------------------------------

--WHERE 사용법

SELECT *
  FROM 직원
 WHERE 성별 = '남';
 
SELECT 직원ID
     , 이름
     , 나이
     , 입사일시
     , 연봉
  FROM 직원
 WHERE 연봉 >= 8000;
 --연습문제
SELECT 직원ID
     , 이름
     , 나이
     , 입사일시
  FROM 직원
 WHERE 연봉 > 9000;
 
SELECT *
  FROM 직원
 WHERE 이름 = '이현정';
 
SELECT *
  FROM 직원연락처
 WHERE 연락처 = '010-1231-1234';
 
SELECT 부서명
  FROM 부서
 WHERE 근무지 = '서울';
 
SELECT 주소
  FROM 직원주소
 WHERE 직원ID = 'A0007';
 
 -------------------------------------------------------------------------
 
-- AND 조건은 앞뒤가 모두 참이어야만 TRUE이다. 나머지는 다 거짓(FALSE)
-- OR 조건은 앞뒤가 모두 거짓이어만 FALSE이다. 나머지는 다 참(TRUE)

SELECT *
  FROM 직원
 WHERE 성별 = '남'
   AND 나이 >= 28;
   
SELECT *
  FROM 직원
 WHERE 부서ID = 'D002'
    OR 부서ID = 'D004';
--연습문제
SELECT 연락처
  FROM 직원연락처
 WHERE 구분코드 = '집전화'
   AND 직원ID = 'A0001';
   
SELECT *
  FROM 직원
 WHERE 부서ID = 'D003'
   AND 나이 >= 30;
   
SELECT*
  FROM 직원
 WHERE 직원ID = 'A0001'
    OR 직원ID = 'A0005'
    OR 직원ID = 'A0007';
    
SELECT *
  FROM 직원
 WHERE 부서ID = 'D001'
    OR 부서ID = 'D002'
   AND 이름 = '김철수';               --답은 2개 나옴
    
--------------------------------2023.03.20-------------------------------------

SELECT 직원ID, 연봉, 1 AS 리터럴
  FROM 직원;
  
SELECT 직원ID, 연봉, 1000, 연봉 +1000
  FROM 직원;
  
SELECT 직원ID, 연봉, 1000, 연봉 - 1000 AS 감봉
  FROM 직원;
  
SELECT 직원ID
     , 연봉
     , 연봉 * 0.1 AS 보너스
     , 연봉 + (연봉*0.1) AS 실수령액
  FROM 직원;
  
  
SELECT 이름, 연봉, 이름 || ' 직원의 연봉은 ' || 연봉 || '만원 입니다.'
  FROM 직원;
  
SELECT 이름, 나이, 이름 || ' 직원의 나이는 ' || 나이 || '살입니다.' AS 직원나이정보
  FROM 직원;

------------------------------------------------------------------------------
--내장형 함수
--문자형 함수

SELECT LOWER('ABCDE123@@') AS LOWER
  FROM DUAL;
  
SELECT 패스워드, UPPER(패스워드) AS UPPER한패스워드
  FROM 직원;
  
--SUBSRT 입력받은 문자형 리터럴에서 길이만큼 잘라낸다
SELECT 패스워드, SUBSTR(패스워드, 2, 4) AS SUBSTR한패스워드
  FROM 직원;
  
--TRIM 
SELECT TRIM('  안녕하세요  '), TRIM('안   녕  하 세 요 ')
  FROM DUAL;
  
--REPLACE 입력받은 문자형 리터럴 안에있는 바뀔값을 바꿀값으로 변경하여 출력한다.
SELECT 주민등록번호, REPLACE(주민등록번호, '-', ' ')
  FROM 직원;
  
--연습문제

SELECT SUBSTR('https://smhrd.or.kr/' , 9, 5 )
  from DUAL;
  
SELECT 직원ID, 주민등록번호, SUBSTR(주민등록번호, 1, 6) AS 생년월일
  FROM 직원;
  
SELECT 직원ID, 구분코드, 연락처, REPLACE(연락처, '-', ' ') AS 연락처번호만
  FROM 직원연락처;
  
-------------------------------------------------------------------------------
--숫자형 함수

--MOD : %와 같은 느낌
SELECT 연봉, MOD(연봉,1000)
  FROM 직원;
  
--ROUND : 실수를 소수점 자릿수까지 반올림한 결과를 출력
SELECT ROUND(1.452, 2), ROUND(1.452, 1)
  FROM DUAL;
  
-----------------------------------------------------------------------------
--날짜형 함수
  
--SYSDATE 현재 날짜와 시각을 날짜
SELECT SYSDATE FROM DUAL;

SELECT SYSDATE + 1 AS 하루더함
     , SYSDATE + 1/24 AS 한시간더함
     , SYSDATE + 1/24/60 AS 일분더함
     , SYSDATE + 1/24/60/60 AS 일초더함
  FROM DUAL;
  
SELECT 직원ID
     , 입사일시
     , ADD_MONTHS(입사일시, 60)
     , ADD_MONTHS(입사일시, -60)
  FROM 직원;

--연습문제
SELECT 직원ID
     , 입사일시
     , ADD_MONTHS(입사일시, 60) AS 오년후입사일시
  FROM 직원;
  
SELECT SYSDATE + 3 AS 사흘더함
  FROM DUAL;
  

-------------------------------------------------------------------------------
--형변환 함수
 
SELECT TO_NUMBER('1') FROM DUAL ; -- 문자형('1')을 숫자형(1) 로 형변환해 출력
 
SELECT TO_CHAR(1) FROM DUAL ; --숫자형(1)을 문자형('1') 로 형변환해 출력
 
SELECT TO_CHAR(SYSDATE , 'YYYY/MM/DD HH24:MI:SS') FROM DUAL ; 
 
SELECT TO_DATE('20230101' , 'YYYY/MM/DD') FROM DUAL ; 
 

/* 포맷 */
/*
YYYY : 연도 4자리
  MM : 월 2자리(1월이라면01)
  DD : 일 2자리(1일이라면 01, 20일이라면 20)
HH24 : 시간을 의미 (24시간제) 0~23시
  HH : 12시간제 (0~11)
MI(MINUTES) : 분 (0~59)
SS(SECONDS) : 초 (0~59)
*/

SELECT TO_DATE('20230101141212' , 'YYYY/MM/DD HH24:MI:SS') FROM DUAL;

------------------------------2023.03.21---------------------------------------

--NULL 함수 사용하기

--NVL(매우중요)
--NVL을 사용하면 널값에 ,오른쪽에 있는 값을 넣어줌
--널값이 아니면 그냥 그대로 출력
SELECT 직원ID, 나이, NVL(나이, 0)  
  FROM 직원;


--NVL을 사용하면 널값에 ,오른쪽에 있는 값을 넣고 다음 +20 을 해줌
SELECT 직원ID, 나이, NVL(나이, 0) + 20 
  FROM 직원;
  
  
--DECODE(DATA1,DATA2,DATA3,DATA4)(매우중요)
--DATA1과 DATA2를 비교해서 같으면 DATA3을 출력 다르면 DATA4를 출력
SELECT 직원ID, 부서ID, DECODE(부서ID, 'D001', 'OK', 'NO')
  FROM 직원;
  
--COALESCE
--앞에서부터 DATA를 확인하다가 NULL값이 아닌값이 나오면 출력
SELECT COALESCE(NULL,NULL,2,NULL)
  FROM DUAL;
  
  
--연습문제
--1번
SELECT 직원ID
     , 패스워드
     , 이름
     , 성별
     , NVL(나이,20) AS 나이
  FROM 직원;

--2번
SELECT 직원ID
     , 패스워드
     , 이름
     , DECODE(성별,'남','남성입니다.','여성입니다.') AS 성별
     , 나이
  FROM 직원;
  
  
  
------------------------------------------------------------------------------
--부정연산

SELECT *
  FROM 직원
 WHERE NOT 이름 = '이현정';
 
SELECT *
  FROM 직원
 WHERE 이름 != '이현정';
 
SELECT *
  FROM 직원
 WHERE NOT 나이 >= 28;
 
--연습문제
SELECT *
  FROM 직원연락처
 WHERE 구분코드 != '휴대폰';
 
SELECT 직원ID, 이름, 성별, 나이
  FROM 직원
 WHERE NOT 나이 < 50;
 
-------------------------------------------------------------------------------

--NULL 조건
--IS NULL/ IS NOT NULL로 출력 가능
 
--나이가 NULL인 데이터만 뽑을때 이렇게 쓰지 않는다.
--NULL은 정상적인 산술, 비교 연산 불가능하다.
 
SELECT *
  FROM 직원
 WHERE 나이 IS NULL;
 
SELECT *
  FROM 직원
 WHERE 나이 IS NOT NULL;
 
--연습문제
SELECT *
  FROM 직원
 WHERE 나이 IS NOT NULL;
 
SELECT *
  FROM 직원
 WHERE 입사일시 IS NULL;
 
-------------------------------------------------------------------------------
--SQL 연산자(IN/BETWEEN/LIKE)

--IN 연산자
SELECT *
  FROM 직원
 WHERE 직원ID IN ('A0001','A0003','A0005');
 --아래랑 위의 결과가 같음
SELECT *
  FROM 직원
 WHERE 직원ID = 'A0001'
    OR 직원ID = 'A0003'
    OR 직원ID = 'A0005';
--IN연산자는 뒤에 입력되는 파라미터 중 NULL은 무시한다.
--NOT IN 연산자는 뒤에 입력된 조건 값들을 제외한 대상을 출력해줍니다.
--(주의사항 ? 조건 값 중에 NULL이 들어가면 아무것도 출력하지 않습니다)

SELECT *
  FROM 직원
 WHERE 직원ID NOT IN ('A0001','A0003','A0005');
 
SELECT *
  FROM 직원
 WHERE 직원ID NOT IN ('A0001','A0003','A0005',NULL);
 --위를 풀어쓴거가 아래
 SELECT *
  FROM 직원
 WHERE 직원ID != 'A0001'
   AND 직원ID != 'A0003'
   AND 직원ID != 'A0005'
   AND 직원ID != NULL;
   

--BETWEEN
SELECT *
  FROM 직원
 WHERE 나이 >= 20
   AND 나이 <= 29;
--위의 식을 BETWEEN을써서 간략하게 하면 아래 식
SELECT *
  FROM 직원
 WHERE 나이 BETWEEN 20 AND 29;
 
--주의사항 3가지
-- 모든 자료형 가능(날짜형, 숫자형, 문자형 전부 쓸 수 있음)
SELECT *
  FROM 직원
 WHERE 입사일시 BETWEEN SYSDATE - 365 AND SYSDATE; --지금으로부터 1년전부터 입사한 사람
 
SELECT *
  FROM 직원
 WHERE 직원ID BETWEEN 'A0001' AND 'A0003'; --문자열 비교도 가능

-- OR가 아님 무조건 AND를 사용해야함
-- 이상-이하임


--LIKE
--LIKE 연산자는 _ 나 % 같은 와일드카드(특수문자)를 이용해 매칭 연산을 진행합니다.

--직원들 중 이름이 '강'으로 시작하는 모든 대상을 출력
SELECT * FROM 직원 WHERE 이름 LIKE '강%';
--직원들 중 이름 중간에 '홍'이 포함된 모든 대상을 출력
SELECT * FROM 직원 WHERE 이름 LIKE '%홍%';
--직원들 중 패스워드가'123'으로 끝나는 모든 대상을 출력
SELECT * FROM 직원 WHERE 패스워드 LIKE '%123';

--직원들 중 이름의 세번째 굴자가 '수'인 세글자인 모든 대상을 출력
SELECT * FROM 직원 WHERE 이름 LIKE '__수';
--부서이름중 @@부처럼 3글자로 이뤄지고 부로 끝나는 모든 대상을 출력
SELECT * FROM 부서 WHERE 부서명 LIKE '__부';

--연습문제
--직원 테이블에서 이름에 '철'이 포함되는 직원의 직원ID, 이름, 나이를 출력해주세요
SELECT 직원ID, 이름, 나이
  FROM 직원
 WHERE 이름 LIKE '%철%';
 
--직원 중에 2015년도에 입사를 했거나, 입사일시가 정해지지 않은 직원의 모든 정보를 출력해주세요
SELECT *
  FROM 직원
 WHERE TO_CHAR(입사일시, 'YYYY') = '2015'
    OR 입사일시 IS NULL;

--2017년 이후부터 현재 시점까지 입사한 모든 직원을 출력해주세요
SELECT *
  FROM 직원
 WHERE 입사일시 >= TO_DATE('20170101')
   AND 입사일시 <  SYSDATE;
   
--직원 중에 연봉이 7000~9000 사이인 직원들의 직원ID, 연봉, 입사일시를 출력해주세요
SELECT 직원ID, 연봉, 입사일시
  FROM 직원
 WHERE 연봉 BETWEEN 7000 AND 9000;
 
 --직원주소 테이블에서 주소가 '동구'로 시작하는 모든 데이터를 출력해주세요
SELECT *
  FROM 직원주소
 WHERE 주소 LIKE '동구%';
 
 
 
--------------------------------------------------------------------------------
--FROM사용법

SELECT SERVICE.직원.직원ID
  FROM SERVICE.직원
 WHERE SERVICE.직원.직원ID = 'A0005';
--실제로 오라클에서는 위에처럼 실행함
SELECT 직원ID
  FROM 직원
 WHERE 직원ID = 'A0005';
 
SELECT *
  FROM 직원, 직원연락처;
  
--FROM뒤에 테이블이 두개 이상일때, 테이블을 명시해서 컬럼을 입력해야 함
SELECT 직원.직원ID
     , 직원.이름
     , 직원.나이
     , 직원.연봉
     , 직원연락처.직원ID
     , 직원연락처.연락처
  FROM 직원, 직원연락처
 WHERE 직원.직원ID = 직원연락처.직원ID;
--FROM 뒤 테이블에 별칭을 주면 작성이 용이해짐 #AS를 사용하지 않음
SELECT A.직원ID
     , A.이름
     , A.나이
     , A.연봉
     , B.직원ID
     , B.연락처
  FROM 직원 A, 직원연락처 B
 WHERE A.직원ID = B.직원ID;  --별칭을 썻으면 뒤에도 별칭을 꼭 써줘야함
 --WHERE 직원.직원ID 이런식으로 쓰면 안됌
 
 
--------------------------------2023.03.22--------------------------------------

 --JOIN의미와 원리
SELECT A.직원ID
     , A.이름
     , A.연봉
     , B.연락처
  FROM 직원 A
     , 직원연락처 B
 WHERE A.직원ID = B.직원ID   --테이블 2개 이상 쓰기 때문에 구분이 꼭 필요하다.
   AND A.직원ID = 'A0006'
   AND B.구분코드 = '휴대폰';
   
   


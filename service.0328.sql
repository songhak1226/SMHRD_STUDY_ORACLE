
--ROWNUM
--테이블의 튜플(행)에 임시로 부여되는 일련번호


SELECT ROWNUM AS RN
     , 직원ID
     , 이름
     , 연봉
     , 부서ID
  FROM 직원;
  -- ROWNUM처럼 실제 테이블에 없는데 사용되는 애들을 가짜컬럼(의사컬럼)이라고 한다.
  
SELECT ROWNUM AS RN
     , 직원ID
     , 이름
     , 연봉
     , 부서ID
  FROM 직원
 WHERE ROWNUM <= 3;
 
SELECT ROWNUM AS RN
     , 직원ID , 이름 , 연봉 , 부서ID
  FROM 직원
 WHERE ROWNUM = 1;         --이건 가능
 
SELECT ROWNUM AS RN
     , 직원ID , 이름 , 연봉 , 부서ID
  FROM 직원
 WHERE ROWNUM = 2;         --이건 불가능 (1의값을 사용하지 않고 2를 사용못함)
 
 SELECT ROWNUM AS RN
     , 직원ID , 이름 , 연봉 , 부서ID
  FROM 직원
 WHERE ROWNUM <= 3;        --이건 1이 포함되서 가능
 
 
SELECT *
  FROM (
        SELECT ROWNUM AS RN
             , 직원ID
             , 이름
             , 연봉
             , 부서ID
         FROM 직원
       )
 WHERE RN <= 10; 
--ROWNUM 개념과 인라인뷰 개념을 조합해서 상위N개의 데이터만 뽑는 기술을 터득할 수 있음
--이 기술을 TOP-N기술이라고 한다.
 
--연습문제
SELECT *
  FROM 직원
 WHERE 연봉 IS NOT NULL
 ORDER BY 연봉 DESC;
 
 
--직원의 연봉이 높은 순서대로 상위 5명만 출력해봅시다
SELECT *
  FROM (
        SELECT *
          FROM 직원
         WHERE 연봉 IS NOT NULL
         ORDER BY 연봉 DESC
          )
 WHERE ROWNUM <= 5;
 
 
SELECT *
  FROM (
        SELECT * 
          FROM 직원
         WHERE 연봉 IS NOT NULL
         ORDER BY 연봉
        )
 WHERE ROWNUM <=3;
 
SELECT *
  FROM (
        SELECT * 
          FROM 직원
         WHERE 입사일시 IS NOT NULL
         ORDER BY 입사일시 DESC
        )
 WHERE ROWNUM <=3;
 
 
 
 
 
 
 
 
CREATE TABLE 게시판 (
게시판번호 NUMBER(9) PRIMARY KEY ,
작성자 VARCHAR2(50) NOT NULL ,
게시물내용 VARCHAR2(4000) NOT NULL ,
작성일시 DATE NOT NULL
) ;
INSERT INTO 게시판
SELECT LEVEL -- 게시판번호
, '아이디' || MOD(LEVEL , 10000) -- 작성자
, '아이디' ||
MOD(LEVEL , 10000) ||
'님이 작성하신 게시물입니다. 이 게시물은 게시판 번호가 '
|| LEVEL
|| '입니다' -- 게시물내용
, TO_DATE('20000101') + LEVEL --2022년 1월1일부터 하루씩 게시물이 입력되는 것
FROM DUAL
CONNECT BY LEVEL <=1000000; --100만건의 데이터 입력
COMMIT;

SELECT * FROM 게시판;



SELECT * 
  FROM(
       SELECT * 
         FROM 게시판
        ORDER BY 작성일시 DESC
        )
 WHERE ROWNUM <= 20;
 
 

SELECT * 
  FROM(
  SELECT ROWNUM AS RN
  , A.*
       SELECT * 
         FROM 게시판
        ORDER BY 작성일시 DESC
        ) A
        WHERE ROWNUM <= 20 * N
        )
 WHERE ROWNUM >= 20 * (N-1;
 
 
 
 
 
 
 
 
 
 
 
 
------------------------------------------------------------------------------
--서브쿼리

ALTER TABLE 직원 MODIFY (부서ID NULL) ;
UPDATE 직원 SET 부서ID = NULL WHERE 직원ID = 'A0005' ;
COMMIT;

SELECT A.직원ID
     , A.연봉
     , A.부서ID
     , (
        SELECT 부서명
          FROM 부서
         WHERE 부서ID = A.부서ID
         ) AS 부서명
  FROM 직원 A
 WHERE 직원ID BETWEEN 'A0001' AND 'A0006';
 
 
 
SELECT A.직원ID, A.연봉, A.부서ID, B.부서명
  FROM 직원 A, 부서 B
 WHERE A.부서ID = B.부서ID(+)
   AND A.직원ID BETWEEN 'A0001' AND 'A0006';
   
SELECT A.직원ID, A.연봉, A.부서ID, B.부서명
  FROM 직원 A LEFT OUTER JOIN 부서 B
    ON (A.부서ID = B.부서ID)
 WHERE A.직원ID BETWEEN 'A0001' AND 'A0006';
 
SELECT *
  FROM 부서
 WHERE 1=1;
   
   
SELECT * FROM 직원;


--연습문제
SELECT A.직원ID, A.연봉, A.부서ID, ( SELECT 부서명 FROM 부서 WHERE 부서ID = A.부서ID) AS 부서명
  FROM 직원 A
 WHERE 직원ID BETWEEN 'A0001' AND 'A0006';
 
 
SELECT A.직원ID
     , A.이름
     , A.주민등록번호
     , (SELECT 연락처 
          FROM 직원연락처 
         WHERE 직원ID = A.직원ID 
           AND 구분코드 = '휴대폰') AS 휴대폰번호
  FROM 직원 A
 WHERE 직원ID BETWEEN 'A0006' AND 'A0010';



SELECT A.직원ID
     , A.이름
     , A.주민등록번호
     , (SELECT 연락처 
          FROM 직원연락처 
         WHERE 직원ID = A.직원ID 
           AND 구분코드 = '휴대폰') AS 휴대폰번호
     , (SELECT 주소 
          FROM 직원주소 
         WHERE 직원ID = A.직원ID 
           AND 구분코드 = '집') AS 집주소
  FROM 직원 A
 WHERE 직원ID BETWEEN 'A0006' AND 'A0010';
 
 -----
 
 
 SELECT A.직원ID , A.연봉 , A.부서ID , B.부서명 , B.근무지  
  FROM 직원 A , 부서 B 
 WHERE A.부서ID = B.부서ID(+) 
   AND A.직원ID BETWEEN 'A0001' AND 'A0005'    
   AND B.근무지(+) = '서울';
   
   
   
SELECT A.직원ID , A.연봉 , A.부서ID , B.부서ID , B.부서명 , B.근무지  
  FROM 직원 A LEFT OUTER JOIN 부서 B ON ( A.부서ID = B.부서ID  AND B.근무지 = '서울') 
 WHERE A.직원ID BETWEEN 'A0001' AND 'A0005'   ; 
 
------------------------------------------------------

SELECT A.직원ID
     , A.이름
     , A.연봉
     , B.부서별최고연봉
  FROM 직원 A
     , ( SELECT 부서ID, MAX(연봉) AS 부서별최고연봉
           FROM 직원
          WHERE 부서ID IS NOT NULL
          GROUP BY 부서ID
          ) B
 WHERE A.부서ID = B.부서ID
   AND A.연봉 = B.부서별최고연봉;
   
   
--연습문제
SELECT A.직원ID
     , A.이름
     , A.연봉
     , B.부서별최저연봉
  FROM 직원 A
     , ( SELECT 부서ID, MIN(연봉) AS 부서별최저연봉
           FROM 직원
          WHERE 부서ID IS NOT NULL
          GROUP BY 부서ID
          ) B
 WHERE A.부서ID = B.부서ID
   AND A.연봉 = B.부서별최저연봉;
   
   
SELECT A.직원ID, A.이름, A.연봉, B.부서별최저연봉
  FROM 직원A
     , (
         SELECT 부서ID, MIN(연봉) AS 부서별최저연봉
           FROM 직원
          WHERE 부서ID IS NOT NULL
          GROUP BY 부서ID
        ) B
WHERE A.부서ID = B.부서ID
  AND A.연봉 = B.부서별최저연봉;
   

SELECT *
  FROM ( SELECT *
           FROM 직원
          WHERE 나이 IS NOT NULL
          ORDER BY 나이
          )
 WHERE ROWNUM <=3;
 


------------------------------------------------------------------------------
--중첩서브쿼리

SELECT *
  FROM 직원                                 
 WHERE 연봉 >= (SELECT AVG(연봉)       --비상관 서브쿼리
                  FROM 직원           --여기서 직원 연봉 평균을 구하고
               );
               
--비상관 서브쿼리
--서브쿼리가 먼저 실행되고 메인 쿼리가 실행된다.



SELECT *
  FROM 직원 A
 WHERE 연봉 = ( SELECT MIN(연봉)
                  FROM 직원
                 WHERE 부서ID = A.부서ID);
                 
------------------------------------------------------------------------------
--연습문제
                 
SELECT *
  FROM 직원 A
 WHERE 연봉 = ( SELECT MAX(연봉)
                  FROM 직원
                 WHERE 부서ID = A.부서ID);
                 
SELECT *
  FROM 직원 A
 WHERE 입사일시 = ( SELECT MAX(입사일시)
                     FROM 직원);
                     
SELECT *
  FROM 직원 A
 WHERE 연봉 = (SELECT MAX(연봉)
                 FROM 직원);
                 
                 
                 
-----------------------------------------------------------------------------
--단일행/다중행 연산자

SELECT *
  FROM 직원 A
 WHERE 연봉 = ( SELECT 연봉
                  FROM 직원
                 WHERE 부서ID = 'D001');
             
--위는 오류 아래는 정상실행

SELECT *
  FROM 직원 A
 WHERE 연봉 IN ( SELECT 연봉
                  FROM 직원
                 WHERE 부서ID = 'D001');    --다중행은 IN,EXISTS, NOT EXISTS, ANY, ALL등
                 
                 
SELECT *
  FROM 직원
 WHERE 연봉 IN( SELECT MAX(연봉)
                  FROM 직원
                 GROUP BY 부서ID);


SELECT *
  FROM 직원
 WHERE 연봉 = ANY ( SELECT MAX(연봉)
                      FROM 직원
                     GROUP BY 부서ID);
                     

SELECT *
  FROM 직원
 WHERE 연봉 >= ALL ( SELECT MAX(연봉)
                      FROM 직원
                     GROUP BY 부서ID);
                     
                     
                     
UPDATE 직원 SET 연봉 = 2800 WHERE 직원ID = 'A0001';

SELECT * FROM 직원;

COMMIT;
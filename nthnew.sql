--TB_CUST는 회원 정보가 들어있는 테이블
--TB_CUST_ADDR은 회원 주소 정보가 있는 테이블

SELECT CUST_ID
     , CUST_NAME
  FROM TB_CUST A
 WHERE EXISTS (
                SELECT 1
                  FROM TB_CUST_ADDR
                 WHERE CUST_ID = A.CUST_ID
                 );
                 
SELECT CUST_ID
     , CUST_NAME
  FROM TB_CUST A
 WHERE NOT EXISTS (
                SELECT 1
                  FROM TB_CUST_ADDR
                 WHERE CUST_ID = A.CUST_ID
                 );
                 
                 
--------------------------실습문제----------------------------------                 
-- 1.                 
SELECT *
FROM TB_PRD;

SELECT A.CUST_ID
     , A.CUST_NAME
  FROM TB_CUST A
 WHERE EXISTS (
                SELECT 1
                  FROM TB_PRD
                 WHERE REG_ID = A.CUST_ID
                );
                 
                 
-- 2.
SELECT CUST_ID, CUST_NAME, BIRTH_DY
  FROM TB_CUST A
 WHERE NOT EXISTS (
                    SELECT 1
                      FROM TB_CUST_TEL
                     WHERE CUST_ID = A.CUST_ID
                       AND TEL_DVCD = '집'
                     );
                 
SELECT CUST_ID, CUST_NAME, BIRTH_DY
  FROM TB_CUST;
  
SELECT *
FROM TB_CUST_TEL;                 
                 
-----------------------------------------------------------------------------

                 
                 
-- 데이터를 출력(조회)하는 방법들         

-- 조인으로 가져올 경우
-- 조인 : 
SELECT A.CUST_ID
     , A.CUST_NAME
     , A.SCORE
     , B.GRADE_NAME
  FROM TB_CUST A
     , TB_GRADE B
 WHERE A.SCORE BETWEEN B.STS_SCORE AND B.END_SCORE;
 
--서브쿼리로 가져올 경우
SELECT A.CUST_ID
     , A.CUST_NAME
     , A.SCORE
     , (
        SELECT GRADE_NAME
          FROM TB_GRADE
         WHERE A.SCORE BETWEEN STS_SCORE AND END_SCORE ) AS GRADE_NAME
  FROM TB_CUST A;
  
-- DECORE로 가져올 경우
SELECT A.CUST_ID
     , A.CUST_NAME
     , A.SCORE
     , DECODE( CEIL(SCORE/20), 0, '브론즈', 1, '브론즈' , 2, '실버', 3, '골드', 4, 'VIP', 5, 'VVIP') AS GRADE_NAME
  FROM TB_CUST A;
  
--CASE 문법으로 가져올 경우
SELECT CUST_ID
     , CUST_NAME
     , SCORE
     , CASE WHEN SCORE > 100 THEN '범위오류'
            WHEN SCORE >= 81 THEN 'VVIP'
            WHEN SCORE >= 61 THEN 'VIP'
            WHEN SCORE >= 41 THEN '골드'
            WHEN SCORE >= 21 THEN '실버'
            WHEN SCORE >=  0 THEN '브론즈'
            ELSE '범위오류'
             END AS GRADE_NAME
  FROM TB_CUST ;
  
  
------------------------실습 문제------------------------------------------
-- 1.
SELECT PRD_ID
     , PRD_NAME
     , PRD_AMT
     , CASE WHEN PRD_AMT >  999999 THEN '매우비쌈'
            WHEN PRD_AMT >= 100000 THEN '비쌈'
            WHEN PRD_AMT >=  10000 THEN '보통'
            WHEN PRD_AMT >=      0 THEN '저렴'
            ELSE '범위 오류'
             END AS 가격대
  FROM TB_PRD
  ORDER BY PRD_AMT DESC;
  
-- 2.
SELECT PRD_ID
     , PRD_NAME
     , PRD_TYPE
     , PRD_AMT
     , CASE WHEN PRD_TYPE = '컴퓨터' OR PRD_TYPE = '스마트폰' THEN PRD_AMT + 100000
            ELSE PRD_AMT
             END AS 인상된가격
   FROM TB_PRD
  ORDER BY PRD_AMT DESC;     
  
-- 3.
SELECT QNA_ID
     , QNA_CONTENT
     , QNA_ANSWER
     , CASE WHEN QNA_ANSWER IS0 NULL THEN 'N'
            ELSE 'Y'
             END AS 문의응답여부
  FROM TB_QNA;
  
---------------------------------------------------------------------------------


--MERGE 문법
--SELECT로 판단을 해서 UPDATE나 INSERT하는 행위를 한번에 처리해줌
MERGE INTO TB_CUST_TEL
USING DUAL
   ON (CUST_ID = 'C0007' AND TEL_DVCD = '휴대폰')
--MERGE INTO 대상테이블 USING 비교할테이블(없으면DUAL) ON(찾아볼조건)

WHEN MATCHED THEN -- 위 조건에 해당하는 값이 있다면 UPDATE
UPDATE SET TEL_NO = '010-7777-7777'

WHEN NOT MATCHED THEN -- 위조건에 해당하는 값이 없다면 INSERT
INSERT (CUST_ID, TEL_DVCD, TEL_NO)
VALUES ('C0007', '휴대폰', '010-7777-7777');

-------------------------------------------------------------------------------

SELECT * FROM 직원;
SELECT * FROM 직원_신입;

MERGE INTO 직원 A
USING 직원_신입 B
   ON (A.직원ID = B.직원ID)
   
WHEN MATCHED THEN
UPDATE
   SET A.직원이름 = B.직원이름
     , A.연봉 = B.연봉
     
WHEN NOT MATCHED THEN
INSERT (A.직원ID, A.직원이름, A.연봉)
VALUES (B.직원ID, B.직원이름, B.연봉);

-------------------------------------------------------------------------------

SELECT * FROM 콘서트예매내역;
SELECT * FROM 뮤지컬예매내역;
SELECT * FROM 극장예매내역;

SELECT 예매번호, 뮤지컬이름 AS 공연이름, 뮤지컬가격 AS 공연가격
  FROM 뮤지컬예매내역
 WHERE 예매번호 >= 3
UNION ALL

SELECT 예매번호, 콘서트이름, 콘서트가격
  FROM 콘서트예매내역
 WHERE 예매번호 >= 3
UNION ALL

SELECT 예매번호, 극이름, 극가격
  FROM 극장예매내역
 WHERE 예매번호 >= 3;
 
-- 2.
SELECT 뮤지컬가격 AS 공연가격
  FROM 뮤지컬예매내역
UNION 
SELECT 콘서트가격
  FROM 콘서트예매내역
UNION 
SELECT 극가격
  FROM 극장예매내역;
  
  
-- 11g (공공기관 등에서 가장 많이 쓰는 버전)
-- 21c (가장 최신)


---------------------------------------------------------------------------------
-- 윈도우함수 : 테이블의 행과 행간의 관계를 이용해서 의미있는 데이터를 뽑는다
SELECT 지점코드
 , ( SELECT 지점위치
 FROM 지점
 WHERE 지점코드 = X.지점코드 ) AS 지점위치
 , 매출액
 , RANK() OVER ( ORDER BY 매출액 DESC ) AS 순위
 FROM (
SELECT A.지점코드
 , SUM(B.매출액) AS 매출액
 FROM 지점 A INNER JOIN 월별매출 B
ON ( A.지점코드 = B.지점코드 )
GROUP BY A.지점코드
 ) X
ORDER BY 순위 ;



----------------------------------실습문제---------------------------------

-- 1.
SELECT PRD_ID
     , PRD_NAME
     , PRD_AMT
     , DENSE_RANK() OVER (ORDER BY PRD_AMT DESC) AS 가격대순위
  FROM TB_PRD;
  
-- 2.
SELECT *
FROM (
SELECT PRD_ID
     , PRD_NAME
     , PRD_AMT
     , DENSE_RANK() OVER (ORDER BY PRD_AMT DESC) AS 가격대순위
  FROM TB_PRD
  )
 WHERE 가격대순위 <= 5;
 
 
 ---------------------------------------------------------------------------

-- 순위 함수
SELECT 경기장 , 승자 , 패자 , 점수차
 FROM (
SELECT 경기장 , 승자 , 패자 , 점수차
 , ROW_NUMBER() OVER ( PARTITION BY 경기장 ORDER BY 점수차 DESC ) AS
RNUM
FROM 월드컵경기내역
 )
WHERE RNUM = 1;

-- GROUP BY 비슷하다?
-- GROUP BY 는 실제로 행이 줄어버린다
-- PARTITION BY는 행이 줄지 않는다. (원본 그대로 유지)

-- 인라인뷰로도 가능합니다.


-- 실습 문제 1.
SELECT PRD_ID
     , PRD_NAME
     , PRD_TYPE
     , PRD_AMT
  FROM (
SELECT PRD_ID
     , PRD_NAME
     , PRD_TYPE
     , PRD_AMT
     , ROW_NUMBER() OVER ( PARTITION BY PRD_TYPE ORDER BY PRD_AMT DESC ) AS RNUM
  FROM TB_PRD
  )
 WHERE RNUM = 1;
 
-------------------------------------------------------------------------------

SELECT 분류코드
 , 상품명
 , 가격
 , SUM(가격) OVER ( ORDER BY 분류코드 , 상품명 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
AS 현재행까지합계
 FROM 상품;
 
----------------------------------------------------------------------------------
-- INDEX

CREATE INDEX IDX_PRD ON TB_PRD(PRD_TYPE);

--/*+RULE*/ 힌트
SELECT /*+ RULE */ PRD_ID, PRD_NAME, PRD_TYPE
  FROM TB_PRD
 WHERE PRD_TYPE = '스마트폰'; -- F10누르면 실행계획을 볼 수 있다
 

------------------------------------------------------------------------------
--NL조인
SELECT /*+ ORDERED USE_NL(B) */ *
  FROM TB_TEST1 A
     , TB_TEST2 B
 WHERE A.COL1 = B.COL1;

CREATE INDEX IDX_TEST2 ON TB_TEST2(COL1);

----------------------------------------------------------------
-- 계층 쿼리
--예시
SELECT 메뉴ID
, 상위메뉴ID
, 메뉴이름
 , LEVEL
, LPAD(' ' , ( LEVEL -1 ) * 2 , ' ' ) || 메뉴이름
 FROM 메뉴
WHERE 1=1 -- WHERE 조건이 없으면 따로 안써도 됨
START WITH 상위메뉴ID IS NULL
CONNECT BY NOCYCLE 상위메뉴ID = PRIOR 메뉴ID
ORDER SIBLINGS BY 메뉴ID ;

--
SELECT 댓글ID
 , 상위글
 , 작성글
 , CASE WHEN 작성글 IS NULL THEN
 ( SELECT 게시물내용
 FROM 게시판
 WHERE 게시글ID = 상위글 )
 ELSE LPAD('ㅣ-' , LEVEL*2 , ' ') || 작성글
 END
 AS 계층쿼리결과
 , LEVEL
 FROM 댓글
START WITH 작성글 IS NULL
CONNECT BY PRIOR 댓글ID = 상위글 ;

INSERT INTO 댓글
VALUES ('C0007', 'C0006', '가지무침싫어요'); -- 대댓글



---------------------------------------------------------------------
-- 프로시저

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE P_SOLD_OUT_YN_DEL
AS -- 변수 (메소드 비슷)
--v_cnt NUMBER := 0; --v_cnt는 숫자형, 0으로 초기화하겠다
v_cust_id TB_CUST.CUST_ID%TYPE;
v_cust TB_CUST%ROWTYPE;
BEGIN
    --원하는 쿼리
        -- System.out.println()
--    DBMS_OUTPUT.PUT_LINE('프로시저 실행');
    
--    EXCEPTION
--     WHEN OTHERS THEN
--      NULL;

--DBMS_OUTPUT : 클래스 / PUT_LINE : 메소드
--DBMS_OUTPUT.PUT_LINE(v_cnt);
--SELECT COUNT(8) INTO v_cnt FROM TB_CUST;
--DBMS_OUTPUT.PUT_LINE(v_cnt);

SELECT CUST_ID INTO v_cust_id FROM TB_CUST WHERE CUST_NAME = '고객001';
DBMS_OUTPUT.PUT_LINE('해당 고객의 아이디는' || v_cust_id || '입니다');

SELECT * INTO v_cust FROM TB_CUST WHERE CUST_ID = 'C0001';
    DBMS_OUTPUT.PUT_LINE('해당 고객의 아이디는' || v_cust.CUST_ID || '입니다');
    DBMS_OUTPUT.PUT_LINE('해당 고객의 생일은' || v_cust.BIRTH_DY || '입니다');
      
END;    
/
------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE P_SOLD_OUT_YN_DEL
AS
v_sold_yn VARCHAR2(5); --v_sold_yn이라는 가변형문자형 변수 선언
                      --초기화는 따로 하지 않았음

BEGIN
    SELECT SOLD_OUT_YN INTO v_sold_yn FROM TB_PRD WHERE PRD_ID = 'P0001';
    IF v_sold_yn = 'Y'
    THEN DBMS_OUTPUT.PUT_LINE('P0001 상품은 품절입니다.');
    ELSIF v_sold_yn = 'N'
    THEN DBMS_OUTPUT.PUT_LINE('P0001 상품은 판매중입니다');
    END IF;
    v_sold_yn := null;
    SELECT SOLD_OUT_YN INTO v_sold_yn FROM TB_PRD WHERE PRD_ID = 'P0015';
    IF v_sold_yn = 'Y'
    THEN DBMS_OUTPUT.PUT_LINE('P0015 상품은 품절입니다');
    ELSE DBMS_OUTPUT.PUT_LINE('P0015 상품은 판매중입니다');
    END IF;
END;
/

EXEC P_SOLD_OUT_YN_DEL;

-----------------------------------------------------

CREATE OR REPLACE PROCEDURE P_SOLD_OUT_YN_DEL
AS
v_prd_id TB_PRD.PRD_ID%TYPE;        --v_prd_id의 컬럼타입은 TB_PRD의 PRD_ID와 동일하게
v_sold_yn TB_PRD.SOLD_OUT_YN%TYPE;  --v_sold_yn의 컬럼타입은 TB_PRD의 SOLD_OUT_YN과 동일하게

CURSOR c_prd_cursor IS SELECT pRD_ID, SOLD_OUT_YN FROM TB_PRD;
-- 커서는 포인터의 개념과 비슷함
-- 즉 IS 뒤에있는 SELECT 결과를 인스턴스 기준으로 한 행씩 가져오도록 할 수 있음

BEGIN
    OPEN c_prd_cursor; --위 커서를 사용(열어서)하겠다는 의미

    LOOP --LOOP반복문의 시작을 의미
        FETCH c_prd_cursor INTO v_prd_id, v_sold_yn; --FETCH를 하면 저장된 커서에서 한 행씩을 가져오기가 가능
        IF v_sold_yn = 'Y' then
            dbms_output.put_line(V_PRD_ID || '는 품절입니다.');
        ELSE 
            dbms_output.put_line(V_PRD_ID || '는 판매중입니다.');
        END IF;
        
        EXIT WHEN c_prd_cursor%NOTFOUND; --더이상 가져올 행이 없다면(COTFOUND) 반복을 종료(EXIT)
    END LOOP; --LOOP 반복문의 끝을 의미
    CLOSE c_prd_cursor; --위 커서를 다시 닫겠다는 의미
END; --프로시저 생성종료
/

EXEC P_SOLD_OUT_YN_DEL;








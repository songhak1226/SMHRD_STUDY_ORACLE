--DDL
--테이블 같은 데이터 저장소 객체를 만들거나 수정한다.

--CREATE
--새로운 객체(OBJECT)를 생성할 때 사용하는 명령어

CREATE TABLE QUIZ_TABLE (
Q_ID         NUMBER(3,0) NOT NULL,
Q_CONTENT    VARCHAR2(200) NOT NULL,
Q_ANSWER     VARCHAR2(100),
REG_DATE     DATE DEFAULT SYSDATE
);

COMMIT;
SELECT * FROM QUIZ_TABLE;

INSERT INTO QUIZ_TABLE(
       Q_ID
     , Q_CONTENT
     , Q_ANSWER
     , REG_DATE
) VALUES (
       1
     , '쥐는 영어로 무엇일까요?'
     , 'mouse'
     , SYSDATE
);
INSERT INTO QUIZ_TABLE(
       Q_ID
     , Q_CONTENT
     , Q_ANSWER
     , REG_DATE
) VALUES (
       2
     , '달력은 영어로 무엇일까요?'
     , 'calendar'
     , SYSDATE
);
INSERT INTO QUIZ_TABLE(
       Q_ID
     , Q_CONTENT
     , Q_ANSWER
     , REG_DATE
) VALUES (
       3
     , '종이는 영어로 무엇일까요?'
     , 'paper'
     , SYSDATE
);


--COMMENT 사용법
COMMENT ON TABLE QUIZ_TABLE IS '퀴즈 정보가 들어간 테이블';
COMMENT ON COLUMN QUIZ_TABLE.Q_ID IS '퀴즈ID';




--제약조건
--PRIMARY KEY(PK)
--특정 컬럼을 식별자로 만들면 자동으로 NOT NULL + UNIQUE 성질로 바뀌게 된다.
ALTER TABLE QUIZ_TABLE ADD CONSTRAINT PK_QUIZ_TABLE PRIMARY KEY (Q_ID);

--UNIQUE KEY(UK)
--NULL값은 가능 중복값은 불가능


--FOREIGN KEY(FK) = 외래키
--테이블끼리 연결되어 있는 관계를 물리적 모델링한 것

     
--연습문제
CREATE TABLE 회원정보 (
회원ID VARCHAR2(10) NOT NULL,
이름 VARCHAR2(20) NOT NULL,
가입일자 DATE,
나이 NUMBER(3,0) DEFAULT 0
);

CREATE TABLE 회원연락처 (
회원ID VARCHAR2(10) NOT NULL,
구분코드 VARCHAR2(10) NOT NULL,
연락처 VARCHAR2(15) NOT NULL
);

CREATE TABLE 회원주소 (
회원ID VARCHAR2(10) NOT NULL,
도로명주소 VARCHAR2(20) NOT NULL
);

COMMIT;
ALTER TABLE 회원정보 ADD CONSTRAINT PK_회원정보 PRIMARY KEY (회원ID);
ALTER TABLE 회원연락처 ADD CONSTRAINT PK_회원연락처 PRIMARY KEY (회원ID, 구분코드);
ALTER TABLE 회원주소 ADD CONSTRAINT PK_회원주소 PRIMARY KEY (회원ID);

SELECT * FROM 회원정보;

ALTER TABLE 회원연락처 
ADD CONSTRAINT FK_회원연락처
FOREIGN KEY (회원ID) 
REFERENCES 회원정보(회원ID);

ALTER TABLE 회원주소 
ADD CONSTRAINT FK_회원주소
FOREIGN KEY (회원ID) 
REFERENCES 회원정보(회원ID);


-------------------------------------------------------------------------------
--ALTER 
--ALTER TABLE 테이블명 ADD 컬럼명 자료형 : 테이블에 컬럼을 추가

ALTER TABLE 직원 ADD(생년월일 VARCHAR2(8));

SELECT * FROM 직원;

--ALTER TABLE 테이블명 DROP COLUMN 컬럼명 : 테이블에서 컬럼을 삭제
ALTER TABLE 직원 DROP COLUMN 생년월일;

--ALGER TABLE 테이블명 MODIFY : 테이블에서 컬럼 속성을 변경

--ALTER TABLE 테이블명 RENAME COLUMN 컬럼명 TO 바꿀컬럼명 : 테이블에서 컬럼의 이름을 변경
ALTER TABLE 직원 RENAME COLUMN 패스워드 TO 비밀번호;



--------------------------------2023.03.27-------------------------------------



--1. 대소문자 구분 안함
--2. 중복이름으로 테이블 생성 불가
--3. 테이블 내 컬럼명 중복 불가
--4. 문자로 시작, 예약어는 불가


-------------------------------------------------------------------------------
--테이블/제약조건 삭제하기

--DROP
DROP TABLE 회원정보; --외래 키에 의해 참조되는 고유/기본키가 테이블에 있음 DROP불가
DROP TABLE 회원정보 CASCADE CONSTRAINT;


--TRUNCATE : 테이블의 데이터를 삭제
--1.DELETE도 테이블의 데이토를 삭제
--2.DROP은 데이터와 테이블을 삭제

--1.DELETE (ROLLBACK이 가능)     --되돌릴 수 있다.
DELETE FROM 성적표;

--2.TRUNCATE(ROLLBACK이 불가능)  --실행하면 영구삭제
TRUNCATE TABLE 성적표;

--3.DROP(ROLLBACK이 불가능)      --실행하면 영구삭제
DROP TABLE 성적표;


------------------------------------------------------------------------------
--SEQUNCE


CREATE SEQUENCE 직원ID_SEQ
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999;
       
SELECT 직원ID_SEQ.NEXTVAL FROM DUAL;


INSERT INTO 직원 (
       직원ID
     , 비밀번호
     , 이름
     , 성별
     , 나이
     , 입사일시
     , 주민등록번호
     , 연봉
     , 부서ID
) VALUES (
       'A' || LPAD( 직원ID_SEQ.NEXTVAL , 4 , '0' )
     , '비밀번호123'
     , '새직원'
     , '여'
     , 30
     , SYSDATE
     , '930711-2441223'
     , 5000
     , 'D006'
); 

SELECT LPAD(직원ID_SEQ.NEXTVAL, 4 , '0')FROM DUAL;

DROP SEQUENCE 직원ID_SEQ;

ROLLBACK;

--------------------------------------------------------------------------------
--VIEW
-- 이 쿼리 자주 쓰니까 따로 저장좀 하고싶다.

CREATE VIEW 부서별최고연봉_VIEW AS
SELECT 부서ID, MAX(연봉) AS 부서별최고연봉
  FROM 직원
 GROUP BY 부서ID
 ORDER BY 부서ID;
 
SELECT * FROM 부서별최고연봉_VIEW;
--뷰는 물리적인/실제 데이터를 가지고 있지 않다. -> 그냥 호출해주는거임
--그냥 우리가 만들때 써놓은 쿼르(SQL)을 재작성(REWRITE)할 뿐이다.

SELECT A.이름
     , A.연봉
     , B.부서별최고연봉
  FROM 직원 A
     , 부서별최고연봉_VIEW B
 WHERE A.부서ID = B.부서ID
   AND A.연봉 = B.부서별최고연봉;
   
--인라인 뷰(INLINE VIEW)
--서브쿼리 기술 중 하나로 FROM절에 쿼리를 작성해 가상의 테이블처럼 사용하는 방식
--뷰를 만든다는 건
-- 자주쓰는 쿼리를 저장해놓고 쉽게 쓴다는 것
--4줄정도는 그냥 인라인뷰로 넣어버린다.
--50~100줄 정도 되면 VIEW로 만들어 놓는다.

SELECT A.이름
     , A.연봉
     , B.부서별최고연봉
  FROM 직원 A
     , (SELECT 부서ID, MAX(연봉) AS 부서별최고연봉
          FROM 직원
         GROUP BY 부서ID
         ORDER BY 부서ID
       )B
 WHERE A.부서ID = B.부서ID
   AND A.연봉 = B.부서별최고연봉;
   
   
   
CREATE VIEW 직원_민감정보제외 AS
SELECT 직원ID
     , 이름
     , 부서ID
  FROM 직원;

SELECT * FROM 직원_민감정보제외;

DROP VIEW 부서별최고연봉_VIEW;
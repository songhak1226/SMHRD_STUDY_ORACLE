CREATE TABLE 고객 (
고객번호 VARCHAR2(5) PRIMARY KEY ,
고객명 VARCHAR2(50) NOT NULL
) ;
CREATE TABLE 고객전화번호 (
고객번호 VARCHAR2(5) ,
전화구분코드 VARCHAR2(10) ,
전화번호 VARCHAR(15) NOT NULL
) ;
ALTER TABLE 고객전화번호 ADD CONSTRAINT PK_고객전화번호 PRIMARY KEY(고객번호 , 전화구분코드) ;
INSERT INTO 고객 VALUES ( '0001' , '동동일' ) ;
INSERT INTO 고객 VALUES ( '0002' , '동동이' ) ;
INSERT INTO 고객 VALUES ( '0003' , '동동삼' ) ;
INSERT INTO 고객전화번호 VALUES ( '0001' , '집전화' , '062-111-1111') ;
INSERT INTO 고객전화번호 VALUES ( '0001' , '휴대폰' , '010-1111-1111') ;
INSERT INTO 고객전화번호 VALUES ( '0002' , '휴대폰' , '010-2222-2222') ;
INSERT INTO 고객전화번호 VALUES ( '0004' , '휴대폰' , '010-4444-4444') ;
COMMIT; 

SELECT * FROM 고객;
SELECT * FROM 고객전화번호;

-------------------------------------------------------------------------------

--연습문제
SELECT A.고객번호
     , A.고객명
     , B.전화번호
  FROM 고객 A
     , 고객전화번호 B;
-- WHERE A.고객번호 = B.고객번호;

SELECT A.고객번호
     , A.고객명
     , B.전화번호
  FROM 고객 A
     , 고객전화번호 B
 WHERE A.고객번호 = B.고객번호;
 
--고객번호가 0001인 고객의 고객번호, 고객명, 집전화 연락처를 출력해주세요
SELECT A.고객번호
     , A.고객명
     , B.전화번호
  FROM 고객 A
     , 고객전화번호 B
 WHERE A.고객번호 = B.고객번호
   AND A.고객번호 = '0001'
   AND B.전화구분코드 LIKE '집전화';
   
-------------------------------------------------------------------------------
--동등조인
   
SELECT *
  FROM 고객, 고객전화번호
 WHERE 고객.고객번호 = 고객전화번호.고객번호;
 
--비동등조인
SELECT *
  FROM 고객, 고객전화번호
 WHERE 고객.고객번호 <= 고객전화번호.고객번호;
 
--1. 실무에서 동등조인을 주로 쓴다
--2. 조인조건이 하나라도 '=' 이게 아니면 비동등조인이다

--INNER 조인
SELECT A.고객번호
     , A.고객명
     , B.전화번호
  FROM 고객 A
     , 고객전화번호 B
 WHERE A.고객번호 = B.고객번호; --두 테이블에 교집합으로 있는 정보만 출력
--OUTER 조인
--위에서는 안나오던 고객번호 0003번이 아래 구문에서는 나왔다
SELECT A.고객번호
     , A.고객명
     , B.전화번호
  FROM 고객 A
     , 고객전화번호 B
 WHERE A.고객번호 = B.고객번호(+); --(+)를 추가해서 조인에 실패한것(0003)도 출력
   -- (+)기호가 붙은 반대쪽의 조인에 실패한것을 출력해줌
   --위에서는 기호가 B쪽에 붙었으니 A쪽의 실패한것을 출력
   
   
--연습문제
SELECT A.직원ID 
     , A.성별
     , A.나이
     , B.직원ID AS 주소_직원ID
     , B.구분코드
     , B.주소
  FROM 직원 A
     , 직원주소 B
 WHERE A.직원ID = B.직원ID;
 
 
SELECT A.직원ID
     , A.성별
     , A.나이
     , B.직원ID AS 주소_직원ID
     , B.구분코드
     , B.주소
  FROM 직원 A
     , 직원주소 B
 WHERE A.직원ID = B.직원ID
   AND A.직원ID = 'A0007';
   
   
SELECT A.직원ID
     , A.성별
     , A.연봉
     , A.나이
     , B.직원ID AS 주소_직원ID
     , B.구분코드
     , B.주소
  FROM 직원 A
     , 직원주소 B
 WHERE A.직원ID = B.직원ID(+);
 

SELECT A.직원ID
     , A.이름
     , A.연봉
     , A.나이
     , B.직원ID AS 주소_직원ID
     , B.구분코드
     , B.주소
  FROM 직원 A
     , 직원주소 B
 WHERE A.직원ID = B.직원ID(+)
   AND B.주소 IS NULL;
   


SELECT A.직원ID
     , A.이름
     , A.나이
     , B.주소
     , C.연락처
  FROM 직원 A
     , 직원주소 B
     , 직원연락처 C
 WHERE A.직원ID = B.직원ID
   AND B.직원ID = C.직원ID;
   

SELECT A.직원ID
     , A.이름
     , A.입사일시
     , B.연락처
  FROM 직원 A
     , 직원연락처 B
 WHERE A.직원ID = B.직원ID
   AND B.구분코드 = '휴대폰'
   AND A.직원ID IN ('A0001','A0002','A0003');
   
   
SELECT A.직원ID
     , A.이름
     , A.부서ID
     , B.부서명
  FROM 직원 A
     , 부서 B
 WHERE A.부서ID = B.부서ID;

-----------------------------------------------------------------------------
--ANSI문법_INNER JOIN
SELECT A.직원ID
     , A.이름
     , B.주소
  FROM 직원 A
     , 직원주소 B
 WHERE A.직원ID = B.직원ID
   AND A.직원ID = 'A0006';
--위의 구문을 INNER JOIN을 사용하여 작성한 아래의 구문(결과같음)
SELECT A.직원ID
     , A.이름
     , B.주소
  FROM 직원 A INNER JOIN 직원주소 B
    ON (A.직원ID = B.직원ID)
 WHERE A.직원ID = 'A0006';
 
--ANSI문법_OUTER JOIN
SELECT A.직원ID
     , A.이름
     , B.주소
  FROM 직원 A
     , 직원주소 B
 WHERE A.직원ID = B.직원ID(+);
--위의 구문과 아래의 구문 결과 같음
SELECT A.직원ID
     , A.이름
     , B.주소
  FROM 직원 A LEFT OUTER JOIN 직원주소 B
    ON (A.직원ID = B.직원ID);



--연습문제
SELECT A.직원ID
     , A.이름
     , B.주소
  FROM 직원 A INNER JOIN 직원주소 B
    ON (A.직원ID = B.직원ID)
 WHERE A.직원ID IN ('A0005', 'A0008');
 
SELECT B.직원ID
     , B.이름
     , A.주소
  FROM 직원주소 A RIGHT OUTER JOIN 직원 B
    ON (A.직원ID = B.직원ID);
    
SELECT A.직원ID
     , A.이름
     , A.나이
     , B.연락처
  FROM 직원 A INNER JOIN 직원연락처 B
    ON (A.직원ID = B.직원ID);
    
    
    
--3개 테이블 조인하는법
SELECT A.직원ID
     , A.이름
     , B.연락처
     , C.주소
  FROM 직원 A
     , 직원연락처 B
     , 직원주소 C
 WHERE A.직원ID = B.직원ID
   AND B.직원ID = C.직원ID;
--위의 구문을 INNERJOIN을 사용해서 아래구문으로 바꿀수있음
SELECT A.직원ID
     , A.이름
     , B.연락처
     , C.주소
  FROM 직원 A INNER JOIN 직원연락처 B ON (A.직원ID = B.직원ID)
             INNER JOIN 직원주소 C   ON (B.직원ID = C.직원ID)

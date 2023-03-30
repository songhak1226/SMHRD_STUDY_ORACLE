--TCL/DCL


--TCL
--트랜잭션 특징
--원자성 : 트랜잭션이 모두 완료되거나 하나라도 실패시 모두 원상복구 되어야 한다.(ALL OR NOTHING)
--일관성 : 항상 일관적인 형태를 가져야 한다. (트랜잭션 실행 전이 정상이라면 실행 후도 정상이어야 한다.)
--고립성 : 트랜잭션은 서로 간섭하면 안된다.
--영속성/지속성 : 영구 저장을 했으면 반드시 반영되어야 한다.



UPDATE 직원
   SET 연봉 = 연봉 + 1000
 WHERE 직원ID = 'A0005';
 
SELECT 직원ID, 이름, 연봉 FROM 직원;

COMMIT;

--SAVEPOINT


UPDATE 직원 SET 연봉 = 9999 WHERE 직원ID = 'A0001';
SAVEPOINT SV1;
UPDATE 직원 SET 연봉 = 9999 WHERE 직원ID = 'A0002';
SAVEPOINT SV2;
UPDATE 직원 SET 연봉 = 9999 WHERE 직원ID = 'A0003';
SAVEPOINT SV3;

ROLLBACK TO SV2;


--LOCK

UPDATE 직원
   SET 연봉 = 9999
 WHERE 직원ID = 'A0003';
 
--LOCK
--둘 이상의 세션이 똑같은 행을 조작하려고 할 때 충돌하는 현상
--LOCK 해제방법 
--1.원인이 되는 세션에서 COMMIT 혹은 ROLLBACK을 한다
--2.DBA에게 가서 LOCK좀 풀어달라고 한다
--3.구글에 LOCK 및 세션 KILL방법을 조회해 직접 세션을 KILL한다.


-------------------------------------------------------------------------------

--오라클
DML(데이터 조작어) : INSERT, UPDATE, DELETE  
==> 직접 COMMIT을 해줘야 영구 반영이 된다.(되돌리고 싶으면 ROLLBACK)

DDL(데이터 정의어) : CREATE, ALTER, DROP, TRUNCATE
==> 실행할때마다 자동으로 알아서 COMMIT이 된다.


INSERT INTO ...
COMMIT;   --마지막 커밋 시점

INSERT INTO ...
DELETE ...
UPDATE ...

ROLLBACK; --어디까지 돌아가는가? 마지막 커밋 시점까지!



------------------------------------------------------------------------------
--DCL

--GRANT
--GRANT 부여할권한[ON 대상객체] TO 부여받을계정
--ROLL : 여러 권한을 한번에 부여할 수 있음


--REVOKE 회수할권한[ON 회수할객체] FROM 회수당할계정

조회 - SELECT
DML - INSERT, UPDATE, DELETE, MERGE
DDL - CREATE, ALTER, DROP, RENAME, TRUNCATE
TCL - COMMIT, ROLLBACK, SAVEPOINT
DCL(데이터제어어) - GRANT, REVOKE, ROLE



-------------------------------------------------------------------------------

DELETE FROM QUIZ_TABLE;
TRUNCATE TABLE QUIZ_TABLE;
DROP TABLE QUIZ_TABLE;

-------------------------------------------------------------------------------
--


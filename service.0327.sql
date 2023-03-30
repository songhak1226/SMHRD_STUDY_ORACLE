--TCL/DCL


--TCL
--Ʈ����� Ư¡
--���ڼ� : Ʈ������� ��� �Ϸ�ǰų� �ϳ��� ���н� ��� ���󺹱� �Ǿ�� �Ѵ�.(ALL OR NOTHING)
--�ϰ��� : �׻� �ϰ����� ���¸� ������ �Ѵ�. (Ʈ����� ���� ���� �����̶�� ���� �ĵ� �����̾�� �Ѵ�.)
--���� : Ʈ������� ���� �����ϸ� �ȵȴ�.
--���Ӽ�/���Ӽ� : ���� ������ ������ �ݵ�� �ݿ��Ǿ�� �Ѵ�.



UPDATE ����
   SET ���� = ���� + 1000
 WHERE ����ID = 'A0005';
 
SELECT ����ID, �̸�, ���� FROM ����;

COMMIT;

--SAVEPOINT


UPDATE ���� SET ���� = 9999 WHERE ����ID = 'A0001';
SAVEPOINT SV1;
UPDATE ���� SET ���� = 9999 WHERE ����ID = 'A0002';
SAVEPOINT SV2;
UPDATE ���� SET ���� = 9999 WHERE ����ID = 'A0003';
SAVEPOINT SV3;

ROLLBACK TO SV2;


--LOCK

UPDATE ����
   SET ���� = 9999
 WHERE ����ID = 'A0003';
 
--LOCK
--�� �̻��� ������ �Ȱ��� ���� �����Ϸ��� �� �� �浹�ϴ� ����
--LOCK ������� 
--1.������ �Ǵ� ���ǿ��� COMMIT Ȥ�� ROLLBACK�� �Ѵ�
--2.DBA���� ���� LOCK�� Ǯ��޶�� �Ѵ�
--3.���ۿ� LOCK �� ���� KILL����� ��ȸ�� ���� ������ KILL�Ѵ�.


-------------------------------------------------------------------------------

--����Ŭ
DML(������ ���۾�) : INSERT, UPDATE, DELETE  
==> ���� COMMIT�� ����� ���� �ݿ��� �ȴ�.(�ǵ����� ������ ROLLBACK)

DDL(������ ���Ǿ�) : CREATE, ALTER, DROP, TRUNCATE
==> �����Ҷ����� �ڵ����� �˾Ƽ� COMMIT�� �ȴ�.


INSERT INTO ...
COMMIT;   --������ Ŀ�� ����

INSERT INTO ...
DELETE ...
UPDATE ...

ROLLBACK; --������ ���ư��°�? ������ Ŀ�� ��������!



------------------------------------------------------------------------------
--DCL

--GRANT
--GRANT �ο��ұ���[ON ���ü] TO �ο���������
--ROLL : ���� ������ �ѹ��� �ο��� �� ����


--REVOKE ȸ���ұ���[ON ȸ���Ұ�ü] FROM ȸ�����Ұ���

��ȸ - SELECT
DML - INSERT, UPDATE, DELETE, MERGE
DDL - CREATE, ALTER, DROP, RENAME, TRUNCATE
TCL - COMMIT, ROLLBACK, SAVEPOINT
DCL(�����������) - GRANT, REVOKE, ROLE



-------------------------------------------------------------------------------

DELETE FROM QUIZ_TABLE;
TRUNCATE TABLE QUIZ_TABLE;
DROP TABLE QUIZ_TABLE;

-------------------------------------------------------------------------------
--


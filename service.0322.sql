CREATE TABLE �� (
����ȣ VARCHAR2(5) PRIMARY KEY ,
���� VARCHAR2(50) NOT NULL
) ;
CREATE TABLE ����ȭ��ȣ (
����ȣ VARCHAR2(5) ,
��ȭ�����ڵ� VARCHAR2(10) ,
��ȭ��ȣ VARCHAR(15) NOT NULL
) ;
ALTER TABLE ����ȭ��ȣ ADD CONSTRAINT PK_����ȭ��ȣ PRIMARY KEY(����ȣ , ��ȭ�����ڵ�) ;
INSERT INTO �� VALUES ( '0001' , '������' ) ;
INSERT INTO �� VALUES ( '0002' , '������' ) ;
INSERT INTO �� VALUES ( '0003' , '������' ) ;
INSERT INTO ����ȭ��ȣ VALUES ( '0001' , '����ȭ' , '062-111-1111') ;
INSERT INTO ����ȭ��ȣ VALUES ( '0001' , '�޴���' , '010-1111-1111') ;
INSERT INTO ����ȭ��ȣ VALUES ( '0002' , '�޴���' , '010-2222-2222') ;
INSERT INTO ����ȭ��ȣ VALUES ( '0004' , '�޴���' , '010-4444-4444') ;
COMMIT; 

SELECT * FROM ��;
SELECT * FROM ����ȭ��ȣ;

-------------------------------------------------------------------------------

--��������
SELECT A.����ȣ
     , A.����
     , B.��ȭ��ȣ
  FROM �� A
     , ����ȭ��ȣ B;
-- WHERE A.����ȣ = B.����ȣ;

SELECT A.����ȣ
     , A.����
     , B.��ȭ��ȣ
  FROM �� A
     , ����ȭ��ȣ B
 WHERE A.����ȣ = B.����ȣ;
 
--����ȣ�� 0001�� ���� ����ȣ, ����, ����ȭ ����ó�� ������ּ���
SELECT A.����ȣ
     , A.����
     , B.��ȭ��ȣ
  FROM �� A
     , ����ȭ��ȣ B
 WHERE A.����ȣ = B.����ȣ
   AND A.����ȣ = '0001'
   AND B.��ȭ�����ڵ� LIKE '����ȭ';
   
-------------------------------------------------------------------------------
--��������
   
SELECT *
  FROM ��, ����ȭ��ȣ
 WHERE ��.����ȣ = ����ȭ��ȣ.����ȣ;
 
--�񵿵�����
SELECT *
  FROM ��, ����ȭ��ȣ
 WHERE ��.����ȣ <= ����ȭ��ȣ.����ȣ;
 
--1. �ǹ����� ���������� �ַ� ����
--2. ���������� �ϳ��� '=' �̰� �ƴϸ� �񵿵������̴�

--INNER ����
SELECT A.����ȣ
     , A.����
     , B.��ȭ��ȣ
  FROM �� A
     , ����ȭ��ȣ B
 WHERE A.����ȣ = B.����ȣ; --�� ���̺� ���������� �ִ� ������ ���
--OUTER ����
--�������� �ȳ����� ����ȣ 0003���� �Ʒ� ���������� ���Դ�
SELECT A.����ȣ
     , A.����
     , B.��ȭ��ȣ
  FROM �� A
     , ����ȭ��ȣ B
 WHERE A.����ȣ = B.����ȣ(+); --(+)�� �߰��ؼ� ���ο� �����Ѱ�(0003)�� ���
   -- (+)��ȣ�� ���� �ݴ����� ���ο� �����Ѱ��� �������
   --�������� ��ȣ�� B�ʿ� �پ����� A���� �����Ѱ��� ���
   
   
--��������
SELECT A.����ID 
     , A.����
     , A.����
     , B.����ID AS �ּ�_����ID
     , B.�����ڵ�
     , B.�ּ�
  FROM ���� A
     , �����ּ� B
 WHERE A.����ID = B.����ID;
 
 
SELECT A.����ID
     , A.����
     , A.����
     , B.����ID AS �ּ�_����ID
     , B.�����ڵ�
     , B.�ּ�
  FROM ���� A
     , �����ּ� B
 WHERE A.����ID = B.����ID
   AND A.����ID = 'A0007';
   
   
SELECT A.����ID
     , A.����
     , A.����
     , A.����
     , B.����ID AS �ּ�_����ID
     , B.�����ڵ�
     , B.�ּ�
  FROM ���� A
     , �����ּ� B
 WHERE A.����ID = B.����ID(+);
 

SELECT A.����ID
     , A.�̸�
     , A.����
     , A.����
     , B.����ID AS �ּ�_����ID
     , B.�����ڵ�
     , B.�ּ�
  FROM ���� A
     , �����ּ� B
 WHERE A.����ID = B.����ID(+)
   AND B.�ּ� IS NULL;
   


SELECT A.����ID
     , A.�̸�
     , A.����
     , B.�ּ�
     , C.����ó
  FROM ���� A
     , �����ּ� B
     , ��������ó C
 WHERE A.����ID = B.����ID
   AND B.����ID = C.����ID;
   

SELECT A.����ID
     , A.�̸�
     , A.�Ի��Ͻ�
     , B.����ó
  FROM ���� A
     , ��������ó B
 WHERE A.����ID = B.����ID
   AND B.�����ڵ� = '�޴���'
   AND A.����ID IN ('A0001','A0002','A0003');
   
   
SELECT A.����ID
     , A.�̸�
     , A.�μ�ID
     , B.�μ���
  FROM ���� A
     , �μ� B
 WHERE A.�μ�ID = B.�μ�ID;

-----------------------------------------------------------------------------
--ANSI����_INNER JOIN
SELECT A.����ID
     , A.�̸�
     , B.�ּ�
  FROM ���� A
     , �����ּ� B
 WHERE A.����ID = B.����ID
   AND A.����ID = 'A0006';
--���� ������ INNER JOIN�� ����Ͽ� �ۼ��� �Ʒ��� ����(�������)
SELECT A.����ID
     , A.�̸�
     , B.�ּ�
  FROM ���� A INNER JOIN �����ּ� B
    ON (A.����ID = B.����ID)
 WHERE A.����ID = 'A0006';
 
--ANSI����_OUTER JOIN
SELECT A.����ID
     , A.�̸�
     , B.�ּ�
  FROM ���� A
     , �����ּ� B
 WHERE A.����ID = B.����ID(+);
--���� ������ �Ʒ��� ���� ��� ����
SELECT A.����ID
     , A.�̸�
     , B.�ּ�
  FROM ���� A LEFT OUTER JOIN �����ּ� B
    ON (A.����ID = B.����ID);



--��������
SELECT A.����ID
     , A.�̸�
     , B.�ּ�
  FROM ���� A INNER JOIN �����ּ� B
    ON (A.����ID = B.����ID)
 WHERE A.����ID IN ('A0005', 'A0008');
 
SELECT B.����ID
     , B.�̸�
     , A.�ּ�
  FROM �����ּ� A RIGHT OUTER JOIN ���� B
    ON (A.����ID = B.����ID);
    
SELECT A.����ID
     , A.�̸�
     , A.����
     , B.����ó
  FROM ���� A INNER JOIN ��������ó B
    ON (A.����ID = B.����ID);
    
    
    
--3�� ���̺� �����ϴ¹�
SELECT A.����ID
     , A.�̸�
     , B.����ó
     , C.�ּ�
  FROM ���� A
     , ��������ó B
     , �����ּ� C
 WHERE A.����ID = B.����ID
   AND B.����ID = C.����ID;
--���� ������ INNERJOIN�� ����ؼ� �Ʒ��������� �ٲܼ�����
SELECT A.����ID
     , A.�̸�
     , B.����ó
     , C.�ּ�
  FROM ���� A INNER JOIN ��������ó B ON (A.����ID = B.����ID)
             INNER JOIN �����ּ� C   ON (B.����ID = C.����ID)

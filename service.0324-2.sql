--DDL
--���̺� ���� ������ ����� ��ü�� ����ų� �����Ѵ�.

--CREATE
--���ο� ��ü(OBJECT)�� ������ �� ����ϴ� ��ɾ�

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
     , '��� ����� �����ϱ��?'
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
     , '�޷��� ����� �����ϱ��?'
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
     , '���̴� ����� �����ϱ��?'
     , 'paper'
     , SYSDATE
);


--COMMENT ����
COMMENT ON TABLE QUIZ_TABLE IS '���� ������ �� ���̺�';
COMMENT ON COLUMN QUIZ_TABLE.Q_ID IS '����ID';




--��������
--PRIMARY KEY(PK)
--Ư�� �÷��� �ĺ��ڷ� ����� �ڵ����� NOT NULL + UNIQUE ������ �ٲ�� �ȴ�.
ALTER TABLE QUIZ_TABLE ADD CONSTRAINT PK_QUIZ_TABLE PRIMARY KEY (Q_ID);

--UNIQUE KEY(UK)
--NULL���� ���� �ߺ����� �Ұ���


--FOREIGN KEY(FK) = �ܷ�Ű
--���̺��� ����Ǿ� �ִ� ���踦 ������ �𵨸��� ��

     
--��������
CREATE TABLE ȸ������ (
ȸ��ID VARCHAR2(10) NOT NULL,
�̸� VARCHAR2(20) NOT NULL,
�������� DATE,
���� NUMBER(3,0) DEFAULT 0
);

CREATE TABLE ȸ������ó (
ȸ��ID VARCHAR2(10) NOT NULL,
�����ڵ� VARCHAR2(10) NOT NULL,
����ó VARCHAR2(15) NOT NULL
);

CREATE TABLE ȸ���ּ� (
ȸ��ID VARCHAR2(10) NOT NULL,
���θ��ּ� VARCHAR2(20) NOT NULL
);

COMMIT;
ALTER TABLE ȸ������ ADD CONSTRAINT PK_ȸ������ PRIMARY KEY (ȸ��ID);
ALTER TABLE ȸ������ó ADD CONSTRAINT PK_ȸ������ó PRIMARY KEY (ȸ��ID, �����ڵ�);
ALTER TABLE ȸ���ּ� ADD CONSTRAINT PK_ȸ���ּ� PRIMARY KEY (ȸ��ID);

SELECT * FROM ȸ������;

ALTER TABLE ȸ������ó 
ADD CONSTRAINT FK_ȸ������ó
FOREIGN KEY (ȸ��ID) 
REFERENCES ȸ������(ȸ��ID);

ALTER TABLE ȸ���ּ� 
ADD CONSTRAINT FK_ȸ���ּ�
FOREIGN KEY (ȸ��ID) 
REFERENCES ȸ������(ȸ��ID);


-------------------------------------------------------------------------------
--ALTER 
--ALTER TABLE ���̺�� ADD �÷��� �ڷ��� : ���̺� �÷��� �߰�

ALTER TABLE ���� ADD(������� VARCHAR2(8));

SELECT * FROM ����;

--ALTER TABLE ���̺�� DROP COLUMN �÷��� : ���̺��� �÷��� ����
ALTER TABLE ���� DROP COLUMN �������;

--ALGER TABLE ���̺�� MODIFY : ���̺��� �÷� �Ӽ��� ����

--ALTER TABLE ���̺�� RENAME COLUMN �÷��� TO �ٲ��÷��� : ���̺��� �÷��� �̸��� ����
ALTER TABLE ���� RENAME COLUMN �н����� TO ��й�ȣ;



--------------------------------2023.03.27-------------------------------------



--1. ��ҹ��� ���� ����
--2. �ߺ��̸����� ���̺� ���� �Ұ�
--3. ���̺� �� �÷��� �ߺ� �Ұ�
--4. ���ڷ� ����, ������ �Ұ�


-------------------------------------------------------------------------------
--���̺�/�������� �����ϱ�

--DROP
DROP TABLE ȸ������; --�ܷ� Ű�� ���� �����Ǵ� ����/�⺻Ű�� ���̺� ���� DROP�Ұ�
DROP TABLE ȸ������ CASCADE CONSTRAINT;


--TRUNCATE : ���̺��� �����͸� ����
--1.DELETE�� ���̺��� �����並 ����
--2.DROP�� �����Ϳ� ���̺��� ����

--1.DELETE (ROLLBACK�� ����)     --�ǵ��� �� �ִ�.
DELETE FROM ����ǥ;

--2.TRUNCATE(ROLLBACK�� �Ұ���)  --�����ϸ� ��������
TRUNCATE TABLE ����ǥ;

--3.DROP(ROLLBACK�� �Ұ���)      --�����ϸ� ��������
DROP TABLE ����ǥ;


------------------------------------------------------------------------------
--SEQUNCE


CREATE SEQUENCE ����ID_SEQ
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999;
       
SELECT ����ID_SEQ.NEXTVAL FROM DUAL;


INSERT INTO ���� (
       ����ID
     , ��й�ȣ
     , �̸�
     , ����
     , ����
     , �Ի��Ͻ�
     , �ֹε�Ϲ�ȣ
     , ����
     , �μ�ID
) VALUES (
       'A' || LPAD( ����ID_SEQ.NEXTVAL , 4 , '0' )
     , '��й�ȣ123'
     , '������'
     , '��'
     , 30
     , SYSDATE
     , '930711-2441223'
     , 5000
     , 'D006'
); 

SELECT LPAD(����ID_SEQ.NEXTVAL, 4 , '0')FROM DUAL;

DROP SEQUENCE ����ID_SEQ;

ROLLBACK;

--------------------------------------------------------------------------------
--VIEW
-- �� ���� ���� ���ϱ� ���� ������ �ϰ�ʹ�.

CREATE VIEW �μ����ְ���_VIEW AS
SELECT �μ�ID, MAX(����) AS �μ����ְ���
  FROM ����
 GROUP BY �μ�ID
 ORDER BY �μ�ID;
 
SELECT * FROM �μ����ְ���_VIEW;
--��� ��������/���� �����͸� ������ ���� �ʴ�. -> �׳� ȣ�����ִ°���
--�׳� �츮�� ���鶧 ����� ����(SQL)�� ���ۼ�(REWRITE)�� ���̴�.

SELECT A.�̸�
     , A.����
     , B.�μ����ְ���
  FROM ���� A
     , �μ����ְ���_VIEW B
 WHERE A.�μ�ID = B.�μ�ID
   AND A.���� = B.�μ����ְ���;
   
--�ζ��� ��(INLINE VIEW)
--�������� ��� �� �ϳ��� FROM���� ������ �ۼ��� ������ ���̺�ó�� ����ϴ� ���
--�並 ����ٴ� ��
-- ���־��� ������ �����س��� ���� ���ٴ� ��
--4�������� �׳� �ζ��κ�� �־������.
--50~100�� ���� �Ǹ� VIEW�� ����� ���´�.

SELECT A.�̸�
     , A.����
     , B.�μ����ְ���
  FROM ���� A
     , (SELECT �μ�ID, MAX(����) AS �μ����ְ���
          FROM ����
         GROUP BY �μ�ID
         ORDER BY �μ�ID
       )B
 WHERE A.�μ�ID = B.�μ�ID
   AND A.���� = B.�μ����ְ���;
   
   
   
CREATE VIEW ����_�ΰ��������� AS
SELECT ����ID
     , �̸�
     , �μ�ID
  FROM ����;

SELECT * FROM ����_�ΰ���������;

DROP VIEW �μ����ְ���_VIEW;

--ROWNUM
--���̺��� Ʃ��(��)�� �ӽ÷� �ο��Ǵ� �Ϸù�ȣ


SELECT ROWNUM AS RN
     , ����ID
     , �̸�
     , ����
     , �μ�ID
  FROM ����;
  -- ROWNUMó�� ���� ���̺� ���µ� ���Ǵ� �ֵ��� ��¥�÷�(�ǻ��÷�)�̶�� �Ѵ�.
  
SELECT ROWNUM AS RN
     , ����ID
     , �̸�
     , ����
     , �μ�ID
  FROM ����
 WHERE ROWNUM <= 3;
 
SELECT ROWNUM AS RN
     , ����ID , �̸� , ���� , �μ�ID
  FROM ����
 WHERE ROWNUM = 1;         --�̰� ����
 
SELECT ROWNUM AS RN
     , ����ID , �̸� , ���� , �μ�ID
  FROM ����
 WHERE ROWNUM = 2;         --�̰� �Ұ��� (1�ǰ��� ������� �ʰ� 2�� ������)
 
 SELECT ROWNUM AS RN
     , ����ID , �̸� , ���� , �μ�ID
  FROM ����
 WHERE ROWNUM <= 3;        --�̰� 1�� ���ԵǼ� ����
 
 
SELECT *
  FROM (
        SELECT ROWNUM AS RN
             , ����ID
             , �̸�
             , ����
             , �μ�ID
         FROM ����
       )
 WHERE RN <= 10; 
--ROWNUM ����� �ζ��κ� ������ �����ؼ� ����N���� �����͸� �̴� ����� �͵��� �� ����
--�� ����� TOP-N����̶�� �Ѵ�.
 
--��������
SELECT *
  FROM ����
 WHERE ���� IS NOT NULL
 ORDER BY ���� DESC;
 
 
--������ ������ ���� ������� ���� 5�� ����غ��ô�
SELECT *
  FROM (
        SELECT *
          FROM ����
         WHERE ���� IS NOT NULL
         ORDER BY ���� DESC
          )
 WHERE ROWNUM <= 5;
 
 
SELECT *
  FROM (
        SELECT * 
          FROM ����
         WHERE ���� IS NOT NULL
         ORDER BY ����
        )
 WHERE ROWNUM <=3;
 
SELECT *
  FROM (
        SELECT * 
          FROM ����
         WHERE �Ի��Ͻ� IS NOT NULL
         ORDER BY �Ի��Ͻ� DESC
        )
 WHERE ROWNUM <=3;
 
 
 
 
 
 
 
 
CREATE TABLE �Խ��� (
�Խ��ǹ�ȣ NUMBER(9) PRIMARY KEY ,
�ۼ��� VARCHAR2(50) NOT NULL ,
�Խù����� VARCHAR2(4000) NOT NULL ,
�ۼ��Ͻ� DATE NOT NULL
) ;
INSERT INTO �Խ���
SELECT LEVEL -- �Խ��ǹ�ȣ
, '���̵�' || MOD(LEVEL , 10000) -- �ۼ���
, '���̵�' ||
MOD(LEVEL , 10000) ||
'���� �ۼ��Ͻ� �Խù��Դϴ�. �� �Խù��� �Խ��� ��ȣ�� '
|| LEVEL
|| '�Դϴ�' -- �Խù�����
, TO_DATE('20000101') + LEVEL --2022�� 1��1�Ϻ��� �Ϸ羿 �Խù��� �ԷµǴ� ��
FROM DUAL
CONNECT BY LEVEL <=1000000; --100������ ������ �Է�
COMMIT;

SELECT * FROM �Խ���;



SELECT * 
  FROM(
       SELECT * 
         FROM �Խ���
        ORDER BY �ۼ��Ͻ� DESC
        )
 WHERE ROWNUM <= 20;
 
 

SELECT * 
  FROM(
  SELECT ROWNUM AS RN
  , A.*
       SELECT * 
         FROM �Խ���
        ORDER BY �ۼ��Ͻ� DESC
        ) A
        WHERE ROWNUM <= 20 * N
        )
 WHERE ROWNUM >= 20 * (N-1;
 
 
 
 
 
 
 
 
 
 
 
 
------------------------------------------------------------------------------
--��������

ALTER TABLE ���� MODIFY (�μ�ID NULL) ;
UPDATE ���� SET �μ�ID = NULL WHERE ����ID = 'A0005' ;
COMMIT;

SELECT A.����ID
     , A.����
     , A.�μ�ID
     , (
        SELECT �μ���
          FROM �μ�
         WHERE �μ�ID = A.�μ�ID
         ) AS �μ���
  FROM ���� A
 WHERE ����ID BETWEEN 'A0001' AND 'A0006';
 
 
 
SELECT A.����ID, A.����, A.�μ�ID, B.�μ���
  FROM ���� A, �μ� B
 WHERE A.�μ�ID = B.�μ�ID(+)
   AND A.����ID BETWEEN 'A0001' AND 'A0006';
   
SELECT A.����ID, A.����, A.�μ�ID, B.�μ���
  FROM ���� A LEFT OUTER JOIN �μ� B
    ON (A.�μ�ID = B.�μ�ID)
 WHERE A.����ID BETWEEN 'A0001' AND 'A0006';
 
SELECT *
  FROM �μ�
 WHERE 1=1;
   
   
SELECT * FROM ����;


--��������
SELECT A.����ID, A.����, A.�μ�ID, ( SELECT �μ��� FROM �μ� WHERE �μ�ID = A.�μ�ID) AS �μ���
  FROM ���� A
 WHERE ����ID BETWEEN 'A0001' AND 'A0006';
 
 
SELECT A.����ID
     , A.�̸�
     , A.�ֹε�Ϲ�ȣ
     , (SELECT ����ó 
          FROM ��������ó 
         WHERE ����ID = A.����ID 
           AND �����ڵ� = '�޴���') AS �޴�����ȣ
  FROM ���� A
 WHERE ����ID BETWEEN 'A0006' AND 'A0010';



SELECT A.����ID
     , A.�̸�
     , A.�ֹε�Ϲ�ȣ
     , (SELECT ����ó 
          FROM ��������ó 
         WHERE ����ID = A.����ID 
           AND �����ڵ� = '�޴���') AS �޴�����ȣ
     , (SELECT �ּ� 
          FROM �����ּ� 
         WHERE ����ID = A.����ID 
           AND �����ڵ� = '��') AS ���ּ�
  FROM ���� A
 WHERE ����ID BETWEEN 'A0006' AND 'A0010';
 
 -----
 
 
 SELECT A.����ID , A.���� , A.�μ�ID , B.�μ��� , B.�ٹ���  
  FROM ���� A , �μ� B 
 WHERE A.�μ�ID = B.�μ�ID(+) 
   AND A.����ID BETWEEN 'A0001' AND 'A0005'    
   AND B.�ٹ���(+) = '����';
   
   
   
SELECT A.����ID , A.���� , A.�μ�ID , B.�μ�ID , B.�μ��� , B.�ٹ���  
  FROM ���� A LEFT OUTER JOIN �μ� B ON ( A.�μ�ID = B.�μ�ID  AND B.�ٹ��� = '����') 
 WHERE A.����ID BETWEEN 'A0001' AND 'A0005'   ; 
 
------------------------------------------------------

SELECT A.����ID
     , A.�̸�
     , A.����
     , B.�μ����ְ���
  FROM ���� A
     , ( SELECT �μ�ID, MAX(����) AS �μ����ְ���
           FROM ����
          WHERE �μ�ID IS NOT NULL
          GROUP BY �μ�ID
          ) B
 WHERE A.�μ�ID = B.�μ�ID
   AND A.���� = B.�μ����ְ���;
   
   
--��������
SELECT A.����ID
     , A.�̸�
     , A.����
     , B.�μ�����������
  FROM ���� A
     , ( SELECT �μ�ID, MIN(����) AS �μ�����������
           FROM ����
          WHERE �μ�ID IS NOT NULL
          GROUP BY �μ�ID
          ) B
 WHERE A.�μ�ID = B.�μ�ID
   AND A.���� = B.�μ�����������;
   
   
SELECT A.����ID, A.�̸�, A.����, B.�μ�����������
  FROM ����A
     , (
         SELECT �μ�ID, MIN(����) AS �μ�����������
           FROM ����
          WHERE �μ�ID IS NOT NULL
          GROUP BY �μ�ID
        ) B
WHERE A.�μ�ID = B.�μ�ID
  AND A.���� = B.�μ�����������;
   

SELECT *
  FROM ( SELECT *
           FROM ����
          WHERE ���� IS NOT NULL
          ORDER BY ����
          )
 WHERE ROWNUM <=3;
 


------------------------------------------------------------------------------
--��ø��������

SELECT *
  FROM ����                                 
 WHERE ���� >= (SELECT AVG(����)       --���� ��������
                  FROM ����           --���⼭ ���� ���� ����� ���ϰ�
               );
               
--���� ��������
--���������� ���� ����ǰ� ���� ������ ����ȴ�.



SELECT *
  FROM ���� A
 WHERE ���� = ( SELECT MIN(����)
                  FROM ����
                 WHERE �μ�ID = A.�μ�ID);
                 
------------------------------------------------------------------------------
--��������
                 
SELECT *
  FROM ���� A
 WHERE ���� = ( SELECT MAX(����)
                  FROM ����
                 WHERE �μ�ID = A.�μ�ID);
                 
SELECT *
  FROM ���� A
 WHERE �Ի��Ͻ� = ( SELECT MAX(�Ի��Ͻ�)
                     FROM ����);
                     
SELECT *
  FROM ���� A
 WHERE ���� = (SELECT MAX(����)
                 FROM ����);
                 
                 
                 
-----------------------------------------------------------------------------
--������/������ ������

SELECT *
  FROM ���� A
 WHERE ���� = ( SELECT ����
                  FROM ����
                 WHERE �μ�ID = 'D001');
             
--���� ���� �Ʒ��� �������

SELECT *
  FROM ���� A
 WHERE ���� IN ( SELECT ����
                  FROM ����
                 WHERE �μ�ID = 'D001');    --�������� IN,EXISTS, NOT EXISTS, ANY, ALL��
                 
                 
SELECT *
  FROM ����
 WHERE ���� IN( SELECT MAX(����)
                  FROM ����
                 GROUP BY �μ�ID);


SELECT *
  FROM ����
 WHERE ���� = ANY ( SELECT MAX(����)
                      FROM ����
                     GROUP BY �μ�ID);
                     

SELECT *
  FROM ����
 WHERE ���� >= ALL ( SELECT MAX(����)
                      FROM ����
                     GROUP BY �μ�ID);
                     
                     
                     
UPDATE ���� SET ���� = 2800 WHERE ����ID = 'A0001';

SELECT * FROM ����;

COMMIT;
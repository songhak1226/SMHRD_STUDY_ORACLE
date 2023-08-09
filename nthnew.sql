--TB_CUST�� ȸ�� ������ ����ִ� ���̺�
--TB_CUST_ADDR�� ȸ�� �ּ� ������ �ִ� ���̺�

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
                 
                 
--------------------------�ǽ�����----------------------------------                 
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
                       AND TEL_DVCD = '��'
                     );
                 
SELECT CUST_ID, CUST_NAME, BIRTH_DY
  FROM TB_CUST;
  
SELECT *
FROM TB_CUST_TEL;                 
                 
-----------------------------------------------------------------------------

                 
                 
-- �����͸� ���(��ȸ)�ϴ� �����         

-- �������� ������ ���
-- ���� : 
SELECT A.CUST_ID
     , A.CUST_NAME
     , A.SCORE
     , B.GRADE_NAME
  FROM TB_CUST A
     , TB_GRADE B
 WHERE A.SCORE BETWEEN B.STS_SCORE AND B.END_SCORE;
 
--���������� ������ ���
SELECT A.CUST_ID
     , A.CUST_NAME
     , A.SCORE
     , (
        SELECT GRADE_NAME
          FROM TB_GRADE
         WHERE A.SCORE BETWEEN STS_SCORE AND END_SCORE ) AS GRADE_NAME
  FROM TB_CUST A;
  
-- DECORE�� ������ ���
SELECT A.CUST_ID
     , A.CUST_NAME
     , A.SCORE
     , DECODE( CEIL(SCORE/20), 0, '�����', 1, '�����' , 2, '�ǹ�', 3, '���', 4, 'VIP', 5, 'VVIP') AS GRADE_NAME
  FROM TB_CUST A;
  
--CASE �������� ������ ���
SELECT CUST_ID
     , CUST_NAME
     , SCORE
     , CASE WHEN SCORE > 100 THEN '��������'
            WHEN SCORE >= 81 THEN 'VVIP'
            WHEN SCORE >= 61 THEN 'VIP'
            WHEN SCORE >= 41 THEN '���'
            WHEN SCORE >= 21 THEN '�ǹ�'
            WHEN SCORE >=  0 THEN '�����'
            ELSE '��������'
             END AS GRADE_NAME
  FROM TB_CUST ;
  
  
------------------------�ǽ� ����------------------------------------------
-- 1.
SELECT PRD_ID
     , PRD_NAME
     , PRD_AMT
     , CASE WHEN PRD_AMT >  999999 THEN '�ſ���'
            WHEN PRD_AMT >= 100000 THEN '���'
            WHEN PRD_AMT >=  10000 THEN '����'
            WHEN PRD_AMT >=      0 THEN '����'
            ELSE '���� ����'
             END AS ���ݴ�
  FROM TB_PRD
  ORDER BY PRD_AMT DESC;
  
-- 2.
SELECT PRD_ID
     , PRD_NAME
     , PRD_TYPE
     , PRD_AMT
     , CASE WHEN PRD_TYPE = '��ǻ��' OR PRD_TYPE = '����Ʈ��' THEN PRD_AMT + 100000
            ELSE PRD_AMT
             END AS �λ�Ȱ���
   FROM TB_PRD
  ORDER BY PRD_AMT DESC;     
  
-- 3.
SELECT QNA_ID
     , QNA_CONTENT
     , QNA_ANSWER
     , CASE WHEN QNA_ANSWER IS0 NULL THEN 'N'
            ELSE 'Y'
             END AS �������俩��
  FROM TB_QNA;
  
---------------------------------------------------------------------------------


--MERGE ����
--SELECT�� �Ǵ��� �ؼ� UPDATE�� INSERT�ϴ� ������ �ѹ��� ó������
MERGE INTO TB_CUST_TEL
USING DUAL
   ON (CUST_ID = 'C0007' AND TEL_DVCD = '�޴���')
--MERGE INTO ������̺� USING �������̺�(������DUAL) ON(ã�ƺ�����)

WHEN MATCHED THEN -- �� ���ǿ� �ش��ϴ� ���� �ִٸ� UPDATE
UPDATE SET TEL_NO = '010-7777-7777'

WHEN NOT MATCHED THEN -- �����ǿ� �ش��ϴ� ���� ���ٸ� INSERT
INSERT (CUST_ID, TEL_DVCD, TEL_NO)
VALUES ('C0007', '�޴���', '010-7777-7777');

-------------------------------------------------------------------------------

SELECT * FROM ����;
SELECT * FROM ����_����;

MERGE INTO ���� A
USING ����_���� B
   ON (A.����ID = B.����ID)
   
WHEN MATCHED THEN
UPDATE
   SET A.�����̸� = B.�����̸�
     , A.���� = B.����
     
WHEN NOT MATCHED THEN
INSERT (A.����ID, A.�����̸�, A.����)
VALUES (B.����ID, B.�����̸�, B.����);

-------------------------------------------------------------------------------

SELECT * FROM �ܼ�Ʈ���ų���;
SELECT * FROM �����ÿ��ų���;
SELECT * FROM ���忹�ų���;

SELECT ���Ź�ȣ, �������̸� AS �����̸�, �����ð��� AS ��������
  FROM �����ÿ��ų���
 WHERE ���Ź�ȣ >= 3
UNION ALL

SELECT ���Ź�ȣ, �ܼ�Ʈ�̸�, �ܼ�Ʈ����
  FROM �ܼ�Ʈ���ų���
 WHERE ���Ź�ȣ >= 3
UNION ALL

SELECT ���Ź�ȣ, ���̸�, �ذ���
  FROM ���忹�ų���
 WHERE ���Ź�ȣ >= 3;
 
-- 2.
SELECT �����ð��� AS ��������
  FROM �����ÿ��ų���
UNION 
SELECT �ܼ�Ʈ����
  FROM �ܼ�Ʈ���ų���
UNION 
SELECT �ذ���
  FROM ���忹�ų���;
  
  
-- 11g (������� ��� ���� ���� ���� ����)
-- 21c (���� �ֽ�)


---------------------------------------------------------------------------------
-- �������Լ� : ���̺��� ��� �ణ�� ���踦 �̿��ؼ� �ǹ��ִ� �����͸� �̴´�
SELECT �����ڵ�
 , ( SELECT ������ġ
 FROM ����
 WHERE �����ڵ� = X.�����ڵ� ) AS ������ġ
 , �����
 , RANK() OVER ( ORDER BY ����� DESC ) AS ����
 FROM (
SELECT A.�����ڵ�
 , SUM(B.�����) AS �����
 FROM ���� A INNER JOIN �������� B
ON ( A.�����ڵ� = B.�����ڵ� )
GROUP BY A.�����ڵ�
 ) X
ORDER BY ���� ;



----------------------------------�ǽ�����---------------------------------

-- 1.
SELECT PRD_ID
     , PRD_NAME
     , PRD_AMT
     , DENSE_RANK() OVER (ORDER BY PRD_AMT DESC) AS ���ݴ����
  FROM TB_PRD;
  
-- 2.
SELECT *
FROM (
SELECT PRD_ID
     , PRD_NAME
     , PRD_AMT
     , DENSE_RANK() OVER (ORDER BY PRD_AMT DESC) AS ���ݴ����
  FROM TB_PRD
  )
 WHERE ���ݴ���� <= 5;
 
 
 ---------------------------------------------------------------------------

-- ���� �Լ�
SELECT ����� , ���� , ���� , ������
 FROM (
SELECT ����� , ���� , ���� , ������
 , ROW_NUMBER() OVER ( PARTITION BY ����� ORDER BY ������ DESC ) AS
RNUM
FROM �����Ű�⳻��
 )
WHERE RNUM = 1;

-- GROUP BY ����ϴ�?
-- GROUP BY �� ������ ���� �پ������
-- PARTITION BY�� ���� ���� �ʴ´�. (���� �״�� ����)

-- �ζ��κ�ε� �����մϴ�.


-- �ǽ� ���� 1.
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

SELECT �з��ڵ�
 , ��ǰ��
 , ����
 , SUM(����) OVER ( ORDER BY �з��ڵ� , ��ǰ�� RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
AS ����������հ�
 FROM ��ǰ;
 
----------------------------------------------------------------------------------
-- INDEX

CREATE INDEX IDX_PRD ON TB_PRD(PRD_TYPE);

--/*+RULE*/ ��Ʈ
SELECT /*+ RULE */ PRD_ID, PRD_NAME, PRD_TYPE
  FROM TB_PRD
 WHERE PRD_TYPE = '����Ʈ��'; -- F10������ �����ȹ�� �� �� �ִ�
 

------------------------------------------------------------------------------
--NL����
SELECT /*+ ORDERED USE_NL(B) */ *
  FROM TB_TEST1 A
     , TB_TEST2 B
 WHERE A.COL1 = B.COL1;

CREATE INDEX IDX_TEST2 ON TB_TEST2(COL1);

----------------------------------------------------------------
-- ���� ����
--����
SELECT �޴�ID
, �����޴�ID
, �޴��̸�
 , LEVEL
, LPAD(' ' , ( LEVEL -1 ) * 2 , ' ' ) || �޴��̸�
 FROM �޴�
WHERE 1=1 -- WHERE ������ ������ ���� �Ƚᵵ ��
START WITH �����޴�ID IS NULL
CONNECT BY NOCYCLE �����޴�ID = PRIOR �޴�ID
ORDER SIBLINGS BY �޴�ID ;

--
SELECT ���ID
 , ������
 , �ۼ���
 , CASE WHEN �ۼ��� IS NULL THEN
 ( SELECT �Խù�����
 FROM �Խ���
 WHERE �Խñ�ID = ������ )
 ELSE LPAD('��-' , LEVEL*2 , ' ') || �ۼ���
 END
 AS �����������
 , LEVEL
 FROM ���
START WITH �ۼ��� IS NULL
CONNECT BY PRIOR ���ID = ������ ;

INSERT INTO ���
VALUES ('C0007', 'C0006', '������ħ�Ⱦ��'); -- ����



---------------------------------------------------------------------
-- ���ν���

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE P_SOLD_OUT_YN_DEL
AS -- ���� (�޼ҵ� ���)
--v_cnt NUMBER := 0; --v_cnt�� ������, 0���� �ʱ�ȭ�ϰڴ�
v_cust_id TB_CUST.CUST_ID%TYPE;
v_cust TB_CUST%ROWTYPE;
BEGIN
    --���ϴ� ����
        -- System.out.println()
--    DBMS_OUTPUT.PUT_LINE('���ν��� ����');
    
--    EXCEPTION
--     WHEN OTHERS THEN
--      NULL;

--DBMS_OUTPUT : Ŭ���� / PUT_LINE : �޼ҵ�
--DBMS_OUTPUT.PUT_LINE(v_cnt);
--SELECT COUNT(8) INTO v_cnt FROM TB_CUST;
--DBMS_OUTPUT.PUT_LINE(v_cnt);

SELECT CUST_ID INTO v_cust_id FROM TB_CUST WHERE CUST_NAME = '��001';
DBMS_OUTPUT.PUT_LINE('�ش� ���� ���̵��' || v_cust_id || '�Դϴ�');

SELECT * INTO v_cust FROM TB_CUST WHERE CUST_ID = 'C0001';
    DBMS_OUTPUT.PUT_LINE('�ش� ���� ���̵��' || v_cust.CUST_ID || '�Դϴ�');
    DBMS_OUTPUT.PUT_LINE('�ش� ���� ������' || v_cust.BIRTH_DY || '�Դϴ�');
      
END;    
/
------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE P_SOLD_OUT_YN_DEL
AS
v_sold_yn VARCHAR2(5); --v_sold_yn�̶�� ������������ ���� ����
                      --�ʱ�ȭ�� ���� ���� �ʾ���

BEGIN
    SELECT SOLD_OUT_YN INTO v_sold_yn FROM TB_PRD WHERE PRD_ID = 'P0001';
    IF v_sold_yn = 'Y'
    THEN DBMS_OUTPUT.PUT_LINE('P0001 ��ǰ�� ǰ���Դϴ�.');
    ELSIF v_sold_yn = 'N'
    THEN DBMS_OUTPUT.PUT_LINE('P0001 ��ǰ�� �Ǹ����Դϴ�');
    END IF;
    v_sold_yn := null;
    SELECT SOLD_OUT_YN INTO v_sold_yn FROM TB_PRD WHERE PRD_ID = 'P0015';
    IF v_sold_yn = 'Y'
    THEN DBMS_OUTPUT.PUT_LINE('P0015 ��ǰ�� ǰ���Դϴ�');
    ELSE DBMS_OUTPUT.PUT_LINE('P0015 ��ǰ�� �Ǹ����Դϴ�');
    END IF;
END;
/

EXEC P_SOLD_OUT_YN_DEL;

-----------------------------------------------------

CREATE OR REPLACE PROCEDURE P_SOLD_OUT_YN_DEL
AS
v_prd_id TB_PRD.PRD_ID%TYPE;        --v_prd_id�� �÷�Ÿ���� TB_PRD�� PRD_ID�� �����ϰ�
v_sold_yn TB_PRD.SOLD_OUT_YN%TYPE;  --v_sold_yn�� �÷�Ÿ���� TB_PRD�� SOLD_OUT_YN�� �����ϰ�

CURSOR c_prd_cursor IS SELECT pRD_ID, SOLD_OUT_YN FROM TB_PRD;
-- Ŀ���� �������� ����� �����
-- �� IS �ڿ��ִ� SELECT ����� �ν��Ͻ� �������� �� �྿ ���������� �� �� ����

BEGIN
    OPEN c_prd_cursor; --�� Ŀ���� ���(���)�ϰڴٴ� �ǹ�

    LOOP --LOOP�ݺ����� ������ �ǹ�
        FETCH c_prd_cursor INTO v_prd_id, v_sold_yn; --FETCH�� �ϸ� ����� Ŀ������ �� �྿�� �������Ⱑ ����
        IF v_sold_yn = 'Y' then
            dbms_output.put_line(V_PRD_ID || '�� ǰ���Դϴ�.');
        ELSE 
            dbms_output.put_line(V_PRD_ID || '�� �Ǹ����Դϴ�.');
        END IF;
        
        EXIT WHEN c_prd_cursor%NOTFOUND; --���̻� ������ ���� ���ٸ�(COTFOUND) �ݺ��� ����(EXIT)
    END LOOP; --LOOP �ݺ����� ���� �ǹ�
    CLOSE c_prd_cursor; --�� Ŀ���� �ٽ� �ݰڴٴ� �ǹ�
END; --���ν��� ��������
/

EXEC P_SOLD_OUT_YN_DEL;








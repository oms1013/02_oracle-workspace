-- ���� ���� 
/*
    < TCL : TRANSCATION CONTROL LANGUAGE > 
    Ʈ����� ���� ��� 
    
    
    * Ʈ������ (TRANSACTION) 
    - �����ͺ��̽� �� ���� ���� 
    - �������� �������(DML �߰�, ����, ����)���� �ϳ��� Ʈ����ǿ� ��� ó��  
    
    
    --Ʈ������� COMMIT���� ���� �Է��� �����Ű�°� �ƴҶ� �ӽ÷� �����صδ� ����
    -- AUTO COMMIT? 
    ROLLBACK�� Ʈ�������� ���� ������ COMMIT �������� ���ƿ��°� 
    DML �� �Ѱ��� ������ �� Ʈ�������� �����ϸ� �ش� Ʈ����ǿ� ���� ��� ó�� 
                         Ʈ�������� �������� ������ Ʈ�������� ���� ���� 
    COMMIT�� �ϱ� �������� ������׵��� �ϳ��� Ʈ�����ǿ� ��� �� 
    - Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE (DML) 
    
    COMMIT  (Ʈ������ ���� ó�� �� Ȯ��)
    ROLLBACK (Ʈ������ ���) 
    SAVEPOINT (�ӽ� ����) 
    
    - COMMIT; ���� : �� Ʈ����ǿ� ����ִ� ������׵��� ���� DB�� �ݿ���Ű�ڴٴ� �ǹ� (�Ŀ� Ʈ�������� �����) 
    - ROLLBACK; ���� : �� Ʈ�����ǿ� ����ִ� ������׵��� ����(���) �� �� ������ COMMIT �������� ���ư� 
    - SAVEPOINT ����Ʈ��; : ���� �� ������ �ش� ����Ʈ������ �ӽ� �������� �����صδ� �� 
                           ROLLBACK ���� �� ������׵� �� �����ϴ°� �ƴ϶� �Ϻθ� �ѹ鰡��
         
*/

SELECT * FROM EMP_01;

-- ����� 900�� ��� �����
DELETE FROM EMP_01
WHERE EMP_ID = 900;

-- ����� 901���� ��� �����
DELETE FROM EMP_01
WHERE EMP_ID = 901;

-- Ʈ����ǿ� 900, 901 ����� ����Ǿ� ����
ROLLBACK;
--DELETE �ΰ��� �� ������ ��ҵ�

----------------------------------------------------------------------------

-- 200���� ��� ����� 
DELETE FROM EMP_01
WHERE EMP_ID = 200; 

-- 800, ȫ�浿, �ѹ��� ��� �߰�
INSERT INTO EMP_01
VALUES (800, 'ȫ�浿', '�ѹ���');

SELECT * FROM EMP_01;

COMMIT;

ROLLBACK; 
--�ѹ� COMMIT�� ��Ű�� ROLLBACK�� �ص� ���ƿ��� �ʴ´�. �̹� Ʈ����ǿ� ���ִ���
--����Ǿ��� �ѹ��� COMMIT �����������δ� ���ư��� ���ϱ� ������. 

-- 217, 216, 214 ��� ���� 
DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

SAVEPOINT SP;

-- 801, �����, �λ������ ��� �߰�
INSERT INTO EMP_01
VALUES (801, '�����', '�λ������');

SELECT * FROM EMP_01;

-- 218 ��� ����
DELETE FROM EMP_01
WHERE EMP_ID = 218; 

ROLLBACK TO SP;
COMMIT;
SELECT * FROM EMP_01;

--------------------------------------------------------------------------------

-- 900�� , 901��� ����
DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

--218�� ��� ����
DELETE FROM EMP_01
WHERE EMP_ID =218;

SELECT * FROM EMP_01;

-- DDL��
CREATE TABLE TEST(
    TID NUMBER 
);
ROLLBACK;

-- DDL�� ( CREATE, ALTER, DROP)�� �����ϸ� ������ Ʈ�������� �ִ� ������׵��� COMMIT ���ѹ���
-- �� DDL ���� �� ��������� �־��ٸ� ��Ȯ�� �Ƚ�(COMMIT, ROLLBACK)�� ���ĵξ�� �Ѵ�. 



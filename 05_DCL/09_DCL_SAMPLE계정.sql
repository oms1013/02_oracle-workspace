-- ���� ���� 
CREATE TABLE TEST(
    TEST_ID NUMBER, 
    TEST_NAME VARCHAR2(10) 
    --insufficient privileges
    --������ ���ٴ� ������ ��µ� 
); 




-- CREATE TABLE �� �� �ִ� ������ ��� ������ �߻��� 
-- 3_1. CREATE TABLE �ý��� ���� �ޱ� 
-- 3_2. TABLESPACE �Ҵ� �ޱ� 

SELECT * FROM TEST;
INSERT INTO TEST VALUES(10, '�ȳ�');
-- CREATE TABLE ������ ���̺� ���� �� �ƴ϶� �ٷ� ������ ��������
-- (��ȸ, �Է� ���) 

--------------------------------------------

-- KH���� �� �ִ� EMPLOYEE ���̺� ���� 
-- �ٵ� ��ȸ ������ ���� 

-- 4. ��ȸ ��ȯ �ޱ�
SELECT * FROM KH.EMPLOYEE;
-- KH������ EMPLOYEE ���̺����� ��ȸ ������
-- SAMPLE ������ �ο��ؼ� ��ȸ�� ����������. 
SELECT * FROM KH.DEPARTMENT; 

-- 5. INSERT ON KH.DEPARTMENT ���� �ο��ޱ�
INSERT INTO KH. DEPARTMENT 
VALUES ('D0', 'ȸ���', 'L1');

ROLLBACK;



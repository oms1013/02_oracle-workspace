--����
--------------------------------QUIZ1--------------------------------
--���ʽ��� ���� ������ �μ���ġ�� �� ��� ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
-- NULL���� ���� ���� �ܼ��� �Ϲ� �񱳿����ڸ� ���� ���ϴ°� �Ұ����ϴ�.
-- �ذ��� : IS NULL / IS NOT NULL �����ڸ� �̿��ؼ� ���ؾ���

SELECT * FROM EMPLOYEE; 

SELECT * 
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;


----------------------------------QUIZ 2-----------------------------------
--�˻��ϰ��� �ϴ� ����
-- JOB_CODE�� J7�̰ų� J6�̸鼭 SALARY���� 200���� �̻��̰� 
-- BONUS�� �ְ� �����̸� �̸��� �ּҴ� _�տ� 3���ڸ� �ִ� ����� EMP_NAME, EMP_NO,
-- JOB_CODE, DEPT_CODE, SALARY, BONUS�� ��ȸ�Ϸ��� �Ѵ�.
-- ���������� ��ȸ�� �� �ȴٸ� �������� 2���̿��� �Ѵ�. 

--�� ������ �����Ű���� �ۼ��� SQL���� ������ ����
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS, EMAIL
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE ='J6' AND SALARY >2000000 
AND EMAIL LIKE '___%' AND BONUS IS NULL;

--�� SQL�� ����� ���ϴ� ����� ����� ��ȸ���� ����. � ������ �ִ��� ��� ã�Ƽ� ����
--�׸��� �Ϻ��� SQL�� ����

--������
/*
    1. OR�����ڿ� AND�����ڰ� �������� ��� AND���� ������ ��. �������� �䱸�� �������� 
       OR������ ���� ����Ǿ�� �Ѵ�. 
    2. �޿����� ���� �񱳰� �߸��Ǿ� ����.  >�� �ƴ� >=���� ���ؾ���. 
    3. ���ʽ��� �ִ� �̶�� ���ǿ� IS NULL �� �ƴ� IS NOT NULL�� ���ؾ���
    4. ���ڿ� ���� ������ �����Ǿ� ����
    5. �̸��Ͽ� ���� �񱳽� �׹�° �ڸ��� �ִ� _�� �����Ͱ����� ������� �ʰ� �� ���ϵ�ī�带
    �����ؾߵǰ�, ���� ESCAPE�� ��ϵ� �������. 
*/

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS, EMAIL
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE ='J6') AND SALARY >=2000000 
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8,1) IN ('2','4');

----------------------------------QUIZ3-------------------------------------
--[������������] CREATE USER ������ IDENTIFIED BY ��й�ȣ; 

--���� : COOKIE, ��й�ȣ : COOKIE ������ �����ϰ� �ʹ�. 
-- �� �� �Ϲݻ���� ������ KH������ �����ؼ� CREATE USER COOKIE; �� �����ϴ� ������ �߻� 

-- ������1. ����� ���� ������ ������ ������ ���������� ����!! 
-- ������2. SQL���� �߸��Ǿ�����! ������� �Է��ؾ���

-- ��ġ���� 1. ������ �������� ����
-- ��ġ���� 2. CREATE USER COOKIE IDENTIFIED BY COOKIE; 
CREATE USER COOKIE IDENTIFIED BY COOKIE;

--���� SQL(CREATE)�� ���� �� ������ ����� ������ �Ϸ��� �ߴ��� ����
--�� �ƴ϶� �ش� ������ ���̺� �������� �͵� ���� ����! �ֱ׷���?

-- ������1. ����� ���� ���� �� �ּ����� ���� �ο�
--���ӱ��� : CREATE SESSION 

--��ġ����1
GRANT CREATE SESSION TO COOKIE; --���Ӹ� �ϴ� ����
GRANT CREATE TABLE TO COOKIE; 

GRANT CONNECT, RESOURCE TO COOKIE; --������ �Ѱ���


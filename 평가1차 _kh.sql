/*

1
[
1. ���1
����1- ������ ����� �� ������ ������ �ƴ� �Ϲ� ����� 
����2- ���� ���� ������ ���� ID�� �����ǰ� ��й�ȣ ������ ���� ����

2. ���
����-������ ��������� ���� ����, ���̺� ���� ������ �־�������
���� �����̱� ������ ���ӵ� ���� �ʰ� ���̺� ������ �Ұ����� ��

��ġ����

���1
1. ���� ���� �� ������ ���� ������ �ִ� ������ �������� ���� ������ �����ؾ��� 
2. ���� ���� ���� ������ �����ؼ� ��й�ȣ ������ �Է��ؾ� ��.
CREATE USER SAMPLE; =>
CREATE USER SAMPLE IDENTIFIED BY 1234;


���2
���� ���� ������ �������� SAMPLE ������ ���� ������ �ο��ؾ� ��
GRANT CONNECT TO SAMPLE; ������ ����

���� ���̺� ���� ������ SAMPLE ������ �־�� �ϱ� ������ �ش� ������ ������ �������� �����ؾ���
GRANT CREATE TABLE TO SAMPLE;  


]
*/



SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____%' ;


SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE='D9' OR DEPT_CODE='D6') --��ȣ �߰��� OR������ ���� ����ǰ� ����
AND SALARY >= 3000000 -- 3000000 �̻� ���� ���� ����
AND BONUS IS NOT NULL -- BONUS�� �ִ� ������ ���� ����
AND EMAIL LIKE '___$_%' ESCAPE '$'  -- '$' ���� ESCAPE ������ ���� 4��° '_'�� 
--���ϵ�ī��� �����޵��� ������ ����
AND SUBSTR(EMP_NO, 8,1) IN (1,3); --������ ������ ���� �߰�







--����
--NULL���� ���� ������ '=', '!=' �� ���� �񱳿����ڵ�δ� ���� �ν����� ���ϱ� �����̴�.

SELECT * 
FROM EMPLOYEE 
WHERE BONUS IS NULL AND MANAGER_ID IS NOT NULL;
--BONUS�� NULL�̱� ������ IS NULL, 
--MANAGER_ID�� NULL���� �ƴϱ� ������ IS NOT NULL�� �����ؾ� �Ѵ�.

/*

[





]
*/







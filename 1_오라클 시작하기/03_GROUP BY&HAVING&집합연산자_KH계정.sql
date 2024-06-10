
/*

        < GROUP BY �� > 
        �׷� ������ ������ �� �ִ� ���� (�ش� �׷���غ��� ���� �׷��� ���� �� ����) 
        �������� ������ �ϳ��� �׷����� ��� ó���� �������� ��� 

*/

SELECT SUM(SALARY)
FROM EMPLOYEE; --> ��ü ����� �ϳ��� �׷����� ��� ������ ���� ���

-- �� �μ��� �� �޿� ��

SELECT DEPT_CODE, SUM(SALARY) --  
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� ��� ��
SELECT DEPT_CODE, COUNT(*), SUM(SALARY) --
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY) --3
FROM EMPLOYEE --1 
GROUP BY DEPT_CODE --2
ORDER BY DEPT_CODE; --4
--ORDER BY���� �׻� �������� �Է��ؾ���

SELECT DISTINCT JOB_CODE --DISTINCT, �ߺ��� ����
FROM EMPLOYEE;

SELECT JOB_CODE, COUNT(*), SUM(SALARY) --3
FROM EMPLOYEE --1
GROUP BY JOB_CODE --2
ORDER BY JOB_CODE; --4

--�� ���޺�  �� �����, ���ʽ��� �޴� ��� ��, �޿� ��, ��� �޿�, �����޿�, �ִ�޿�
SELECT DEPT_CODE, COUNT(*) AS "�� ��� ��", COUNT(BONUS) AS "���ʽ� �޴� �����",
                SUM(SALARY) AS "�޿� ��", FLOOR(AVG(SALARY)) AS "��� �޿�", 
                MIN(SALARY) AS "�����޿�", MAX(SALARY) AS "�ִ� �޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE;
ORDER BY 1;
--���ĵ��� �ۼ����� ������ GROUP BY ��� ������ ����
-- EX) GROUP BY 'DEPT_CODE'�ε� SELECT���� 'DEPT_CODE'�� �ƴ� �ٸ� �̸��� ��

--GROUP BY ���� �Լ��� ����� �� ����
SELECT DECODE(SUBSTR(EMP_NO, 8,1), '1',  '��',  '2', '��'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

--GROUP BY���� ���� �÷��� ����� �� �ִ�. 
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

--------------------------------------------------

/*
    < HAVING �� >
    �׷쿡 ���� ������ ������ �� ���Ǵ� ���� (�ַ� �׷��Լ����� ������ ������ ������ �� ���)
*/

--�� �μ��� ��� �޿� ��ȸ(�μ� �ڵ�, ��� �޿�) 
SELECT DEPT_CODE, TRUNC(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE --1
WHERE AVG(SALARY)>=3000000 --���� �߻�, AVG(SALARY)�� �Ұ�.
--�׷��Լ����� WHERE���� �� �� ����. SALARY�� �ƴ϶� AVG�� �Ұ��� --2
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000; 
--WHERE ���� ��ü �����Ϳ� ���� ����, HAVING���� �׷쿡 ���� �����̴�.
-- �׷쿡 ���� ������ �ɰŸ� HAVING���� ���°� ���� 
-- WHERE�� ��� ���ϴ°� �ƴ�, AVGó�� �׷��Լ��� GROUP BY�� �Բ� �����°�

--���޺� �� �޿���(��,���޺� �޿����� 1000���� �̻��� ���޸��� ��ȸ)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;
HAVING SUM(SALARY) >=10000000;

--�μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ �μ��ڵ常 ��ȸ(HAVING�Ἥ)
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;
----------------------------------------------------------------------
/*
    < SELECT �� ���� ���� >  ��
    5.SELECT * | ��ȸ�ϰ��� �ϴ� �÷� | ����� "�� Ī()" | �Լ��� AS "��Ī" 
    1.FROM ��ȸ�ϰ��� �ϴ� ���̺��
    2.WHERE ���ǽ� (�����ڵ��� ������ ���) 
    3.GROUP BY �׷�������� ���� �÷� | �Լ���
    4.HAVING ���ǽ�(�׷��Լ��� ������ ����ؾ���) 
    6.ORDER BY �÷���|��Ī|���� [ASC|DESC] [NULLS FIRST|NULLS LAST]
*/
--------------------------------------------------------------------
/*
    < ���� �Լ� > 
    �׷캰 ����� ������� �߰� ���踦 ������ִ� �Լ� 
    
    ROLL UP 
    => GROUP BY ���� ����ϴ� �Լ� 
    GROUPY BY�� ���� �Լ��� �հ踦 ����Ϸ��� �� �� ����Ѵ�. 
*/

--�� ���޺��� �޿��� �� 
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1; 

--ROLLUP : �߰� ���踦 ���� �Լ� 


----------------------------------------------------------------
/*
        < ���� ������ == SET OPERATION >
        
        �������� �������� ������ �ϳ��� ���������� ����� ������ 
        
        - UNION         : OR | ������ ( �� ������ ������ ������� ���� �� �ߺ��Ǵ�
                            ���� �ѹ��� ���������� ��) 
        - INTERSERCT    : AND | ������ ( �� ������ ������ ������� �ߺ��Ǵ� ����� 
        - UNION ALL     : ������+������ ( �ߺ��Ǵ� �κ��� �ι� ǥ���� �� ����)
        - MINUS         : ������ (���� ��������� ���� ������� �� ������) 
*/

-- 1. UNION 
-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ (���,�̸�,�μ��ڵ�,�޿�)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE  DEPT_ CODE = 'D5'; 
--6����(�ڳ���, ������, ���ؼ�, �ɺ���, ������,���ȥ) 

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY >3000000; 
--8����(������,������,��ȫö,�����,������,�ɺ���,���ȥ,������)

--1. UNION(������) 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY >3000000; 
--�� ����� 8+6-2(��ġ�� �κ�) 
--12�� ���� ��µȴ�. 

--���� ������ ��� WHERE���� OR�� �ᵵ �ذ��� ������.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' OR SALARY>3000000;

-- 2. INTERSECT(������) 
-- �μ��ڵ尡 D5�̸鼭�� �޿������� 300���� �ʰ��� ��� ��ȸ 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY >3000000; 
--�� ������ �� �����ϴ� 2�� �� ��� 

--���������� AND�� ����ؼ� ���� �� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' AND SALARY>3000000;

---------------------------------------------------------
--���տ����� ���� ���� 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY >3000000;
/* �� �������� SELECT���� �ۼ��Ǿ� �ִ� �÷� ������ �����ؾ� �Ѵ�. 
ORA-01789: query block has incorrect number of result columns
01789. 00000 -  "query block has incorrect number of result columns"
*Cause:    
*Action:

*/


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >3000000;
/* �÷� ���� �� �ƴ϶� �� �÷� �ڸ����� ������ 'Ÿ��'���� ����ؾ� �Ѵ�.
ORA-01789: query block has incorrect number of result columns
01789. 00000 -  "query block has incorrect number of result columns"
*Cause:    
*Action:

*/


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
--ORDER BY EMP_NAME �ι� ���� ���� �߻�
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE SALARY >3000000
ORDER BY EMP_NAME;
--�� Ÿ���� ���絵 �۵��ϱ� ������ SALARY�� BONUS�� �̻��ϰ� ����������
--�ᱹ �۵��� ���� �� ������ ����

--���� ORDER BY�� �� ������ �ѹ��� ����� ������
--�������� �ѹ��� ����ؾ���

----------------------------------------------------------------

--3. UNION ALL : ���� ������ ����� ������ �ٴ���. �� ������+��ģ�κ� �߰�(�ߺ�������)
--
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;
--�׳� ���Ͽ¿��� ��ģ�κи� �ѹ� �� ��µ�

--4. MINUS : ���� SELECT ������� ���� SELECT�� ����� �� ������
--�μ��ڵ尡 D5�� ����� �� �޿��� 300�����ʰ��� ������� �����ؼ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5' and SALARY <= 3000000;
--�̷��Ե� ������ ��


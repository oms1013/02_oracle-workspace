/*
    < SELECT >
    �����͸� ��ȸ�� �� ����ϴ� ����
    
    >> RESULT SET : SELECT���� ���ؼ� ��ȸ�� ����� (��, ��ȸ�� ����� ����)
    
    [ǥ����] 
    SELECT ��ȸ�ϰ��� �ϴ� �÷�1, �÷�2, ...
    FROM ���̺��;
    
    * �翬�� �ݵ�� �����ϴ� �÷����� ��� �Ѵ�. ���� �÷� ���� ������ 

*/

-- EMPLOYEE ���̺��� ��� �÷�(*) ��ȸ
-- SELECT EMP_ID, EMP_NAME, EMP_NO,  ...
--SELECT *
--FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���, �̸�, �޿� ��ȸ
--SELECT EMP_ID, EMP NAME, SALAY
SELECT *
FROM EMPLOYEE; 

-- JOB ���̺��� ��� �÷� ��ȸ
SELECT *
FROM JOB; 

----------------------------�ǽ�����----------------------------------
--1. JOB ���̺��� ���޸� ��ȸ
SELECT JOB_NAME
FROM JOB;

--2. DEPARTMENT ���̺��� ��� �÷�
SELECT *
FROM DEPARTMENT;

--3. DEPARTMENT ���̺��� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
--4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ
SELECT EMP_NAME,EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
  <�÷����� ���� �������>
  SELECT �÷��� �ۼ� �κп� ������� ��� ����(�̶�, �������� ��� ��ȸ
*/

--EMPLOYEE ���̺��� �����, ����� ����(�޿� * 12) ��ȸ
SELECT EMP_NAME, SALARY *12
FROM EMPLOYEE;

--EMPLOYEE ���̺��� �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

--EMPLOYEE���̺��� �����, �޿�, ���ʽ�, ����
SELECT EMP_NAME, SALARY, BONUS, (SALARY+(SALARY*BONUS)) *12
FROM EMPLOYEE;

--> ��� ���� ���� �� NULL���� ������ ��� ������� ����������� NULL�� ��µȴ�. 

-- EMPLOYEE�� �����, �Ի���, �ٹ��ϼ�(���� ��¥ - �Ի���)
-- DATE���ĳ����� ������ �����ϴ�.
-- *���� ��¥ : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

-- DATE - DATE : ������� �� ������ ����! 
-- ��, ���� �������� ������ DATE������ ��/��/��/��/��/�� ������ �ð�����
-- ������ �����ϱ⶧���� ���� �� ������ �� �� �ִ�. �Լ� �����ؼ� ����� ��� Ȯ�ΰ���


-----------------------------------------------------------------------
/*
    
    <�÷��� ��Ī �����ϱ�> 
    ��������� �ϰ� �Ǹ� �÷����� ��������... �� �� �÷������� ��Ī�� �ο��ؼ�
    ����ϰ� ������ �� �ִ�. 
    
    [ǥ����]  
    �÷��� ��Ī / �÷��� AS ��Ī / �÷��� "��Ī" / �÷��� AS "��Ī"
    
    AS Ű���带 ���̵� �Ⱥ��̵簣�� �ο��ϰ��� �ϴ� ��Ī�� ���� Ȥ�� Ư������
    �� ���Ե� ��쿡�� �ݵ�� �ֵ���ǥ("")�� �����.
    
*/
SELECT EMP_NAME �����, SALARY AS �޿�, SALARY*12 "����(��)", (SALARY+SALARY*BONUS)*12 AS "���ʽ� ���� ����"
FROM EMPLOYEE;


------------------------------------------------------------------------
/*
    < ���ͷ� > 
    ���Ƿ� ������ ���ڿ�('')    
    
    SELECT���� ���ͷ��� �����ϸ� ��ġ ���̺�� �����ϴ� ������ó�� ��ȸ�� �����ϴ�. 
    ��ȸ��RESULT SET�� ��� �࿡ �ݺ������� ���� ��� 
*/
-- EMPLOYEE ���̺��� ���, �����, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS "����"
FROM EMPLOYEE;

/*
    < ���� ������ : || >
    ���� �÷������� ��ġ �ϳ��� �÷��� ��ó�� �����ϰų�, 
    �÷����� ���ͷ��� ������ �� ����
    
    System.out.println("num�� �� : " +num); �̷� ����
        
*/
--���, �̸�, �޿��� �ϳ��� �÷����� ��ȸ 
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;


----�÷����̶� ���ͷ��� ����
--- xxx�� ������ xxx���Դϴ�. => �÷��� ��Ī : �޿�����
SELECT EMP_NAME ||  '�� ������ ' || SALARY ||'�� �Դϴ�.' AS "�޿�����"
FROM EMPLOYEE;

--------------------------------------------------------------
    /*
    < DISTINCT >
    �÷��� �ߺ��� ������ �� ������ ǥ���ϰ��� �� �� ����� 
    */
--���� �츮 ȸ�翡 � ������ ������� �����ϴ��� �ñ���.
SELECT JOB_CODE
FROM EMPLOYEE;  --����� 23���� ������ ������� �� ��ȸ�ȴ�. 

-- EMPLOYEE �����ڵ� (�ߺ� ����) ��ȸ 
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;  --�ߺ��� ���ŵǼ� 7�ุ ��ȸ��. 

--������� � �μ��� �����ִ��� �ñ���
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- null: ���� �μ� ��ġ�� ���� ���� ��� 



---���ǻ��� : DISTINCT�� SELECT���� �� �ѹ��� ����� ������ 
/* ��������
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE --
FROM EMPLOYEE;
*/

SELECT DISTINCT JOB_CODE, DEPT_CODE 
FROM EMPLOYEE;
--(JOB_CODE, DEPT_CODE)�� ������ ��� �ߺ��� �Ǻ��ѵ� ��ȸ 

-- ==============================================================

/*
    < WHERE �� > 
    ��ȸ�ϰ��� �ϴ� ���̺� �κ��� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ���
    �̶� WHERE������ ���ǽ��� �����ؾ���! 
    ���ǽĿ����� �پ��� �����ڵ��� ����� �� �ִ�
    
    [ǥ����] 
    SELECT �÷�1, �÷�2, .. 
    FROM ���̺��
    WHERE ���ǽ�
    
    [�񱳿�����]
    >, <, >= , <=  -->  ��Һ�
    =              -->  �����
    !=, ^=, <>     -->  �������� ������ �� 
     
*/

--EMPLOYEE ���� �μ��ڵ尡 'D9'�� ����鸸 ��ȸ. (�� ��, ��� �÷� ��ȸ)

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D1'�� ������� �����, �޿�, �μ��ڵ常 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';


-- �μ��ڵ尡 D1�� �ƴ� ������� ���, �����, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1'; --NULL�� ��ȸ���� �ʴ´�.
--WHERE DEPT_CODE ^='D1';
WHERE DEPT_CDOE <> 'D1'; 


-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;


-- EMPLOYEE���� ������ (ENT_YN�� �÷����� 'N')�� ������� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

---------------------------------�ǽ�����-----------------------------

--1. �޿� 300���� �̻��� ������� �޿�, �Ի���, ����(���ʽ� ������) ��ȸ
SELECT SALARY, HIRE_DATE, SALARY*12
FROM EMPLOYEE
WHERE SALARY >= 3000000;



--2. ���� 5000���� �̻��� ������� �޿�, ����, �μ��ڵ� ��ȸ

SELECT EMP_NAME, SALARY, SALARY*12 AS "����", DEPT_CODE
FROM EMPLOYEE
--WHERE ���� >=50000000; -- invalid identifier �߻� '������ ���� �𸣰ڴ�'
--WHERE�������� SELECT���� �ۼ��� ��Ī�� ����� �� ����. 
WHERE SALARY*12>=50000000;

--���� ���� ����
-- FROM��. �ϴ� ��� ������ ������ ����
-- WHERE��. � ������ ���� �༮�� ã���� �ǳ�
-- SELECT��. ���ǿ� �����ϴ� �༮�� ã�Ұ� ���� ��� �κ��� ����ұ�
-- �׷��� ���� ���ǽ��� SELECT�� "����"�� ����Ȱ�  ã�Ƴ��� ���߱� ������ 
-- WHERE���� "����"�� ã�Ƴ��� ���Ѱ�



--3. �����ڵ� 'J3'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ
SELECT  EMP_NO, EMP_NAME, DEPT_CODE,  ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE <> 'J3';



-- �μ��ڵ尡 'D9'�̸鼭 �׺��� 500���� �̻��� ������� ���, �����, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000; --WHERE ���ǽĿ� AND, OR��밡��


-- �μ��ڵ� 'D9' �̰ų� �޿��� 300���� �̻��� ������� �����, �μ��ڵ�, �޿���ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;


--�޿��� 350���� �̻� 600���� ���ϸ� �޴� ������� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE 350<=SALARY<=600; �ڹٶ� ���������� �Ұ���
WHERE SALARY >= 3500000 AND SALARY<=6000000;

-----------------------------------------------------------
/*
    < BETWEEN A AND B>  
    ���ǽĿ��� ���Ǵ� ���� 
    �� �̻��̰� �� ������ ���� �� ���� ������ ������ �� ���Ǵ� ������ 
    
    [ǥ����]
    �񱳴���÷� BETWEEN A(��1) AND B(��2)
    => �ش� �÷����� A(��1) �̻��̰� B(��2) ������ ��� ��� ���� 
    
*/
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE 
WHERE SALARY BETWEEN 3500000 AND 6000000;


--���� ���� ���� ���� ������� ��ȸ�ϰ� �ʹٸ� ?  350�̸� + 600 �ʰ� 
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 OR SALARY > 6000000;

-- �ش� ������ �ƴҶ� NOT ���. 
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- �÷� �� �� �Ǵ� BETWEEN �տ� ������ ����

-- �Ի��� '90/01/01' ~ '01/01/01'
 SELECT *
 FROM EMPLOYEE
 --WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '2001/01/01';
  WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-----------------------------------------------------------------

/*
   <LIKE>
   ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ 
   
   [ǥ����] 
   �񱳴���÷� LIKE 'Ư������' 
   
   -Ư�� ���� ���ý� '%', '_'�� ���ϵ�ī��� ����� �� ���� 
    
    >>'%' : 0���� �̻�
    EX) �񱳴���÷� LIKE '����%' => �񱳴���� �÷����� ���ڷ� "����"�Ǵ°� ��ȸ
        �񱳴���÷� LIKE '%����' => �񱳴���� �÷����� ���ڷ� "��"���°� ��ȸ 
        �񱳴���÷� LIKE '%A����%' => �񱳴���� �÷����� ���ڰ� "����"�Ǵ°� ��ȸ
   
   >> '_' : 1���� 
   EX ) �񱳴���÷� LIKE '_����'  => �񱳴���� �÷����� ���ھտ� ������ �ѱ��ڰ� �� ��� ��ȸ
        �񱳴���÷� LIKE '__����' => �񱳴���� �÷����� ���ھտ� ������ �α��ڰ� ���ð�� ��ȸ
        �񱳴���÷� LIKE '_����_' => �񱳴���� �÷����� ���� ���̶� �ڿ� ������ �ѱ��� �� ��� ��ȸ
        
*/

-- ����� �� ���� ������ ������� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';
   
--�̸��߿� �� �� ���Ե� ������� �����, �ֹι�ȣ, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';


--�̸��� ��� ���ڰ� ���� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';


-- ��ȭ��ȣ�� ����° �ڸ��� 1�� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ  
-- ���ϵ� ī�� : _(1����), %(0���� �̻�)
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%'; -- ��


-- ** Ư�����̽� 
-- �̸��� �� _�������� �ձ��ڰ� 3������ ������� ���, �̸�, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';  --���ߴ� ��� ���� ����!@
-- ���ϵ�ī��� ���ǰ� �ִ� ���ڿ� �÷����� ��� ���ڰ� �����ؼ� ��ȸ�� ����� ���� ����
-- ��� ���ϵ� ī��� ��� ������ ������ �����������!!!
-- ������ ������ ����ϰ��� �ϴ� �� �տ� ������ ���ϵ� ī�带 �����ϰ�, 
-- ������ ���ϵ� ī�带 ESCAPE OPTION���� ����ؾ� �Ѵ�. 

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE 
WHERE EMAIL LIKE '___$_%' ESCAPE '$'; -- $�� ������ �ű⼭���� ���ϵ�ī�尡 �ƴ�
--�ϱ� Ż���ض�. �� ���� _�� ���ϵ�ī�尡 �ƴ�. �� 4��°�� _�� ���� ������� ���
--�١١�
--���� ������� �ƴ� �� ���� ������� ��ȸ�ϰ��� �ϸ�?
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE 
WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';
--�׳� �տ� NOT�� �޾ƹ����� ���. �÷��� ���̳� LIKE �տ� ������ �����ϴ�. 

-----------------------------�ǽ�����--------------------------------------

-- 1. EMPLOYEE���� �̸���'��'���� ������ ������� �����, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';


--2. EMPLOYEE���� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';


--3. EMPLOYEE���� �̸��� '��'�� ���Եǰ� �޿��� 240���� �̻��� ������� �����,�޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND SALARY>=2400000;

--4. DEPARTMENT���� �ؿܿ������� �μ����� �μ��ڵ�, �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

--------------------------------------------------------
/*
    < IS NULL / IS NOT NULL >
    �÷����� NULL�� ���� ��� NULL�� �񱳿� ���Ǵ� ������ 
       
*/

-- ���ʽ��� ���� �ʴ� ���(BONUS ���� NULL)���� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS = NULL; ���������� ��ȸ���� ����
WHERE BONUS IS NULL; --���ʽ� ���°��(NULL)


-- ���ʽ��� ���� �ʴ� ���(BONUS ���� NULL)���� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS != NULL; --�Ұ�, NULL�� =�� !=�� ��� �Ұ�
WHERE BONUS IS NOT NULL; --���ʽ��� ���� ���ִ� ���
--WHERE NOT BONUS IS NULL; -- �� ��쵵 ������ ��
--NOT�� �÷��� �Ǵ� IS �ڿ��� ��� ����


-- ����� ���� ���(MANAGER_ID���� NULL)���� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;


-- �μ���ġ�� ���� ������ �ʾ�����, ���ʽ��� �޴� ������� �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-----------------------------------------------------
/*
    < IN > 
    �񱳴���÷����� ���� ������ ��� �߿� ��ġ�ϴ� ���� �ִ��� 
    
    [ǥ����] 
    �񱳴���÷� IN (��1, ��2, ��3, ..)
    
*/

-- �μ��ڵ� D6�̰ų� D8�̰ų� D5�� �μ������� �̸�, �μ��ڵ�, �޿� ��ȸ 
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D6';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5'); -- �� ���� ���� 

--�� ���� �����
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D6';
WHERE DEPT_CODE NOT  IN ('D6', 'D8', 'D5'); -- �� ���� ���� 


-------------------------------------------
/*

    <������ �켱 ����>
    0.()
    1. ���������
    2. ���Ῥ����
    3. �񱳿�����
    4. IS NULL / LIKE 'Ư������' / IN
    5. BETWEEN A AND B
    6. NOT(��������)
    7. AND(��������)
    8. OR(��������) 
        
*/

-- �����ڵ� J7�̰ų� J2�� ����� �� �޿��� 200���� �̻��� ������� ��� �÷� ��ȸ
-- ��OR���� AND�� ���� ����ȴ�. 
SELECT *
FROM EMPLOYEE
--WHERE JOB_CODE = 'J7' OR JOB_CODE ='J2' AND SALARY > 2000000;
-- OR���� AND�� ���� �۵��ؼ� J2�鼭 200�� �̻��� ����� OR �׳� J7�� ��µȴ�. 
WHERE (JOB_CODE = 'J7' OR JOB_CODE ='J2') AND SALARY > 2000000;
-- �̷��� ������� ���������� ��µȴ�. 


-----------------------�ǽ�����-----------------------------

--1. ����� ���� �μ���ġ�� ���� ���� ������� (�����,������,�μ��ڵ�)
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE 
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--2. ����(���ʽ� ������)�� 3000���� �̻�, ���ʽ� ���� �ʴ� ������� 
--(���,�����,�޿�,���ʽ�)
SELECT EMP_NO, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE (SALARY*12) >= 30000000 AND BONUS IS NULL;


--3. �Ի����� '95/01/05' �̻��̰� �μ���ġ�� ���� ������� 
--( ���, �����, �Ի���, �μ��ڵ�)��ȸ
SELECT EMP_NO, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/05' AND DEPT_CODE IS NOT NULL;


--4. �޿��� 200���� �̻�, 500���� �����̰� �Ի����� '01/01/01' �̻��̰� ���ʽ��� 
--���� ���� ������� (���, �����, �޿�, �Ի���, ���ʽ�)
SELECT EMP_NO, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000 AND 
HIRE_DATE >= '01/01/01' AND BONUS IS NULL;


--5. ���ʽ� ���� ������ NULL�� �ƴϰ�, �̸��� '��'�� ���ԵǾ� �մ� �������
--(���,�����,�޿�, ���ʽ� ���� ����)��ȸ. (��Ī �ο��ؾ���)
SELECT EMP_NO AS "�����ȣ", EMP_NAME  AS "�����" , SALARY AS "�޿�",
(SALARY+(SALARY*BONUS))*12 AS "���ʽ� ���� ����"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND (SALARY+(SALARY*BONUS))*12 IS NOT NULL;



SELECT EMP_ID, EMP_NAME, SALARY --3
FROM EMPLOYEE  -- 1
WHERE DEPT_CODE IS NULL; --2

---------------------------------------------------------------------
/*
    < ORDER BY �� > ��
    ���� ������ �ٰ� �ۼ���! �Ӹ� �ƴ϶� ������� ���� �������� ���� 
    
    
    
    [ǥ����] 
    SELECT ��ȸ�� �÷�, �÷�, �������� AS "��Ī" 
    FROM ��ȸ�ϰ��� �ϴ� ���̺�� 
    WHERE ���ǽ� 
    ORDER BY �����ϰ�����÷�|��Ī|�÷����� [ASC|DESC] [NULLS FIRST|NULLS LAST] 
    
    - ASC : �������� ���� (���� �� �⺻��)   
    - DESC : �������� ���� 
    
    - NULLS FIRST : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� 
      �ش� �����͸� �� �տ� ��ġ(������ DESC�϶��� �⺻��)
    
    - NULLS LAST : �����ϰ��� �ϴ� �÷����� NULL�� ���� ��� 
      �ش� �����͸� �� �ڿ� ��ġ�Ѵ�.(���� �� ASC�϶��� �⺻��)
*/

SELECT *
FROM EMPLOYEE 
--ORDER BY BONUS; --BONUS�� ������������ ���
--ORDER BY BONUS ASC --�������� �����϶� �⺻������ NULLS LAST��� ���� �� �� �ִ�. 
--ORDER BY BONUS ASC NULLS FIRST; -- NULL�� ������ ��ܿ��� �������� ����
--ORDER BY BONUS DESC; -- �������� ������ �� �⺻������ NULLS FIRST����!
ORDER BY BONUS DESC, SALARY ASC; -- ���� ������ ������ ���� ����
--(ù��° ������ �÷����� ������ ��� �ι�° ���� �÷��� ������ ����) 

-- �� ����� �����, ���� ��ȸ(������ �������� ���� ��ȸ)
SELECT EMP_NAME, SALARY*12 AS "����" --2
FROM EMPLOYEE --1
--ORDER BY SALARY*12 DESC --3 ORDER BY�� �� �������̴�.
--ORDER BY ���� DESC; --�� �̰� ����������. ��Ī ��� ����. 
ORDER BY 1 DESC; -- �÷� ���� ��� ����. �� (�÷� �������� ū ���ڴ� �翬�� �ȵ�. ����)
--DESC�ϱ� �ش� ĭ�� ������������ �����Ѵ�. 












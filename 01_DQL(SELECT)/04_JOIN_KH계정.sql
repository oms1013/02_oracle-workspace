/*
    < JOIN >  
    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ���� 
    
    ������ �����ͺ��̽� �ּ����� �����ͷ� ������ ���̺� �����͸� ��� ���� 
    (�ߺ��� �ּ�ȭ �ϱ� ���� �ִ��� �ɰ��� ������.)
    
    -- � ����� � �μ��� �����ִ��� �ñ���! �ڵ� ���� �̸�����.. 
    
    => ������ �����ͺ��̽����� SQL���� �̿��� ���̺��� "����"�� �δ� ��� 
    (������ �� ��ȸ�ؿ��°� �ƴ϶� �� ���̺� ������ν��� �����͸� ��Ī���Ѽ� ��ȸ�ؾ���)

    JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI ����" (ANSI == �̱�����ǥ����ȸ) 
    => �ƽ�Ű�ڵ�ǥ�� ����� ��ü 
    
                            [JOIN ��� ����] 
    ����Ŭ ���� ����                   |                   ANSI ����
-------------------------------------------------------------------------
        �����                      |     ���� ����([INNER] JOIN) 
    (EQUAL JOIN)                    |     �ڿ� ����(NATURAL JOIN)
-------------------------------------------------------------------------
       ���� ����                      |    ���� �ܺ�����(LEFT OUTER JOIN
      (LEFT JOIN)                    |    ������ �ܺ�����(RIGHT OUTER JOIN)
    (RIGHT JOIN)                     |    ��ü �ܺ�����(FULL OUTER JOIN)
-------------------------------------------------------------------------
   ��ü ����(SELF JOIN)                |
  �� ����(NON EQUAL JOIN)          |     

    */

--��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ�ϰ��� �� �� 
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸� ��ȸ�ϰ��� �� ��
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    1. � ����(EQUAL JOIN) / ���� ����(INNTER JOIN) 
       �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ (==��ġ�ϴ� ���� ����
       ���� ��ȸ���� ���ܵȴ�.) 
*/

-->> ����Ŭ ���� ���� 
--   FROM���� ��ȸ�ϰ��� �ϴ� ���̺���� ���� (, �����ڷ�) 
--   WHERE ���� ��Ī��ų �÷�(�����)�� ���� ������ ������ 
-- 
-- 1) ������ �� �÷����� �ٸ���� (EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
-- ���, �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT --WHERE���� ���� �� ������ ������ ������ �����Ͱ�
--�̻��ϰ� ��µ�. ������� ���
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵ� ���� Ȯ���� �� ���� 
-- DEPT_CODE�� NULL�� ����� ��ȸ���� ����, DEPT_ID D3,D4,D7 ��ȸ X

--2) ������ �� �÷����� ���� ��� 
--���, �����, �����ڵ�, ���޸� 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE= JOB_CODE;
-- ambiguously : �ָ��ϴ�, ��ȣ�ϴ�. 

-- 1)�ذ��� : ���̺���� �̿��ϴ� ��� �� 
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
--JOB_CODE=JOB_CODE�� ���� ���� ���ظ� ���ϴ� �� ���̺��. �� �ٿ���
--������ �� �ְ� ����� SELECT������ �� ����ؾ� �ϴ��� ������
--�Ѵ� ���� JOB_CODE�⶧���� �ƹ��ų� �տ� �ٿ���


-- 2)�ذ��� : ���̺� ��Ī�� �ο��ؼ� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
--���� ������ �����



-- >> ANSI����
-- FROM���� ������ �Ǵ� ���̺� �ϳ� ����� �� 
-- JOIN���� ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� + ��Ī 
-- JOIN USING, JOIN ON 

--1) ������ �� �÷����� �ٸ� ���(EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
--������ JOIN ON �������θ� �����ϴ� 
--���, �����, �μ��ڵ�, �μ��� 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE 
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); 


-- 2) ������ �� �÷��� �̸��� ���� ��� 
-- JOIN ON, JOIN USING ������ ��� ����! 
-- ���, �����, �����ڵ�, ���޸� ��ȸ 


--�ذ��� 1) ���̺�� �Ǵ� ��Ī�� �̿��ؼ� �ϴ� ��� 
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E 
JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE);

--�ذ��� 2) JOIN USING�� ����ϴ� ���( �� �÷����� ��ġ�� ���� ��밡��) 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE);


--[�������]--
--�ڿ� ����(NATURAL JOIN) : �� ���̺� ������ �÷��� �� ���� ������ ��� 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME 
FROM EMPLOYEE
NATURAL JOIN JOB;
--�� ��� �� �Ǵ� ���� �ƴϰ� �� ���̺�� ���� �÷��� �Ѱ��� �־�� �����ϴ�.

--������ �븮�� ����� �̸�, ���޸�, �޿� ��ȸ

--����Ŭ ���� ����
SELECT EMP_NAME, JOB_NAME, SALARY 
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
AND J.JOB_NAME = '�븮';

--ANSI���뱸��
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

---------------------------------�ǽ�--------------------------------
--1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ

--����Ŭ ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE = '�λ������';

-- ANSI����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';


--2.DEPARTMENT�� LOCATION�� �����ؼ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�
--����Ŭ ����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE
FROM DEPARTMENT , LOCATION 
WHERE LOCATION_ID = LOCAL_CODE;

--D LOCATION ID= L LOCATION CODE

--ANSI ����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE
FROM DEPARTMENT
JOIN LOCATION ON (LOCAL_CODE=LOCATION_ID);


--3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ

--����Ŭ ����
SELECT EMP_NO, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;


--ANSI����
SELECT EMP_NO, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE BONUS IS NOT NULL;

--4.�μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �μ��� ��ȸ
--����Ŭ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '�ѹ���';


--ANSI����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE !='�ѹ���';

-- ���� ���� DEPT_CODE�� NULL�ΰ��� ��µ��� ����.
-- DEPT_TITLE�� NULL���� �����ϴ� ���� �������� �ʱ� ���� 

-------------------------------------------------------------
/*
    2. ���� ���� / �ܺ� ���� (OUTER JOIN) 
    �� ���̺� ���� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ���� 
    ��, �ݵ�� LEFT / RIGHT �����ؾ���!! (������ �Ǵ� ���̺� ����) 
*/

--�ܺ� ���ΰ� ���Ҹ��� INNER JOIN ��ȸ�صα�! 
-- �����ֱ� 
-- �����, �μ���, �޿�, ���� 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--���� �μ���ġ�� ���� ���� �ο� 2���� ��ȸ���� ����
--�μ��� ������ ����� ���� �μ����� ��쵵 ��ȸ X 


--1) LFTT OUTER JOIN : �� ���̺� �� ���� ����� ���̺� �������� JOIN
-- >> ANSI ���� 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--LEFT�⶧���� EMPLOYEE�� ��� �����͸� ����Ѵ�. 
-- �Ʊ� NULL���� ����� 2���� �����͵� ����


-->> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID(+); 
-- �������� ����� �ϴ� ���̺��� �ݴ��� �÷� �ڿ� (+) ���̱�. OUTER JOIN




-- 2) RIGHT [OUTER] JOIN : �� ���̺� �߿��� �������� �������� JOIN
--ANSI����
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); 

-- >> ����Ŭ ���� ���� 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;



--3) FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ �� �� ����.
--(��, ����Ŭ ���� �������δ� �ȵ�)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


-------------------------------------------------------------------

/*
    3. �� ����(NON EQUAL JOIN) => ��� �׳� ����� 
    ��Ī��ų �÷��� ���� ���� �ۼ��� '=(��ȣ)' �� ������� �ʴ� ���ι�
    ANSI �������δ� JOIN ON�� ��� ����! 
*/

SELECT EMP_NAME, SALARY, SAL_LEVEL 
FROM EMPLOYEE;

SELECT SAL_LEVEL, MIN_SAL, MAX_SAL
FROM SAL_GRADE; 

-- �����, �޿�, �ִ� ���� �ѵ� 
--����Ŭ ���� ���� 1 
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE E,  SAL_GRADE S
WHERE E.SAL_LEVEL = S.SAL_LEVEL;


--2 
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE ,  SAL_GRADE 
WHERE SALARY >=MIN_SAL AND SALARY<=MAX_SAL
AND SALARY BETWEEN MIN_SAL AND MAX_SAL;
--�̷��� ����ϴ°� ������ �ϴ�


--ANSI����, ����
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE 
JOIN SAL_GRADE ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);

--------------------------------------------------------
/*   //�١١�
    4.��ü ���� (SELF JOIN)
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ��� 
*/

-- ��ü ����� ���, �����, ����μ��ڵ� => EMPLOYEE 
--     ����� ���, �����, ����μ��ڵ� => EMPLOYEE

--> ����Ŭ ���� ����
SELECT E.EMP_ID "������", E.EMP_NAME "�����", E.DEPT_CODE "����μ��ڵ�", 
    M.EMP_ID "������", M.EMP_NAME "�����", M.DEPT_CODE "����λ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID; 

-- >>ANSI ����
SELECT E.EMP_ID "������", E.EMP_NAME "�����", E.DEPT_CODE "����μ��ڵ�", 
       M.EMP_ID "������", M.EMP_NAME "�����", M.DEPT_CODE "����λ��ڵ�"
FROM EMPLOYEE E 
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID=M.EMP_ID);


--------------------------------------------------------------
/*
    < ���� ���� > 
    2�� �̻��� ���̺��� ������ JOIN�� �� 
*/

-- ���, �����, �μ���, ���޸� ��ȸ 

SELECT * FROM EMPLOYEE; -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;        -- JOB_CODE

-->����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;

-->>
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
JOIN JOB USING(JOB_CODE); --�̸��� ������ USING�� ���°� ����
--JOIN�� ������ ����� �� ����

-- ���, �����, �μ���, ������
SELECT * FROM EMPLOYEE; --DEPT_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID LOCATION_ID 
SELECT * FROM LOCATION; --           LOCAL_CODE

SELECT EMP_NO, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION 
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE; 

--> ANSI���� 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

---------------------------�ǽ�����----------------------------
--1.���, �����, �μ���, ������, ������ ��ȸ (EMP, DEP, LOC, NATIONAL)

--����Ŭ
SELECT * FROM DEPARTMENT;         --  LOCATION_ID
SELECT * FROM EMPLOYEE;--   
SELECT * FROM LOCATION; --    COLUMN_ID
SELECT * FROM NATIONAL; --      COLUMN_ID 
-- LOCATION   
-- NATIONAL              

SELECT EMP_NO, EMP_NAME, L.LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, LOCATION L, DEPARTMENT, NATIONAL N
WHERE DEPT_ID = DEPT_CODE --DEP, EMP
AND LOCATION_ID = LOCAL_CODE -- DEP, LOC
AND L.NATIONAL_CODE = N.NATIONAL_CODE; --LOC, NAT

--ANSI
SELECT EMP_NO, EMP_NAME, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE =DEPT_ID )
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);

--2.���, �����, �μ���, ���޸�, ������, ������, �ش� �޿� ��޿��� ���� �� �ִ�
-- �ִ� �ݾ� ��ȸ(������̺� ����) 

--����Ŭ
SELECT * FROM EMPLOYEE;--    DEPT_ CODE            JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID     LOCATION_ID  
SELECT * FROM JOB; --                              JOB_CODE            
SELECT * FROM LOCATION; --              LOCATION_CODE      NATIONAL_CODE 
SELECT * FROM NATIONAL; --                                  NATIONAL_CODE
 
SELECT EMP_NO, EMP_NAME, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, 
 MAX_SAL
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND D.LOCATION_ID = L.LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.SAL_LEVEL = S.SAL_LEVEL;

--ANSI
SELECT EMP_NO, EMP_NAME, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
JOIN JOB USING (JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL N USING(NATIONAL_CODE)
JOIN SAL_GRADE S USING(SAL_LEVEL);


--3. 

























































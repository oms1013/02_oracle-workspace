/*


    DQL (QUERY ������ ���� ���) : SELECT 
    
    DML (MANIPULATION ������ ���� ���) : INSERT, UPDATE, DELETE 
    DDL (DEFINITION ������ ���� ���) : CREATE, ALTER, DROP
    DCL (CONTROL ������ ���� ���) : GRANT, REVOKE, [COMMIT, ROLLBACK] 
    
    TEL (TRANSACTION Ʈ������ ���� ���) : COMMIT, ROLLBACK�� �����ϴ� ����� ����
    
    < DML : DATE MANIPULATION LANGUAGE >
    ������ ���� ��� 
    
    ���̺� ���� ����(INSERT)�ϰų�, ����(UPDATE)�ϰų�, ����(DELETE)�ϴ� ���� 
                
*/


/*
    1. INSERT
    ���̺� ���ο� ���� �߰��ϴ� ���� 
    
    [ǥ����] 
    1) INSERT INTO ���̺�� VALUES(��1, ��2, ...); 
      ���̺� ��� �÷��� ���� ���� ���� �����ؼ� �� �� INSERT�ϰ��� �� �� ��� 
      �÷� ������ ���Ѽ� VALUES�� ���� �����ؾߵ�!! 
        
*/

INSERT INTO EMPLOYEE VALUES(900, '������', '900101-1234567');
--����, not enough values ���. ���� ���ڶ�� �Է��� �� 


INSERT INTO EMPLOYEE VALUES(900, '������', '900101-1234567', 'cha@kh.or.kr',
'01011112222', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT,111);
--00913. 00000 -  "too many values" ���� �� ���� �Է��� ����

INSERT INTO EMPLOYEE VALUES(900, '������', '900101-1234567', 'cha@kh.or.kr',
'01011112222', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);


SELECT * FROM EMPLOYEE; 

/*
    2) INSERT INTO ���̺��(�÷���, �÷���, �÷���) VALUES(��1,��2,��3) ; 
       ���̺� ���� ������ �÷��� ���� ���� INSERT�Ҷ� ��� 
       �׷��� �� �� ������ �߰��Ǳ� ������ ������ ���� ���� �÷���
       �⺻�����δ� NULL�� ����. 
       => NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� ���� �����ؾ���. 
       ��, DEFAULT���� �ִ� ���� NULL�� �ƴ� DEFAULT���� ����. 
       
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE) 
VALUES(901, '������', '880202-1111111', 'J1', 'S2', SYSDATE); 

SELECT * FROM EMPLOYEE; 
-- ENT_YN�� ����Ʈ ������ ������!

INSERT
  INTO EMPLOYEE
       (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE
    )
       
VALUES
    (
       901  
     , '������' 
     , '880202-1111111'
     , 'J1'
     , 'S2'
     , SYSDATE
     ); 

-------------------------------------------------------------------

/*
    3) INSERT INTO ���̺�� (��������); 
       VALUES�� �� ���� ����ϴ°� ��ſ� 
       ���������� ��ȸ�� ������� ��°�� INSERT ����! (���� ���� INSERT �� �� ����)
*/

--���ο� ���̺� ����
CREATE TABLE EMP_01(
    EMP_ID NUMBER, 
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR(20) 
       
); 

SELECT * FROM EMP_01;

-- ��ü ������� ���, �̸�, �μ��� ��ȸ 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01 ( 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;

--------------------------------------------------------------------------
/*
    2.INSERT ALL 
*/


--�켱 �׽�Ʈ�� ���̺��� ����� 
-- ������ ������
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0; --�����ʹ� ���ΰ� ������ ������

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID 
    FROM EMPLOYEE
    WHERE 1=0; 
    
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

--�μ��ڵ尡 D1�� ������ǻ��,�̸�,�μ��ڵ�,�Ի���,������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
     [ǥ����]
     INSERT ALL 
     INTO ���̺��1 VALUES(�÷���, �÷���, ...)
     INTO ���̺��2 VALUES(�÷���,�÷���, ...) 
     ��������;
*/

INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID,EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

-- * ������ ����ؼ��� �� ���̺� �� INSERT����!!

-- 2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺� 
CREATE TABLE EMP_OLD 
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;  --���������� ������ �����ؿ�

-- 2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺� 
CREATE TABLE EMP_NEW 
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;  --���������� ������ �����ؿ�

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

/*
    [ǥ����] 
    INSERT ALL 
    WHEN ����1 THEN
        INTO ���̺��1 VALUES(�÷���, �÷���, ...) 
    WHEN ����2 THEN 
        INTO ���̺��2 VALUES(�÷���, �÷���, ...)
    ��������; 
    
*/ 

INSERT ALL 
WHEN HIRE_DATE <'2000/01/01' THEN 
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE > '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;


SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;


/*
    3. UPDATE
       ���̺� ��ϵǾ��ִ� ������ �����͸� �����ϴ� ���� 
       
       [ǥ����] 
       UPDATE ���̺�� 
       SET �÷��� = �ٲܰ�,
           �÷��� = �ٲܰ�
           ...    --> �������� �÷��� ���� ���� ����! (,�� �����ؾߵ�! AND �ƴ�!!)                  
        [WHERE ����]; -->�����ϸ� ��ü ���� ��� ���� �����Ͱ� ����ȴ�..! �׷��� �� ���� ����!
*/

--���纻 ���̺� ���� �� �۾� 
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT; 

SELECT * FROM DEPT_COPY; 

-- D9 �μ��� �μ����� '������ȹ��'���� ���� 
UPDATE DEPT_COPY 
SET DEPT_TITLE = '������ȹ��';

ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��' --�ѹ���
WHERE DEPT_ID = 'D9';

-- �켱 ���纻 ���� ����
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE; 

SELECT * FROM EMP_SALARY;

-- �����غ��� 
-- ���ö ����� �޿��� 100�������� ����! �����ٰ� ������ ���!! 
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE; 

UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_ID = '202'; --202 �ϴ� ���ö ID�� �������(�������� �������� ������)

SELECT * FROM EMP_SALARY;

-- ������ ����� �޿��� 700�������� ����, ���ʽ��� 0.2�� ����! ������ ���
--200 ������ D9 8000000
UPDATE EMP_SALARY
SET SALARY = 7000000, BONUS = 0.2
WHERE EMP_NAME = '������';

-- ��ü ����� �޿��� ������ �޿��� 10���� �λ��� �ݾ�
UPDATE EMP_SALARY
SET SALARY = SALARY*1.1;

-- UPDATE�� ���������� ��� ����!!
/*
    UPDATE ���̺��
    SET �÷��� = (��������) 
    WHERE ����; 
*/

--���� ����� �޿��� ���ʽ� ���� ����� ����� �޿��� ���ʽ� ������ ���� 

SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '����'; 

--������ ��������
UPDATE EMP_SALARY 
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '�����'), --1518000
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME ='�����') --NULL
WHERE EMP_ID = 214;

--���߿� �������� 
UPDATE EMP_SALARY
SET(SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����')
WHERE EMP_ID = 214;

SELECT * FROM EMP_SALARY;

--ASIA �������� �ٹ��ϴ� ������� ���ʽ� ���� 0.3���� ����
--DEPARTMENT -LOCATION_ID      DEPT_ID          LOCATION_ID
--EMPLOYEE                     DEPT_CODE
--LOCATION, LOCAL_CODE(L1,L2,L3)               LOCAL_CODE

SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';


UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN  (

SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN LOCATION USING (LOCATION_ID)
WHERE LOCAL_NAME LIKE 'ASIA%');

-------------------------------------
--����� 200���� ����� �̸��� NULL�� ����
SELECT EMP_NAME 
FROM EMPLOYEE
WHERE EMP_ID=200;

UPDATE EMPLOYEE
SET EMP_NAME =NULL 
WHERE EMP_ID = 200;
--ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
--�������ǿ� EMP_NAME�� NOT NULL�� �پ��־� NULL�� �����ϴ°��� �Ұ����ϴ�. 

--���ö ����� �����ڵ带 J9���� ����!
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '���ö'; --J2

UPDATE EMPLOYEE
SET JOB_CODE = 'J9' 
WHERE EMP_ID= 202;
--ORA-02291: integrity constraint (KH.SYS_C007177) violated - parent key not found
--FOREIGN KEY �������� ����.

--------------------------------------------------------------
COMMIT; 

/*
    4.DELETE 
      ���̺� ��ϵ� ������ �����ϴ� ����(�� �� ������ ������)
      
      [ǥ����]
      DELETE FROM ���̺��
      WHERE ���� ;
      ���⼭ ������ �Ⱦ��� ���̺� ��ü�� ����������. 
*/

-- ������ ����� ������ ����� 
SELECT * FROM EMPLOYEE WHERE EMP_NAME ='������'; 

DELETE FROM EMPLOYEE WHERE EMP_ID = 900;
ROLLBACK; -- ������ Ŀ�� �������� ���ư�


DELETE FROM EMPLOYEE 
WHERE EMP_NAME = '������';

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '������'; 

COMMIT; 

ROLLBACK; 

-- DEPT_ID�� D1�� �μ��� ���� 
SELECT * FROM DEPARTMENT; 

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1'; 
-- ORA-02292: integrity constraint (KH.SYS_C007176) violated - child record found
-- �⺻������ ������ �Ұ���. �ܷ�Ű ���� 
-- D1�� ���� ������ ���� �ڽ� �����Ͱ� �ֱ� ������ ���� �ȵ�!

-- DEPT_ID�� D3�� �μ��� ���� 
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3'; 

ROLLBACK;
/*
    *TRUNCATE : ���̺��� ��ü ���� ������ �� ���Ǵ� ���� 
                DELETE���� ���� ������ ����.
                ������ ���� ���ð� �Ұ���. �׳� ���̺��� ��� �� �ٻ���
                ROLLBACK�� �Ұ����� 
                
    [ǥ����] TRUNCATE TABLE ���̺��;                       
*/

SELECT * FROM EMP_SALARY; 

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;





















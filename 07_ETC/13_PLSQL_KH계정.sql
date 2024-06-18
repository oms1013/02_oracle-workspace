/*
    < PL/SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
    SQL���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE) ���� �����ϸ�
    SQL�� ������ ����
    �ټ��� SQL���� �ѹ��� ���� ���� (BLOCK ����)
    
    * PL / SQL ����
    - [����� (DECLARE SECTION)] : DECLARE �� ����, ������ ����� ���� �� �ʱ�ȭ �ϴ� �κ�
    - ����� (EXECUTABLE SECTION) : BEGIN���� ����, SQL�� �Ǵ� ���(���ǹ�, �ݺ���)���� ������ ����ϴ� �κ�
    - [����ó���� (EXCEPTION SECTION)] : EXCEPTION ���� ����, ���� �߻��� �ذ��ϱ� ���� ������ �̸� ����صѼ� �ִ� �κ�
    
*/

-- �����ϰ� ȭ�鿡 HELLO ORACLE ���

SET SERVEROUTPUT ON; -- �ܼ�â ���� ���
--SYSTEM.OUT.PRINTLN("HELLO WORLD"); -- JAVA
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/ 
-- �������� ��

--------------------------------------------------------------------------------

/*
    1. DECLARE �����
       ���� �� ��� �����ϴ� ���� (����� ���ÿ� �ʱ�ȭ�� ����)
       �Ϲ�Ÿ�Ժ���, ���۷�������Ÿ��, ROWŸ�Ժ���
       
       1_1 �Ϲ�Ÿ�Ժ��� ���� �� �ʱ�ȭ
           [ǥ����] ������ [CONSTANT] �ڷ��� [:= ��];
    
       
*/
  --    EID := 800;
  --    ENAME := '������';
DECLARE  
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER :=3.14;
BEGIN

    
    EID := &��ȣ;
    ENMAE := '&�̸�';
    PI := 3.14;
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' ||PI);
END;
/
--------------------------------------------------------------------------------
-- 1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ( � ���̺��� � �÷��� ������ Ÿ���� �����ؼ� �� Ÿ������ ����)
--       [ǥ����] ������ ���̺��.�÷���%TYPE;

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;

BEGIN
   --EID := '300';
   --ENAME := '�̽���';
   --SAL := 3000000;
   -- ����� 200���� ����� ���, �����, �޿� ��ȸ�ؼ� �� ������ ����
   SELECT EMP_ID, EMP_NAME, SALARY
     INTO EID, ENAME, SAL
     FROM EMPLOYEE
    --WHERE EMP_ID = 200;
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
END;
/
--------------------------�ǽ�����------------------------------------------------
/*
    ���۷���Ÿ�Ժ����� EID, ENAEM JCODE, SAL DTITLE�� �����ϰ� 
    �� �ڷ��� EMPLOYEE,(EMP_ID, EMP_NAME, JOB_CODE, SALARY), DEPARTMENT (DEPT_TITLE ����
    
    ����ڰ� �Է��� ����� ������ �ִ� ����� ���, �����, �����ڵ�, �޿� �μ��� ��ȸ�� �� ������ ��� ���
 */
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
      INTO EID, ENAME, JCODE, SAL, DTITLE
      FROM EMPLOYEE   
      JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&���';

 DBMS_OUTPUT.PUT_LINE('EID : '||EID);
 DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
 DBMS_OUTPUT.PUT_LINE('JCODE : '||JCODE);
 DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
 DBMS_OUTPUT.PUT_LINE('DTITLE : '||DTITLE);
END;
/

--------------------------------------------------------------------------------
-- 1_3) ROW Ÿ�Ժ��� ����
--      ���̺� �� �࿡ ���� ��� �÷����� �Ѳ����� ������ �ִ� ����
-- ǥ���� : ������ ���̺��%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE;

BEGIN
    SELECT * -- EMP_NAME, SALARY, BONUS (������ �̾Ƴ����� 2��° ���)
      INTO E
      FROM EMPLOYEE
     WHERE EMP_ID = '&���';
     
     DBMS_OUTPUT.PUT_LINE('����� : '||E.EMP_NAME);
     DBMS_OUTPUT.PUT_LINE('�޿� : '||E.SALARY);
     DBMS_OUTPUT.PUT_LINE('���ʽ� : '|| NVL(E.BONUS,0)); 
END;
/
-- NULL ���� ��������� ���� NVL ��� ����

--------------------------------------------------------------------------------
--2. BEGIN ���๮

-- <���ǹ�> 

-- 1) IF ���ǽ� THEN ���೻�� END IF; (���� IF��)

-- ��� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%) ���
-- ��, ���ʽ��� ���� �ʴ� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�' �� /���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
      INTO EID, ENAME, SALARY, BONUS
      FROM EMPLOYEE
     WHERE EMP_ID = '&���';
     
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SALARY);
    
    IF BONUS = 0 
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʽ��ϴ�');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : '||BONUS * 100||'%');
END;
/

-- 2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF; (IF ELSE ��)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
      INTO EID, ENAME, SALARY, BONUS
      FROM EMPLOYEE
     WHERE EMP_ID = '&���';
     
     DBMS_OUTPUT.PUT_LINE('��� : '||EID);
     DBMS_OUTPUT.PUT_LINE('�̸� : '||ENAME);
     DBMS_OUTPUT.PUT_LINE('�޿� : '|| SALARY||'��');
     
     IF BONUS = 0
        THEN  DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʽ��ϴ�.');
     ELSE
              DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS*100|| '%');
    END IF;
END;
/

-------------------------�ǽ�����-------------------------------------------------
--���۷��� Ÿ�� (EID, ENAME, DTITLE, NCODE
-- �÷� (EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
-- �Ϲ�Ÿ�� ���� (TEAM ���ڿ�) <= �̵� ������, �ؿ��� ��������

-- ����ڰ� �Է��� ����� ���� ���ִ� ����� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ �� �� ���� ����
--NCODE���� KO �϶� => TEAM�� '������ ' ����
-- �ƴҰ�� �ؿ��� ����

-- ���, �̸�, �μ�, �Ҽ�(TEAM)�� ���� ���
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.LOCAL_CODE%TYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
      INTO EID, ENAME, DTITLE, NCODE
      FROM EMPLOYEE
      JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
      JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
      WHERE EMP_ID = '&���';
      
      IF NCODE = 'KO' 
            THEN  TEAM := '������';
      ELSE 
           TEAM := '�ؿ���';
      END IF;
      
      DBMS_OUTPUT.PUT_LINE('��� : '|| EID);
      DBMS_OUTPUT.PUT_LINE('�̸� : '|| ENAME);
      DBMS_OUTPUT.PUT_LINE('�μ� : '|| DTITLE);
      DBMS_OUTPUT.PUT_LINE('�Ҽ� : '|| TEAM);
END;
/

-- 3) IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2...[ELSE ���೻��N] END IF;

-- ������ �Է¹޾� SCORE ������ ������
-- 90�� �̻��� 'A', 80�̻� 'B', 70�̻� 'C', 60�̻� 'D', 60�̸� 'F'�� ó���� 
-- GRADE ������ ����
-- ����� ������ XX���̰� ������ X���Դϴ�.

DECLARE
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &����;
    
    IF SCORE >= 90 THEN GRADE :='A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ ' ||SCORE||'�� �̰�, ������ '||GRADE||' �����Դϴ�');
    
END;
/

-- �޿�
-- 500 ���
-- 300 �̻� �߱�
-- 300 �̸� �ʱ�
-- ����� �Է¹޾� �� ����� ������ �ִ� ����� �޿���� ���
-- �ش� ����� �޿������ XX �Դϴ�.

DECLARE 
    SAL EMPLOYEE.SALARY%TYPE;
    SAL_LEVEL VARCHAR2(10);
BEGIN
    SELECT SALARY
      INTO SAL
      FROM EMPLOYEE
     WHERE EMP_ID = '&���';
     
     IF SAL >=5000000 THEN SAL_LEVEL := '���';
     ELSIF SAL >= 3000000 THEN SAL_LEVEL := '�߱�';
     ELSE SAL_LEVEL := '�ʱ�';
     END IF;
     
     DBMS_OUTPUT.PUT_LINE('�ش� ����� �޿������ '||SAL_LEVEL|| ' �Դϴ�.');
     
END;
/

--------------------------------------------------------------------------------
-- JAVA SWITCH (){} CASE 1: ~ BREAK;

-- 4) CASE �񱳴���� WHEN ������Ұ�1 THEN �����1 WHEN ������Ұ�2 THEN ��2... ELSE ����� END;

DECLARE 
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30);
BEGIN
    SELECT * 
      INTO EMP
      FROM EMPLOYEE
     WHERE EMP_ID ='&���';
     
     DNAME := CASE EMP.DEPT_CODE
              WHEN 'D1' THEN '�λ���'
              WHEN 'D2' THEN 'ȸ����'
              WHEN 'D3' THEN '��������'
              WHEN 'D4' THEN '����������'
              WHEN 'D9' THEN '�ѹ���'
              ELSE '�ؿܿ�����'
            END;
     
     DBMS_OUTPUT.PUT_LINE( EMP.EMP_NAME ||'�� ' ||DNAME || ' �Դϴ�.');
END;
/

-- 1. ����� ������ ���ϴ� PL/SQL �� �ۼ�. ���ʽ��� �ִ� ����ִ� ����� ���ʽ��� ���� ���
-- ���ʽ��� ���ٸ� ���ʽ� ������ ����
-- ���ʽ��� ������ ���ʽ� ���� ����
 -- ��� ���� (����Է¹޾Ƽ�_
-- �޿� �̸� \999,999,999 (8000000 ������ \124,800,000)

DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    YSAL NUMBER;
BEGIN
    SELECT EMP_NAME, SALARY, BONUS --, SALARY +(SALARY*BONUS)*12
      INTO ENAME, SAL, BONUS --, YSAL
      FROM EMPLOYEE
     WHERE EMP_ID = '&���';
     
     IF BONUS =0 THEN YSAL := TO_NUMBER(FLOOR(SAL +(SAL * BONUS)*12),'999,999,999');
     ELSE YSAL := TO_NUMBER(FLOOR(SAL *12),'99,999,999');
     END IF;
     
     DBMS_OUTPUT.PUT_LINE( SAL || ENAME || '\'||YSAL);
    
           
END;
/


DECLARE 
    EMP
    SALARY NUMBER;
BEGIN
    SELECT *
      INTO EMP
      FROM EMPLOYEE
     WHERE EMP_ID = '&���';
    
    IF(EMP.BONUS = 0) THEN SALARY := EMP.SALARY *12;
    ELSE SALARY := (EMP.SALARY + EMP.SALARY *EMP.BONUS)*12;
    END IF;

    DBMS_OUTPUT.PUT_LINE(EMP.SALARY ||  ' '|| EMP.EMP_NAME || TO_CHAR(SALARY, 'L999,999,999'));
END;
/

--------------------------------------------------------------------------------
/*
    �ݺ���
    
    1) BASIC LOOP��
    [ǥ����]
    LOOP
        �ݺ������� ������ ����
        *�ݺ����� �������� �� �ִ� ����
    END LOOP;
    
    * �ݺ����� ���������� �ִ� ���� (2����)
    1) IF ���ǽ� THEN EXIT; END IF;
    2) EXIT WHEN ���ǽ�;
*/

-- 1~5 ���� ���������� 1�� ����
DECLARE
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I+1;
        
    --    IF I = 6 THEN EXIT;    END IF;
     EXIT WHEN I =6;
     
    END LOOP;
END;
/

--------------------------------------------------------------------------------
/*
    2) FOR LOOP��
    
    [ǥ����]
    FOR ���� IN [REVERSE -> ���� ���� �۾����� �ϰ� ������..] �ʱⰪ..������
    LOOP
       * �ݺ������� ������ ����;
    END LOOP
*/
BEGIN
    FOR I IN 1..10
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

BEGIN
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

DROP TABLE TEST;

CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE
NOCACHE;

BEGIN
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL,SYSDATE);
    END LOOP;
END;
/

SELECT * FROM TEST;

--------------------------------------------------------------------------------
/*
    WHILE LOOP��
    
    [ǥ����]
    WHILE �ݺ����� ����� ����
    LOOP 
        �ݺ������� ������ ����
    END LOOP;
*/

DECLARE
    I NUMBER :=1;
BEGIN
    WHILE I < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
    END LOOP;
END;
/

--------------------------------------------------------------------------------

/*
    3. ����ó����
    
    ����(EXCEPTION) : ������ �߻��ϴ� ����
    
    [ǥ����]
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ...
        WHEN OTHERS THEN ����ó������N;
        
        * ���ܸ� �� ��� �ұ�?
        * �ý��� ���� (����Ŭ���� �̸� �����ص� ����)
        - NO_DATA_FOUND : SELECT �� ����� �� �൵ ���� ���
        - TOO_MANY_ROWS : SELECT �� ����� �������� ���
        - ZERO_DIVIDE : 0���� ���� ��
        - DUP_VAL_ON_INDEX : UNIQUE �������ǿ� ������� ���
        ..
*/

-- ����ڰ� �Է��� ���� �������� ������ ���
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &����;
    DBMS_OUTPUT.PUT_LINE('��� : '||RESULT);
EXCEPTION 
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ������ �����ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ������ �����ϴ�.'); 
END;
/

-- UNIQUE �������� ����
BEGIN
    UPDATE EMPLOYEE
       SET EMP_ID = '&�����һ��'
     WHERE EMP_NAME = '���ö';
EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
      INTO EID, ENAME
      FROM EMPLOYEE
     WHERE MANAGER_ID = '&������'; --211 ������
    
     
     DBMS_OUTPUT.PUT_LINE('��� : '||EID);
     DBMS_OUTPUT.PUT_LINE('�̸� : '||ENAME);
     
EXCEPTION
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ� ���� ���� ��ȸ�Ǿ����ϴ�');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ���� ����� �����ϴ�');

END;
/

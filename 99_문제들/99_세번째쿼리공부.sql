-- ��������
-- QUIZ1

-- CREATE USER TEST IDENTIFIED BY 1234;����
-- USER TEST ���� �Ϸ�

-- �������� ���� ������ ������. ��?
-- ������ : ���������� �߰�, ���� ������ �ο����� �ʾұ� ������
-- ��ġ���� :
-- GRANT CONNECT, RESOURCE TO TEST �� ������ �����

-- QUIZ2 (JOIN����)
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY, 
    JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);

-- ���� �� ���̺��� �ִٴ� �����Ͽ�
-- �� ���̺��� �����ؼ� EMPNO, EMPNAME, JOBNO, JOBNAME �÷��� ��ȸ�Ұ���
-- �� �� ������ SQL��
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
  FROM TB_EMP
  JOIN TB_JOB USING(JOBNO);
--ORA-00904: "TB_JOB"."JOBNO": invalid identifier
--TB_JOB���̺� JOBNO�� ����.

--������ : JOBNO�÷��� TM_EMP���� ���������� TB_JOB���� �������� �ʱ� ������
--USING ������ ����Կ� �־ ������ �߻��Ѵ�.
-- �ذ᳻�� : USING(JOBNO)�� �ƴ϶� ON�� (JOBNO=JOBCODE)�� ����Ѵ�.

SELECT EMPNO, EMPNAME, JOBNO
  FROM TB_EMP
  JOIN TB_JOB ON (JOBNO=JOBCODE);
  
-------------------------------------------------------------

-- ���̺� ���� �����ؼ� ������ Ÿ��(CHAR, VARCHAR2 ������) 

-- ����Ŭ ��ü(SEQUENCE, VIEW) ���� ����...

-- �������� => �ڴʰ� ���������� �߰��� �� �ִ� ALTER��

-- DCL�� �����ΰ�? GRANT�����

-- Ŀ��, �ѹ��� �����ΰ�? + SAVEPOINT(CREATE, ALTER, DROP) => �ڵ�Ŀ��...

-- QUIZ3(JOIN����) 

-- �Ʒ��� SQL������ �μ��� �����հ谡 15,000,000�� �ʰ��ϴ� �μ��� ��ȸ�� ���̴�. 

-- ����� �ùٸ��� �ʴٰ� �Ҷ�, �� ���ΰ� ��ġ����

SELECT DEPT_CODE, SUM(SALARY)
  FROM EMPLOYEE
  WHERE SALARY > 15000000
  GROUP
    BY DEPT_CODE;
    --HAVING SUM(SALARY)>15000000
    
-- �̰� �ȵǴ� ����? �޿� 15000000�� �Ѵ� ����� ��Ƽ� ����Ϸ��ϱ� �׷���
-- ��������� ���°� 
-- HAVING���� ������

--QUIZ4(��������)
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZ4 VALUES(1, '����1��', 30);
INSERT INTO QUIZ4 VALUES(1, '����222222222��', 40);
--�۵� ���ϴ� ����, ���� 222222���� VARCHAR2(10)�̶� ũ�⿡ ���� �뷮�� ���ڶ�

INSERT INTO QUIZ4 VALUES(1,'����2��', 40);
--�̷��� �ȵ�. VALUE���� 1�� PRIMARY KEY�� ���� ���� �߻�


--�޿��� �������� 500���� �̻� ->��ް�����
--             350���� �̻� ->�߱ް�����
--                        ->�ʱް�����
--CASE WHEN THEN

SELECT EMP_NAME, SALARY, 
        CASE WHEN SALARY>=5000000 THEN '��ް�����'
             WHEN SALARY>=3500000 THEN '�߱ް�����'
             ELSE '�ʱް�����'
        END AS "����"
    FROM EMPLOYEE;
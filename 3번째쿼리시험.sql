CREATE USER EMP1 IDENTIFIED BY EMP01234;
GRANT CONNECT TO EMP1;
/*

*/
/*
�Ʒ��� ��Ȳ�� ������ ������ �а� ������ �߻��� ����(20��)�� �� ��ġ����(�ùٸ� SQL����)(20��)�� �ۼ��Ͻÿ�(�� 40��)
1) �ó����� ��Ȳ
����� ������ ����� ���� ������ �������� �����Ͽ�
CREATE USER EMP IDENTIFIED BY EMP0123; ��ɾ ������ ��
������ Ȯ���Ͽ���.


2) ���� ����
User EMP��(��) �����Ǿ����ϴ�.
ORA-01045: user EMP lacks CREATE SESSION privilege; logon denied

���� �߻� ���� - ���� ������ ���������� �Ǿ����� ���� ������ �־����� �ʾұ� ������ �ش� �������� ������ �Ұ����ϴ�.

��ġ���� - ������ �������� ������ ���¿��� �߰��� 
        GRANT CONNECT TO EMP; ������ �Է��� �ش� EMP ������ ������ �� �ִ� ������ �ο��ؾ���

*/


/*
���� �� ���� ���̺��� �����Ͽ� EMPNO, EMPNAME, DEPTNO, DEPTNAME �÷��� ��ȸ�Ͽ��� �� ������ �߻��Ѵ�.
�Ʒ��� ����� ������Ȳ�� ����, �߻��� ����(30��)�� �ذ��� �� �ִ� ��ġ����(30��)�� ����Ͻÿ�. (�� 60��)
-- ����� ���̺� ���� ���� --


�߻� ����-
- 
-

��ġ����-
-
-
*/
DROP TABLE DEPARTMENT;
CREATE TABLE DEPARTMENT(
  DEPTCODE NUMBER PRIMARY KEY,
  DEPTNAME NVARCHAR2(10) NOT NULL
);

DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE(
  EMPNO NUMBER PRIMARY KEY,
  EMPNAME VARCHAR2(10) NOT NULL,
  DEPTNO NUMBER REFERENCES DEPARTMENT(DEPTCODE)
);
-- ���� ��Ȳ
ORA-00904: "DEPARTMENT"."DEPTNO": invalid identifier

INSERT INTO DEPARTMENT VALUES('11','����1');
INSERT INTO DEPARTMENT VALUES('12','����2');

INSERT INTO EMPLOYEE VALUES('1','����1','11');
INSERT INTO EMPLOYEE VALUES('2','����2','12');
-- ������ ���� ���� --
SELECT EMPNO, EMPNAME, DEPTNO, DEPTNAME
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPTNO);

-- �����
SELECT EMPNO, EMPNAME, DEPTNO, DEPTNAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPTNO=DEPTCODE);
ROLLBACK;
--
-- ���� ��Ȳ
ORA-00904: "DEPARTMENT"."DEPTNO": invalid identifier



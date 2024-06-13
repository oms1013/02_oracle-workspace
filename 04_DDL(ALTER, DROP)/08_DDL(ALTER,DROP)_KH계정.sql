--
/*
    DDL(DATA DEFINITION LANGUAGE) : ������ ���� ��� 
    
    ��ü���� ����(CREATE), ����(ALTER), ����(DROP) �ϴ� ���� 
    
    <ALTER> 
    ��ü�� �����ϴ� ���� 
    
    [ǥ����]
    ALTER TABLE ���̺�� ������ ����; 
    
    * ������ ���� 
    1) �÷� �߰�/����/����
    2) �������� �߰�/���� --> ������ �Ұ�(�����ϰ��� �Ѵٸ� �����ϰ� ���� �߰��ؾ���) 
    3) �÷���/�������Ǹ�/���̺�� ���� 
  
*/

--1) �÷� �߰�/����/����  �١�
--1_1) �÷� �߰�(ADD) : ADD �÷��� �ڷ��� [DEFAULT �⺻��] �������� 
--DEPT_COPY�� CNAME�̶�� �÷� �߰�

ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> ���ο� �÷��� ��������� �⺻������ NULL�� ä���� 

SELECT * FROM DEPT_COPY;

--LNAME �÷� �߰� (�⺻���� ������ä��) 
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�'; 

--1_2) �÷� ����(MODIFY)
--> �ڷ��� ����           : MODIFY �÷��� �ٲٰ��� �ϴ� �ڷ��� 

--> DEFAULT�� ����       : MODIFY �÷��� DEFAULT �ٲٰ��� �ϴ� �⺻�� 

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--�̰� ������! �̹� �ȿ� ���ڰ� �ƴ� �����Ͱ� ���ִµ� �ڷ����� �ٲٷ��� �ϸ� �������°�
--�翬��. �����ϴ� �����Ͱ� ����߸� �̷��� �ٲ� �� ����. 

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
--���������� ����. �ȿ� �ִ� �����Ͱ� �ʹ� Ŀ�� ��������� ������ �߻�

--���� �غ���
--DEPT_TITLE �÷��� VARCHAR2�� 50����Ʈ�� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);

--LOCATION_ID �÷��� VARCHAR2(4)�� ����
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);

--LNAME �÷��� �⺻���� '�̱�'���� ����
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '�̱�';
SELECT * FROM DEPT_COPY;

--�翬�� ����Ʈ ���� �ٲ۴ٰ� �ؼ� �̹� ������ �߰��� �����Ͱ� ����Ǵ°� �ƴ�


--���� ���浵 ������.
ALTER TABLE DEPT_COPY 
    MODIFY DEPT_TITLE VARCHAR2(50) 
    MODIFY LOCATION_ID VARCHAR2(50)
    MODIFY LNAME DEFAULT '�̱�';

--1_3) �÷� ����(DROP COLUMN) : DROP COLUMN �����ϰ��� �ϴ� �÷���
--������ ���� ���纻 ���̺� ���� 
CREATE TABLE DEPT_COPY2 
 AS SELECT * FROM DEPT_COPY;
 
 SELECT * FROM DEPT_COPY2; 
 
 --DEPT_COPY2�κ��� DEPT_ID �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2
    DROP COLUMN LOCATION_ID
    DROP COLUMN CNAME;
    --�ٴ��� ALTER�� �ѹ��� DROP�� ������ ����� ���� ����. 

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
--ORA-12983: cannot drop all columns in a table
--������ �÷��� LNAME ���� �Ұ�. ���̺� �÷��� �ϳ��� �����־�� �ϱ� ���� 
--���̺� �ּ��� �Ѱ��� �÷��� �����ؾ� �Ѵ�.

--------------------------------------------------------------------
--2)�������� �߰�/���� 

/*
    2_1) �������� �߰�
    �̷��� 5���� ������ �ִ�. 
    PRIMARY KEY : ADD PRIMARY KEY(�÷���)
    FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[(�÷���)];
    UNIQUE      : ADD UNIQUE(�÷���) 
    CHECK       : ADD CHECK(�÷��� ���� ����)
    NOT NULL    : MODIFY �÷��� NOT NULL | NULL => �̰� ���� ���� ���ȴ�. 

    �������Ǹ��� �����ϰ��� �Ѵٸ� CONSTRAINT ��������
*/

-- DEPT_ID�� PRIMARY KEY �������� �߰� ADD
-- DEPT_TITLE�� UNIQUE �������� �߰� ADD
-- LNAME�� NOT NULL �������� �߰� MODIFY 
ALTER TABLE DEPT_COPY 
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

SELECT * FROM DEPT_COPY;

-- 2_2) �������� ���� : DROP CONSTRAINT ��������

-- ������ NOT NULL ���������� �����ϴ°� �ƴ�
-- MODIFY �÷��� NULL�� �ؾ���. �����ۿ� ����� ����

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;
--���� ����

ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
    --���� ������ �ѹ��� ����
    

--------------------------------------------------
--3) �÷���/�������Ǹ�/���̺�� ���� (RENAME) 
-- 3_1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷��� 

-- DEPT_TITLE => DEPT_NAME 
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

--3_2) �������Ǹ� ���� : RENAME CONSTRAINT �������Ǹ� TO �ٲ� �������Ǹ�
-- SYS_C007242 LOCATION_ID NN �ڱⲨ �������� 
-- SYS_C007242 => DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007242 TO DCOPY_LID_NN;


--3_3) ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺�� 
-- DEPT_COPY => DEPT_ TEST 
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;


---------------------------------------------------------

--���̺� ���� ��
DROP TABLE DEPT_TEST;

--��, ��򰡿��� �����ǰ� �ִ� �θ� ���̺��� �Ժη� ������ �� ����!! 
--���࿡ �����ϰ��� �Ѵٸ� 
-- ���1. �ڽ� ���̺��� ���� ���� �� �� �θ� ���̺��� �����ؾ���. 
-- ���2. �׳� �θ����̺� �����ϵ� �������Ǳ��� ���� �����ϴ� ��� 
--      DROP TABLE ���̺�� CASCADE CONSTRAINT;

















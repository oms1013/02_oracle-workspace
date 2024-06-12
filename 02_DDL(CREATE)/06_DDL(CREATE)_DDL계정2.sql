--���� ���� DQL(DATA QUERY(����) LANGUAGE)
/*
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ������ �����(CREATE), ������ �����ϰ�(ALTER), ���� ��ü�� ����(DROP)�ϴ� ���
    ��, ���� �����Ͱ��� �ƴ� ���� ��ü�� �����ϴ� ���
    �ַ� DB������, �����ڰ� �����
    
    ����Ŭ������ ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), 
                          �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER),
                          ���ν���(PROCEDURE), �Լ�(FUNCTION), ���Ǿ�(SYNONYM), �����(USER)
                          
    <CREATE>
    ��ü�� ������ �����ϴ� ����
*/

/*
    1. ���̺� ����
    - ���̺��̶�? ��(ROW)�� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                ��� �����͵��� ���̺��� ���ؼ� �����!!
                (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��!)
                
     [ ǥ���� ]
     CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���,
        ...
     );
    
    * �ڷ���
    - ���� (CHAR(����Ʈũ��) | VARCHAR2(����Ʈũ��)) => �ݵ�� ũ�� ���� �ؾ���!!
    > CHAR : �ִ� 2000 ����Ʈ���� ���� ����. ������ ���� �ȿ����� ��� �� / ��������(������ ũ�⺸�� �� ���� ���� ���͵� �������� ä����)
             ������ ���ڼ��� �����͸��� ��� ��� ���
    
    > VARCHAR2 : �ִ� 4000 ����Ʈ ���� ���� ����, ���� ���� (��� ���� ���� ������ ũ�� ������)
                ������� �����Ͱ� ���� �� �� ��� ���
    
    - ���� (NUMBER)
    
    - ��¥ (DATE)
    
    
*/

-- > ȸ���� ���� �����͸� ��� ���� ���̺� MEMBER �����ϱ�
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
    
);

SELECT * FROM MEMBER;

-- ���� �÷��� ��Ÿ�� ���ٸ�?
-- �ٽ� ����� �ɱ�? ���� �����ϰ� �ٽ� �ϵ� �ؾ� ��

-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺��
-- [����] USER_TABLES : ���� �� ������ ������ �ִ� ���̺� ���� �� �� ����
SELECT * FROM USER_TABLES;

--------------------------------------------------------------------------------

/*
    2. �÷��� �ּ� �ޱ� (�÷��� ���� ��������)
    
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
    >> �߸� �ۼ��ؼ� �������� ��� ���� �� �ٽ� �����ϸ� ��!
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';

COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

-- ���̺� �����ϰ��� �� �� : DROP TABLE ���̺��;

-- ���̺� ������ �߰���Ű�� ���� (DML : INSERT) �� �� �ڼ��ϰ� ���
-- INSERT INTO ���̺�� VALUES(��1, ��2, ....)

SELECT * FROM MEMBER;
--INSERT INTO MEMBER VALUES(1,'user01', 'pass01', 'ȫ�浿');
INSERT INTO MEMBER VALUES(1,'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'aaa@naver.com', '24/06/11');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', 'ȫ���', '��', null, NULL, SYSDATE);

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- ��ȿ���� ���� �����Ͱ� ���� ����.. ���� ������ �ɾ���� ��.

--------------------------------------------------------------------------------

/*
    <�������� CONSTRAINTS>
    - ���ϴ� �����Ͱ�(��ȿ�� ������ ��)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ��������
    - ������ ���Ἲ ������ �������� �Ѵ�!
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY    
*/

/*
    * NOT NULL ��������
    - �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ���(��, �ش� �÷��� ���� NULL�� ���ͼ��� �ȵǴ� ���)
    ����/���� �� NULL���� ������� �ʵ��� ����
    
    ���������� �ο��ϴ� ��� ũ�� 2������ ���� (�÷��������/���̺������)
    NOT NULL ���������� ������ �÷�������� �ۿ� �ȵ�
*/

-- �÷� ���� ��� : �÷��� �ڷ��� �������� 
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1,'user01','pass01', '�����', '��', null, null);
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', null, '�����', '��', null, 'aaa@naver.com');
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- �ǵ��ߴ���� ������!! (NOT NULL �������ǿ� ����Ǿ� ���� �߻�!)
INSERT INTO MEM_NOTNULL VALUES(2, 'user01', 'pass01', '�����', null, null, null);
--> ���̵� �ߺ��Ǿ� �������� �ұ��ϰ� �� �߰� �� ��_��


/*
    * UNIQUE ��������
    �ش� �÷��� �ߺ��� ���� ������ �� �� ���
    �÷����� �ߺ����� �����ϴ� ��������
    ����/���� �� ������ �ִ� �����Ͱ� �� �ߺ����� ���� ��� ���� �߻�!
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --�÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

-- ���̺� ���� ��� : ��� �÷��� �� ���� �� �� �������� ���
--                 �������� (�÷���)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50), 
    UNIQUE(MEM_ID) -- ���̺������
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass01', '�����', NULL, NULL, NULL);
-- ORA-00001: unique constraint (DDL.SYS_C007081) violated 
-- UNIQUE �������� �������! INSERT ����!!
-- ���� ������ �������Ǹ����� �˷���!! (Ư�� �÷��� � ������ �ִ��� ���� �˷����� ����!)
-- > ���� �ľ��ϱ� �����
-- > �������� �ο��� �������Ǹ��� ���������� ������ �ý��ۿ��� ������ �������Ǹ��� �ο��ع���

/*
    * �������� �ο��� �������Ǹ���� �����ִ� ���
    
    > �÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� [CONSTRAINT �������Ǹ�]��������,
        �÷��� �ڷ��� 
    );
    
    > ���̺������
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        [CONSTRAINT �������Ǹ�] ��������(�÷���)
        
    );
    
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL, 
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50), 
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '�����', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass01', '�����', NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�����', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '����', '��', NULL, NULL);
-- > ������ ��ȿ�� ���� �ƴ� �� ���͵� �� INSERT �ȴ�. => �̷��� �ȵ�...

--------------------------------------------------------------------------------

/*
    * CHECK(���ǽ�) ��������
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� ����!
    �ش� ���ǿ� �����ϴ� �����͸� ��� �� ����
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), -- �÷� ���� ���
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CHECK(GENDER IN ('��','��'))
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES(1, 'user01', 'pass01', '�����', '��', null, null);

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '�����', '��', null, null);
-- ORA-02290: check constraint (DDL.SYS_C007091) violated
-- CHECK �������� ����Ʊ� ������ ���� �߻�!

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '�����', NULL, null, null);
--> ���� GENDER �÷��� �����Ͱ��� �ְ��� �Ѵٸ� CHECK �������ǿ� �����ϴ� ���� �־�ߵ�
--> NOT NULL �ƴϸ� NULL�� �����ϱ���!!

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES(2, 'user03', 'pass03', '����', '��', null, null);
--> ȸ����ȣ�� �����ص� ���������� INSERT �Ź���..

-------------------------------------------------------------------------------
-- 6/12
/*
    * PRIMARY KEY (�⺻Ű) ��������
    ���̺��� �� ����� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� �������� (�ĺ����� ����)
    
    EX) ȸ����ȣ, �й�, �����ȣ(EMP_ID), �μ��ڵ�(DEPT_CODE), �����ڵ�(JOB_CODE), �ֹ���ȣ, �����ȣ, ������ȣ
    
    PRIMARY KEY ���������� �ο��ϸ� �� �÷��� �ڵ����� NOT NULL + UNIQUE ���������� ������.
    
    * ���ǻ��� : �� ���̺� �� ������!!! �� ���� ���� ����
    ~~ �����̸Ӹ�Ű�� ���ڷ� ���� ���� ��
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- �÷� ���� ���
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- ���̺� ���� ���
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI
VALUES(1, 'user01', 'pass01', '�����', '��', '010-1111-2222', null);

INSERT INTO MEM_PRI
VALUES(1, 'user02', 'pass02', '�����', '��', NULL, null);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated 
-- �⺻Ű�� �ߺ����� �������� �� �� (UNIQUE �������� ����)

INSERT INTO MEM_PRI
VALUES(NULL, 'user02', 'pass02', '�����', '��', NULL, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- �⺻Ű�� NULL �������� �� �� (NOT NULL �������ǿ� �����)

INSERT INTO MEM_PRI
VALUES(2, 'user02', 'pass02', '�����', '��', NULL, null);

SELECT * FROM MEM_PRI;

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) PRIMARY KEY, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
-- ORA-02260: table can have only one primary key
-- �⺻Ű �ϳ��� �ȴ�!!!

SELECT * FROM MEM_PRI2;

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20), 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- ��� PRIMARY KEY �������� �ο�(~~ ����Ű// �� �� �Ȱ��ƾ� ��)
);

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '�����', null, null, null);

INSERT INTO MEM_PRI2
VALUES(1, 'user02', 'pass02', '�����', null, null, null);

INSERT INTO MEM_PRI2
VALUES(2, 'user02', 'pass02', '�����', null, null, null);

INSERT INTO MEM_PRI2
VALUES(NULL, 'user02', 'pass02', '�����', null, null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- PRIMARY KEY�� �����ִ� �� �÷��� ���� NULL ������� ����!!

-- ����Ű ��� ���� (���ϱ�, ���ƿ�, ����) (~~ 1���̶�� ����� A��ǰ�� ���߰� 1���̶�� ����� A�� �� ���ϴ� �� �ʿ���°Ű� 2���̶�� ����� A��ǰ ���ϰ� 1���̶�� ����� B��ǰ�� ���� �� �����ϱ�)
-- ���ϱ� : �� ��ǰ�� ������ �ѹ��� ���� �� ����
-- � ȸ���� � ��ǰ�� ���ϴ����� ���� �����͸� �����ϴ� ���̺�
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(60),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES(1, '�౸��', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '�౸ȭ', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '�౸ȭ', SYSDATE); -- �����߻�!! �ѹ��� ���ؾߵ�
INSERT INTO TB_LIKE VALUES(2, '�౸ȭ', SYSDATE);

--------------------------------------------------------------------------------
-- ȸ�� ��޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
DROP TABLE MEM_GRADE;
SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20)NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER -- ȸ�� ��� ��ȣ ���� ������ �÷�
);

SELECT * FROM MEM;

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '�����', '��', null, null, null);

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '�����', null, null, null, 10);

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '����', null, null, null, 90);
-- ��ȿ�� ȸ����� ��ȣ�� �ƴԿ��� �ұ��ϰ� �� insert�� ��..

---------------------------------------------------------------
/*
    * FOREIGN KEY(�ܷ�Ű) ���� ���� 
    �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� Ư�� �÷��� �ο��ϴ� �������� 
    --> �ٸ� ���̺��� �����Ѵٰ� ǥ�� 
    --> �ַ� FOREIGN KEY �������ǿ� ���� ���̺��� ���谡 ������!
    
    > �÷� ���� ���
    �÷��� �ڷ��� REFERENCES ������ ���̺��[(������ �÷���)] 
    
    
    > ���̺� ���� ��� 
    FOREIGN KEY (�÷���) REFERENCES ������ ���̺��[(������ �÷���)] 
    
    --> ������ �÷��� ������ ������ ���̺��� PRIMARY KEY�� ������ �÷����� ��Ī
    
*/
DROP TABLE MEM; 

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20)NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) --�÷�������� : �����÷��� �Ⱦ��� �����̸Ӹ�Ű�� �ڵ���Ī!
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) 
       );

    SELECT * FROM MEM;
    
    INSERT INTO MEM
    VALUES(1,'user01', 'pass01', '�����', '��', null, null, null);
    --�ܷ�Ű �������� �ο��� �÷��� �⺻������ null ���
    INSERT INTO MEM
    VALUES(2,'user02', 'pass02', '�����', null, null, null, null);

    SELECT * FROM MEM;
    
     INSERT INTO MEM
    VALUES(3,'user03', 'pass03', '����', null, null, null, 30);

     INSERT INTO MEM
    VALUES(4,'user04', 'pass04', 'ī����', null, null, null, 90);
    -- ORA-02291 : integrity constraint (DDL.YSY_C007134) violated - parent key not found
    -- PARENT KEY�� ã�� �� ���ٴ� ������ �߻���
    -- �θ� ���̺� 90���� ����!!
    
    INSERT INTO MEM
    VALUES(4,'user04', 'pass04', 'ī����', null, null, null, 10);
    
      INSERT INTO MEM
    VALUES(5,'user05', 'pass05', '���켮', null, null, null, 20);
    
     SELECT * FROM MEM;
    --MEM_GRADE(�θ����̺�) -|----------------------MEM(�ڽ����̺�)
    
    -->�� �� �θ����̺�(MEM_GRADE)���� �����Ͱ��� ������ ��� � ������ ������?
    --> ������ ���� : DELEFTE FROM ���̺�� WHERE ����;
    
    SELECT * FROM MEM_GRADE;
    --MEM_GRADE ���̺��� 10����� ����
    DELETE FROM MEM_GRADE
    WHERE GRADE_CODE = 10;
    --ORA-02292: integrity constraint (DDL.SYS_C007134)violated - child record found
    --�ڽ����̺� (MEM)�� 10�̶�� ���� ����ϰ� �־ ������ �Ұ�����.
   
   DELETE FROM MEM
   WHERE MEM_NO=4;
   --> �ڽ����̺�(MEM)�� 10�̶�� ���� ������� �ʰ� �־ ������ �ߵ�
   
   --> �ڽ����̺��� �̹� ����ϰ� �ִ� ���� ���� ���
   --> �θ� ���̺�κ��� ������ ������ �ȵǰ� �ϴ� "���� ���� �ɼ�" �� �ɷ�����
   SELECT * FROM MEM_GRADE;
   ROLLBACK;
   -------------------------------------------------------
   /*
        �ڽ� ���̺� ������ �ܷ�Ű ���������� �ο��� �� �����ɼ��� ������ �� ����
        * �����ɼ� : �θ����̺��� ������ ���� �� �� �����͸� ����ϰ� �ִ� �ڽ����̺��� ����
        ��� ó���Ұ���. 
        
        - ON DELETE RESTRICTED(�⺻��) : ���� ���� �ɼ�����, �ڽ� �����ͷ� ���̴� �θ����ʹ� 
        ����� ������ �ƿ� �ȵǰԲ� �ϴ� �ɼ�
        
        - ON DELETE SET NULL : �θ����� ������ �ش� �����͸� ���� �ڽĵ����� �� NULL�κ���
        
        - �١١١� ON DELETE CASCADE : �θ����� ������ �ش絥���� ���� �ڽĵ����͵� ���� ���� 
        
    */
    DROP TABLE MEM; 
    
--ON DELETE SET NULL

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20)NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
         );
         
    INSERT INTO MEM
    VALUES(1,'user01', 'pass01', '�����', '��', null, null, null);
    
    INSERT INTO MEM
    VALUES(2,'user02', 'pass02', '�����', null, null, null, 10);

     INSERT INTO MEM
    VALUES(3,'user03', 'pass03', '����', null, null, null, 30);

     INSERT INTO MEM
    VALUES(4,'user04', 'pass04', 'ī����', null, null, null, 10);
    
    SELECT * FROM MEM;
    SELECT * FROM MEM_GRADE;
    
    DELETE * FROM MEM_GRADE 
    WHERE GRADE_CODE =10;
    --�� ������!1 (��,10�� ������ ���� �ڽĵ����� �� NULL�� ����)
    
    ROLLBACK;
    
    DROP TABLE MEM;
 
 CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20)NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
         );
         
         /*
         
    CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL 
   );
         */
         
    INSERT INTO MEM
    VALUES(1,'user01', 'pass01', '�����', '��', null, null, null);
    
    INSERT INTO MEM
    VALUES(2,'user02', 'pass02', '�����', null, null, null, 10);

     INSERT INTO MEM
    VALUES(3,'user03', 'pass03', '����', null, null, null, 30);

     INSERT INTO MEM
    VALUES(4,'user04', 'pass04', 'ī����', null, null, null, 10);
    
    SELECT * FROM MEM;
    SELECT * FROM MEM_GRADE;
    
    DELETE FROM MEM_GRADE
    WHERE GRADE_CODE = 10;
    
    SELECT * 
    FROM MEM_GRADE;
    --�� ������ (��, �ش� �����͸� ����ϰ� �ִ� �ڽ� �����Ͱ� ���� DELETE��!!)
   ----------------------------------------------------------------
   
   /*
        < DEFAULT �⺻�� > ** �������� �ƴ� 
        �÷��� �������� �ʰ� INSERT �� NULL �� �ƴ� �⺻���� INSERT�ϰ��� �� �� �����ص� �� �ִ� ��
       
   */

DROP TABLE MEMBER;

-- �÷��� �ڷ��� DEFAULT �⺻�� [��������]
-- DEFAULT�������� �տ� �ڸ���ƾ���
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    --��NUMBER, DATEŸ���� ũ�������� ���� �ʾƵ� �ȴ�.
    HOBBY VARCHAR2(20) DEFAULT '����',
    ENROLL_DATE DATE DEFAULT SYSDATE

);

SELECT * FROM MEMBER;

--INSERT INTO ���̺�� VALUES(��1, ��2)

INSERT INTO MEMBER VALUES(1, '�����', 20, '�౸', '23/01/22');
INSERT INTO MEMBER VALUES(2, '�����', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(3, 'ī����', NULL, DEFAULT, DEFAULT);
--NULL���� �ƴ϶� DEFAULT�� ������ ���� ����Ѵ�.


--�Ǵٸ� INSERT ���.   
-- INSERT INTO ���̺��(�÷���, �÷���) VALUES(��1, ��2)
-- NOT NULL �����Ǿ��ִ� �÷����� �� ���� �Է��ؾ���. 
--�׾� NULL�� ���� �ȵǴ� �����̶� �Է¿� NULL�� �Է��� �� �����ϱ�.
-- PRIMARYŰ�� NULL���� �ȵǴ� ������ �⺻���� ž��Ǿ� �ֱ� ������ �� ������ DEFAULT�������
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4,'����');
--�� �Է��ϴ°� �ƴ϶� ���Ÿ� �Է��ϸ� �Է����� ���� ���� DEFAULT���� �����Ǿ� ������,
--�ڵ������� DEFAULT���� ���
SELECT * FROM MEMBER;
--��°�� 4, ����, NULL, ����, ����ð� ��� 
--DEFAULT������ �ȵ��ִ� AGE�� NULL�� ��µȴ�.
--��, �ش� �÷��� DEFAULT���� ���� ��� NULL�� �ƴ� DEFUALT���� �� 

-----------------------------------------------------------------

/*
    !!!!!!!!!!!!!!!!!!!!!!!!���⼭���� KH�������� �ؾ���!!!!!!!!!!!!!!!!!!!!!!
    < SUBQUERY�� �̿��� ���̺� ���� > 
    ���̺��� �����ϴ� ���� 
    
    [ ǥ���� ]
    CREATE TABLE ���̺�� 
    AS �������� 
*/

-- EMPLOYEE ���̺��� ������ ���ο� ���̺��� ���� 
CREATE TABLE EMPLOYEE_COPY 
AS SELECT *
   FROM EMPLOYEE; 
   
SELECT * FROM EMPLOYEE_COPY; 
--> �÷�, �����Ͱ�, �������� ���� ��� NOT NULL�� ����� 

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS 
    FROM EMPLOYEE
    WHERE 1=0; --������ FALSE�� ����!! : �������� �����ϰ��� �� �� ���̴� ���� 
--�̷��� ���̺��� ������ �����´�. �����ʹ� �������� ���� 

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 AS "����"
    FROM EMPLOYEE;
-- "must name this expression with a column alias" ���� �߻� 
-- alias : ��Ī!! 
-- SALARY*12�� �����ΰ�. �Լ����� �������� ��Ī�� ����Ѵ�.
-- �������� SELECT���� ������ ������̳� �Լ����� ������ ��Ī�� ��� �ԡ١١�

SELECT * FROM EMPLOYEE_COPY3;

SELECT EMP_NAME, ���� 
FROM EMPLOYEE_COPY3; 

------------------------------------------------------------
/*
    * ���̺� �� ������ �Ŀ� �ڴʰ� �������� �߰� 

    ALTER TABLE ���̺�� ������ ����; 
    
    - PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���); 
    - FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���)REFERENCES ������ ���̺��[(�������÷���)]
    - UNIQUE      : ALTER TABLE ���̺�� ADD UNIQUE(�÷���); 
    - CHECK       : ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
    - NOT NULL    : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL; **�ణ Ư���� 
    
*/

-- ���������� �̿��ؼ� ������ ���̺��� NOT NULL���������� �����ϸ� �������� ����.
-- EMPLOYEE_COPY ���̺� PRIMARY KEY ���������� �߰�. (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID); 

--EMPLOYEE ���̺� DEPT_CODE�� �ܷ�Ű ���������� �߰�.(�����ϴ� ���̺�(�θ�) : DEPARTMENT
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;
--FOREIGN KEY���� ������ �÷����� �����ϸ� �θ����̺��� PK�� ��

-- EMPLOYEE ���̺� JOB_CODE�� �ܷ�Ű ���������� �߰�(JOB ���̺� ����) 
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;

-- EMPLOYEE ���̺� SAL_LEVEL�� �ܷ�Ű ���������� �߰�(SAL_GRADE ���̺� ����) 
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE;

-- DEPARTMENT ���̺� LOCATION_ID�� �ܷ�Ű ���������� �߰�(LOCATION ���̺� ����) 
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;



   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
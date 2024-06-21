/*

com.kh.model.vo.Book Ŭ���� �ۼ�
com.kh.model.vo.Magazine Ŭ���� �ۼ�
com.kh.model.dao.BookDao Ŭ���� �ۼ�
com.kh.controller.BookController Ŭ���� �ۼ�
com.kh.view.BookMenu Ŭ���� �ۼ�

�̶�, �޴��� LibraryRun ���Ͽ� �ִ� �޴��� �����Ͽ� �����,
1~5 ������ �޴��� ���� �����ؾ���.

�����ʹ� 10�� ������ �����͸� ���̺��� ���� �����͸� �߰��ϵ��� �Ѵ�.

(�Ҿ���� ���Ը� ã�Ƽ� ~ �������� �鸸���� �丮 ������)
-

���೻���� JAR���Ϸ� Export �Ͽ� ������ ��!
*/

 DROP TABLE BOOK;
CREATE TABLE BOOK(
    BNO VARCHAR2(20) NOT NULL UNIQUE,       -- å ��ȣ
    TITLE VARCHAR2(200) NOT NULL,    -- å ����
    AUTHOR VARCHAR2(30),    -- ����
    PUBLISHER VARCHAR2(50), -- ���ǻ�
    PRICE NUMBER,           -- ����
    DESCRIPTION VARCHAR(500)     -- ����
  );
COMMENT ON COLUMN BOOK.BNO IS 'å ��ȣ';
COMMENT ON COLUMN BOOK.TITLE IS 'å ����';
COMMENT ON COLUMN BOOK.AUTHOR IS '����';
COMMENT ON COLUMN BOOK.PUBLISHER IS '���ǻ�';
COMMENT ON COLUMN BOOK.PRICE IS '����';
COMMENT ON COLUMN BOOK.DESCRIPTION IS '����';
   
    DROP TABLE MAGAZINE;
CREATE TABLE MAGAZINE(
    BNO VARCHAR2(20) NOT NULL UNIQUE,       -- å ��ȣ
    TITLE VARCHAR2(200) NOT NULL,           -- å ����
    AUTHOR VARCHAR2(30),                     -- ����
    PUBLISHER VARCHAR2(50),                 -- ���ǻ�
    PRICE NUMBER,                           -- ����
    DESCRIPTION VARCHAR(500),             -- ����
    YEAR NUMBER,                            -- �Ⱓ����
    MONTH NUMBER                            -- �Ⱓ��
  );
COMMENT ON COLUMN MAGAZINE.YEAR IS '�Ⱓ����';
COMMENT ON COLUMN MAGAZINE.MONTH IS '�Ⱓ��';
COMMENT ON COLUMN BOOK.BNO IS 'å ��ȣ';
COMMENT ON COLUMN BOOK.TITLE IS 'å ����';
COMMENT ON COLUMN BOOK.AUTHOR IS '����';
COMMENT ON COLUMN BOOK.PUBLISHER IS '���ǻ�';
COMMENT ON COLUMN BOOK.PRICE IS '����';
COMMENT ON COLUMN BOOK.DESCRIPTION IS '����';



 INSERT INTO BOOK VALUES('100', '�Ҿ���� ���Ը� ã�Ƽ�', '��� �ڻ�', '��� ���ǻ�', 8500, '�����潺��, ���� ���塻 ���� 20���� �ְ��� å');
 INSERT INTO BOOK VALUES('101', '�������� �ڼ���', '�����̰� �ű�', '������ �������ǻ�', 8500, '��ȭ��� ��ä���� ��õ�� ������ ��ġ�� ��ȥ�� �ڼ���');
 INSERT INTO BOOK VALUES('103', '������� �ڵ�����', '�ڵ�õ�� ������', '�����̳� ����', 9900, '�� 13ȸ �̿��� �ִ� ���л� ������');
 INSERT INTO BOOK VALUES('106', '���Ѻ��� �̶�Ŭ���', '���ν� �ڻ�', '�����̳� ���ǻ�', 6300, '�����̵� 2�� ������ �̶�Ŭ���');
 INSERT INTO BOOK VALUES('107', '�������� �鸸���� �丮������', '���￡�� �� ��ȣ', '�����ּ��� �ֽ±� ���ǻ�', 6300, '���̵� Ȳ������ ���� ��õ�� �ְ��� ������');
  
INSERT INTO MAGAZINE VALUES('102', '���°� ���е���', '������ ���� ����', '��� ���̾�', 8500, '���� ��Ʃ�꿡 �Ұ��� ���и�ȭ ����', 2024, 5);
INSERT INTO MAGAZINE VALUES('104', '�������� �����ϱ�', '������', '����21', 3800, '��ȭ���� ����ȣ ������ ��ȭ ���� ����', 2021, 4);
INSERT INTO MAGAZINE VALUES('105', '���ֿ��� ���ϸ���', '���÷�� ���ؿ�', '�����̳� å��', 12000, '�ְ� ��ÿ��� ������� ���� ����', 2024, 10);

COMMIT;

SELECT * FROM BOOK;
SELECT * FROM MAGAZINE;
    
SELECT *
FROM BOOK B
RIGHT JOIN MAGAZINE Z ON (B.BNO=Z.BNO);


    COMMIT;
   
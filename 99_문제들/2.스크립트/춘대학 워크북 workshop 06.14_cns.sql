
--1. 4�� ���̺� ���Ե� ������ �� ���� ���ϴ� SQL ������ ����� SQL ������ �ۼ��Ͻÿ�.  
SELECT COUNT(*) FROM TB_BOOK;
SELECT COUNT(*) FROM TB_BOOK_AUTHOR;
SELECT COUNT(*) FROM TB_PUBLISHER;
SELECT COUNT(*) FROM TB_WRITER;

SELECT COUNT(*) 
FROM TB_BOOK TB, TB_BOOK_AUTHOR TBA,  TB_WRITER TW, TB_PUBLISHER TP
WHERE TB.BOOK_NO = TBA.BOOK_NO 
AND TBA.WRITER_NO = TW.WRITER_NO
AND TP.PUBLISHER_NM = TB.PUBLISHER_NM;


--2. 4�� ���̺��� ������ �ľ��Ϸ��� �Ѵ�. ���õ� ���ó�� TABLE_NAME, COLUMN_NAME, DATA_TYPE, 
--DATA_DEFAULT, NULLABLE, CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME ���� 
--��ȸ�ϴ� SQL ������ �ۼ��Ͻÿ�.  �ء�
SELECT TABLE_NAME, COLUMN_NAME, DATE_TYPE, DATE_DEFAULT, NULLABLE, CONSTAINT_NAME, 
CONSTRAINT_TYPE, R_CONSTRAINT_NAME
FROM TB_BOOK TB, TB_BOOK_AUTHOR TBA,  TB_WRITER TW, TB_PUBLISHER TP
WHERE TB.BOOK_NO = TBA.BOOK_NO 
AND TBA.WRITER_NO = TW.WRITER_NO
AND TP.PUBLISHER_NM = TB.PUBLISHER_NM;

--3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;


--4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰� 
--�̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
--�١١١١� 
SELECT ROWNUM, WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM
(SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM TB_WRITER
WHERE SUBSTR(MOBILE_NO,1,3) = '019' AND SUBSTR(WRITER_NM,1,1) = '��'
ORDER BY WRITER_NM)
WHERE ROWNUM =1;


--5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� 
--���۰�(��)������ ǥ�õǵ��� �� ��)  

SELECT COUNT(DISTINCT WRITER_NM)
FROM TB_WRITER
JOIN TB_BOOK_AUTHOR USING (WRITER_NO)  
WHERE COMPOSE_TYPE = '�ű�';


--6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.(���� 
--���°� ��ϵ��� ���� ���� ������ ��) 

-- TB_BOOK�� STOCK_QTY ��� ����
-- TB_BOOK_AUTHOR�� COMPOSE_TYPE ���� ���� 
SELECT COMPOSE_TYPE, COUNT(COMPOSE_TYPE)
FROM TB_BOOK 
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
GROUP BY COMPOSE_TYPE 
HAVING COUNT(BOOK_NO) >= 300 AND COMPOSE_TYPE IS NOT NULL; 


--7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 

--å �̸�,  ��������,  ���ǻ� �̸�  
-- BOOK_NM, ISSUE_DATE PUBLISHER_NM

SELECT ROWNUM, BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM 
(SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM TB_BOOK
ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

--8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
--��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �� 
--��)  ��

-- �۰� �̸�,        �Ⱓ�� å ����,    �������� �۰� ����      ����� �۰��̸�,�Ǽ� AS
--TB_WRITER�� WRITER_NM ,
--TB_BOOK_AUTHOR�� WRITER_NO(�۰���ȣ)  COUNT���
 
  
SELECT "�۰� �̸�", "�� ��"
FROM (
    SELECT WRITER_NM AS "�۰� �̸�", COUNT(TBA.WRITER_NO) AS "�� ��"
    FROM TB_WRITER W
    JOIN TB_BOOK_AUTHOR TBA ON W.WRITER_NO = TBA.WRITER_NO
    GROUP BY WRITER_NM
    ORDER BY COUNT(TBA.WRITER_NO) DESC
)
WHERE ROWNUM <= 3;

--9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰��� 
--������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��) 


 UPDATE TB_WRITER
       SET REGIST_DATE =
       
       SELECT * 
       FROM 
       TB_BOOK
       TB_BOOK_AUTHOR
       TB_WRITER
        
        
           ...    --> �������� �÷��� ���� ���� ����! (,�� �����ؾߵ�! AND �ƴ�!!)                  
        [WHERE ����]; -->�����ϸ� ��ü ���� ��� ���� �����Ͱ� ����ȴ�..! �׷��� �� ���� ����!
        
set

INSERT ALL 
WHEN HIRE_DATE <'2000/01/01' THEN 
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE > '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

--�� �۰� ���� ���ǵ��� �������� TB_BOOK�� ISSUE_DATE ��

--������ TB_BOOK, TB_WRITER JOIN�ؾ��� 

-- �۰� �̸����� �������� �ּ�ġ�� ������

--�״�� ��Ƽ� TB_WRITER, REGIST_DATE����°�� ����־����

-- �������� WRITER_NM(�۰� �̸�)�� REGIST_DATE ��� 



--TB_WRITER�۰����� ���̺��� REGIST_DATE(��� ������� �׸�) �� NULL�̴�. 
--�� ��ġ�� ���� �ش� �۰� ���� ���ǵ��� ������ ��¥�� ����־����. COMMITó���Ұ�





--10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ�
--�� �Ѵ�. ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�. �ء�
--(Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸��� 
--��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��) 
-- 
--�Ӽ� �÷� Ÿ�� Null PK FK ���� ���̺� 
--���� ��ȣ  BOOK_NO  VARCHAR2(10)  NOT NULL  Y Y TB_BOOK  
--�۰� ��ȣ  WRITER_NO  VARCHAR2(10)  NOT NULL  Y Y TB_WRITER  
--���� ���  TRANS_LANG  VARCHAR2(60)  NULL  N N    
-- 
--TB_BOOK ���� �⺻ ���� ���� ���̺� 
--TB_WRITE �۰�(������/������) �⺻ ���� ���� ���̺�  
--TB_PUBLISHER ���ǻ� �⺻ ���� ���� ���̺� 
--TB_BOOK_AUTHOR ���� �� ������ ���� ���� ���� ���̺� 
--SQL Final Workshop 

CREATE TABLE TB_BOOK_ TRANSLATOR(
    
    
    NO VARCHAR2(5) PRIMARY KEY,
    --�⺻Ű����
    NAME VARCHAR2(10)
);



--11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ� 
--���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL 
--������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. (�̵��� �����ʹ� �� 
--�̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��) �ء�





--12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 

SELECT *





--13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL 
--������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, �������� 
--ǥ�õǵ��� �� ��) �ء�




--14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL 
--������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)  �ء�
-- 
--���ǻ� �繫�� ��ȭ��ȣ �ŷ����� 
--�� ���ǻ� 02-6710-3737 Default �� ��� 
-- 




--15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������ 
--�ۼ��Ͻÿ�. �ء�




--16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. �ش� �÷��� 
--NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)  �ء�




--17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰��� 
--�̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. �ء�




--18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. 
--�ء�



--19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���' 
--���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������ 
--�ۼ��Ͻÿ�. ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
--�������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�.  �ء� 
-- 




--20.  '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� 
--��������,�����ڡ�,�����ڡ��� ǥ���� ��)  �ء�
--  




--21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ��� 
--����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������, ����� 
--������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ������ 
--������ ǥ�õǵ��� �� ��)�ء�








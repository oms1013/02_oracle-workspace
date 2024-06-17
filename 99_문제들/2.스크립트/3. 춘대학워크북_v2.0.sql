--1.�� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" 
--���� ǥ���ϵ��� �Ѵ�.

SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY AS "�迭"
FROM TB_DEPARTMENT;

--2.  �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.

SELECT DEPARTMENT_NAME || '�� ������', CAPACITY || '�� �Դϴ�.'
FROM TB_DEPARTMENT;

-- 3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� 
--���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� 
--ã�� ������ ����)
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y' AND SUBSTR(STUDENT_SSN, 8, 1) IN (2,4);
-- ��������

--STUDENT_NAME -------------------- 
--�Ѽ��� 

--4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. �� ����ڵ��� 
--�й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�. 
  --  A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN( 'A513079', 'A513090', 'A513091', 'A513110', 'A513119' );


--5. ���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�. 
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <=30;

-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.  �׷� �� 
--������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� ����. 
--��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ� 
--������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.

SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;


--10. 02 �й� ���� �����ڵ��� ������ ������� �Ѵ�. �����ѻ������ ������ �������� 
--�л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N'
ORDER BY STUDENT_NAME;


----------------------------�Լ�---------------------------------
--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� 
--������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" �� 
--ǥ�õǵ��� ����.) ��
SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�̸�" , 
 TO_CHAR (ENTRANCE_DATE, 'YYYY-MM-DD') AS"���п���"
--���г⵵  1999-03-01 ������ �����ؾ���
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE;


--2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����. �� ������ 
--�̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL 
--������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

--3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. �� 
--�̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� �� 
--2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� ����. ���̴� ���������� 
--�������.)

SELECT PROFESSOR_NAME AS "���� �̸�" , 
TRUNC(MONTHS_BETWEEN(SYSDATE , SUBSTR(PROFESSOR_SSN,1,6))/12) AS "����"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8,1) IN (1,3);

--4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� ����� 
--?�̸�? �� �������� ����. (���� 2���� ���� ������ ���ٰ� �����Ͻÿ�)

SELECT SUBSTR(PROFESSOR_NAME,2,2) 
FROM TB_PROFESSOR;

--5. �� ������б��� ����� �����ڸ� ���Ϸ��� ����. ��� ã�Ƴ� ���ΰ�?  �̶�, 
--19�쿡 �����ϸ� ����� ���� ���� ������ �A������.
SELECT *
FROM TB_STUDENT;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE, SUBSTR(STUDENT_SSN,1,6))/12) =19; 

--6. 2020�� ũ���������� ���� �����ΰ�?
/*  ?????
SELECT 
FROM DUAL;
*/

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')  �� ���� �� �� �� 
--�� �� ���� �ǹ�����? �� TO_DATE('99/10/11','RR/MM/DD'), 
--TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ�����? 

-- YY�� ������ ���� ����� �Է��ϱ� ������
-- TO_DATE('99/10/11','YY/MM/DD')�� 2099.10.11�� ���ϸ�
-- TO_DATE('49/10/11','YY/MM/DD')�� 2049.10.11�� ���Ѵ� 

-- RR�� 50~99�� ���� ����� �����ϰ� 00~49�� ���� ����� �����ϱ� ������
-- TO_DATE('99/10/11','RR/MM/DD')�� 1999.10.11�̸�
-- TO_DATE('49/10/11','RR/MM/DD')�� 2049.10.11�̴�.


--8. �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�. 2000�⵵ 
--���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE NOT SUBSTR(STUDENT_NO, 1,1) = 'A';

--9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��, 
--�̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� �� 
--�ڸ������� ǥ���Ѵ�.

SELECT ROUND(AVG(POINT),1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO ='A517178'
GROUP BY STUDENT_NO;


--10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� 
--��µǵ��� �Ͻÿ�. 

SELECT DEPARTMENT_NO AS "�а���ȣ", CAPACITY "�л���(��)"
FROM TB_DEPARTMENT;


--11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ���� 
--�ۼ��Ͻÿ�.  
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;



--12. �й��� A112113�� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��, 
--�̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� 
--�Ҽ��� ���� �� �ڸ������� ǥ������. ��

SELECT STUDENT_NO 
FROM TB_GRADE
GROUP BY STUDENT_NO
HAVING STUDENT_NO = 'A112113';

--13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ 
--�ۼ��Ͻÿ�. ��
SELECT DEPARTMENT_NO, COUNT(ABSENCE_YN)  
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NO, ABSENCE_YN
HAVING ABSENCE_YN = 'Y'
ORDER BY DEPARTMENT_NO;



--14.  �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����. � SQL 
--������ ����ϸ� �����ϰڴ°�? ��

-- SELECT �̸�
-- FROM TB_STUDENT

--WHERE���� COUNT, �̸� ī��Ʈ ���� 1�� �ƴ� ��� 


--15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , �� 
--������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� 
--ǥ���Ѵ�.)��

    --SELECT
    --FROM
    --WHERE

-----------------[Additional SELECT - Option]------------------------------
--1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�, 
--������ �̸����� �������� ǥ���ϵ��� ����.
SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_ADDRESS AS "�ּ���"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;


--2.  �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME,STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y' 
ORDER BY TO_DATE(SUBSTR(STUDENT_SSN,1,6));


--3. �ּ����� �������� ��⵵�� �л��� �� 1900��� �й��� ���� �л����� �̸��� �й�, 
--�ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�", 
--"������ �ּ�" �� ��µǵ��� ����.

SELECT STUDENT_NAME AS "�л��̸�", STUDENT_NO AS "�й�", STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS, 1,2) IN ('����', '���')
ORDER BY STUDENT_NAME;


--4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ 
--�ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� 
--������ ����)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = 005
ORDER BY TO_DATE(SUBSTR(PROFESSOR_SSN,1,6));

--5. 2004��2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������ 
--���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ 
--�ۼ��غ��ÿ�. 
SELECT *
FROM TB_GRADE
WHERE TERM_NO = 200402 AND CLASS_NO = 'C3118100'
ORDER BY POINT, STUDENT_NO DESC;


--6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL 
--���� �ۼ��Ͻÿ�.
-- STUDENT_NO(TB_STUDENT), STUDENT_NAME(TB_STUDENT),DEPARTMENT_NAME(TB_DEPARTMENT)
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;


--7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

--8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� 
--�ۼ��Ͻÿ�.
--CLASS_NAME(TB_CLASS) ���� �̸�                            CLASS_NO
--PROFESSOR_NAME(TB_PROFESSOR) ���� �̸�   PROFESSOR_NO
--TB_CLASS_PROFESSOR ����� ���� CLASS_NO, PROFESSOR_NO
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);

--9. 8���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿� 
--�ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR CP, TB_CLASS C, TB_PROFESSOR P, TB_DEPARTMENT D
--TB_ CLASS            CLASS NO                  DEPARTMENT_NO
--TB_CLASS_PROFESSOR   CLASS NO  PROFESSOR_NO
--TB DEPARTMENT                                  DEPARTMENT_NO
--TB PROFESSOR                   PROFFESOR_NO
WHERE D.DEPARTMENT_NO=C.DEPARTMENT_NO AND C.CLASS_NO = CP.CLASS_NO
AND P.PROFESSOR_NO = CP.PROFESSOR_NO
AND CATEGORY = '�ι���ȸ';

--10. �������а��� �л����� ������ ���Ϸ��� ����. �����а� �л����� "�й�", "�л� �̸�", 
--"��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1�ڸ������� 
--�ݿø��Ͽ� ǥ������.)
SELECT STUDENT_NO, STUDENT_NAME, ROUND(AVG(POINT),1)
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO)
GROUP BY STUDENT_NO,  STUDENT_NAME;


--11. �й��� A313047�� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ� 
--���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ���� 
--�ۼ��Ͻÿ�.  ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?���� 
--��µǵ��� ����. ��
--SELECT DEPARTMENT_NAME(TB_DEPARTMENT), STUDENT_NAME(TB_STUDENT), 
-- COACH_PROFESSOR_NO(TB_STUDENT), PROFESSOR_NAME(PROFESSOR_NAME)

SELECT DEPARTMENT_NAME AS "�а��̸�", STUDENT_NAME AS "�л��̸�", PROFESSOR_NAME AS "���������̸�"
FROM TB_STUDENT
JOIN TB_PROFESSOR USING(DEPARTMENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)

WHERE STUDENT_NO = 'A313047';


--12. 2007 �⵵�� '�΁A�����' ������ ������ �л��� ã�� �л��̸��� �����б⸧ ǥ���ϴ� 
--SQL ������ �ۼ��Ͻÿ�.  
--TB_CLASS�� CLASS_NO C2604100, CLASS_NAME �ΰ������
--TB_GRADE�� TERM_NO 2007�⵵, CLASS NO  C2604100 STUDENTNO
--�л��̸� TB_STUDENT�� STUDENT_NAME                 STUDENTNO
SELECT STUDENT_NAME, TERM_NO
FROM TB_GRADE 
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_STUDENT USING (STUDENT_NO)
WHERE CLASS_NO = 'C2604100'  AND SUBSTR(TERM_NO,1,4) = '2007';


--13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ���� 
--�̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��

--TB_CLASS_PROFESSOR             CLASS_NO, PROFFESOR_NO       CLASS_NO
--������ ����
--WHERE PROFESSOR_NO IS NULL

--TB_CLASS  CLASS_NAME            DEPARTMENT_NO                         CLASS_NO
--���� �̸�

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO) 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE CATEGORY = '��ü��' AND PROFESSOR_NO IS NULL;


SELECT DEPARTMENT_NAME
FROM TB_DEPARTMENT
WHERE CATEGORY = '��ü��' AND DEPARTMENT_NAME IS NULL;

--14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸��� 
--�������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?���� 
--ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��,  �������� ?�л��̸�?, ?��������?�� 
--ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� ����.

SELECT D.STUDENT_NAME AS "�л��̸�", PROFESSOR_NAME AS "��������"
FROM TB_STUDENT D
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE D.DEPARTMENT_NO = 20; 

--15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а� 
--�̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.  

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME, AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
GROUP BY STUDENT_NO, ABSENCE_YN, STUDENT_NAME,DEPARTMENT_NAME
HAVING AVG(POINT) > 4.0 AND ABSENCE_YN = 'N';


--16. �Q�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.��
-- �а��̸�,  --�������� , --���� ���� 


--����, TB_GRADE�� POINT, ���߿� ���񺰷� �������               CLASS_NO      

--�а��̸�, TB_DEPARTMENT�� DEPARTMENT_NAME                               

--TB_CLASS�� ��������. CLASS_TYPE                             CLASS_NO    
SELECT CLASS_TYPE, AVG(POINT)
FROM TB_CLASS
JOIN TB_GRADE USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO) 
GROUP BY CLASS_TYPE, POINT
HAVING DEPARTMENT_NAME = 'ȯ�������а�';

--17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� 
--SQL ���� �ۼ��Ͻÿ�.��
--�л� �̸�,   �л� �ּ�, �� �̸� ,
--TB_STUDENT�� STUDENT NAME�л��̸�, STUDENT_ADDRESS �л��ּ� 
--TB_DEPARTMENT�� DEPARTMENT_NAME �� �̸� 

SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO       '�ְ���';



--18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL���� 
--�ۼ��Ͻÿ�.��
SELECT ;



--19. �� ������б��� "�Q�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������ 
--�ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. ��, �������� "�迭 �а���", 
--"��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� 
--����.��


----------------------------------DDL--------------------------------------
--1. �迭 ������ ������ ī�װ� ���̺��� ������� ����. ������ ���� ���̺��� 
--�ۼ��Ͻÿ�. 

CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 1
);

--2. ���� ������ ������ ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    --�⺻Ű����
    NAME VARCHAR2(10)
);

--3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY�� �����Ͻÿ�. 
--(KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� ���ٸ� �̸��� ������ 
--�˾Ƽ� ������ �̸��� �������.) 
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);



--4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
ALTER TABLE TB_CLASS MODIFY CLASS_TYPE NOT NULL;


--5. �� ���̺��� �÷� ���� NO�� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷����� 
--NAME �� ���� ���C������ ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR(10);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR(20);


--6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ� 
--���� ���·� ��������. 
--(ex. CATEGORY_NAME)
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;


--7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� 
--�����Ͻÿ�. 
--Primary Key �� �̸��� ?PK_ + �÷��̸�?���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINTS SYS_C007268 TO PK_CLASS_TYPE_NAME;
ALTER TABLE TB_CATEGORY RENAME CONSTRAINTS SYS_C007251 TO PK_CATEGORY_NAME;



--8. ������ ����INSERT ���� ��������. 
INSERT INTO TB_CATEGORY VALUES ('����','Y'); 
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y'); 
INSERT INTO TB_CATEGORY VALUES ('����','Y'); 
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y'); 
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y'); 
COMMIT; 

--9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ� 
--������ �����ϵ��� FOREIGN KEY�� �����Ͻÿ�. �� �� KEY �̸��� 
--FK_���̺��̸�_�÷��̸����� ��������. (ex. FK_DEPARTMENT_CATEGORY ) 

ALTER TABLE TB_DEPARTMENT
  ADD FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

------------------------------view ���� ----------------------

--10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW�� ������� ����. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. ��

CREATE VIEW VW_�л��Ϲ�����
 AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
 FROM TB_STUDENT;
 

 --�й� STUDENT_NO
 --�л��̸� STUDENT_NAME
 --�ּ� STUDENT_ADDRESS



--11. �� ������б��� 1�⿡ �� ���� �а����� �л��� ���������� ���� ����� ��������. 
--�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�. 
--�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT 
--���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.) ��

--�л��̸�, �а��̸�, ��米���̸�
--STUDENT_NAME, DEPARTMENT_NAME(TB_DEPARTMENT), COACH_PROFESSOR

DROP VIEW VW_�������;

CREATE VIEW VW_�������
 AS SELECT STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME
 FROM TB_STUDENT
 JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
 JOIN  TB_PROFESSOR ON (PROFESSOR_NO = COACH_PROFESSOR_NO)
 ORDER BY DEPARTMENT_NAME; 
 
 SELECT * FROM VW_�������;
 --NULL����


--12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����. ��
CREATE VIEW VW_�а����л��� 
 AS SELECT DEPARTMENT_NAME, CAPACITY "STUDENT_COUNT"
 FROM TB_DEPARTMENT;
 
 SELECT * FROM VW_�а����л���;

--13. ������ ������ �л��Ϲ����� View�� ���ؼ� �й��� A213046�� �л��� �̸��� ���� 
--�̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�. ��


 UPDATE VW_�л��Ϲ�����
            SET 
            (
            SELECT STUDENT_NAME 
            FROM TB_STUDENT
        
           WHERE STUDENT_NO = 'A213046')
            FROM TB_STUDENT;

--14. 13 �������� ���� VIEW�� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW�� 
--��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�. ��


DROP VIEW VW_�л��Ϲ�����;

CREATE VIEW OR REPLACE VW_�л��Ϲ����� 
 AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
 FROM TB_STUDENT
 WITH READ ONLY; 
 


----------------------------------------------------


--15. �� ������б��� �ų� ������û ��A�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ���� 
--������ �ǰ� �ִ�. �ֱ� 3���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������ 
--�ۼ��غ��ÿ�.�ء�


----------------------------------DML-------------------------------------
--1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE MODIFY CLASS_TYPE_NO VARCHAR(20);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR(20);

INSERT INTO TB_CLASS_TYPE VALUES('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('02', '��������');
INSERT INTO TB_CLASS_TYPE VALUES('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES('05', '������');


-- 2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� ����. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
CREATE TABLE TB_�л��Ϲ�����
    AS SELECT STUDENT_NO,
    STUDENT_NAME,
    STUDENT_ADDRESS
    FROM TB_STUDENT;
    
       
    --TB_STUDENT 
      -- STUDENT_NO �й� 
      -- STUDENT_NAME �л��̸�
      -- STUDENT_ADDRESS �л� �ּ�
       



 --3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� ����. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ� 
--�ۼ��Ͻÿ�)
CREATE TABLE TB_������а� AS
    
    SELECT STUDENT_NO, -- �й�
    STUDENT_NAME, -- �̸�
    STUDENT_ADDRESS, -- �ּ�
    PROFESSOR_NAME -- �����̸�
    
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
    WHERE DEPARTMENT_NAME = '������а�';
    
   --����⵵
   --�����̸�



--4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��, 
--�ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� ����) 

UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY*1.1);


--5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ� 
--����. �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�. 

SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';


ALTER TABLE TB_STUDENT MODIFY STUDENT_ADDRESS VARCHAR2(300);

UPDATE TB_STUDENT
SET STUDENT_ADDRESS =  "����� ���α� ���ε� 181-21" --���� �߻�
WHERE STUDENT_NO = 'A413042';


--6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ�� 
--�����Ͽ���. �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�. 
--(��. 830530-2124663 ==> 830530 )  

UPDATE TB_STUDENT
SET STUDENT_NO = SUBSTR(STUDENT_NO, 1, 6);

--7. ���а� ����� �л��� 2005�� 1�б⿡ �ڽ��� ������ '�Ǻλ�����' ������ 
--�߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���. ��� ������ Ȯ�� ���� ��� �ش� 
--������ ������ 3.5�� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�. 

UPDATE TB_GRADE 
SET POINT = 3.5
WHERE STUDENT_NO = 
    (
    SELECT STUDENT_NO
    FROM TB_STUDENT 
    JOIN TB_CLASS USING (DEPARTMENT_NO)
    WHERE STUDENT_NAME = '�����' AND CLASS_NAME = '�Ǻλ�����'
    AND TERM_NO = '200501'
);

--8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�.
DELETE FROM TB_GRADE

WHERE STUDENT_NO IN (
    SELECT STUDENT_NO
    FROM TB_STUDENT
    WHERE ABSENCE_YN = 'Y');
    




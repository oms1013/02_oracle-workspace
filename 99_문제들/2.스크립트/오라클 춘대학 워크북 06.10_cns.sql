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

SELECT DEPARTMENT_NAME, STUDENT_NAME, PROFESSOR_NAME
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
WHERE CLASS_NO = 'C2604100'  AND SUBSTR(TERM_NO,1,4) = '2007'


--13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ���� 
--�̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
--��米�� 
--�����̸�  
--�а��̸�  TB_DEPARTMENT�� TB_CLASS,�а���ȣ(56~63) , CATEGORY ��ü��

SELECT
FROM 
WHERE CO



--14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸��� 
--�������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?���� 
--ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��,  �������� ?�л��̸�?, ?��������?�� 
--ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� ����. 

--15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а� 
--�̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.  


--16. �Q�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.


--17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� 
--SQL ���� �ۼ��Ͻÿ�.


--18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL���� 
--�ۼ��Ͻÿ�.

--19. �� ������б��� "�Q�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������ 
--�ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. ��, �������� "�迭 �а���", 
--"��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� 
--����.











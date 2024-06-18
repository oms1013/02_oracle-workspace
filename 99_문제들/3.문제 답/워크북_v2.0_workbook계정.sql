----------------------------------------------------------------------------------------------------------------
SELECT * FROM TB_CLASS; --���� (�����ȣ, �а���ȣ, ���������ȣ, �����̸�, ���񱸺�)
SELECT * FROM TB_CLASS_PROFESSOR; -- ���� ���� (�����ȣ, ������ȣ)
SELECT * FROM TB_DEPARTMENT; -- �а� (�а���ȣ, �а��̸�, �迭, ��������, ����)
SELECT * FROM TB_GRADE; -- ���� (�б��ȣ, �����ȣ, �л���ȣ, ����)
SELECT * FROM TB_PROFESSOR; -- ���� (������ȣ, �����̸�, �����ֹι�ȣ, �����ּ�, �а���ȣ)
SELECT * FROM TB_STUDENT; -- �л� (�л���ȣ, �а���ȣ, �л��̸�, �л��ֹι�ȣ, �л��ּ�, ��������, ���п���, ����������ȣ)
----------------------------------------------------------------------------------------------------------------

------------------------------------- [Basic SELECT] -------------------------------------
/*
    1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭"���� ǥ���ϵ��� �Ѵ�.
*/
SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY AS "�迭"
FROM TB_DEPARTMENT;

/* 
    2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
    ex) ������а��� ������ 20���Դϴ�. 
*/
SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�.' AS "�а��� ����"
FROM TB_DEPARTMENT;

/*
    3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�. 
    �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
*/
SELECT DEPARTMENT_NO FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '������а�'; -- 001

SELECT STUDENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '������а�'
      AND SUBSTR(STUDENT_SSN, 8, 1) IN ('2', '4')
      AND ABSENCE_YN = 'Y';
      
/*
    4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� �Ѵ�.
    �� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
    A513079, A513090, A513091, A513110, A513119
*/
SELECT STUDENT_NAME FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY 1 DESC;

/*
     5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
*/
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

/*
    6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.
    �׷� �� ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT PROFESSOR_NAME FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

/*
    7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.
    ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
*/
SELECT * FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

/*
    8. ������û�� �Ϸ��� �Ѵ�.
    �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ� ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
*/
SELECT CLASS_NO FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

/*
    9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
*/
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY 1;

/*
    10. 02�й� ���� �����ڵ��� ������ ������� �Ѵ�. ������ ������� ������ �������� �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
*/
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(ENTRANCE_DATE, 1, 2) = '02'
      AND STUDENT_ADDRESS LIKE '%����%'
      AND ABSENCE_YN = 'N';
      
------------------------------------- [Additional SELECT - �Լ�] -------------------------------------
/*
    1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
    ( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� �Ѵ�.)
*/
SELECT STUDENT_NO AS "�й�",
       STUDENT_NAME AS "�̸�",
       TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') AS "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 3;

/*
    2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. 
    �� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����.
    (* �̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
*/
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

/*
    3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
    ��, �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�.
    (��, ���� �� 2000�� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�.
    ���̴� ���������� ����Ѵ�.)
*/
SELECT PROFESSOR_NAME AS "�����̸�",
       TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(19 || SUBSTR(PROFESSOR_SSN, 1, 6), 'RRRRMMDD')) / 12) AS "����"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 2;

/*
    4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
    ��� ����� "�̸�"�� �������� �Ѵ�. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
*/
SELECT SUBSTR(PROFESSOR_NAME, 2, 2) AS "�̸�" FROM TB_PROFESSOR;

/*
    5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�?
    �̶�, 19 �쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
*/
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))) > 19;

/*
    6. 2020 �� ũ���������� ���� �����ΰ�?
*/
SELECT TO_CHAR(TO_DATE(20201225), 'DAY') FROM DUAL;

/*
    7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�?
    �� TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�?
*/
-- TO_DATE('99/10/11','YY/MM/DD') : 2099�� 10�� 11��
-- TO_DATE('49/10/11','YY/MM/DD') : 2049�� 10�� 11��
-- TO_DATE('99/10/11','RR/MM/DD') : 1999�� 10�� 11��
-- TO_DATE('49/10/11','RR/MM/DD') : 2049�� 10�� 11��
SELECT TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD'), TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD')
FROM DUAL;

/*
    8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�.
    2000 �⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT STUDENT_NO, STUDENT_NAME FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

/*
    9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
    ��, �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
*/
SELECT ROUND(AVG(POINT), 1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

/*
    10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� ��µǵ��� �Ͻÿ�.
*/
SELECT DEPARTMENT_NO AS "�а���ȣ", COUNT(*) AS "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

/*
    11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT COUNT(*) FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

/*
    12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
    ��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�,
    ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
*/
SELECT SUBSTR(TERM_NO, 1, 4) AS "�⵵",
       ROUND(AVG(POINT), 1) AS "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

/*
    13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT DEPARTMENT_NO AS "�а��ڵ��", COUNT(DECODE(ABSENCE_YN, 'Y', 1)) AS "���л� ��"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

/*
    14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� �Ѵ�. � SQL ������ ����ϸ� �����ϰڴ°�?
*/
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) >= 2
ORDER BY 1;

/*
    15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
    (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
*/
SELECT NVL(SUBSTR(TERM_NO, 1, 4), ' ') AS "�⵵",
       NVL(SUBSTR(TERM_NO, 5, 2), ' ') AS "�б�",
       ROUND(AVG(POINT), 1) AS "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2));

------------------------------------- [Additional SELECT - Option] -------------------------------------
/*
    1. �л��̸��� �ּ����� ǥ���Ͻÿ�.
    ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�, ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
*/
SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_ADDRESS AS "�ּ���"
FROM TB_STUDENT
ORDER BY 1;

/*
    2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
*/
SELECT STUDENT_NAME, STUDENT_SSN FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

/*
    3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�.
    ��, ���������� "�л��̸�", "�й�", "������ �ּ�" �� ��µǵ��� �Ѵ�.
*/
SELECT STUDENT_NAME AS "�л��̸�",
       STUDENT_NO AS "�й�",
       STUDENT_ADDRESS AS "������ �ּ�"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '����%' OR STUDENT_ADDRESS LIKE '���%') AND STUDENT_NO NOT LIKE 'A%'
ORDER BY 1;

/*
    4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
    (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�Ƴ����� ����)
*/
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���а�'
ORDER BY 2;

/*
    5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�.
    ������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��غ��ÿ�.
*/
SELECT STUDENT_NO, TO_CHAR(POINT, 'FM90.00') AS "POINT"
FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY 2 DESC, 1;

/*
    6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL���� �ۼ��Ͻÿ�.
    * ��� ���ð� �������� ������ �Ǿ����� ���� *
*/
-->> ����Ŭ ���� ����
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO;
--ORDER BY 2;

-->> ANSI ����
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);
--ORDER BY 2;

/*
    7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
-->> ����Ŭ ���� ����
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO;

-->> ANSI ����
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

/*
    8. ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
-->> ����Ŭ ���� ����
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_PROFESSOR P, TB_CLASS_PROFESSOR CP
WHERE C.CLASS_NO = CP.CLASS_NO
      AND P.PROFESSOR_NO = CP.PROFESSOR_NO
ORDER BY C.DEPARTMENT_NO, P.PROFESSOR_NO, C.CLASS_TYPE DESC, C.CLASS_NO;

-->> ANSI ����
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP ON (C.CLASS_NO = CP.CLASS_NO)
JOIN TB_PROFESSOR P ON (P.PROFESSOR_NO = CP.PROFESSOR_NO)
ORDER BY C.DEPARTMENT_NO, P.PROFESSOR_NO, C.CLASS_TYPE DESC, C.CLASS_NO;

/*
    9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�.
    �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
-->> ����Ŭ ���� ����
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_PROFESSOR P, TB_CLASS_PROFESSOR CP, TB_DEPARTMENT D
WHERE C.CLASS_NO = CP.CLASS_NO
      AND P.PROFESSOR_NO = CP.PROFESSOR_NO
      AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
      AND CATEGORY = '�ι���ȸ'
ORDER BY C.DEPARTMENT_NO, P.PROFESSOR_NO, C.CLASS_TYPE DESC, C.CLASS_NO;

-->> ANSI ����
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP ON (C.CLASS_NO = CP.CLASS_NO)
JOIN TB_PROFESSOR P ON (P.PROFESSOR_NO = CP.PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '�ι���ȸ'
ORDER BY C.DEPARTMENT_NO, P.PROFESSOR_NO, C.CLASS_TYPE DESC, C.CLASS_NO;

/*
    10. �������а��� �л����� ������ ���Ϸ��� �Ѵ�.
    �����а� �л����� "�й�", "�л� �̸�", "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
    (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
*/
-->> ����Ŭ ���� ����
SELECT G.STUDENT_NO AS "�й�",
       STUDENT_NAME AS "�л� �̸�",
       ROUND(AVG(POINT), 1) AS "��ü ����"
FROM TB_STUDENT S, TB_GRADE G, TB_DEPARTMENT D
WHERE S.STUDENT_NO = G.STUDENT_NO
      AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
      AND DEPARTMENT_NAME = '�����а�'
GROUP BY G.STUDENT_NO, STUDENT_NAME
ORDER BY 1;

-->> ANSI ����
SELECT G.STUDENT_NO AS "�й�", STUDENT_NAME AS "�л� �̸�", ROUND(AVG(POINT), 1) AS "��ü ����"
FROM TB_STUDENT S
JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '�����а�'
GROUP BY G.STUDENT_NO, STUDENT_NAME
ORDER BY 1;

/*
    11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ� ���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�.
    �̶� ����� SQL ���� �ۼ��Ͻÿ�.
    ��, �������� '�а��̸�?, '�л��̸�?, '���������̸�?���� ��µǵ��� �Ѵ�.
*/
-->> ����Ŭ ���� ����
SELECT DEPARTMENT_NAME AS "�а��̸�",
       STUDENT_NAME AS "�л��̸�",
       PROFESSOR_NAME AS "���������̸�"
FROM TB_DEPARTMENT D, TB_STUDENT S, TB_PROFESSOR P
WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
      AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
      AND STUDENT_NO = 'A313047';

-->> ANSI ����
SELECT DEPARTMENT_NAME AS "�а��̸�",
       STUDENT_NAME AS "�л��̸�",
       PROFESSOR_NAME AS "���������̸�"
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

/*
    12. 2007 �⵵�� '�ΰ������' ������ ������ �л��� ã�� �л��̸��� �����б⸦ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
-->> ����Ŭ ���� ����
SELECT STUDENT_NAME, TERM_NO
FROM TB_STUDENT S, TB_GRADE G, TB_CLASS C
WHERE S.STUDENT_NO = G.STUDENT_NO
      AND G.CLASS_NO = C. CLASS_NO
      AND SUBSTR(TERM_NO, 1, 4) = '2007'
      AND CLASS_NAME = '�ΰ������'
ORDER BY 1;

-->> ANSI ����
SELECT STUDENT_NAME, TERM_NO
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE SUBSTR(TERM_NO, 1, 4) = '2007'
      AND CLASS_NAME = '�ΰ������'
ORDER BY 1;

/*
    13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã��
    �� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM (SELECT CLASS_NO
      FROM TB_CLASS C, TB_DEPARTMENT D
      WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO
      AND CATEGORY = '��ü��'
      MINUS
      SELECT CLASS_NO
      FROM TB_CLASS_PROFESSOR) J, TB_CLASS C, TB_DEPARTMENT D
WHERE J.CLASS_NO = C.CLASS_NO
      AND C. DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY C.DEPARTMENT_NO, C.CLASS_TYPE DESC, C.CLASS_NAME;

/*
    14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�.
    �л��̸��� �������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�.
    ��, �������� '�л��̸�?, ?��������?�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.
*/
-->> ����Ŭ ���� ����
SELECT STUDENT_NAME AS "�л��̸�", NVL(PROFESSOR_NAME, '�������� ������') AS "��������"
FROM TB_STUDENT S, TB_PROFESSOR P
WHERE COACH_PROFESSOR_NO = PROFESSOR_NO(+)
AND S.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM TB_DEPARTMENT
                       WHERE DEPARTMENT_NAME = '���ݾƾ��а�')
ORDER BY STUDENT_NO;

-->> ANSI ����
SELECT STUDENT_NAME AS "�л��̸�", NVL(PROFESSOR_NAME, '�������� ������') AS "��������"
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE S.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                         FROM TB_DEPARTMENT
                         WHERE DEPARTMENT_NAME = '���ݾƾ��а�')
ORDER BY STUDENT_NO;

/*
    15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а� �̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT G.STUDENT_NO AS "�й�",
       STUDENT_NAME AS "�̸�",
       DEPARTMENT_NAME AS "�а� �̸�",
       AVG(POINT) AS "����"
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE S.STUDENT_NO = G.STUDENT_NO
      AND D.DEPARTMENT_NO = S.DEPARTMENT_NO
      AND ABSENCE_YN = 'N'
GROUP BY G.STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0
ORDER BY 1;

/*
    16. ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT G.CLASS_NO, C.CLASS_NAME, AVG(POINT)
FROM TB_GRADE G, TB_CLASS C
WHERE C.CLASS_NO = G.CLASS_NO
AND G.CLASS_NO IN (SELECT CLASS_NO
                   FROM TB_DEPARTMENT D, TB_CLASS C
                   WHERE D.DEPARTMENT_NO = C.DEPARTMENT_NO
                   AND DEPARTMENT_NAME = 'ȯ�������а�'
                   AND CLASS_TYPE LIKE '����%')
GROUP BY G.CLASS_NO, C.CLASS_NAME
ORDER BY 1;

/*
    17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                        FROM TB_STUDENT
                        WHERE STUDENT_NAME = '�ְ���');
                        
/*
    18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT G.STUDENT_NO, S.STUDENT_NAME
FROM TB_GRADE G, TB_DEPARTMENT D, TB_STUDENT S
WHERE G.STUDENT_NO = S.STUDENT_NO
AND D.DEPARTMENT_NO = S.DEPARTMENT_NO
AND S.DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '������а�')
GROUP BY G.STUDENT_NO, STUDENT_NAME
HAVING AVG(G.POINT) = (SELECT MAX(AVG(POINT))
                       FROM TB_GRADE G, TB_STUDENT S
                       WHERE G.STUDENT_NO = S.STUDENT_NO
                       AND S.DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                              FROM TB_DEPARTMENT
                                              WHERE DEPARTMENT_NAME = '������а�')
                       GROUP BY G.STUDENT_NO);

/*
    19. �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������ �ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�.
    ��, �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ��� �Ѵ�.
*/
SELECT DEPARTMENT_NAME AS "�迭 �а���", ROUND(AVG(POINT), 1) AS "��������"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY FROM TB_DEPARTMENT
                  WHERE DEPARTMENT_NAME = 'ȯ�������а�')
AND CLASS_TYPE LIKE '����%'
GROUP BY DEPARTMENT_NAME
ORDER BY 1;

------------------------------------- [DDL] -------------------------------------
/*
    1. �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
*/
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

/*
    2. ���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
*/
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

/*
    3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
    (KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� �Ѵٸ� �̸��� ������ �˾Ƽ� ������ �̸��� ����Ѵ�.)
*/
ALTER TABLE TB_CATEGORY ADD CONSTRAINT NAME_PK PRIMARY KEY(NAME);

/*
    4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
*/
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

/*
    5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����,
    �÷����� NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
*/
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE 
    MODIFY NO VARCHAR2(10)
    MODIFY NAME VARCHAR2(20);
    
/*
    6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ� ���� ���·� �����Ѵ�.
    (ex. CATEGORY_NAME)
*/
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CATEGORY RENAME COLUMN USE_YN TO CATEGORY_USE_YN;

ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

/*
    7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ���� �����Ͻÿ�.
    Primary Key �� �̸��� 'PK_ + �÷��̸�'���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
*/
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT NAME_PK TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007134 TO PK_CLASS_TYPE_NO;

/*
    8. ������ ���� INSERT ���� �����Ѵ�.
*/
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT;

/*
    9.TB_DEPARTMENT �� CATEGORY �÷���
    TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ� ������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�.
    �� �� KEY �̸��� FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )
*/
ALTER TABLE TB_DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY;

/*
    10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� �Ѵ�.
    �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
*/
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�", STUDENT_ADDRESS AS "�ּ�"
   FROM TB_STUDENT;

/*
    11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�.
    �̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
    �̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ�
    (��, �� VIEW �� �ܼ� SELECT���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
*/
CREATE OR REPLACE VIEW VW_�������
AS SELECT STUDENT_NAME AS "�л��̸�", DEPARTMENT_NAME AS "�а��̸�", PROFESSOR_NAME AS "���������̸�"
   FROM TB_STUDENT
   LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
   LEFT JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
   ORDER BY 2;

/*
    12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
*/
CREATE OR REPLACE VIEW VW_�а����л���
AS SELECT DEPARTMENT_NAME, COUNT(STUDENT_NO) AS "STUDENT_COUNT"
   FROM TB_STUDENT
   RIGHT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
   GROUP BY DEPARTMENT_NAME
   ORDER BY 1;

/*
    13. ������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸��� ���� �̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
UPDATE VW_�л��Ϲ�����
SET �л��̸� = '������'
WHERE �й� = 'A213046';

/*
    14. 13 �������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW �� ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.
*/
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
AS SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�", STUDENT_ADDRESS AS "�ּ�"
   FROM TB_STUDENT
WITH READ ONLY;

/*
    15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ���� ������ �ǰ� �ִ�.
    �ֱ� 3 ���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������ �ۼ��غ��ÿ�. (2005����� 2009��)
*/
SELECT * FROM (SELECT CLASS_NO, CLASS_NAME, COUNT(*)
               FROM TB_GRADE
               JOIN TB_CLASS USING(CLASS_NO)
               WHERE SUBSTR(TERM_NO, 1, 4) BETWEEN 2005 AND 2009
               GROUP BY CLASS_NO, CLASS_NAME
               ORDER BY 3 DESC)
WHERE ROWNUM <= 3;

------------------------------------- [DML] -------------------------------------
/*
    1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
*/
INSERT INTO TB_CLASS_TYPE VALUES('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('02', '��������');
INSERT INTO TB_CLASS_TYPE VALUES('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES('05', '������');

/*
    2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�.
    �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
*/
CREATE TABLE TB_�л��Ϲ�����
AS SELECT STUDENT_NO AS "�й�", STUDENT_NAME AS "�л��̸�", STUDENT_ADDRESS AS "�ּ�"
   FROM TB_STUDENT;

/*
    3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� �Ѵ�.
    �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
    (��Ʈ : ����� �پ���, �ҽŲ� �ۼ��Ͻÿ�)
*/
CREATE TABLE TB_������а�
AS SELECT STUDENT_NO AS "�й�",
          STUDENT_NAME AS "�л��̸�",
          EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6))) AS "����⵵",
          PROFESSOR_NAME AS "�����̸�"
   FROM TB_STUDENT
   JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
   JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
   WHERE DEPARTMENT_NAME = '������а�';

/*
    4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�.
    (��, �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�)
*/
UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY * 1.1);

/*
    5. �й� A413042 �� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ� �Ѵ�.
    �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.
*/
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '����� ���α� ���ε� 181-21'
WHERE STUDENT_NO = 'A413042';

/*
    6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ�� �����Ͽ���.
    �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
    (��. 830530-2124663 ==> 830530 )
*/
UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

/*
    7. ���а� ����� �л��� 2005 �� 1 �б⿡ �ڽ��� ������ '�Ǻλ�����' ������ �߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���.
    ��� ������ Ȯ�� ���� ��� �ش� ������ ������ 3.5 �� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�.
*/
UPDATE TB_GRADE
SET POINT = 3.5
WHERE CLASS_NO = (SELECT CLASS_NO
                  FROM TB_CLASS
                  WHERE CLASS_NAME = '�Ǻλ�����')
AND STUDENT_NO = (SELECT STUDENT_NO
                  FROM TB_STUDENT S, TB_DEPARTMENT D
                  WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
                  AND DEPARTMENT_NAME = '���а�'
                  AND STUDENT_NAME = '�����')
AND TERM_NO = '200501';

/*
    8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�.
*/
DELETE FROM TB_GRADE
WHERE STUDENT_NO IN (SELECT STUDENT_NO FROM TB_STUDENT
                     WHERE ABSENCE_YN = 'Y');
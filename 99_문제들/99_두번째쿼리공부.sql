--DB������


------------------------------------QUIZ1--------------------------------------

-- ROWNUM�� Ȱ���ؼ� �޿��� ���� ���� 5���� ��ȸ�ϰ� �;�����, ����� ��ȸ�� �ȉ���
-- �̶� �ۼ��� SQL���� �Ʒ��� ���� 
SELECT ROWNUM, EMP_NAME, SALARY  --3
    FROM EMPLOYEE  --1
    WHERE ROWNUM <=5  --2
    ORDER BY SALARY DESC;  --4
    
-- � ������ �ִ��� �ذ�� SQL���� �ۼ�
-- ������ �Ǳ⵵ ���� ROWNUM�� �ο��� ������ 

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT *
    FROM EMPLOYEE
    ORDER BY SALARY DESC; -- => �� ������ ���̺�� ���!! (�ζ��κ�!!)
    
SELECT ROWNUM, EMP_NAME, SALARY
    FROM (SELECT *
    FROM EMPLOYEE
    ORDER BY SALARY DESC) 
    WHERE ROWNUM <=5;


SELECT ROWNUM, E.*  --ROWNUM, *�� ���� ����� �ȵ����� �̷��� ��Ī�� �ο��ϸ� �����ϴ�
    FROM (SELECT *
    FROM EMPLOYEE
    ORDER BY SALARY DESC) E 
    WHERE ROWNUM <=5;

----------------------------------QUIZ2-----------------------------------
--�μ��� ��ձ޿��� 270������ �ʰ��ϴ� �μ��鿡 ���� (�μ��ڵ�,�μ����ѱ޿���,�μ�����ձ޿�,�μ��������)
--�� �� �ۼ��� SQL���� ������ ����

SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο��� --4
    FROM EMPLOYEE --1
    
    GROUP BY DEPT_CODE --2
    HAVING AVG(SALARY) >2700000 --�׷� �Լ��� ������(AVG()) ���� ���� WHERE����
    --����ϴ°��� �Ұ����ϴ�. HAVING���� ���ؾ���. --3
    ORDER BY 1; --5


---------------------------------------QUIZ3----------------------------------
--������ ��� 
--JOIN�� ����(��������, �ܺ����� ���) �� Ư¡, ����
--�����������ͺ��̽����� ���������� ���� �����͸� ��������°� JOIN��

--�Լ�����(TRIM) �׳� �Լ� �� ���ƺ���

-- ������ �޿� ��ȸ �� �� ���޺� �λ��ؼ� ��ȸ 
-- J7�� ����� �޿��� 10% �λ� (SALARY * 1.1)
-- J6�� ����� �޿� 15% �λ�(SALARY*1.15)
-- J5�� ����� �޿� 20% �λ�(SALARY*1.2)
-- �� ���� ����� �޿��� 5% �λ�(SALARY * 1.05)

SELECT EMP_NAME, JOB_CODE, SALARY, DECODE(JOB_CODE, 'J7', SALARY*1.1,
                                                    'J6', SALARY*1.15,
                                                    'J5', SALARY*1.2,
                                                    SALARY * 1.05)
FROM EMPLOYEE;

-- '24/06/24' �� ���� ���ڿ��� ������ '2024-06-24'�� ǥ���غ���
-- ���ڿ� => ��¥Ÿ�� => ���ڿ� 
SELECT TO_CHAR(TO_DATE('24/06/24'),'YYYY-MM-DD' ) 
FROM DUAL;

-- '230908' ���� ���ڿ��� ������ 2023�� 9�� 8�� ǥ�� -- 09�� 08���� �ƴ� (���۸� ����!!)

SELECT  TO_CHAR(TO_DATE('230908'), 'FMYYYY"��" MM"��" DD"��"')
FROM DUAL;

-- OR SUBSTR�� �̿��� �������
SELECT SUBSTR(TO_CHAR(TO_DATE('230908'), 'YYYY"��" MM"��" DD"��"'), 1, 6)
     || SUBSTR(TO_CHAR(TO_DATE('230908'), 'YYYY"��" MM"��" DD"��"'), 8, 3)
     || SUBSTR(TO_CHAR(TO_DATE('230908'), 'YYYY"��" MM"��" DD"��"'), 12, 2)     
FROM DUAL;




























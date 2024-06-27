/*
1.�Ʒ��� SQL������ �μ� �� ��� ������ 2800000�� �ʰ��ϴ� �μ��� ��ȸ�� ���̴�.
����� �ùٸ��� �ʴٰ� �� ��, �� ����(20��)�� �ùٸ��� ������ ��ġ����(20��)�� ���� �׸� �°� ����Ͻÿ�. (�� 40��)
*/

SELECT DEPT, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMP  
HAVING AVG(SAL)>2800000
GROUP BY DEPT 
ORDER BY DEPT ASC; 

SELECT JOB, SUM(SAL), FLOOR(AVG(SAL)), COUNT(*)
FROM EMP  
WHERE SAL > 2800
GROUP BY JOB 
ORDER BY JOB ASC;

SELECT JOB, SUM(SAL), FLOOR(AVG(SAL)), COUNT(*)
FROM EMP  
HAVING AVG(SAL)>2800
GROUP BY JOB 
ORDER BY JOB ASC; 
/*����
1. �� ������ WHERE���� ���ؼ� ������ �ۼ��߱� ������ �μ��� ������ 2800000�� �Ѵ� ����鸸 �μ��� ��� ����ϰ� �ֱ� ������
��µǴ� �μ��� �ٸ��� �μ��� �ο����� ������ 280������ �Ѵ� �ο��� COUNT�Ѵ�.
*/
/*��ġ����
1. ������ WHERE SALARY > 2800000 
    -> HAVING AVG(SAL)>2800000 ���� ����.
    DEPT�׷��� SAL(����)�� AVG(���)�� 2800000�� �Ѵ� �μ����� ��µǵ��� ������ �����Ѵ�

    SELECT DEPT, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
    FROM EMP  
    HAVING AVG(SAL)>2800000
    GROUP BY DEPT 
    ORDER BY DEPT ASC; 


*/


/*
ROWNUM�� �̿��ؼ� ������ ���� ���� 3���� �������� �Ͽ�����, �ùٸ� ����� ��ȸ ���� �ʾҴ�.
����� �߸� ��ȸ�� ������ [����](30��)�� ����ϰ�, �Ʒ��� ������ �����Ͽ� [��ġ����](30��)�� ����Ͻÿ�. (�� 60��)

[SQL����]
*/

SELECT ROWNUM, EMPNAME, SAL
FROM EMP
WHERE ROWNUM <= 3
ORDER BY SAL DESC;

SELECT ROWNUM, ENAME, SAL --3
FROM EMP --1
WHERE ROWNUM <= 3 --2
ORDER BY SAL DESC; --4

--�� ������ ���������
--1. FROM EMP
--2. WHERE ROWNUM<=3
--3. SELECT ROWNUM,EMPNAME,SAL
--4. ORDER BY SAL DESC ��

-- EMP���̺��� ���� ���� ���� ���� ������ 3���� ROWNUM, EMPNAME, SAL�� ����ϸ�
-- �� ����� �����ϴ� ���̱� ������ �ùٸ� ����� ��µ��� �ʴ´�.
-- ORDER BY �� ������ ������ �������� ����ǹǷ� �ҷ��� �� �̹� ���ĵ� ���·� ����� �ξ�� �Ѵ�.

--�ҷ��� ����
SELECT EMPNAME, SAL 
 FROM EMP
 ORDER BY SAL DESC 

SELECT ROWNUM, EMPNAME, SAL
FROM     �� ������ �Է��ؾ���

FROM DUAL;
--   ->
SELECT ROWNUM, ENAME, SAL
FROM 
(SELECT ENAME, SAL 
 FROM EMP
 ORDER BY SAL DESC)
 WHERE ROWNUM<=3;
 
 
SELECT ROWNUM, ENAME, SAL
FROM EMP
WHERE ROWNUM <= 3
ORDER BY SAL DESC;



/*����

*/

/*��ġ����

*/





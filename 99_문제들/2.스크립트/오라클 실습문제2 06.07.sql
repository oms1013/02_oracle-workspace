--SCOTT_�������� 
--1. EMP���̺��� COMM �� ���� NULL�� �ƴ� ���� ��ȸ 
SELECT *
FROM EMP
WHERE NOT COMM IS NULL;
--WHERE NOT COMM;

--2. EMP���̺��� Ŀ�̼��� ���� ���ϴ� ���� ��ȸ 
SELECT ENAME
FROM EMP
WHERE COMM IS NULL;

--3. EMP���̺��� �����ڰ� ���� ���� ���� ��ȸ 
SELECT *
FROM EMP
WHERE MGR IS NULL;



--4. EMP���̺��� �޿��� ���� �޴� ���� ������ ��ȸ 
SELECT *
FROM EMP
ORDER BY SAL DESC;



--5. EMP���̺��� �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ 
SELECT *
FROM EMP
ORDER BY COMM, SAL DESC; 



--6. EMP���̺��� �����ȣ, �����,����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��) 
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE;


--7. EMP���̺��� �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����) 
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO DESC;

--8. EMP���̺��� ���, �Ի���, �����, �޿� ��ȸ  
--(�μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��� ������ ó��) 
SELECT EMPNO, HIREDATE, ENAME, SAL, DEPTNO
FROM EMP
ORDER BY DEPTNO, HIREDATE;


--9. ���� ��¥�� ���� ���� ��ȸ 
SELECT SYSDATE FROM DUAL;



--10. EMP���̺��� ���, �����, �޿� ��ȸ  
--(��, �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����) 
SELECT EMPNO, ENAME, TRUNC(SAL, -2) AS "�޿�"
FROM EMP
ORDER BY SAL DESC;


--11. EMP���̺��� �����ȣ�� Ȧ���� ������� ��ȸ 
SELECT *
FROM EMP;
--WHERE  MOD(EMPNO, 2) 
---���̰�!!


--12. EMP���̺��� �����, �Ի��� ��ȸ (��, �Ի����� �⵵�� ���� �и� �����ؼ� ���) 
SELECT ENAME, SUBSTR(   (EMP_NO)   ,1,2)
FROM EMP


--13. EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ 



--14. EMP���̺��� 81�⵵�� �Ի��� ���� ��ȸ 



--15. EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ 



--16. EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ 



--16-1. LIKE ��� 



--16-2. SUBSTR() �Լ� ��� 



--17. EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ 



--18. EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ 


--19. ���� ��¥���� �⵵�� ���� 

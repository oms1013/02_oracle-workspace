/*
1.아래의 SQL구문은 부서 별 평균 월급이 2800000을 초과하는 부서를 조회한 것이다.
결과가 올바르지 않다고 할 때, 그 원인(20점)과 올바르게 수정한 조치사항(20점)을 각각 항목에 맞게 기술하시오. (총 40점)
*/

SELECT DEPT, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
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
/*원인
1. 현 구문은 WHERE절을 통해서 구문을 작성했기 때문에 부서별 월급이 2800000을 넘는 사람들만 부서에 모아 출력하고 있기 때문에
출력되는 부서도 다르고 부서의 인원수도 월급이 280만원을 넘는 인원만 COUNT한다.
*/
/*조치내용
1. 기존의 WHERE SALARY > 2800000 
    -> HAVING AVG(SAL)>2800000 으로 변경.
    DEPT그룹의 SAL(월급)의 AVG(평균)이 2800000을 넘는 부서만이 출력되도록 구문을 변경한다

    SELECT DEPT, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
    FROM EMP  
    HAVING AVG(SAL)>2800000
    GROUP BY DEPT 
    ORDER BY DEPT ASC; 


*/


/*
ROWNUM을 이용해서 월급이 가장 높은 3명을 뽑을려고 하였으나, 올바른 결과가 조회 되지 않았다.
결과가 잘못 조회된 이유를 [원인](30점)에 기술하고, 아래의 구문을 수정하여 [조치내용](30점)에 기술하시오. (총 60점)

[SQL구문]
*/

SELECT ROWNUM, EMPNAME, SAL
FROM EMP
WHERE ROWNUM <= 3
ORDER BY SAL DESC;

SELECT ROWNUM, ENAME, SAL --3
FROM EMP --1
WHERE ROWNUM <= 3 --2
ORDER BY SAL DESC; --4

--현 구문의 실행순서는
--1. FROM EMP
--2. WHERE ROWNUM<=3
--3. SELECT ROWNUM,EMPNAME,SAL
--4. ORDER BY SAL DESC 로

-- EMP테이블에서 조건 없이 가장 먼저 나오는 3명의 ROWNUM, EMPNAME, SAL를 출력하며
-- 그 결과를 정렬하는 것이기 때문에 올바른 결과가 출력되지 않는다.
-- ORDER BY 는 무조건 구문의 마지막에 실행되므로 불러올 때 이미 정렬된 상태로 만들어 두어야 한다.

--불러올 정도
SELECT EMPNAME, SAL 
 FROM EMP
 ORDER BY SAL DESC 

SELECT ROWNUM, EMPNAME, SAL
FROM     이 구문에 입력해야함

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



/*원인

*/

/*조치내용

*/





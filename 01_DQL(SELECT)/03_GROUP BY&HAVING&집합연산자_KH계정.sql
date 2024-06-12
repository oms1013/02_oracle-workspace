
/*

        < GROUP BY 절 > 
        그룹 기준을 제시할 수 있는 구문 (해당 그룹기준별로 여러 그룹을 묶을 수 있음) 
        여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용 

*/

SELECT SUM(SALARY)
FROM EMPLOYEE; --> 전체 사원을 하나의 그룹으로 묶어서 총합을 구한 결과

-- 각 부서별 총 급여 합

SELECT DEPT_CODE, SUM(SALARY) --  
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 사원 수
SELECT DEPT_CODE, COUNT(*), SUM(SALARY) --
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY) --3
FROM EMPLOYEE --1 
GROUP BY DEPT_CODE --2
ORDER BY DEPT_CODE; --4
--ORDER BY절은 항상 마지막에 입력해야함

SELECT DISTINCT JOB_CODE --DISTINCT, 중복값 제거
FROM EMPLOYEE;

SELECT JOB_CODE, COUNT(*), SUM(SALARY) --3
FROM EMPLOYEE --1
GROUP BY JOB_CODE --2
ORDER BY JOB_CODE; --4

--각 직급별  총 사원수, 보너스를 받는 사원 수, 급여 합, 평균 급여, 최저급여, 최대급여
SELECT DEPT_CODE, COUNT(*) AS "총 사원 수", COUNT(BONUS) AS "보너스 받는 사원수",
                SUM(SALARY) AS "급여 합", FLOOR(AVG(SALARY)) AS "평균 급여", 
                MIN(SALARY) AS "최저급여", MAX(SALARY) AS "최대 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE;
ORDER BY 1;
--공식데로 작성하지 않으면 GROUP BY 출력 에러가 나옴
-- EX) GROUP BY 'DEPT_CODE'인데 SELECT에선 'DEPT_CODE'가 아닌 다른 이름을 씀

--GROUP BY 절에 함수도 기술할 수 있음
SELECT DECODE(SUBSTR(EMP_NO, 8,1), '1',  '남',  '2', '여'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO, 8, 1);

--GROUP BY절에 여러 컬럼을 기술할 수 있다. 
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;

--------------------------------------------------

/*
    < HAVING 절 >
    그룹에 대한 조건을 제시할 때 사용되는 구문 (주로 그룹함수식을 가지고 조건을 제시할 때 사용)
*/

--각 부서별 평균 급여 조회(부서 코드, 평균 급여) 
SELECT DEPT_CODE, TRUNC(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE --1
WHERE AVG(SALARY)>=3000000 --오류 발생, AVG(SALARY)가 불가.
--그룹함수여서 WHERE절에 쓸 수 없다. SALARY가 아니라 AVG가 불가능 --2
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000; 
--WHERE 절은 전체 데이터에 대한 조건, HAVING절은 그룹에 대한 조건이다.
-- 그룹에 대해 조건을 걸거면 HAVING절을 쓰는게 맞음 
-- WHERE를 사용 못하는게 아님, AVG처럼 그룹함수를 GROUP BY랑 함께 못쓰는것

--직급별 총 급여합(단,직급별 급여합이 1000만원 이상인 직급만을 조회)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;
HAVING SUM(SALARY) >=10000000;

--부서별 보너스를 받는 사원이 없는 부서만을 조회 부서코드만 조회(HAVING써서)
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;
----------------------------------------------------------------------
/*
    < SELECT 문 실행 순서 >  ☆
    5.SELECT * | 조회하고자 하는 컬럼 | 산술식 "별 칭()" | 함수식 AS "별칭" 
    1.FROM 조회하고자 하는 테이블명
    2.WHERE 조건식 (연산자들을 가지고 기술) 
    3.GROUP BY 그룹기준으로 삼을 컬럼 | 함수식
    4.HAVING 조건식(그룹함수를 가지고 기술해야함) 
    6.ORDER BY 컬럼명|별칭|순번 [ASC|DESC] [NULLS FIRST|NULLS LAST]
*/
--------------------------------------------------------------------
/*
    < 집계 함수 > 
    그룹별 산출된 결과값에 중간 집계를 계산해주는 함수 
    
    ROLL UP 
    => GROUP BY 절에 기술하는 함수 
    GROUPY BY로 묶인 함수의 합계를 출력하려고 할 때 사용한다. 
*/

--각 직급별로 급여의 합 
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1; 

--ROLLUP : 중간 집계를 내는 함수 


----------------------------------------------------------------
/*
        < 집합 연산자 == SET OPERATION >
        
        여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자 
        
        - UNION         : OR | 합집합 ( 두 쿼리문 수행한 결과값을 더한 후 중복되는
                            값은 한번만 더해지도록 함) 
        - INTERSERCT    : AND | 교집합 ( 두 쿼리문 수행한 결과값에 중복되는 결과값 
        - UNION ALL     : 합집합+교집합 ( 중복되는 부분이 두번 표현될 수 있음)
        - MINUS         : 차집합 (선행 결과값에서 후행 결과값을 뺀 나머지) 
*/

-- 1. UNION 
-- 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원들 조회 (사번,이름,부서코드,급여)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE  DEPT_ CODE = 'D5'; 
--6개행(박나라, 하이유, 김해술, 심봉선, 윤은해,대북혼) 

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY >3000000; 
--8개행(선동일,송종기,노홍철,유재식,정중하,심봉선,대북혼,전지연)

--1. UNION(합집합) 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY >3000000; 
--두 결과값 8+6-2(겹치는 부분) 
--12개 행이 출력된다. 

--위의 쿼리문 대신 WHERE절에 OR를 써도 해결이 가능함.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' OR SALARY>3000000;

-- 2. INTERSECT(교집합) 
-- 부서코드가 D5이면서도 급여까지도 300만원 초과인 사원 조회 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY >3000000; 
--두 조건을 다 만족하는 2개 행 출력 

--마찬가지로 AND를 사용해서 만들 수 있음
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' AND SALARY>3000000;

---------------------------------------------------------
--집합연산자 유의 사항 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY >3000000;
/* 각 쿼리문의 SELECT절에 작성되어 있는 컬럼 개수가 동일해야 한다. 
ORA-01789: query block has incorrect number of result columns
01789. 00000 -  "query block has incorrect number of result columns"
*Cause:    
*Action:

*/


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >3000000;
/* 컬럼 개수 뿐 아니라 각 컬럼 자리마다 동일한 '타입'으로 기술해야 한다.
ORA-01789: query block has incorrect number of result columns
01789. 00000 -  "query block has incorrect number of result columns"
*Cause:    
*Action:

*/


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
--ORDER BY EMP_NAME 두번 쓰면 오류 발생
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE SALARY >3000000
ORDER BY EMP_NAME;
--두 타입을 맞춰도 작동하긴 하지만 SALARY랑 BONUS가 이상하게 섞여버린다
--결국 작동만 하지 쓸 이유가 없음

--또한 ORDER BY는 한 쿼리당 한번만 사용이 가능함
--마지막에 한번만 기술해야함

----------------------------------------------------------------

--3. UNION ALL : 여러 쿼리의 결과를 무조건 다더함. 즉 합집합+겹친부분 추가(중복값나옴)
--
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;
--그냥 유니온에서 겹친부분만 한번 더 출력됨

--4. MINUS : 선행 SELECT 결과에서 후행 SELECT한 결과를 뺀 나머지
--부서코드가 D5인 사원들 중 급여가 300만원초과한 사원들은 제외해서 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >3000000;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D5' and SALARY <= 3000000;
--이렇게도 가능은 함


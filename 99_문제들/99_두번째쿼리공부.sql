--DB시험대비


------------------------------------QUIZ1--------------------------------------

-- ROWNUM을 활용해서 급여가 가장 높은 5명을 조회하고 싶었으나, 제대로 조회가 안됬음
-- 이때 작성된 SQL문이 아래와 같음 
SELECT ROWNUM, EMP_NAME, SALARY  --3
    FROM EMPLOYEE  --1
    WHERE ROWNUM <=5  --2
    ORDER BY SALARY DESC;  --4
    
-- 어떤 문제가 있는지 해결된 SQL문을 작성
-- 정렬이 되기도 전에 ROWNUM이 부여된 상태임 

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT *
    FROM EMPLOYEE
    ORDER BY SALARY DESC; -- => 이 구문을 테이블로 사용!! (인라인뷰!!)
    
SELECT ROWNUM, EMP_NAME, SALARY
    FROM (SELECT *
    FROM EMPLOYEE
    ORDER BY SALARY DESC) 
    WHERE ROWNUM <=5;


SELECT ROWNUM, E.*  --ROWNUM, *는 같이 사용이 안되지만 이렇게 별칭을 부여하면 가능하다
    FROM (SELECT *
    FROM EMPLOYEE
    ORDER BY SALARY DESC) E 
    WHERE ROWNUM <=5;

----------------------------------QUIZ2-----------------------------------
--부서별 평균급여가 270만원을 초과하는 부서들에 대해 (부서코드,부서별총급여합,부서별평균급여,부서별사원수)
--이 때 작성된 SQL문은 다음과 같음

SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수 --4
    FROM EMPLOYEE --1
    
    GROUP BY DEPT_CODE --2
    HAVING AVG(SALARY) >2700000 --그룹 함수를 가지고(AVG()) 비교할 때는 WHERE절을
    --사용하는것이 불가능하다. HAVING으로 비교해야함. --3
    ORDER BY 1; --5


---------------------------------------QUIZ3----------------------------------
--서술형 대비 
--JOIN의 종류(내부조인, 외부조인 등등) 별 특징, 역할
--관계형데이터베이스에서 가지고있지 않은 데이터를 가지고오는게 JOIN임

--함수종류(TRIM) 그냥 함수 쓱 돌아보자

-- 직원의 급여 조회 시 각 직급별 인상해서 조회 
-- J7인 사원은 급여를 10% 인상 (SALARY * 1.1)
-- J6인 사원은 급여 15% 인상(SALARY*1.15)
-- J5인 사원은 급여 20% 인상(SALARY*1.2)
-- 그 외의 사원은 급여를 5% 인상(SALARY * 1.05)

SELECT EMP_NAME, JOB_CODE, SALARY, DECODE(JOB_CODE, 'J7', SALARY*1.1,
                                                    'J6', SALARY*1.15,
                                                    'J5', SALARY*1.2,
                                                    SALARY * 1.05)
FROM EMPLOYEE;

-- '24/06/24' 와 같은 문자열을 가지고 '2024-06-24'로 표현해보기
-- 문자열 => 날짜타입 => 문자열 
SELECT TO_CHAR(TO_DATE('24/06/24'),'YYYY-MM-DD' ) 
FROM DUAL;

-- '230908' 같은 문자열을 가지고 2023년 9월 8일 표현 -- 09월 08일이 아님 (구글링 가능!!)

SELECT  TO_CHAR(TO_DATE('230908'), 'FMYYYY"년" MM"월" DD"일"')
FROM DUAL;

-- OR SUBSTR를 이용한 강제출력
SELECT SUBSTR(TO_CHAR(TO_DATE('230908'), 'YYYY"년" MM"월" DD"일"'), 1, 6)
     || SUBSTR(TO_CHAR(TO_DATE('230908'), 'YYYY"년" MM"월" DD"일"'), 8, 3)
     || SUBSTR(TO_CHAR(TO_DATE('230908'), 'YYYY"년" MM"월" DD"일"'), 12, 2)     
FROM DUAL;




























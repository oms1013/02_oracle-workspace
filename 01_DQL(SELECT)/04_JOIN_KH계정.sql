/*
    < JOIN >  
    두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    조회 결과는 하나의 결과물(RESULT SET)로 나옴 
    
    관계형 데이터베이스 최소한의 데이터로 각각의 테이블에 데이터를 담고 있음 
    (중복을 최소화 하기 위해 최대한 쪼개서 관리함.)
    
    -- 어떤 사원이 어떤 부서에 속해있는지 궁금함! 코드 말고 이름으로.. 
    
    => 관계형 데이터베이스에서 SQL문을 이용한 테이블간에 "관계"를 맺는 방법 
    (무작정 다 조회해오는게 아니라 각 테이블간 연결고리로써의 데이터를 매칭시켜서 조회해야함)

    JOIN은 크게 "오라클 전용 구문"과 "ANSI 구문" (ANSI == 미국국립표준협회) 
    => 아스키코드표를 만드는 단체 
    
                            [JOIN 용어 정리] 
    오라클 전용 구문                   |                   ANSI 구문
-------------------------------------------------------------------------
        등가조인                      |     내부 조인([INNER] JOIN) 
    (EQUAL JOIN)                    |     자연 조인(NATURAL JOIN)
-------------------------------------------------------------------------
       포괄 조인                      |    왼쪽 외부조인(LEFT OUTER JOIN
      (LEFT JOIN)                    |    오른쪽 외부조인(RIGHT OUTER JOIN)
    (RIGHT JOIN)                     |    전체 외부조인(FULL OUTER JOIN)
-------------------------------------------------------------------------
   자체 조인(SELF JOIN)                |
  비등가 조인(NON EQUAL JOIN)          |     

    */

--전체 사원들의 사번, 사원명, 부서코드, 부서명을 조회하고자 할 때 
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 전체 사원들의 사번, 사원명, 직급코드, 직급명 조회하고자 할 때
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    1. 등가 조인(EQUAL JOIN) / 내부 조인(INNTER JOIN) 
       연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회 (==일치하는 값이 없는
       행은 조회에서 제외된다.) 
*/

-->> 오라클 전용 구문 
--   FROM절에 조회하고자 하는 테이블들을 나열 (, 구분자로) 
--   WHERE 절에 매칭시킬 컬럼(연결고리)에 대한 조건을 제시함 
-- 
-- 1) 연결한 두 컬럼명이 다른경우 (EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
-- 사번, 사원명, 부서코드, 부서명 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT --WHERE절이 없을 시 오류가 나지는 않지만 데이터가
--이상하게 출력됨. 연결고리가 없어서
WHERE DEPT_CODE = DEPT_ID;
--> 일치하는 값이 없는 행은 조회에서 제외된 것을 확인할 수 있음 
-- DEPT_CODE가 NULL인 사원은 조회되지 않음, DEPT_ID D3,D4,D7 조회 X

--2) 연결한 두 컬럼명이 같은 경우 
--사번, 사원명, 직급코드, 직급명 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE= JOB_CODE;
-- ambiguously : 애매하다, 모호하다. 

-- 1)해결방법 : 테이블명을 이용하는 방법 ☆ 
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
--JOB_CODE=JOB_CODE가 뭐가 뭔지 이해를 못하니 각 테이블명. 을 붙여서
--이해할 수 있게 만들고 SELECT에서도 뭘 출력해야 하는지 모르지만
--둘다 같은 JOB_CODE기때문에 아무거나 앞에 붙여줌


-- 2)해결방법 : 테이블에 별칭을 부여해서 이용하는 방법
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
--위랑 원리는 비슷함



-- >> ANSI구문
-- FROM절에 기준이 되는 테이블 하나 기술한 후 
-- JOIN절에 같이 조회하고자 하는 테이블 기술 + 매칭 
-- JOIN USING, JOIN ON 

--1) 연결할 두 컬럼명이 다른 경우(EMPLOYEE : DEPT_CODE, DEPARTMENT : DEPT_ID)
--오로지 JOIN ON 구문으로만 가능하다 
--사번, 사원명, 부서코드, 부서명 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE 
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID); 


-- 2) 연결한 두 컬럼의 이름이 같은 경우 
-- JOIN ON, JOIN USING 구문도 사용 가능! 
-- 사번, 사원명, 직급코드, 직급명 조회 


--해결방법 1) 테이블명 또는 별칭을 이용해서 하는 방법 
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E 
JOIN JOB J ON (E.JOB_CODE=J.JOB_CODE);

--해결방법 2) JOIN USING을 사용하는 방법( 두 컬럼명이 일치할 때만 사용가능) 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE);


--[참고사항]--
--자연 조인(NATURAL JOIN) : 각 테이블에 동일한 컬럼이 한 개만 존재할 경우 
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME 
FROM EMPLOYEE
NATURAL JOIN JOB;
--이 경우 다 되는 것이 아니고 각 테이블당 같은 컬럼이 한개만 있어야 가능하다.

--직급이 대리인 사원의 이름, 직급명, 급여 조회

--오라클 전용 구문
SELECT EMP_NAME, JOB_NAME, SALARY 
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
AND J.JOB_NAME = '대리';

--ANSI전용구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

---------------------------------실습--------------------------------
--1. 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회

--오라클 구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND DEPT_TITLE = '인사관리부';

-- ANSI구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';


--2.DEPARTMENT와 LOCATION를 참고해서 전체 부서의 부서코드, 부서명, 지역코드
--오라클 구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE
FROM DEPARTMENT , LOCATION 
WHERE LOCATION_ID = LOCAL_CODE;

--D LOCATION ID= L LOCATION CODE

--ANSI 구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE
FROM DEPARTMENT
JOIN LOCATION ON (LOCAL_CODE=LOCATION_ID);


--3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회

--오라클 구문
SELECT EMP_NO, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE , DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;


--ANSI구문
SELECT EMP_NO, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE BONUS IS NOT NULL;

--4.부서가 총무부가 아닌 사원들의 사원명, 급여, 부서명 조회
--오라클구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE != '총무부';


--ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE !='총무부';

-- 지금 현재 DEPT_CODE가 NULL인것은 출력되지 않음.
-- DEPT_TITLE에 NULL값에 대응하는 값이 존재하지 않기 때문 

-------------------------------------------------------------
/*
    2. 포괄 조인 / 외부 조인 (OUTER JOIN) 
    두 테이블 간에 JOIN시 일치하지 않는 행도 포함시켜서 조회 가능 
    단, 반드시 LEFT / RIGHT 지정해야함!! (기준이 되는 테이블 지정) 
*/

--외부 조인과 비교할만한 INNER JOIN 조회해두기! 
-- 월급주기 
-- 사원명, 부서명, 급여, 연봉 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--현재 부서배치가 되지 않은 인원 2명이 조회되지 않음
--부서에 배정된 사원이 없는 부서같은 경우도 조회 X 


--1) LFTT OUTER JOIN : 두 테이블 중 왼편에 기술된 테이블 기준으로 JOIN
-- >> ANSI 구문 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);
--LEFT기때문에 EMPLOYEE의 모든 데이터를 출력한다. 
-- 아까 NULL값을 출력한 2명의 데이터도 포함


-->> 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID(+); 
-- 기준으로 삼고자 하는 테이블의 반대편 컬럼 뒤에 (+) 붙이기. OUTER JOIN




-- 2) RIGHT [OUTER] JOIN : 두 테이블 중에서 오른쪽을 기준으로 JOIN
--ANSI구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); 

-- >> 오라클 전용 구문 
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;



--3) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회 할 수 있음.
--(단, 오라클 전용 구문으로는 안됨)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


-------------------------------------------------------------------

/*
    3. 비등가 조인(NON EQUAL JOIN) => 얘는 그냥 참고용 
    매칭시킬 컬럼에 대한 조건 작성시 '=(등호)' 를 사용하지 않는 조인문
    ANSI 구문으로는 JOIN ON만 사용 가능! 
*/

SELECT EMP_NAME, SALARY, SAL_LEVEL 
FROM EMPLOYEE;

SELECT SAL_LEVEL, MIN_SAL, MAX_SAL
FROM SAL_GRADE; 

-- 사원명, 급여, 최대 월급 한도 
--오라클 전용 구문 1 
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE E,  SAL_GRADE S
WHERE E.SAL_LEVEL = S.SAL_LEVEL;


--2 
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE ,  SAL_GRADE 
WHERE SALARY >=MIN_SAL AND SALARY<=MAX_SAL
AND SALARY BETWEEN MIN_SAL AND MAX_SAL;
--이렇게 사용하는게 가능은 하다


--ANSI구문, 참고만
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE 
JOIN SAL_GRADE ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);

--------------------------------------------------------
/*   //☆☆☆
    4.자체 조인 (SELF JOIN)
    같은 테이블을 다시 한번 조인하는 경우 
*/

-- 전체 사원의 사번, 사원명, 사원부서코드 => EMPLOYEE 
--     사수의 사번, 사수명, 사수부서코드 => EMPLOYEE

--> 오라클 전용 구문
SELECT E.EMP_ID "사원사번", E.EMP_NAME "사원명", E.DEPT_CODE "사원부서코드", 
    M.EMP_ID "사수사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수부사코드"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID; 

-- >>ANSI 구문
SELECT E.EMP_ID "사원사번", E.EMP_NAME "사원명", E.DEPT_CODE "사원부서코드", 
       M.EMP_ID "사수사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수부사코드"
FROM EMPLOYEE E 
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID=M.EMP_ID);


--------------------------------------------------------------
/*
    < 다중 조인 > 
    2개 이상의 테이블을 가지고 JOIN할 때 
*/

-- 사번, 사원명, 부서명, 직급명 조회 

SELECT * FROM EMPLOYEE; -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB;        -- JOB_CODE

-->오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;

-->>
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID) 
JOIN JOB USING(JOB_CODE); --이름이 같으면 USING을 쓰는게 나음
--JOIN은 여러번 사용할 수 있음

-- 사번, 사원명, 부서명, 지역명
SELECT * FROM EMPLOYEE; --DEPT_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID LOCATION_ID 
SELECT * FROM LOCATION; --           LOCAL_CODE

SELECT EMP_NO, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION 
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE; 

--> ANSI구문 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

---------------------------실습문제----------------------------
--1.사번, 사원명, 부서명, 지역명, 국가명 조회 (EMP, DEP, LOC, NATIONAL)

--오라클
SELECT * FROM DEPARTMENT;         --  LOCATION_ID
SELECT * FROM EMPLOYEE;--   
SELECT * FROM LOCATION; --    COLUMN_ID
SELECT * FROM NATIONAL; --      COLUMN_ID 
-- LOCATION   
-- NATIONAL              

SELECT EMP_NO, EMP_NAME, L.LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, LOCATION L, DEPARTMENT, NATIONAL N
WHERE DEPT_ID = DEPT_CODE --DEP, EMP
AND LOCATION_ID = LOCAL_CODE -- DEP, LOC
AND L.NATIONAL_CODE = N.NATIONAL_CODE; --LOC, NAT

--ANSI
SELECT EMP_NO, EMP_NAME, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE =DEPT_ID )
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);

--2.사번, 사원명, 부서명, 직급명, 지역명, 국가명, 해당 급여 등급에서 받을 수 있는
-- 최대 금액 조회(모든테이블 조인) 

--오라클
SELECT * FROM EMPLOYEE;--    DEPT_ CODE            JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID     LOCATION_ID  
SELECT * FROM JOB; --                              JOB_CODE            
SELECT * FROM LOCATION; --              LOCATION_CODE      NATIONAL_CODE 
SELECT * FROM NATIONAL; --                                  NATIONAL_CODE
 
SELECT EMP_NO, EMP_NAME, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, 
 MAX_SAL
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND D.LOCATION_ID = L.LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.SAL_LEVEL = S.SAL_LEVEL;

--ANSI
SELECT EMP_NO, EMP_NAME, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, MAX_SAL
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
JOIN JOB USING (JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL N USING(NATIONAL_CODE)
JOIN SAL_GRADE S USING(SAL_LEVEL);


--3. 

























































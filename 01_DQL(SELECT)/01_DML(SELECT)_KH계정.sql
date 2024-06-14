/*
    < SELECT >
    데이터를 조회할 때 사용하는 구문
    
    >> RESULT SET : SELECT문을 통해서 조회된 결과물 (즉, 조회된 행들의 집합)
    
    [표현법] 
    SELECT 조회하고자 하는 컬럼1, 컬럼2, ...
    FROM 테이블명;
    
    * 당연히 반드시 존재하는 컬럼으로 써야 한다. 없는 컬럼 쓰면 오류남 

*/

-- EMPLOYEE 테이블의 모든 컬럼(*) 조회
-- SELECT EMP_ID, EMP_NAME, EMP_NO,  ...
--SELECT *
--FROM EMPLOYEE;

-- EMPLOYEE 테이블의 사번, 이름, 급여 조회
--SELECT EMP_ID, EMP NAME, SALAY
SELECT *
FROM EMPLOYEE; 

-- JOB 테이블의 모든 컬럼 조회
SELECT *
FROM JOB; 

----------------------------실습문제----------------------------------
--1. JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

--2. DEPARTMENT 테이블의 모든 컬럼
SELECT *
FROM DEPARTMENT;

--3. DEPARTMENT 테이블의 부서코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
--4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME,EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
  <컬럼값을 통한 산술연산>
  SELECT 컬럼명 작성 부분에 산술연산 기술 가능(이때, 산술연산된 결과 조회
*/

--EMPLOYEE 테이블의 사원명, 사원의 연봉(급여 * 12) 조회
SELECT EMP_NAME, SALARY *12
FROM EMPLOYEE;

--EMPLOYEE 테이블의 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

--EMPLOYEE테이블의 사원명, 급여, 보너스, 연봉
SELECT EMP_NAME, SALARY, BONUS, (SALARY+(SALARY*BONUS)) *12
FROM EMPLOYEE;

--> 산술 연산 과정 중 NULL값이 존재할 경우 산술연산 결과값마저도 NULL이 출력된다. 

-- EMPLOYEE에 사원명, 입사일, 근무일수(오늘 날짜 - 입사일)
-- DATE형식끼리도 연산이 가능하다.
-- *오늘 날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;

-- DATE - DATE : 결과값은 일 단위가 맞음! 
-- 단, 값이 지저분한 인유는 DATE형식은 년/월/일/시/분/초 단위로 시간정보
-- 까지도 관리하기때문에 값이 좀 지저분 할 수 있다. 함수 적용해서 깔끔한 결과 확인가능


-----------------------------------------------------------------------
/*
    
    <컬럼명에 별칭 지정하기> 
    산술연산을 하게 되면 컬럼명이 지저분함... 이 때 컬럼명으로 별칭을 부여해서
    깔끔하게 보여줄 수 있다. 
    
    [표현법]  
    컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
    
    AS 키워드를 붙이든 안붙이든간에 부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자
    가 포함될 경우에는 반드시 쌍따옴표("")를 써야함.
    
*/
SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY*12 "연봉(원)", (SALARY+SALARY*BONUS)*12 AS "보너스 포함 연봉"
FROM EMPLOYEE;


------------------------------------------------------------------------
/*
    < 리터럴 > 
    임의로 지정한 문자열('')    
    
    SELECT열에 리터럴을 제시하면 마치 테이블상에 존재하는 데이터처럼 조회가 가능하다. 
    조회된RESULT SET의 모든 행에 반복적으로 같이 출력 
*/
-- EMPLOYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS "단위"
FROM EMPLOYEE;

/*
    < 연결 연산자 : || >
    여러 컬럼값들을 마치 하나의 컬럼인 것처럼 연결하거나, 
    컬럼값과 리터럴을 연결할 수 있음
    
    System.out.println("num의 값 : " +num); 이런 느낌
        
*/
--사번, 이름, 급여를 하나의 컬럼으로 조회 
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;


----컬럼값이랑 리터럴과 연결
--- xxx의 월급은 xxx원입니다. => 컬럼명 별칭 : 급여정보
SELECT EMP_NAME ||  '의 월급은 ' || SALARY ||'원 입니다.' AS "급여정보"
FROM EMPLOYEE;

--------------------------------------------------------------
    /*
    < DISTINCT >
    컬럼에 중복된 값들을 한 번씩만 표시하고자 할 때 사용함 
    */
--현재 우리 회사에 어떤 직급의 사람들이 존재하는지 궁금함.
SELECT JOB_CODE
FROM EMPLOYEE;  --현재는 23명의 직급이 순서대로 다 조회된다. 

-- EMPLOYEE 직급코드 (중복 제거) 조회 
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;  --중복이 제거되서 7행만 조회됨. 

--사원들이 어떤 부서에 속해있는지 궁금함
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; -- null: 아직 부서 배치가 되지 않은 사람 



---유의사항 : DISTINCT는 SELECT절에 딱 한번만 기술이 가능함 
/* 구문오류
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE --
FROM EMPLOYEE;
*/

SELECT DISTINCT JOB_CODE, DEPT_CODE 
FROM EMPLOYEE;
--(JOB_CODE, DEPT_CODE)를 쌍으로 묶어서 중복을 판별한뒤 조회 

-- ==============================================================

/*
    < WHERE 절 > 
    조회하고자 하는 테이블 로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 때 사용
    이때 WHERE절에는 조건식을 제시해야함! 
    조건식에서는 다양한 연산자들을 사용할 수 있다
    
    [표현법] 
    SELECT 컬럼1, 컬럼2, .. 
    FROM 테이블명
    WHERE 조건식
    
    [비교연산자]
    >, <, >= , <=  -->  대소비교
    =              -->  동등비교
    !=, ^=, <>     -->  동등하지 않은지 비교 
     
*/

--EMPLOYEE 에서 부서코드가 'D9'인 사원들만 조회. (이 때, 모든 컬럼 조회)

SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서코드가 'D1'인 사원들의 사원명, 급여, 부서코드만 조회
SELECT EMP_NAME, SALARY, DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';


-- 부서코드가 D1이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D1'; --NULL도 조회되지 않는다.
--WHERE DEPT_CODE ^='D1';
WHERE DEPT_CDOE <> 'D1'; 


-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;


-- EMPLOYEE에서 재직중 (ENT_YN의 컬럼값이 'N')인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

---------------------------------실습문제-----------------------------

--1. 급여 300만원 이상인 사람들의 급여, 입사일, 연봉(보너스 미포함) 조회
SELECT SALARY, HIRE_DATE, SALARY*12
FROM EMPLOYEE
WHERE SALARY >= 3000000;



--2. 연봉 5000만원 이상인 사람들의 급여, 연봉, 부서코드 조회

SELECT EMP_NAME, SALARY, SALARY*12 AS "연봉", DEPT_CODE
FROM EMPLOYEE
--WHERE 연봉 >=50000000; -- invalid identifier 발생 '연봉이 뭔지 모르겠다'
--WHERE절에서는 SELECT절에 작성된 별칭을 사용할 수 없다. 
WHERE SALARY*12>=50000000;

--쿼리 실행 순서
-- FROM절. 일단 어디서 정보를 가지고 오나
-- WHERE절. 어떤 조건을 가진 녀석을 찾으면 되나
-- SELECT절. 조건에 만족하는 녀석은 찾았고 얘의 어느 부분을 출력할까
-- 그래서 위에 조건식은 SELECT의 "연봉"이 선언된걸  찾아내지 못했기 때문에 
-- WHERE에서 "연봉"을 찾아내지 못한것



--3. 직급코드 'J3'가 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT  EMP_NO, EMP_NAME, DEPT_CODE,  ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE <> 'J3';



-- 부서코드가 'D9'이면서 그병가 500만원 이상인 사원들의 사번, 사원명, 급여, 부서코드 조회
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000; --WHERE 조건식에 AND, OR사용가능


-- 부서코드 'D9' 이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;


--급여가 350만원 이상 600만원 이하를 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE 350<=SALARY<=600; 자바랑 마찬가지로 불가능
WHERE SALARY >= 3500000 AND SALARY<=6000000;

-----------------------------------------------------------
/*
    < BETWEEN A AND B>  
    조건식에서 사용되는 구문 
    몇 이상이고 몇 이하인 범위 에 대한 조건을 제시할 때 사용되는 연산자 
    
    [표현법]
    비교대상컬럼 BETWEEN A(값1) AND B(값2)
    => 해당 컬럼값이 A(값1) 이상이고 B(값2) 이하인 경우 사용 가능 
    
*/
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE 
WHERE SALARY BETWEEN 3500000 AND 6000000;


--위의 쿼리 범위 밖의 사람들을 조회하고 싶다면 ?  350미만 + 600 초과 
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 OR SALARY > 6000000;

-- 해당 조건이 아닐때 NOT 사용. 
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
-- WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- 컬럼 명 앞 또는 BETWEEN 앞에 기입이 가능

-- 입사일 '90/01/01' ~ '01/01/01'
 SELECT *
 FROM EMPLOYEE
 --WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '2001/01/01';
  WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-----------------------------------------------------------------

/*
   <LIKE>
   비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회 
   
   [표현법] 
   비교대상컬럼 LIKE '특정패턴' 
   
   -특정 패턴 제시시 '%', '_'를 와일드카드로 사용할 수 있음 
    
    >>'%' : 0글자 이상
    EX) 비교대상컬럼 LIKE '문자%' => 비교대상의 컬럼값이 문자로 "시작"되는걸 조회
        비교대상컬럼 LIKE '%문자' => 비교대상의 컬럼값이 문자로 "끝"나는걸 조회 
        비교대상컬럼 LIKE '%A문자%' => 비교대상의 컬럼값에 문자가 "포함"되는걸 조회
   
   >> '_' : 1글자 
   EX ) 비교대상컬럼 LIKE '_문자'  => 비교대상의 컬럼값에 문자앞에 무조건 한글자가 올 경우 조회
        비교대상컬럼 LIKE '__문자' => 비교대상의 컬럼값에 문자앞에 무조건 두글자가 나올경우 조회
        비교대상컬럼 LIKE '_문자_' => 비교대상의 컬럼값에 문자 앞이랑 뒤에 무조건 한글자 올 경우 조회
        
*/

-- 사원들 중 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';
   
--이름중에 하 가 포함된 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';


--이름의 가운데 글자가 하인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';


-- 전화번호의 세번째 자리가 1인 사원들의 사원, 사원명, 전화번호, 이메일 조회  
-- 와일드 카드 : _(1글자), %(0글자 이상)
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%'; -- ☆


-- ** 특이케이스 
-- 이메일 중 _기준으로 앞글자가 3글자인 사람들의 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';  --원했던 결과 도출 못함!@
-- 와일드카드로 사용되고 있는 문자와 컬럼값에 담긴 문자가 동일해서 조회가 제대로 되지 않음
-- 어떤게 와일드 카드고 어떤게 데이터 값인지 구분지어야함!!!
-- 데이터 값으로 취급하고자 하는 값 앞에 나만의 와일드 카드를 제시하고, 
-- 나만의 와일드 카드를 ESCAPE OPTION으로 등록해야 한다. 

SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE 
WHERE EMAIL LIKE '___$_%' ESCAPE '$'; -- $를 만나면 거기서부턴 와일드카드가 아니
--니까 탈출해라. 즉 뒤의 _는 와일드카드가 아님. 즉 4번째에 _가 들어가는 결과값만 출력
--☆☆☆
--위의 사원들이 아닌 그 외의 사원들을 조회하고자 하면?
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE 
WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';
--그냥 앞에 NOT을 달아버리는 방법. 컬럼명 앞이나 LIKE 앞에 기입이 가능하다. 

-----------------------------실습문제--------------------------------------

-- 1. EMPLOYEE에서 이름이'연'으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';


--2. EMPLOYEE에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';


--3. EMPLOYEE에서 이름에 '하'가 포함되고 급여가 240만원 이상인 사원들의 사원명,급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY>=2400000;

--4. DEPARTMENT에서 해외영업부인 부서들의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

--------------------------------------------------------
/*
    < IS NULL / IS NOT NULL >
    컬럼값에 NULL이 있을 경우 NULL값 비교에 사용되는 연산자 
       
*/

-- 보너스를 받지 않는 사원(BONUS 값이 NULL)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS = NULL; 정상적으로 조회되지 않음
WHERE BONUS IS NULL; --보너스 없는경우(NULL)


-- 보너스를 받지 않는 사원(BONUS 값이 NULL)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS != NULL; --불가, NULL은 =나 !=를 사용 불가
WHERE BONUS IS NOT NULL; --보너스에 뭐라도 들어가있는 경우
--WHERE NOT BONUS IS NULL; -- 이 경우도 가능은 함
--NOT은 컬럼명 또는 IS 뒤에서 사용 가능


-- 사수가 없는 사원(MANAGER_ID값이 NULL)들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;


-- 부서배치를 아직 받지는 않았지만, 보너스는 받는 사원들의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-----------------------------------------------------
/*
    < IN > 
    비교대상컬럼값이 내가 제시한 목록 중에 일치하는 값이 있는지 
    
    [표현법] 
    비교대상컬럼 IN (값1, 값2, 값3, ..)
    
*/

-- 부서코드 D6이거나 D8이거나 D5인 부서원들의 이름, 부서코드, 급여 조회 
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D6';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5'); -- 위 값과 같다 

--그 외의 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D6';
WHERE DEPT_CODE NOT  IN ('D6', 'D8', 'D5'); -- 위 값과 같다 


-------------------------------------------
/*

    <연산자 우선 순위>
    0.()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL / LIKE '특정패턴' / IN
    5. BETWEEN A AND B
    6. NOT(논리연산자)
    7. AND(논리연산자)
    8. OR(논리연산자) 
        
*/

-- 직급코드 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
-- ☆OR보다 AND가 먼저 연산된다. 
SELECT *
FROM EMPLOYEE
--WHERE JOB_CODE = 'J7' OR JOB_CODE ='J2' AND SALARY > 2000000;
-- OR보다 AND가 먼저 작동해서 J2면서 200만 이상인 사람들 OR 그냥 J7이 출력된다. 
WHERE (JOB_CODE = 'J7' OR JOB_CODE ='J2') AND SALARY > 2000000;
-- 이렇게 묶어줘야 정상적으로 출력된다. 


-----------------------실습문제-----------------------------

--1. 사수가 없고 부서배치도 받지 않은 사원들의 (사원명,사수사번,부서코드)
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE 
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--2. 연봉(보너스 미포함)이 3000만원 이상, 보너스 받지 않는 사원들의 
--(사번,사원명,급여,보너스)
SELECT EMP_NO, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE (SALARY*12) >= 30000000 AND BONUS IS NULL;


--3. 입사일이 '95/01/05' 이상이고 부서배치를 받은 사원들의 
--( 사번, 사원명, 입사일, 부서코드)조회
SELECT EMP_NO, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/05' AND DEPT_CODE IS NOT NULL;


--4. 급여가 200만원 이상, 500만원 이하이고 입사일이 '01/01/01' 이상이고 보너스를 
--받지 않은 사원들의 (사번, 사원명, 급여, 입사일, 보너스)
SELECT EMP_NO, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000 AND 
HIRE_DATE >= '01/01/01' AND BONUS IS NULL;


--5. 보너스 포함 연봉이 NULL이 아니고, 이름에 '하'가 포함되어 잇는 사원들의
--(사번,사원명,급여, 보너스 포함 연봉)조회. (별칭 부여해야함)
SELECT EMP_NO AS "사원번호", EMP_NAME  AS "사원명" , SALARY AS "급여",
(SALARY+(SALARY*BONUS))*12 AS "보너스 포함 연봉"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND (SALARY+(SALARY*BONUS))*12 IS NOT NULL;



SELECT EMP_ID, EMP_NAME, SALARY --3
FROM EMPLOYEE  -- 1
WHERE DEPT_CODE IS NULL; --2

---------------------------------------------------------------------
/*
    < ORDER BY 절 > ☆
    가장 마지막 줄게 작성함! 뿐만 아니라 실행순서 또한 마지막에 실행 
    
    
    
    [표현법] 
    SELECT 조회할 컬럼, 컬럼, 산술연산식 AS "별칭" 
    FROM 조회하고자 하는 테이블명 
    WHERE 조건식 
    ORDER BY 정렬하고싶은컬럼|별칭|컬럼순번 [ASC|DESC] [NULLS FIRST|NULLS LAST] 
    
    - ASC : 오름차순 정렬 (생략 시 기본값)   
    - DESC : 내림차순 정렬 
    
    - NULLS FIRST : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 
      해당 데이터를 맨 앞에 배치(생략시 DESC일때의 기본값)
    
    - NULLS LAST : 정렬하고자 하는 컬럼값에 NULL이 있을 경우 
      해당 데이터를 맨 뒤에 배치한다.(생략 시 ASC일때의 기본값)
*/

SELECT *
FROM EMPLOYEE 
--ORDER BY BONUS; --BONUS를 오름차순으로 출력
--ORDER BY BONUS ASC --오름차순 정렬일때 기본적으로 NULLS LAST라는 것을 알 수 있다. 
--ORDER BY BONUS ASC NULLS FIRST; -- NULL을 앞으로 당겨오고 오름차순 정렬
--ORDER BY BONUS DESC; -- 내림차순 정렬일 때 기본적으로 NULLS FIRST구나!
ORDER BY BONUS DESC, SALARY ASC; -- 정렬 기준을 여러개 제시 가능
--(첫번째 기준의 컬럼값이 동일할 경우 두번째 기준 컬럼을 가지고 정렬) 

-- 전 사원의 사원명, 연봉 조회(연봉별 내림차순 정렬 조회)
SELECT EMP_NAME, SALARY*12 AS "연봉" --2
FROM EMPLOYEE --1
--ORDER BY SALARY*12 DESC --3 ORDER BY는 늘 마지막이다.
--ORDER BY 연봉 DESC; --즉 이게 가능해진다. 별칭 사용 가능. 
ORDER BY 1 DESC; -- 컬럼 순번 사용 가능. ☆ (컬럼 갯수보다 큰 숫자는 당연히 안됨. 오류)
--DESC니까 해당 칸을 내림차순으로 정렬한다. 












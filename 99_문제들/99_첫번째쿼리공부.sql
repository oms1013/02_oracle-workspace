--ㅇㅇ
--------------------------------QUIZ1--------------------------------
--보너스를 받지 않지만 부서배치는 된 사원 조회
SELECT * 
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
-- NULL값을 비교할 때는 단순한 일반 비교연산자를 통해 비교하는게 불가능하다.
-- 해결방법 : IS NULL / IS NOT NULL 연산자를 이용해서 비교해야함

SELECT * FROM EMPLOYEE; 

SELECT * 
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;


----------------------------------QUIZ 2-----------------------------------
--검색하고자 하는 내용
-- JOB_CODE가 J7이거나 J6이면서 SALARY값이 200만원 이상이고 
-- BONUS가 있고 여자이며 이메일 주소는 _앞에 3글자만 있는 사원의 EMP_NAME, EMP_NO,
-- JOB_CODE, DEPT_CODE, SALARY, BONUS를 조회하려고 한다.
-- 정상적으로 조회가 잘 된다면 실행결과는 2행이여야 한다. 

--위 내용을 실행시키고자 작성한 SQL문은 다음과 같음
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS, EMAIL
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE ='J6' AND SALARY >2000000 
AND EMAIL LIKE '___%' AND BONUS IS NULL;

--위 SQL문 실행시 원하는 결과가 제대로 조회되지 않음. 어떤 문제가 있는지 모두 찾아서 서술
--그리고 완벽한 SQL문 서술

--문제점
/*
    1. OR연산자와 AND연산자가 나열됬을 경우 AND부터 수행이 됨. 문제에서 요구한 내용으로 
       OR연산이 먼저 수행되어야 한다. 
    2. 급여값에 대한 비교가 잘못되어 있음.  >이 아닌 >=으로 비교해야함. 
    3. 보너스가 있는 이라는 조건에 IS NULL 이 아닌 IS NOT NULL로 비교해야함
    4. 여자에 대한 조건이 누락되어 있음
    5. 이메일에 대한 비교시 네번째 자리에 있는 _를 데이터값으로 취급하지 않고 새 와일드카드를
    제시해야되고, 또한 ESCAPE로 등록도 해줘야함. 
*/

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS, EMAIL
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE ='J6') AND SALARY >=2000000 
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8,1) IN ('2','4');

----------------------------------QUIZ3-------------------------------------
--[계정생성구문] CREATE USER 계정명 IDENTIFIED BY 비밀번호; 

--정명 : COOKIE, 비밀번호 : COOKIE 계정을 생성하고 싶다. 
-- 이 때 일반사용자 계정인 KH계정에 접속해서 CREATE USER COOKIE; 로 실행하니 문제가 발생 

-- 문제점1. 사용자 계정 생성은 무조건 관리자 계정에서만 가능!! 
-- 문제점2. SQL문이 잘못되어있음! 비번까지 입력해야함

-- 조치내용 1. 관리자 계정으로 접속
-- 조치내용 2. CREATE USER COOKIE IDENTIFIED BY COOKIE; 
CREATE USER COOKIE IDENTIFIED BY COOKIE;

--위의 SQL(CREATE)만 실행 후 접속을 만들어 접속을 하려고 했더니 실패
--뿐 아니라 해당 계정에 테이블 생성같은 것도 되지 않음! 왜그럴까?

-- 문제점1. 사용자 계정 생성 후 최소한의 권한 부여
--접속권한 : CREATE SESSION 

--조치사항1
GRANT CREATE SESSION TO COOKIE; --접속만 하는 권한
GRANT CREATE TABLE TO COOKIE; 

GRANT CONNECT, RESOURCE TO COOKIE; --권한을 넘겨줌


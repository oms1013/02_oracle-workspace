/*


    DQL (QUERY 데이터 질의 언어) : SELECT 
    
    DML (MANIPULATION 데이터 조작 언어) : INSERT, UPDATE, DELETE 
    DDL (DEFINITION 데이터 정의 언어) : CREATE, ALTER, DROP
    DCL (CONTROL 데이터 제어 언어) : GRANT, REVOKE, [COMMIT, ROLLBACK] 
    
    TEL (TRANSACTION 트렌젝션 제어 언어) : COMMIT, ROLLBACK로 구분하는 사람도 있음
    
    < DML : DATE MANIPULATION LANGUAGE >
    데이터 조작 언어 
    
    테이블에 값을 삽입(INSERT)하거나, 수정(UPDATE)하거나, 삭제(DELETE)하는 구문 
                
*/


/*
    1. INSERT
    테이블에 새로운 행을 추가하는 구문 
    
    [표현식] 
    1) INSERT INTO 테이블명 VALUES(값1, 값2, ...); 
      테이블에 모든 컬럼에 대한 값을 직접 제시해서 한 행 INSERT하고자 할 때 사용 
      컬럼 순번을 지켜서 VALUES에 값을 나열해야됨!! 
        
*/

INSERT INTO EMPLOYEE VALUES(900, '차은우', '900101-1234567');
--에러, not enough values 출력. 값을 모자라게 입력한 것 


INSERT INTO EMPLOYEE VALUES(900, '차은우', '900101-1234567', 'cha@kh.or.kr',
'01011112222', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT,111);
--00913. 00000 -  "too many values" 값을 더 많이 입력한 오류

INSERT INTO EMPLOYEE VALUES(900, '차은우', '900101-1234567', 'cha@kh.or.kr',
'01011112222', 'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);


SELECT * FROM EMPLOYEE; 

/*
    2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES(값1,값2,값3) ; 
       테이블에 내가 선택한 컬럼에 대한 값만 INSERT할때 사용 
       그래도 한 행 단위로 추가되기 때문에 선택이 되지 않은 컬럼은
       기본적으로는 NULL이 들어간다. 
       => NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값을 제시해야함. 
       단, DEFAULT값에 있는 경우는 NULL아 아닌 DEFAULT값이 들어간다. 
       
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE) 
VALUES(901, '주지훈', '880202-1111111', 'J1', 'S2', SYSDATE); 

SELECT * FROM EMPLOYEE; 
-- ENT_YN은 디폴트 값으로 들어가있음!

INSERT
  INTO EMPLOYEE
       (
      EMP_ID
    , EMP_NAME
    , EMP_NO
    , JOB_CODE
    , SAL_LEVEL
    , HIRE_DATE
    )
       
VALUES
    (
       901  
     , '주지훈' 
     , '880202-1111111'
     , 'J1'
     , 'S2'
     , SYSDATE
     ); 

-------------------------------------------------------------------

/*
    3) INSERT INTO 테이블명 (서브쿼리); 
       VALUES로 값 직접 명시하는거 대신에 
       서브쿼리로 조회된 결과값을 통째로 INSERT 가능! (여러 행을 INSERT 할 수 있음)
*/

--새로운 테이블 세팅
CREATE TABLE EMP_01(
    EMP_ID NUMBER, 
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR(20) 
       
); 

SELECT * FROM EMP_01;

-- 전체 사원들의 사번, 이름, 부서명 조회 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01 ( 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;

--------------------------------------------------------------------------
/*
    2.INSERT ALL 
*/


--우선 테스트할 테이블을 만들기 
-- 구조만 베끼기
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0; --데이터는 놔두고 구조만 가져옴

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID 
    FROM EMPLOYEE
    WHERE 1=0; 
    
SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

--부서코드가 D1인 사원들의사번,이름,부서코드,입사일,사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

/*
     [표현식]
     INSERT ALL 
     INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
     INTO 테이블명2 VALUES(컬럼명,컬럼명, ...) 
     서브쿼리;
*/

INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID,EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

-- * 조건을 사용해서도 각 테이블에 값 INSERT가능!!

-- 2000년도 이전 입사한 입사자들에 대한 정보 담을 테이블 
CREATE TABLE EMP_OLD 
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;  --마찬가지로 구조만 복사해옴

-- 2000년도 이후 입사한 입사자들에 대한 정보 담을 테이블 
CREATE TABLE EMP_NEW 
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;  --마찬가지로 구조만 복사해옴

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

/*
    [표현식] 
    INSERT ALL 
    WHEN 조건1 THEN
        INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...) 
    WHEN 조건2 THEN 
        INTO 테이블명2 VALUES(컬럼명, 컬럼명, ...)
    서브쿼리; 
    
*/ 

INSERT ALL 
WHEN HIRE_DATE <'2000/01/01' THEN 
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE > '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;


SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;


/*
    3. UPDATE
       테이블에 기록되어있는 기존의 데이터를 수정하는 구문 
       
       [표현법] 
       UPDATE 테이블명 
       SET 컬럼명 = 바꿀값,
           컬럼명 = 바꿀값
           ...    --> 여러개의 컬럼값 동시 변경 가능! (,로 나열해야됨! AND 아님!!)                  
        [WHERE 조건]; -->생략하면 전체 행의 모든 행의 데이터가 변경된다..! 그래서 꼭 조건 쓰자!
*/

--복사본 테이블 만든 후 작업 
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT; 

SELECT * FROM DEPT_COPY; 

-- D9 부서의 부서명을 '전략기획팀'으로 수정 
UPDATE DEPT_COPY 
SET DEPT_TITLE = '전략기획팀';

ROLLBACK;

UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀' --총무부
WHERE DEPT_ID = 'D9';

-- 우선 복사본 떠서 진행
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE; 

SELECT * FROM EMP_SALARY;

-- 직접해보기 
-- 노옹철 사원의 급여를 100만원으로 변경! 옆에다가 데이터 백업!! 
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE; 

UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_ID = '202'; --202 일단 노옹철 ID를 적어두자(동명이인 있을수도 있으니)

SELECT * FROM EMP_SALARY;

-- 선동일 사원의 급여를 700만원으로 변경, 보너스도 0.2로 변경! 데이터 백업
--200 선동일 D9 8000000
UPDATE EMP_SALARY
SET SALARY = 7000000, BONUS = 0.2
WHERE EMP_NAME = '선동일';

-- 전체 사원의 급여를 기존의 급여의 10프로 인상한 금액
UPDATE EMP_SALARY
SET SALARY = SALARY*1.1;

-- UPDATE시 서브쿼리를 사용 가능!!
/*
    UPDATE 테이블명
    SET 컬럼명 = (서브쿼리) 
    WHERE 조건; 
*/

--방명수 사원의 급여와 보너스 값을 유재식 사원의 급여와 보너스 값으로 변경 

SELECT * FROM EMP_SALARY
WHERE EMP_NAME = '방명수'; 

--단일행 서브쿼리
UPDATE EMP_SALARY 
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '유재식'), --1518000
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME ='유재식') --NULL
WHERE EMP_ID = 214;

--다중열 서브쿼리 
UPDATE EMP_SALARY
SET(SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_SALARY WHERE EMP_NAME = '유재식')
WHERE EMP_ID = 214;

SELECT * FROM EMP_SALARY;

--ASIA 지역에서 근무하는 사원들의 보너스 값을 0.3으로 변경
--DEPARTMENT -LOCATION_ID      DEPT_ID          LOCATION_ID
--EMPLOYEE                     DEPT_CODE
--LOCATION, LOCAL_CODE(L1,L2,L3)               LOCAL_CODE

SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';


UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN  (

SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN LOCATION USING (LOCATION_ID)
WHERE LOCAL_NAME LIKE 'ASIA%');

-------------------------------------
--사번이 200번인 사원의 이름을 NULL로 변경
SELECT EMP_NAME 
FROM EMPLOYEE
WHERE EMP_ID=200;

UPDATE EMPLOYEE
SET EMP_NAME =NULL 
WHERE EMP_ID = 200;
--ORA-01407: cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
--제약조건에 EMP_NAME은 NOT NULL이 붙어있어 NULL로 수정하는것이 불가능하다. 

--노옹철 사원의 직급코드를 J9으로 변경!
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '노옹철'; --J2

UPDATE EMPLOYEE
SET JOB_CODE = 'J9' 
WHERE EMP_ID= 202;
--ORA-02291: integrity constraint (KH.SYS_C007177) violated - parent key not found
--FOREIGN KEY 제약조건 위반.

--------------------------------------------------------------
COMMIT; 

/*
    4.DELETE 
      테이블에 기록된 데이터 삭제하는 구문(한 행 단위로 삭제됨)
      
      [표현식]
      DELETE FROM 테이블명
      WHERE 조건 ;
      여기서 조건을 안쓰면 테이블 자체를 날려버린다. 
*/

-- 차은우 사원의 데이터 지우기 
SELECT * FROM EMPLOYEE WHERE EMP_NAME ='차은우'; 

DELETE FROM EMPLOYEE WHERE EMP_ID = 900;
ROLLBACK; -- 마지막 커밋 시점으로 돌아감


DELETE FROM EMPLOYEE 
WHERE EMP_NAME = '차은우';

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '주지훈'; 

COMMIT; 

ROLLBACK; 

-- DEPT_ID가 D1인 부서를 삭제 
SELECT * FROM DEPARTMENT; 

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1'; 
-- ORA-02292: integrity constraint (KH.SYS_C007176) violated - child record found
-- 기본값으로 삭제가 불가능. 외래키 위반 
-- D1의 값을 가져다 쓰는 자식 데이터가 있기 때문에 삭제 안됨!

-- DEPT_ID가 D3인 부서를 삭제 
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3'; 

ROLLBACK;
/*
    *TRUNCATE : 테이블의 전체 행을 삭제할 때 사용되는 구문 
                DELETE보다 수행 조건이 빠름.
                별도의 조건 제시가 불가능. 그냥 테이블의 모든 행 다삭제
                ROLLBACK도 불가능함 
                
    [표현법] TRUNCATE TABLE 테이블명;                       
*/

SELECT * FROM EMP_SALARY; 

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;





















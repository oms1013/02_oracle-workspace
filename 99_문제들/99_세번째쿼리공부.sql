-- 먼저저장
-- QUIZ1

-- CREATE USER TEST IDENTIFIED BY 1234;실행
-- USER TEST 생성 완료

-- 계정생성 이후 접속이 오류남. 왜?
-- 문제점 : 계정생성만 했고, 접속 권한은 부여하지 않았기 때문에
-- 조치사항 :
-- GRANT CONNECT, RESOURCE TO TEST 로 권한을 줘야함

-- QUIZ2 (JOIN복습)
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY, 
    JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);

-- 위의 두 테이블이 있다는 가정하에
-- 두 테이블을 조인해서 EMPNO, EMPNAME, JOBNO, JOBNAME 컬럼을 조회할것임
-- 이 때 실행할 SQL문
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
  FROM TB_EMP
  JOIN TB_JOB USING(JOBNO);
--ORA-00904: "TB_JOB"."JOBNO": invalid identifier
--TB_JOB테이블에 JOBNO가 없다.

--문제점 : JOBNO컬럼이 TM_EMP에는 존재하지만 TB_JOB에는 존재하지 않기 때문에
--USING 구문을 사용함에 있어서 문제가 발생한다.
-- 해결내용 : USING(JOBNO)이 아니라 ON절 (JOBNO=JOBCODE)를 사용한다.

SELECT EMPNO, EMPNAME, JOBNO
  FROM TB_EMP
  JOIN TB_JOB ON (JOBNO=JOBCODE);
  
-------------------------------------------------------------

-- 테이블 생성 관련해서 데이터 타입(CHAR, VARCHAR2 차이점) 

-- 오라클 객체(SEQUENCE, VIEW) 각각 뭔지...

-- 제약조건 => 뒤늦게 제약조건을 추가할 수 있는 ALTER문

-- DCL은 무엇인가? GRANT라던가

-- 커밋, 롤백은 무엇인가? + SAVEPOINT(CREATE, ALTER, DROP) => 자동커밋...

-- QUIZ3(JOIN복습) 

-- 아래의 SQL구문은 부서별 월급합계가 15,000,000을 초과하는 부서를 조회한 것이다. 

-- 결과가 올바르지 않다고 할때, 그 원인과 조치사항

SELECT DEPT_CODE, SUM(SALARY)
  FROM EMPLOYEE
  WHERE SALARY > 15000000
  GROUP
    BY DEPT_CODE;
    --HAVING SUM(SALARY)>15000000
    
-- 이게 안되는 이유? 급여 15000000를 넘는 사람을 모아서 출력하려니까 그런돈
-- 가진사람은 없는것 
-- HAVING절을 썼어야함

--QUIZ4(제약조건)
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZ4 VALUES(1, '퀴즈1번', 30);
INSERT INTO QUIZ4 VALUES(1, '퀴즈222222222번', 40);
--작동 안하는 이유, 퀴즈 222222번이 VARCHAR2(10)이라 크기에 비해 용량이 모자람

INSERT INTO QUIZ4 VALUES(1,'퀴즈2번', 40);
--이래도 안됨. VALUE값에 1이 PRIMARY KEY로 인한 오류 발생


--급여를 기준으로 500만원 이상 ->고급개발자
--             350만원 이상 ->중급개발자
--                        ->초급개발자
--CASE WHEN THEN

SELECT EMP_NAME, SALARY, 
        CASE WHEN SALARY>=5000000 THEN '고급개발자'
             WHEN SALARY>=3500000 THEN '중급개발자'
             ELSE '초급개발자'
        END AS "레벨"
    FROM EMPLOYEE;
CREATE USER EMP1 IDENTIFIED BY EMP01234;
GRANT CONNECT TO EMP1;
/*

*/
/*
아래의 상황과 에러의 내용을 읽고 에러가 발생한 원인(20점)과 그 조치사항(올바른 SQL구문)(20점)을 작성하시오(총 40점)
1) 시나리오 상황
사용자 계정을 만들기 위해 관리자 계정으로 접속하여
CREATE USER EMP IDENTIFIED BY EMP0123; 명령어를 실행한 뒤
접속을 확인하였다.


2) 에러 내용
User EMP이(가) 생성되었습니다.
ORA-01045: user EMP lacks CREATE SESSION privilege; logon denied

에러 발생 원인 - 계정 생성은 정상적으로 되었지만 접속 권한이 주어지지 않았기 때문에 해당 계정으로 접속이 불가능하다.

조치사항 - 관리자 계정으로 접속한 상태에서 추가로 
        GRANT CONNECT TO EMP; 구문을 입력해 해당 EMP 계정에 접속할 수 있는 권한을 부여해야함

*/


/*
다음 두 개의 테이블을 조인하여 EMPNO, EMPNAME, DEPTNO, DEPTNAME 컬럼을 조회하였을 때 문제가 발생한다.
아래의 내용과 문제상황을 보고, 발생한 원인(30점)과 해결할 수 있는 조치사항(30점)을 기술하시오. (총 60점)
-- 사용한 테이블 생성 정보 --


발생 원인-
- 
-

조치사항-
-
-
*/
DROP TABLE DEPARTMENT;
CREATE TABLE DEPARTMENT(
  DEPTCODE NUMBER PRIMARY KEY,
  DEPTNAME NVARCHAR2(10) NOT NULL
);

DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE(
  EMPNO NUMBER PRIMARY KEY,
  EMPNAME VARCHAR2(10) NOT NULL,
  DEPTNO NUMBER REFERENCES DEPARTMENT(DEPTCODE)
);
-- 문제 상황
ORA-00904: "DEPARTMENT"."DEPTNO": invalid identifier

INSERT INTO DEPARTMENT VALUES('11','직원1');
INSERT INTO DEPARTMENT VALUES('12','직원2');

INSERT INTO EMPLOYEE VALUES('1','직원1','11');
INSERT INTO EMPLOYEE VALUES('2','직원2','12');
-- 실행한 조인 쿼리 --
SELECT EMPNO, EMPNAME, DEPTNO, DEPTNAME
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPTNO);

-- 변경시
SELECT EMPNO, EMPNAME, DEPTNO, DEPTNAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPTNO=DEPTCODE);
ROLLBACK;
--
-- 문제 상황
ORA-00904: "DEPARTMENT"."DEPTNO": invalid identifier



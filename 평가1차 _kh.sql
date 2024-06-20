/*

1
[
1. 사례1
원인1- 계정을 만드는 데 관리자 계정이 아닌 일반 사용자 
원인2- 계정 생성 구문이 계정 ID만 설정되고 비밀번호 설정이 되지 않음

2. 사례
원인-계정은 만들었지만 접속 권한, 테이블 생성 권한이 주어져있지
않은 상태이기 때문에 접속도 되지 않고 테이블 생성도 불가능한 것

조치내용

사례1
1. 계정 생성 시 계정을 만들 권한이 있는 관리자 계정으로 생성 구문을 실행해야함 
2. 또한 계정 생성 구문을 수정해서 비밀번호 설정도 입력해야 함.
CREATE USER SAMPLE; =>
CREATE USER SAMPLE IDENTIFIED BY 1234;


사례2
접속 전에 관리자 계정으로 SAMPLE 계정에 접속 권한을 부여해야 함
GRANT CONNECT TO SAMPLE; 구문을 실행

또한 테이블 생성 권한을 SAMPLE 계정에 주어야 하기 때문에 해당 구문을 관리자 계정으로 실행해야함
GRANT CREATE TABLE TO SAMPLE;  


]
*/



SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____%' ;


SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE='D9' OR DEPT_CODE='D6') --괄호 추가로 OR구문이 먼저 실행되게 변경
AND SALARY >= 3000000 -- 3000000 이상 으로 조건 변경
AND BONUS IS NOT NULL -- BONUS가 있는 사람들로 조건 변경
AND EMAIL LIKE '___$_%' ESCAPE '$'  -- '$' 이후 ESCAPE 구문을 통해 4번째 '_'가 
--와일드카드로 인정받도록 구문을 수정
AND SUBSTR(EMP_NO, 8,1) IN (1,3); --남자인 직원들 조건 추가







--원인
--NULL값을 비교할 때에는 '=', '!=' 와 같은 비교연산자들로는 값을 인식하지 못하기 때문이다.

SELECT * 
FROM EMPLOYEE 
WHERE BONUS IS NULL AND MANAGER_ID IS NOT NULL;
--BONUS가 NULL이기 때문에 IS NULL, 
--MANAGER_ID는 NULL값이 아니기 때문에 IS NOT NULL로 수정해야 한다.

/*

[





]
*/







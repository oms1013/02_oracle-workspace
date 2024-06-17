-- 먼저 저장 
CREATE TABLE TEST(
    TEST_ID NUMBER, 
    TEST_NAME VARCHAR2(10) 
    --insufficient privileges
    --권한이 없다는 오류가 출력됨 
); 




-- CREATE TABLE 할 수 있는 권한이 없어서 문제가 발생함 
-- 3_1. CREATE TABLE 시스템 권한 받기 
-- 3_2. TABLESPACE 할당 받기 

SELECT * FROM TEST;
INSERT INTO TEST VALUES(10, '안녕');
-- CREATE TABLE 권한이 테이블 생성 뿐 아니라 바로 조작이 가능해짐
-- (조회, 입력 등등) 

--------------------------------------------

-- KH계정 에 있는 EMPLOYEE 테이블에 접근 
-- 근데 조회 권한이 없음 

-- 4. 조회 권환 받기
SELECT * FROM KH.EMPLOYEE;
-- KH계정의 EMPLOYEE 테이블에관한 조회 권한을
-- SAMPLE 계정에 부여해서 조회가 가능해진다. 
SELECT * FROM KH.DEPARTMENT; 

-- 5. INSERT ON KH.DEPARTMENT 권한 부여받기
INSERT INTO KH. DEPARTMENT 
VALUES ('D0', '회계부', 'L1');

ROLLBACK;



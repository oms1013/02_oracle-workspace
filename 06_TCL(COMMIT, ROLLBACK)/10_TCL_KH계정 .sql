-- 먼저 저장 
/*
    < TCL : TRANSCATION CONTROL LANGUAGE > 
    트랜잭션 제어 언어 
    
    
    * 트랜젝션 (TRANSACTION) 
    - 데이터베이스 논리 연산 단위 
    - 데이터의 변경사항(DML 추가, 수정, 삭제)들을 하나의 트랜잭션에 묶어서 처리  
    
    
    --트랜잭션은 COMMIT으로 최종 입력을 적용시키는게 아닐때 임시로 저장해두는 느낌
    -- AUTO COMMIT? 
    ROLLBACK은 트랜젝션을 비우고 마지막 COMMIT 시점으로 돌아오는것 
    DML 문 한개를 수행할 때 트랜젝션이 존재하면 해당 트랜잭션에 같이 묶어서 처리 
                         트랜젝션이 존재하지 않으면 트랜젝션을 만들어서 묶음 
    COMMIT을 하기 전까지의 변경사항들을 하나의 트랜젝션에 담게 됨 
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML) 
    
    COMMIT  (트랜젝션 종료 처리 후 확정)
    ROLLBACK (트랜젝션 취소) 
    SAVEPOINT (임시 저장) 
    
    - COMMIT; 진행 : 한 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영시키겠다는 의미 (후에 트랜젝션은 사라짐) 
    - ROLLBACK; 진행 : 한 트랜젝션에 담겨있는 변경사항들을 삭제(취소) 한 후 마지막 COMMIT 시점으로 돌아감 
    - SAVEPOINT 포인트명; : 현재 이 시점에 해당 포인트명으로 임시 저장점을 정의해두는 것 
                           ROLLBACK 진행 시 변경사항들 다 삭제하는게 아니라 일부만 롤백가능
         
*/

SELECT * FROM EMP_01;

-- 사번이 900번 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 900;

-- 사번이 901번인 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 901;

-- 트랜잭션에 900, 901 지운게 저장되어 있음
ROLLBACK;
--DELETE 두개가 다 실행이 취소됨

----------------------------------------------------------------------------

-- 200번인 사원 지우기 
DELETE FROM EMP_01
WHERE EMP_ID = 200; 

-- 800, 홍길동, 총무부 사원 추가
INSERT INTO EMP_01
VALUES (800, '홍길동', '총무부');

SELECT * FROM EMP_01;

COMMIT;

ROLLBACK; 
--한번 COMMIT을 시키면 ROLLBACK을 해도 돌아오지 않는다. 이미 트랜잭션에 들어가있던게
--적용되었고 롤백은 COMMIT 이전시점으로는 돌아가지 못하기 때문에. 

-- 217, 216, 214 사원 지움 
DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

SAVEPOINT SP;

-- 801, 장원영, 인사관리부 사원 추가
INSERT INTO EMP_01
VALUES (801, '장원영', '인사관리부');

SELECT * FROM EMP_01;

-- 218 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID = 218; 

ROLLBACK TO SP;
COMMIT;
SELECT * FROM EMP_01;

--------------------------------------------------------------------------------

-- 900번 , 901사원 지움
DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

--218번 사원 지움
DELETE FROM EMP_01
WHERE EMP_ID =218;

SELECT * FROM EMP_01;

-- DDL문
CREATE TABLE TEST(
    TID NUMBER 
);
ROLLBACK;

-- DDL문 ( CREATE, ALTER, DROP)을 수행하면 기존에 트랜젝션이 있던 변경사항들을 COMMIT 시켜버림
-- 즉 DDL 수행 전 변경사항이 있었다면 정확히 픽스(COMMIT, ROLLBACK)을 마쳐두어야 한다. 



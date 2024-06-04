-- 한 줄 짜리 주석 

/*
    여러 줄

    주석
*/

-- 현재 모든 계정들에 대해서 조회하는 명령문
SELECT * FROM DBA_USERS;   --SELECT 조회, * 모든    
     --명령문 하나 실행 (위에 재생버튼ORCTRL+ENTER 실행)
     
     --일반 사용자 계정 생성 구문(오로지 관리자 계정에서만 할 수 있음)
     --[표현법] CREATE USER 계정명 IDENTIFIED  BY 비밀번호;
CREATE USER kh IDENTIFIED BY kh; --계정명, 비번 전부 그냥 소문자로 만들자 

-- 계정가 =>오류남

-- 위에서 생성된 일반 사용자계정에게 최소한의 권한을 줘야함(현재 접속할 권한조차 없음)
-- 접속, 데이터 관리 부여

--[표현법 GRANT(부여) 권한1, 권한2, TO 계정명
GRANT RESOURCE, CONNECT TO kh;










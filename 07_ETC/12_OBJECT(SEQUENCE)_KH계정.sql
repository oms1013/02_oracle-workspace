
/*
    < 시퀀스 SEQUENCE > 
    자동으로 번호 발생시켜주는 역할을 하는 객체 
    정수값을 순차적으로 일정값씩 증가시키면서 생성해줌 
    
    EX) 회원번호, 사원번호, 게시글 번호, ... 
*/

/*
    1. 시퀀스 객체 생성 
    
    [표현식] 
    CREATE SEQUENCE 시퀀스명 
    [START WITH 시작숫자]           --> 처음 발생시킬 시작값 지정(기본값 1) 
    [INCREMENT BY 숫자]            --> 몇씩 증가시킬 건지 
    [MAXVALUE 숫자]                --> 최대값 지정(기본값 아주 큼)
    [MINVALUE 숫자]                --> 최소값 지정(기본값 1) 
    [CYCLE|NOCYCLE]               --> 값 순환 여부 지정 (기본값 NOCYCLE) 
    [NOCACHE|CACHE 바이트크기]      --> 캐시 메모리 할당 (기본값 CACHE 20)
    
    * 캐시 메모리 : 미리 발생될 값들을 생성해서 저장해두는 공간 
                 매번 호출될때 마다 새로이 번호를 생성하는게 아니라 
                 캐시 메모리 공간에 미리 생성된 값들을 가져다 쓸 수 있음(속도가 빨라짐)
                접속이 해제되면 => 캐시메모리에 미리 만들어둔 번호들은 다 날아간다. 
                
    테이블명 : TB_  
    뷰명    : VW_
    시퀀스명 : SEQ_ 
    트리거  : TRG_
*/

CREATE SEQUENCE SEQ_TEST; 

--[참고] 현재 계정이 소유하고 있는 시퀀스의 구조를 보고자 할 때 
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310 
NOCYCLE 
NOCACHE;

/*
    2. 시퀀스 사용 
    
    시퀀스명.CURRVAL : 현재 시퀀스의 값(마지막으로 성공적으로 수행된 NEXTVAL의 값)
    시퀀스명.NEXTVAL : 시퀀스 값에서 일정 값을 증가시켜서 발생된
                      현재 시퀀스 값에서 INCREMENT BY 값 만큼 증가된 값
                     == 시퀀스명. CURRVAL + INCREMENT BY 값  
   
    
    
*/


SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--ORA-08002: sequence SEQ_EMPNO.CURRVAL 
--is not yet defined in this session
--아직 정의되지 않은 시퀀스 오류 

 --왜? CURRVAL은 마지막으로 성공적으로 수행된 NEXTVAL의 값을 저장해서 보여주는 임시 값
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --310

SELECT * FROM USER_SEQUENCES; 
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; 
-- 지정한 MAXVALUE값을 초과했기 때문에
-- 오류가 발생함. (실패) 

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--CURVAL는 마지막으로 성공한 것이기 떄문에 출력 가능

/*
    3. 시퀀스 구조 변경 
    ALTER SEQUENCE 시퀀스명 
    [INCREMENT BY 숫자]           --> 몇씩 증가시킬 건지 
    [MAXVALUE 숫자]               --> 최대값 지정(기본값 아주 큼)
    [MINVALUE 숫자]               --> 최소값 지정(기본값 1) 
    [CYCLE|NOCYCLE]              --> 값 순환 여부 지정 (기본값 NOCYCLE) 
    [NOCACHE|CACHE 바이트크기]     --> 캐시 메모리 할당 (기본값 CACHE 20)
    
    * START WITH는 변경불가
*/


ALTER SEQUENCE SEQ_EMPNO 
INCREMENT BY 10
MAXVALUE 400; 

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  -- 310+10 =>320;
--NMAXVALUE를 400으로 수정했기 때문에 정상적으로 작동한다. 

--4. 시퀀스 삭제
DROP SEQUENCE SEQ_EMPNO; 
----------------------------------------------------------------

--사원번호로 활용할 시퀀스 생성 
CREATE SEQUENCE SEQ_EID
START WITH 400 
NOCACHE; 

INSERT 
    INTO EMPLOYEE
        (
            EMP_ID
           ,EMP_NAME
           ,EMP_NO
           ,JOB_CODE
           ,HIRE_DATE
           ,SAL_LEVEL
           )
VALUES 
        (
            SEQ_EID.NEXTVAL
        ,   '차은우' 
        ,   '111111-1111111'
        ,   'J7'
        ,   SYSDATE
        ,   'S1'
        );
        
SELECT * FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;
        

INSERT 
    INTO EMPLOYEE
        (
            EMP_ID
           ,EMP_NAME
           ,EMP_NO
           ,JOB_CODE
           ,HIRE_DATE
           ,SAL_LEVEL
           )
VALUES 
        (
            SEQ_EID.NEXTVAL
        ,   '주지훈' 
        ,   '111111-1234567'
        ,   'J6'
        ,   SYSDATE
        ,   'S2'
        );
   


































/*
    < VIEW 뷰 > 
    
    SELECT 문(쿼리문)을 저장해둘 수 있는 객체
    (자주 쓰는 긴 SELECT문을 저장해두면 그 긴 SELECT문을 매번 기술할 필요 없음!! 
    임시테이블 같은 존재(실제 데이터가 담겨있는건 아님!!  => 가상으로만 존재하는 논리적인 테이블)

*/

--'한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME ='한국';
 
 
 --'러시아'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME ='러시아';
 
 
 --'일본'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME ='일본';
  
 ------------------------------------------------------------
 /*
    1.VIEW 생성 방법 
    
    [표현식] 
    CREATE VIEW 뷰명 
    
    [OR REPLACE ] : 뷰를 생성할 때 기존에중복된 이름의 뷰가 없다면
    새로이 뷰를 생성하고, 기존에 중복된 이름의 뷰가 있다면 해당 뷰를 변경함(갱신)
 */
 
 CREATE OR REPLACE VIEW VW_EMPLOYEE 
 AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE);
  
  GRANT CREATE VIEW TO KH; -->관리자 계정에서 실행해야됨!!
  
  SELECT * 
  FROM VW_EMPLOYEE;
  
  SELECT * 
  FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME , SALARY 
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE));
  
 --뷰는 논리적인 가상 테이블!(실질적으로 데이터를 저장하고 있지는 않음!)
 
 -- '한국' , '러시아', '일본'에 근무하는 사원 
 SELECT * 
    FROM VW_EMPLOYEE 
   WHERE NATIONAL_NAME ='한국';
    
 SELECT * 
    FROM VW_EMPLOYEE 
   WHERE NATIONAL_NAME ='러시아';
 
 SELECT * 
    FROM VW_EMPLOYEE 
   WHERE NATIONAL_NAME ='일본';
 
 
 --[참고]
 SELECT * FROM USER_VIEWS;
 
 -----------------------------------------------------------
 /*
     * 뷰 컬럼 별칭 부여
       서브쿼리 SELECT 절에 함수식이나 산술연산식이 기술되어있을 경우 반드시 별칭 지정해야함 
 */
 
 -- 전 사원의 사번 이름, 직급명, 성별(남/여), 근무년수를 조회할 수 있는
 --SELECT문 뷰(VW_EMP_JOB)으로 정의
 
CREATE OR REPLACE VIEW VW_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
        DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2' , '여') "성별",
        EXTRACT(YEAR FROM SYSDATE)  - EXTRACT(YEAR FROM HIRE_DATE) "근무년수" 
    FROM EMPLOYEE 
    JOIN JOB USING(JOB_CODE); 

SELECT * FROM VW_EMP_JOB;

--아래와 같은 방법으로도 별칭 부여 가능(단, 이때는 모든 컬럼에 대한 별칭을 작성해야됨) 
CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 이름, 직급명, 성별, 근무년수) 
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
        DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2' , '여'),
        EXTRACT(YEAR FROM SYSDATE)  - EXTRACT(YEAR FROM HIRE_DATE)  
    FROM EMPLOYEE 
    JOIN JOB USING(JOB_CODE); 

SELECT 이름, 직급명
    FROM VW_EMP_JOB 
    WHERE 성별 = '여';

SELECT *
    FROM VW_EMP_JOB
    WHERE 근무년수 >=20;
    
    --뷰 삭제하고자 한다면
    
    DROP VIEW VW_EMP_JOB;
-------------------------------------------------------------------------

-- 생성된 뷰를 이용해서 DML 사용 가능! 
-- 뷰를 통해서 조작하게 되면 실제 데이터가 담겨있는 베이스테이블 

CREATE OR REPLACE VIEW VW_JOB 
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB; 
    
SELECT * FROM VW_JOB; -- 논리 테이블(실제 데이터가 담겨있지 않음) 
SELECT * FROM JOB;    -- 베이스 테이블 (실제 데이터가 담겨있음)

-- 리뷰를 통해서 INSERT
INSERT INTO VW_JOB VALUES('J8', '인턴'); --베이스 테이블에 실질적으로 INSERT가 된다. 

--뷰를 통해서 UPDATE 
UPDATE VW_JOB
    SET JOB_NAME = '알바' 
    WHERE JOB_CODE = 'J8'; --인턴 

-- 뷰를 통해서 DELETE
DELETE 
    FROM VW_JOB
   WHERE JOB_CODE = 'J8';
   
--------------------------------------------------------------------------------

    --    * 단, DML 명령어로 조작이 불가능한 경우가 더 많음! 
 --   1) 뷰에 정의 되어 있지 않은 컬럼을 조작하려고 하는 경우 
 CREATE OR REPLACE VIEW VW_JOB
    AS SELECT JOB_CODE
        FROM JOB;
 
 SELECT * FROM VW_JOB;
 SELECT * FROM JOB; 
 
 -- INSERT 
 INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8', '인턴'); 
 
 -- UPDATE(에러)  
 UPDATE VW_JOB
    SET JOB_NAME ='인턴' 
  WHERE JOB_CODE ='J7'; -- 사원 
  
  -- DELETE 에러)
  DELETE 
    FROM  VW_JOB 
    WHERE JOB_NAME = '사원'; 
 --   2) 뷰에 정의되어있지 않은 컬럼 중에 베이스 테이블 상에 NOT NULL 
 --      제약조건이 지정되어있는 경우

    CREATE OR REPLACE VIEW VW_JOB
        AS SELECT JOB_NAME
        FROM JOB;

    SELECT * FROM VW_JOB; 
    SELECT * FROM JOB;
    
    --INSERT
    INSERT INTO VW_JOB VALUES('인턴');
    --당연히 작동 안함. VW_JOB에는 인턴만 들어가는게 맞는데 실제 베이스 테이블인
    --JOB에도 값을 입력해야 하는데 JOB에는 값이 두개가 들어가야 하기 떄문에
    --실제 베이스테이블에 NULL, '인턴'이 추가되는데 NULL이 추가되면 안되니까
  
  --UPDATE
  UPDATE VW_JOB 
    SET JOB_NAME = '알바'
   WHERE JOB_NAME = '사원';
  
  ROLLBACK;
 
 --DELETE(이 데이터가 쓰고 있는 지식 데이터가 존재하기 때문에 삭제제한 /단, 없다면 삭제 잘됨!!) 
 DELETE 
    FROM VW_JOB
    WHERE JOB_NAME = '사원'; 
    
  
 -- 3) 산술연산식 또는 함수식으로 정의되어있는 경우
 CREATE OR REPLACE VIEW  VW_EMP_SAL
    AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 연봉
    FROM EMPLOYEE; 

 SELECT * FROM VW_EMP_SAL; 
 SELECT * FROM EMPLOYEE; 


--INSERT (에러)  
    INSERT INTO VW_EMP_SAL VALUES(400, '위하준', 3000000, 3600000);
    
 -- UPDATE 
 -- 200번 사원의 연봉을 8000만원으로 
 UPDATE VW_EMP_SAL 
    SET 연봉 =  80000000
  WHERE EMP_ID = 200; --에러 
  
-- 200번 사원의 급여를 700만원으로 
UPDATE VW_EMP_SAL 
    SET SALARY = 7000000 -- 8000000 
  WHERE EMP_ID = 200; -- 성공 
  
  ROLLBACK; 
  
  --DELETE 
  DELETE FROM VW_EMP_SAL 
 WHERE 연봉 = 7200000; 
 
 ROLLBACK; 


 --   4) 그룹함수, GROUP BY 절이 있는 경우
    CREATE OR REPLACE VIEW VW_GROUPDEPT
       AS SELECT DEPT_CODE, SUM(SALARY) "합계", FLOOR(AVG(SALARY)) "평균"
       FROM EMPLOYEE 
       GROUP BY DEPT_CODE; 
       
    SELECT * FROM VW_GROUPDEPT;
    
    -- INSERT (에러) 
    INSERT INTO VW_GROUPDEPT VALUES ('D3',8000000, 4000000); 
    
    --UPDATE (에러)
    UPDATE VW_GROUPDEPT
    SET 합계 = 5000000
    WHERE DEPT_CODE = 'D1';
 
    --DELETE (에러) 
    DELETE
      FROM VW_GROUPDEPT
    WHERE 합계 = 5210000;

 --   5) DISTINCT 구문이 포함된 경우 
    CREATE OR REPLACE VIEW VW_DT_JOB
    AS SELECT DISTINCT JOB_CODE 
        FROM EMPLOYEE; 
    
    SELECT * FROM VW_DT_JOB;
    
    -- INSERT (물론 에러. NULL값이 섞이던 아까 문구와 동일한 원리) 
    INSERT INTO VW_DT_JOB VALUES('J8');
     
    -- UPDATE (에러) 
    UPDATE VW_DT_JOB
        SET JOB_CODE = 'J9'
     WHERE JOB_CODE = 'J7';
     
     --DELETE (에러)  
     DELETE
        FROM VW_DT_JOB 
     WHERE JOB_CODE = 'J4'; 
     
 --   6) JOIN을 이용해서 여러 테이블을 연결시켜놓은 경우 
     CREATE OR REPLACE VIEW VW_JOINEMP
        AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
        
    SELECT * FROM VW_JOINEMP;
            
        --INSERT
        INSERT INTO VW_JOINEMP VALUES(300, '류선재', '총무부');
        --JOIN해서 불가능하다는 오류가 발생
        
        --UPDATE 
        UPDATE VW_JOINEMP
            SET EMP_NAME = '서동일' 
          WHERE EMP_ID = 200;  --성공 
        
        SELECT * FROM EMPLOYEE;
        --베이스테이블인 EMPLOYEE의 선동일이 서동일로 바뀌어있는 모습 
        
        
        UPDATE VW_JOINEMP--(에러)
            SET DEPT_TITLE = '회계부'
         WHERE EMP_ID =200;
         
         -- 회계부로 바꾸려면 또 DEPARTMENT 를 건드려야 하기 때문에
        
     --DELETE
     DELETE
        FROM VW_JOINEMP
      WHERE EMP_ID =200;
      --정상적으로 삭제됨 
      
      SELECT * FROM EMPLOYEE;
    
        ROLLBACK;

----------------------------------------------------------------

/*
    *VIEW 옵션
    
    [상세표현식]
    CREATE [OR REPLACE] [FORCE|"NOFORCE"] VIEW 뷰명
    AS 서브쿼리 
    [WITH CHECK OPTION] 
    [WITH READ ONLY] ;
    
    1)OR REPLACE : 기존에 동일한 뷰가 있을 경우 갱신시키는, 
    --존재하지 않으면 새로이 생성시키는
    2)FORCE|NOFORCE
      >FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 VIEW를 생성되게 할수 있음
      >NOFORCE : 서브쿼리에 기술된 테이블이 존재하는 테이블이여야만 뷰가 생성되게함
      --참고로 NOFORCE 는 생략시 기본값임
    3) WITH CHECK OPTION : DML시 서브쿼리에 기술된 조건에 부합한 값으로만 DML가능하도록
    4) WITH READ ONLY : 뷰에 대해서 조회만 가능하도록(DML문 수행이 불가능함) 
    
*/
-- 2) FORCE | NOFORCE  
--  NOFORCE : 서브쿼리에 기술된 테이블이 존재하는 테이블이여야만 뷰가 생성되게 하는 
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
 AS SELECT TCODE, TNAME, TCONTECT 
    FROM TT; 
        
        
-- FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰가 우선은 생성은 됨 
CREATE OR REPLACE FORCE VIEW VW_EMP
 AS SELECT TCODE, TNAME, TCONTECT 
    FROM TT; 

SELECT * FROM VW_EMP; 

-- TT 테이블을 생성해야만 그때부터 VIEW 활용이 가능 
CREATE TABLE TT(
    TCODE NUMBER, 
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR(30)
);

-- 3) WITH CHECK OPTION : 서브쿼리에 기술된 조건에 부합하지 않는 값으로 수정 시 
-- 오류 발생 


--WITH CHECK OPTION 안쓰고 
CREATE OR REPLACE VIEW VW_EMP
    AS SELECT *
        FROM EMPLOYEE 
      WHERE SALARY >= 3000000; 
      
SELECT * FROM VW_EMP; -- 8명 조회

-- 200번 사원의 급여를 200만원으로 변경( 서브쿼리의 조건에 부합되지 않는 값으로
--변경 시도!!) 

UPDATE VW_EMP 
    SET SALARY = 2000000
  WHERE EMP_ID = 200; 
  
  SELECT * FROM VW_EMP;
  
    ROLLBACK;
    -- WITH CHECK OPTION 쓰고 
    CREATE OR REPLACE VIEW VW_EMP
    AS SELECT * 
        FROM EMPLOYEE
       WHERE SALARY >=3000000
    WITH CHECK OPTION; 
    
    SELECT * FROM VW_EMP; 
    
    UPDATE VW_EMP
        SET SALARY =2000000
     WHERE EMP_ID = 200; --서브쿼리에 기술한 조건에 부합되지 않기 때문에 변경 불가!!
     
     UPDATE VW_EMP
        SET SALARY = 4000000
     WHERE EMP_ID = 200; -- 서브쿼리에 기술한 조건에 부합되기 때문에 변경이 가능
     
     SELECT * FROM EMPLOYEE; 
     
     ROLLBACK;
     
     -- 4) WITH READ ONLY : 뷰에 대해 조회만 가능 (DML문 수행 불가) 
     CREATE OR REPLACE VIEW VW_EMP
     AS SELECT EMP_ID, EMP_NAME, BONUS
        FROM EMPLOYEE
      WHERE BONUS IS NOT NULL
    WITH READ ONLY; 
    
    SELECT * FROM VW_EMP;
    
    DELETE 
        FROM VW_EMP
     WHERE EMP_ID = 200; 
     --수행 불가, 조회만 가능한 VIEW기 때문에 
     
     
     




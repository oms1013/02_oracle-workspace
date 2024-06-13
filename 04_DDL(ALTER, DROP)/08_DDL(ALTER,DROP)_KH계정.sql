--
/*
    DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어 
    
    객체들을 생성(CREATE), 변경(ALTER), 삭제(DROP) 하는 구문 
    
    <ALTER> 
    객체를 변경하는 구문 
    
    [표현법]
    ALTER TABLE 테이블명 변경할 내용; 
    
    * 변경할 내용 
    1) 컬럼 추가/수정/삭제
    2) 제약조건 추가/삭제 --> 수정은 불가(수정하고자 한다면 삭제하고 새로 추가해야함) 
    3) 컬럼명/제약조건명/테이블명 변경 
  
*/

--1) 컬럼 추가/수정/삭제  ☆☆
--1_1) 컬럼 추가(ADD) : ADD 컬럼명 자료형 [DEFAULT 기본값] 제약조건 
--DEPT_COPY에 CNAME이라는 컬럼 추가

ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
--> 새로운 컬럼이 만들어지고 기본적으로 NULL로 채워짐 

SELECT * FROM DEPT_COPY;

--LNAME 컬럼 추가 (기본값을 지정한채로) 
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국'; 

--1_2) 컬럼 수정(MODIFY)
--> 자료형 수정           : MODIFY 컬럼명 바꾸고자 하는 자료형 

--> DEFAULT값 수정       : MODIFY 컬럼명 DEFAULT 바꾸고자 하는 기본값 

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
--이건 오류남! 이미 안에 숫자가 아닌 데이터가 들어가있는데 자료형을 바꾸려고 하면 오류나는게
--당연함. 존재하는 데이터가 없어야만 이렇게 바꿀 수 있음. 

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
--마찬가지로 오류. 안에 있는 데이터가 너무 커서 사이즈때문에 오류가 발생

--직접 해보기
--DEPT_TITLE 컬럼을 VARCHAR2에 50바이트로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);

--LOCATION_ID 컬럼을 VARCHAR2(4)로 변경
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);

--LNAME 컬럼의 기본값을 '미국'으로 변경
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '미국';
SELECT * FROM DEPT_COPY;

--당연히 디폴트 값을 바꾼다고 해서 이미 이전에 추가된 데이터가 변경되는건 아님


--다중 변경도 가능함.
ALTER TABLE DEPT_COPY 
    MODIFY DEPT_TITLE VARCHAR2(50) 
    MODIFY LOCATION_ID VARCHAR2(50)
    MODIFY LNAME DEFAULT '미국';

--1_3) 컬럼 삭제(DROP COLUMN) : DROP COLUMN 삭제하고자 하는 컬럼명
--삭제를 위한 복사본 테이블 생성 
CREATE TABLE DEPT_COPY2 
 AS SELECT * FROM DEPT_COPY;
 
 SELECT * FROM DEPT_COPY2; 
 
 --DEPT_COPY2로부터 DEPT_ID 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2
    DROP COLUMN LOCATION_ID
    DROP COLUMN CNAME;
    --☆다중 ALTER는 한번에 DROP을 여러개 사용할 수는 없음. 

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;

SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
--ORA-12983: cannot drop all columns in a table
--마지막 컬럼인 LNAME 삭제 불가. 테이블에 컬럼이 하나라도 남아있어야 하기 때문 
--테이블에 최소한 한개의 컬럼은 존재해야 한다.

--------------------------------------------------------------------
--2)제약조건 추가/삭제 

/*
    2_1) 제약조건 추가
    이렇게 5개의 조건이 있다. 
    PRIMARY KEY : ADD PRIMARY KEY(컬럼명)
    FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명[(컬럼명)];
    UNIQUE      : ADD UNIQUE(컬럼명) 
    CHECK       : ADD CHECK(컬럼에 대한 조건)
    NOT NULL    : MODIFY 컬럼명 NOT NULL | NULL => 이걸 쓰면 널이 허용된다. 

    제약조건명을 지정하고자 한다면 CONSTRAINT 제약조건
*/

-- DEPT_ID에 PRIMARY KEY 제약조건 추가 ADD
-- DEPT_TITLE에 UNIQUE 제약조건 추가 ADD
-- LNAME에 NOT NULL 제약조건 추가 MODIFY 
ALTER TABLE DEPT_COPY 
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

SELECT * FROM DEPT_COPY;

-- 2_2) 제약조건 삭제 : DROP CONSTRAINT 제약조건

-- 하지만 NOT NULL 제약조건은 삭제하는게 아님
-- MODIFY 컬럼명 NULL로 해야함. 수정밖에 방법이 없음

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;
--조건 삭제

ALTER TABLE DEPT_COPY
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
    --여러 조건을 한번에 삭제
    

--------------------------------------------------
--3) 컬럼명/제약조건명/테이블명 변경 (RENAME) 
-- 3_1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명 

-- DEPT_TITLE => DEPT_NAME 
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

--3_2) 제약조건명 변경 : RENAME CONSTRAINT 제약조건명 TO 바꿀 제약조건명
-- SYS_C007242 LOCATION_ID NN 자기꺼 가져오기 
-- SYS_C007242 => DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007242 TO DCOPY_LID_NN;


--3_3) 테이블명 변경 : RENAME [기존테이블명] TO 바꿀테이블명 
-- DEPT_COPY => DEPT_ TEST 
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;


---------------------------------------------------------

--테이블 삭제 ☆
DROP TABLE DEPT_TEST;

--단, 어딘가에서 참조되고 있는 부모 테이블은 함부로 삭제할 수 없음!! 
--만약에 삭제하고자 한다면 
-- 방법1. 자식 테이블을 먼저 삭제 한 후 부모 테이블을 삭제해야함. 
-- 방법2. 그냥 부모테이블만 삭제하되 제약조건까지 같이 삭제하는 방법 
--      DROP TABLE 테이블명 CASCADE CONSTRAINT;

















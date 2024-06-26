--먼저 저장 DQL(DATA QUERY(질의) LANGUAGE)
/*
    * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    오라클에서 제공하는 객체(OBJECT)를 새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제(DROP)하는 언어
    즉, 실제 데이터값이 아닌 구조 자체를 정의하는 언어
    주로 DB관리자, 설계자가 사용함
    
    오라클에서의 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 
                          인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER),
                          프로시져(PROCEDURE), 함수(FUNCTION), 동의어(SYNONYM), 사용자(USER)
                          
    <CREATE>
    객체를 새로이 생성하는 구문
*/

/*
    1. 테이블 생성
    - 테이블이란? 행(ROW)과 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                모든 데이터들은 테이블을 통해서 저장됨!!
                (DBMS 용어 중 하나로, 데이터를 일종의 표 형태로 표현한 것!)
                
     [ 표현식 ]
     CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명 자료형,
        ...
     );
    
    * 자료형
    - 문자 (CHAR(바이트크기) | VARCHAR2(바이트크기)) => 반드시 크기 지정 해야함!!
    > CHAR : 최대 2000 바이트까지 지정 가능. 지정한 범위 안에서만 써야 함 / 고정길이(지정한 크기보다 더 작은 값이 들어와도 공백으로 채워줌)
             고정된 글자수의 데이터만이 담길 경우 사용
    
    > VARCHAR2 : 최대 4000 바이트 까지 지정 가능, 가변 길이 (담긴 값에 따라서 공간의 크기 맞춰짐)
                몇글자의 데이터가 들어올 지 모를 경우 사용
    
    - 숫자 (NUMBER)
    
    - 날짜 (DATE)
    
    
*/

-- > 회원에 대한 데이터를 담기 위한 테이블 MEMBER 생성하기
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
    
);

SELECT * FROM MEMBER;

-- 만약 컬럼명에 오타가 났다면?
-- 다시 만들면 될까? ㄴㄴ 삭제하고 다시 하든 해야 함

-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블들
-- [참고] USER_TABLES : 현재 이 계정이 가지고 있는 테이블 구조 볼 수 있음
SELECT * FROM USER_TABLES;

--------------------------------------------------------------------------------

/*
    2. 컬럼에 주석 달기 (컬럼에 대한 설명같은거)
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
    >> 잘못 작성해서 실행했을 경우 수정 후 다시 실행하면 됨!
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원버노';
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';

COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';

-- 테이블 삭제하고자 할 때 : DROP TABLE 테이블명;

-- 테이블에 데이터 추가시키는 구문 (DML : INSERT) 이 때 자세하게 배움
-- INSERT INTO 테이블명 VALUES(값1, 값2, ....)

SELECT * FROM MEMBER;
--INSERT INTO MEMBER VALUES(1,'user01', 'pass01', '홍길동');
INSERT INTO MEMBER VALUES(1,'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'aaa@naver.com', '24/06/11');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', '홍길녀', '여', null, NULL, SYSDATE);

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- 유효하지 않은 데이터가 들어가고 있음.. 뭔가 조건을 걸어줘야 함.

--------------------------------------------------------------------------------

/*
    <제약조건 CONSTRAINTS>
    - 원하는 데이터값(유효한 형식의 값)만 유지하기 위해서 특정 컬럼에 설정하는 제약조건
    - 데이터 무결성 보장을 목적으로 한다!
    
    * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY    
*/

/*
    * NOT NULL 제약조건
    - 해당 컬럼에 반드시 값이 존재해야만 할 경우(즉, 해당 컬럼에 절대 NULL이 들어와서는 안되는 경우)
    삽입/수정 시 NULL값을 허용하지 않도록 제한
    
    제약조건을 부여하는 방식 크게 2가지가 있음 (컬럼레벨방식/테이블레벨방식)
    NOT NULL 제약조건은 오로지 컬럼레벨방식 밖에 안됨
*/

-- 컬럼 레벨 방식 : 컬럼명 자료형 제약조건 
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1,'user01','pass01', '손흥민', '남', null, null);
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', null, '장원영', '여', null, 'aaa@naver.com');
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- 의도했던대로 오류남!! (NOT NULL 제약조건에 위배되어 오류 발생!)
INSERT INTO MEM_NOTNULL VALUES(2, 'user01', 'pass01', '장원영', null, null, null);
--> 아이디가 중복되어 있음에도 불구하고 잘 추가 됨 ㅜ_ㅜ


/*
    * UNIQUE 제약조건
    해당 컬럼에 중복된 값이 들어가서는 안 될 경우
    컬럼값에 중복값을 제한하는 제약조건
    삽입/수정 시 기존에 있는 데이터값 중 중복값이 있을 경우 오류 발생!
*/

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --컬럼레벨방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

-- 테이블 레벨 방식 : 모든 컬럼들 다 나열 한 후 마지막에 기술
--                 제약조건 (컬럼명)
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50), 
    UNIQUE(MEM_ID) -- 테이블레벨방식
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '손흥민', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass01', '장원영', NULL, NULL, NULL);
-- ORA-00001: unique constraint (DDL.SYS_C007081) violated 
-- UNIQUE 제약조건 위배됐음! INSERT 실패!!
-- 오류 구문을 제약조건명으로 알려줌!! (특정 컬럼에 어떤 문제가 있는지 상세히 알려주지 않음!)
-- > 쉽게 파악하기 어려움
-- > 제약조건 부여시 제약조건명을 지정해주지 않으면 시스템에서 임의의 제약조건명을 부여해버림

/*
    * 제약조건 부여시 제약조건명까지 지어주는 방법
    
    > 컬럼레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 [CONSTRAINT 제약조건명]제약조건,
        컬럼명 자료형 
    );
    
    > 테이블레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
        
    );
    
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL, 
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50), 
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '손흥민', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass01', '장원영', NULL, NULL, NULL);

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '장원영', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '윈터', 'ㅇ', NULL, NULL);
-- > 성별에 유효한 값이 아닌 게 들어와도 잘 INSERT 된다. => 이러면 안됨...

--------------------------------------------------------------------------------

/*
    * CHECK(조건식) 제약조건
    해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해둘 수 있음!
    해당 조건에 만족하는 데이터만 담길 수 있음
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')), -- 컬럼 레벨 방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CHECK(GENDER IN ('남','여'))
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES(1, 'user01', 'pass01', '손흥민', '남', null, null);

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '장원영', 'ㄴ', null, null);
-- ORA-02290: check constraint (DDL.SYS_C007091) violated
-- CHECK 제약조건 위배됐기 때문에 오류 발생!

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '장원영', NULL, null, null);
--> 만일 GENDER 컬럼에 데이터값을 넣고자 한다면 CHECK 제약조건에 만족하는 값을 넣어야됨
--> NOT NULL 아니면 NULL도 가능하긴함!!

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES(2, 'user03', 'pass03', '윈터', '여', null, null);
--> 회원번호가 동일해도 성공적으로 INSERT 돼버림..

-------------------------------------------------------------------------------
-- 6/12
/*
    * PRIMARY KEY (기본키) 제약조건
    테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건 (식별자의 역할)
    
    EX) 회원번호, 학번, 사원번호(EMP_ID), 부서코드(DEPT_CODE), 직급코드(JOB_CODE), 주문번호, 예약번호, 운송장번호
    
    PRIMARY KEY 제약조건을 부여하면 그 컬럼에 자동으로 NOT NULL + UNIQUE 제약조건을 가진다.
    
    * 유의사항 : 한 테이블 당 오로지!!! 한 개만 설정 가능
    ~~ 프라이머리키는 숫자로 보통 많이 함
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- 컬럼 레벨 방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- 테이블 레벨 방식
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI
VALUES(1, 'user01', 'pass01', '손흥민', '남', '010-1111-2222', null);

INSERT INTO MEM_PRI
VALUES(1, 'user02', 'pass02', '장원영', '여', NULL, null);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated 
-- 기본키에 중복값을 담으려고 할 때 (UNIQUE 제약조건 위반)

INSERT INTO MEM_PRI
VALUES(NULL, 'user02', 'pass02', '장원영', '여', NULL, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- 기본키에 NULL 담으려고 할 때 (NOT NULL 제약조건에 위배됨)

INSERT INTO MEM_PRI
VALUES(2, 'user02', 'pass02', '장원영', '여', NULL, null);

SELECT * FROM MEM_PRI;

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20) PRIMARY KEY, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
-- ORA-02260: table can have only one primary key
-- 기본키 하나만 된다!!!

SELECT * FROM MEM_PRI2;

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20), 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- 묶어서 PRIMARY KEY 제약조건 부여(~~ 복합키// 둘 다 똑같아야 함)
);

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '손흥민', null, null, null);

INSERT INTO MEM_PRI2
VALUES(1, 'user02', 'pass02', '장원영', null, null, null);

INSERT INTO MEM_PRI2
VALUES(2, 'user02', 'pass02', '장원영', null, null, null);

INSERT INTO MEM_PRI2
VALUES(NULL, 'user02', 'pass02', '장원영', null, null, null);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- PRIMARY KEY로 묶여있는 각 컬럼에 절대 NULL 허용하지 않음!!

-- 복합키 사용 예시 (찜하기, 좋아요, 구독) (~~ 1번이라는 사람이 A상품을 찜했고 1번이라는 사람이 A를 또 찜하는 건 필요없는거고 2번이라는 사람이 A상품 찜하고 1번이라는 사람이 B상품을 찜할 수 있으니까)
-- 찜하기 : 한 상품은 오로지 한번만 찜할 수 있음
-- 어떤 회원이 어떤 상품을 찜하는지에 대한 데이터를 보관하는 테이블
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(60),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRODUCT_NAME)
);

SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES(1, '축구공', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '축구화', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, '축구화', SYSDATE); -- 에러발생!! 한번만 찜해야됨
INSERT INTO TB_LIKE VALUES(2, '축구화', SYSDATE);

--------------------------------------------------------------------------------
-- 회원 등급에 대한 데이터를 따로 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
DROP TABLE MEM_GRADE;
SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20)NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER -- 회원 등급 번호 같이 보관할 컬럼
);

SELECT * FROM MEM;

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '손흥민', '남', null, null, null);

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '장원영', null, null, null, 10);

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '윈터', null, null, null, 90);
-- 유효한 회원등급 번호가 아님에도 불구하고 잘 insert가 됨..

---------------------------------------------------------------
/*
    * FOREIGN KEY(외래키) 제약 조건 
    다른 테이블에 존재하는 값만 들어와야 되는 특정 컬럼에 부여하는 제약조건 
    --> 다른 테이블을 참조한다고 표현 
    --> 주로 FOREIGN KEY 제약조건에 의해 테이블간의 관계가 형성됨!
    
    > 컬럼 레벨 방식
    컬럼명 자료형 REFERENCES 참조할 테이블명[(참조할 컬럼명)] 
    
    
    > 테이블 레벨 방식 
    FOREIGN KEY (컬럼명) REFERENCES 참조할 테이블명[(참조할 컬럼명)] 
    
    --> 참조할 컬럼명 생략시 참조할 테이블의 PRIMARY KEY로 지정된 컬럼으로 매칭
    
*/
DROP TABLE MEM; 

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20)NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) --컬럼레벨방식 : 참조컬럼명 안쓰면 프라이머리키로 자동매칭!
    --FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) 
       );

    SELECT * FROM MEM;
    
    INSERT INTO MEM
    VALUES(1,'user01', 'pass01', '손흥민', '남', null, null, null);
    --외래키 제약조건 부여된 컬럼엔 기본적으로 null 허용
    INSERT INTO MEM
    VALUES(2,'user02', 'pass02', '장원영', null, null, null, null);

    SELECT * FROM MEM;
    
     INSERT INTO MEM
    VALUES(3,'user03', 'pass03', '윈터', null, null, null, 30);

     INSERT INTO MEM
    VALUES(4,'user04', 'pass04', '카리나', null, null, null, 90);
    -- ORA-02291 : integrity constraint (DDL.YSY_C007134) violated - parent key not found
    -- PARENT KEY를 찾을 수 없다는 오류가 발생함
    -- 부모 테이블에 90번이 없음!!
    
    INSERT INTO MEM
    VALUES(4,'user04', 'pass04', '카리나', null, null, null, 10);
    
      INSERT INTO MEM
    VALUES(5,'user05', 'pass05', '변우석', null, null, null, 20);
    
     SELECT * FROM MEM;
    --MEM_GRADE(부모테이블) -|----------------------MEM(자식테이블)
    
    -->이 때 부모테이블(MEM_GRADE)에서 데이터값을 삭제할 경우 어떤 문제가 있을까?
    --> 데이터 삭제 : DELEFTE FROM 테이블명 WHERE 조건;
    
    SELECT * FROM MEM_GRADE;
    --MEM_GRADE 테이블에서 10번등급 삭제
    DELETE FROM MEM_GRADE
    WHERE GRADE_CODE = 10;
    --ORA-02292: integrity constraint (DDL.SYS_C007134)violated - child record found
    --자식테이블 (MEM)에 10이라는 값을 사용하고 있어서 삭제가 불가능함.
   
   DELETE FROM MEM
   WHERE MEM_NO=4;
   --> 자식테이블(MEM)에 10이라는 값을 사용하지 않고 있어서 삭제가 잘됨
   
   --> 자식테이블에서 이미 사용하고 있는 값이 있을 경우
   --> 부모 테이블로부터 무조건 삭제가 안되게 하는 "삭제 제한 옵션" 이 걸려있음
   SELECT * FROM MEM_GRADE;
   ROLLBACK;
   -------------------------------------------------------
   /*
        자식 테이블 생성시 외래키 제약조건을 부여할 때 삭제옵션을 지정할 수 있음
        * 삭제옵션 : 부모테이블의 데이터 삭제 시 그 데이터를 사용하고 있는 자식테이블의 값을
        어떻게 처리할건지. 
        
        - ON DELETE RESTRICTED(기본값) : 삭제 제한 옵션으로, 자식 데이터로 쓰이는 부모데이터는 
        절대로 삭제가 아예 안되게끔 하는 옵션
        
        - ON DELETE SET NULL : 부모데이터 삭제시 해당 데이터를 쓰는 자식데이터 값 NULL로변경
        
        - ☆☆☆☆ ON DELETE CASCADE : 부모데이터 삭제시 해당데이터 쓰는 자식데이터도 같이 삭제 
        
    */
    DROP TABLE MEM; 
    
--ON DELETE SET NULL

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20)NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
         );
         
    INSERT INTO MEM
    VALUES(1,'user01', 'pass01', '손흥민', '남', null, null, null);
    
    INSERT INTO MEM
    VALUES(2,'user02', 'pass02', '장원영', null, null, null, 10);

     INSERT INTO MEM
    VALUES(3,'user03', 'pass03', '윈터', null, null, null, 30);

     INSERT INTO MEM
    VALUES(4,'user04', 'pass04', '카리나', null, null, null, 10);
    
    SELECT * FROM MEM;
    SELECT * FROM MEM_GRADE;
    
    DELETE * FROM MEM_GRADE 
    WHERE GRADE_CODE =10;
    --잘 삭제됨!1 (단,10을 가져다 쓰던 자식데이터 값 NULL로 변경)
    
    ROLLBACK;
    
    DROP TABLE MEM;
 
 CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY, 
    MEM_ID VARCHAR2(20)NOT NULL UNIQUE, 
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
         );
         
         /*
         
    CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL 
   );
         */
         
    INSERT INTO MEM
    VALUES(1,'user01', 'pass01', '손흥민', '남', null, null, null);
    
    INSERT INTO MEM
    VALUES(2,'user02', 'pass02', '장원영', null, null, null, 10);

     INSERT INTO MEM
    VALUES(3,'user03', 'pass03', '윈터', null, null, null, 30);

     INSERT INTO MEM
    VALUES(4,'user04', 'pass04', '카리나', null, null, null, 10);
    
    SELECT * FROM MEM;
    SELECT * FROM MEM_GRADE;
    
    DELETE FROM MEM_GRADE
    WHERE GRADE_CODE = 10;
    
    SELECT * 
    FROM MEM_GRADE;
    --잘 삭제됨 (단, 해당 데이터를 사용하고 있던 자식 데이터가 같이 DELETE됨!!)
   ----------------------------------------------------------------
   
   /*
        < DEFAULT 기본값 > ** 제약조건 아님 
        컬럼을 선정하지 않고 INSERT 시 NULL 이 아닌 기본값을 INSERT하고자 할 때 세팅해둘 수 있는 값
       
   */

DROP TABLE MEMBER;

-- 컬럼명 자료형 DEFAULT 기본값 [제약조건]
-- DEFAULT제약조건 앞에 자리잡아야함
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    --☆NUMBER, DATE타입은 크기지정을 하지 않아도 된다.
    HOBBY VARCHAR2(20) DEFAULT '없음',
    ENROLL_DATE DATE DEFAULT SYSDATE

);

SELECT * FROM MEMBER;

--INSERT INTO 테이블명 VALUES(값1, 값2)

INSERT INTO MEMBER VALUES(1, '손흥민', 20, '축구', '23/01/22');
INSERT INTO MEMBER VALUES(2, '장원영', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(3, '카리나', NULL, DEFAULT, DEFAULT);
--NULL값이 아니라 DEFAULT로 지정된 값을 출력한다.


--또다른 INSERT 방식.   
-- INSERT INTO 테이블명(컬럼명, 컬럼명) VALUES(값1, 값2)
-- NOT NULL 설정되어있는 컬럼들은 꼭 값을 입력해야함. 
--그야 NULL이 들어가면 안되는 조건이라 입력에 NULL을 입력할 수 없으니까.
-- PRIMARY키도 NULL값이 안되는 조건이 기본으로 탑재되어 있기 때문에 꼭 비우려면 DEFAULT를써야함
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4,'윈터');
--다 입력하는게 아니라 저거만 입력하면 입력하지 않은 곳이 DEFAULT값이 설정되어 있으면,
--자동적으로 DEFAULT값이 출력
SELECT * FROM MEMBER;
--출력결과 4, 윈터, NULL, 없음, 현재시각 출력 
--DEFAULT설정이 안되있는 AGE는 NULL이 출력된다.
--단, 해당 컬럼에 DEFAULT값이 잇을 경우 NULL이 아닌 DEFUALT값이 들어감 

-----------------------------------------------------------------

/*
    !!!!!!!!!!!!!!!!!!!!!!!!여기서부터 KH계정으로 해야함!!!!!!!!!!!!!!!!!!!!!!
    < SUBQUERY를 이용한 테이블 생성 > 
    테이블을 복사하는 개념 
    
    [ 표현식 ]
    CREATE TABLE 테이블명 
    AS 서브쿼리 
*/

-- EMPLOYEE 테이블을 복제한 새로운 테이블을 생성 
CREATE TABLE EMPLOYEE_COPY 
AS SELECT *
   FROM EMPLOYEE; 
   
SELECT * FROM EMPLOYEE_COPY; 
--> 컬럼, 데이터값, 제약조건 같은 경우 NOT NULL만 복사됨 

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS 
    FROM EMPLOYEE
    WHERE 1=0; --무조건 FALSE인 조건!! : 구조만을 복사하고자 할 때 쓰이는 구문 
--이러면 테이블의 구조만 가져온다. 데이터는 가져오지 않음 

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 AS "연봉"
    FROM EMPLOYEE;
-- "must name this expression with a column alias" 오류 발생 
-- alias : 별칭!! 
-- SALARY*12가 문제인것. 함수식이 있을떄는 별칭을 줘야한다.
-- 서브쿼리 SELECT절에 저렇게 산술식이나 함수식이 있으면 별칭을 줘야 함☆☆☆

SELECT * FROM EMPLOYEE_COPY3;

SELECT EMP_NAME, 연봉 
FROM EMPLOYEE_COPY3; 

------------------------------------------------------------
/*
    * 테이블 다 생성된 후에 뒤늦게 제약조건 추가 

    ALTER TABLE 테이블명 변경할 내용; 
    
    - PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명); 
    - FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명)REFERENCES 참조할 테이블명[(참조할컬럼명)]
    - UNIQUE      : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명); 
    - CHECK       : ALTER TABLE 테이블명 ADD CHECK(컬럼에 대한 조건식);
    - NOT NULL    : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL; **약간 특이함 
    
*/

-- 서브쿼리를 이용해서 복제한 테이블은 NOT NULL제약조건을 제외하면 복제되지 않음.
-- EMPLOYEE_COPY 테이블에 PRIMARY KEY 제약조건을 추가. (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID); 

--EMPLOYEE 테이블에 DEPT_CODE에 외래키 제약조건을 추가.(참조하는 테이블(부모) : DEPARTMENT
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;
--FOREIGN KEY에서 참조할 컬럼명을 생략하면 부모테이블의 PK로 감

-- EMPLOYEE 테이블에 JOB_CODE에 외래키 제약조건을 추가(JOB 테이블 참조) 
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;

-- EMPLOYEE 테이블에 SAL_LEVEL에 외래키 제약조건을 추가(SAL_GRADE 테이블 참조) 
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE;

-- DEPARTMENT 테이블에 LOCATION_ID에 외래키 제약조건을 추가(LOCATION 테이블 참조) 
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;



   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
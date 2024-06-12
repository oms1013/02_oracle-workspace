--실습문제--

--1.
DROP TABLE TB_PUBLISHER;

CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,         --출판사 번호
    PUB_NAME VARCHAR2(10) CONSTRAINT PUBLISHER_NN NOT NULL, --출판사명
    PHONE VARCHAR2(20) -- 출판사 전화번호

);
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '출판사 번호';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '출판사명';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '출판사 전화번호';

INSERT INTO TB_PUBLISHER VALUES(1, '출판사1', '010-1111-2222');
INSERT INTO TB_PUBLISHER VALUES(2, '출판사2', '010-2222-3333');
INSERT INTO TB_PUBLISHER VALUES(3, '출판사3', '010-3333-4444');

SELECT * 
FROM TB_PUBLISHER;



--2. 도서들에 대한 데이터를 담기 위한 도서 테이블(TB_BOOK)
DROP TABLE TB_BOOK;

CREATE TABLE TB_BOOK(

    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(50) CONSTRAINT BOOK_NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(50) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_STOCK NUMBER DEFAULT 1,
    BK_PUB_NO NUMBER CONSTRAINT BOOK_FK REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
    
);
    COMMENT ON COLUMN TB_BOOK.BK_NO IS '도서번호';
    COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '도서명';
    COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '저자명';
    COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '가격 ';
    COMMENT ON COLUMN TB_BOOK.BK_STOCK IS '재고';
    COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '출판사 번호';



--5개 정도의 샘플 데이터 추가하기
    INSERT INTO TB_BOOK VALUES(1, '책1', '오명식1', 10000, 2, 1);
    INSERT INTO TB_BOOK VALUES(2, '책2', '오명식2', 20000, 3, 2);
    INSERT INTO TB_BOOK VALUES(3, '책3', '오명식3', 30000, 4, 3);
    INSERT INTO TB_BOOK VALUES(4, '책4', '오명식4', 40000, 5, 2);
    INSERT INTO TB_BOOK VALUES(5, '책5', '오명식5', 50000, 6, 1);
--NUM CHAR CHAR NUM  NUM NUM
    SELECT * FROM TB_BOOK;



DROP TABLE TB_MEMBER;

CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ NOT NULL UNIQUE, 
    MEMBER_PWD NUMBER CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(15) CONSTRAINT MEMBER_NN_NAME NOT NULL, 
    GENDER CHAR(3) CONSTRAINT MEMBER_CK_ CHECK (GENDER IN ('M','F')),
    ADDRESS VARCHAR2(50),
    PHONE VARCHAR2(50),
    STATUS CHAR(5) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK (STATUS IN('N','Y')), 
    ENROLL_DATE VARCHAR(30) DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL
);

    COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원번호';
    COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '아이디';
    COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '비밀번호';
    COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원명';
    COMMENT ON COLUMN TB_MEMBER.GENDER IS '성별';
    COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '주소';
    COMMENT ON COLUMN TB_MEMBER.PHONE IS '연락처';
    COMMENT ON COLUMN TB_MEMBER.STATUS IS '탈퇴여부';
    COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '가입일';

--회원번호, 아이디, 비번,  회원명,   성별,       주소,    연락처,   탈퇴여부, 가입일
-- NUM, VARCHAR, NUM, VARCHAR, CHAR(MF), VARCHAR, VARCHAR, CHAR(YN), VARCHAR
INSERT INTO TB_MEMBER VALUES(1, '아이디1', 1234 , '오명식', 'M', '주소1', '010-0000-0000', 'N', '2024-01-01');
INSERT INTO TB_MEMBER VALUES(2, '아이디2', 1234 , '오명식2', 'F', '주소2', '010-1111-0000', 'N', '2024-01-01');
INSERT INTO TB_MEMBER VALUES(3, '아이디3', 1234 , '오명식3', 'M', '주소3', '010-2222-0000', 'N', '2024-01-01');
INSERT INTO TB_MEMBER VALUES(4, '아이디4', 1234 , '오명식4', 'F', '주소4', '010-3333-0000', 'N', '2024-01-01');
INSERT INTO TB_MEMBER VALUES(5, '아이디5', 1234 , '오명식5', 'F', '주소5', '010-4444-0000', DEFAULT, DEFAULT);

SELECT * 
FROM TB_MEMBER;





DROP TABLE TB_RENT;
--4. 도서를 대여한 회원에 대한 데이터를 담기 위한 대여목록 테이블(TB_RENT)
CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,
    RENT_MEM_NO NUMBER CONSTRAINT RENT_FK_MEM REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE SET NULL,
--TB_MEMBER(MEMBER_NO) -- 1,2,3,4,5
    RENT_BOOK_NO NUMBER CONSTRAINT RENT_FK_BOOK REFERENCES TB_BOOK(BK_NO) ON DELETE SET NULL,
--TB_BOOK(BK_NO)  -- 1,2,3,4,5
    RENT_DATE DATE DEFAULT SYSDATE 
);

    COMMENT ON COLUMN TB_RENT.RENT_NO IS '대여번호';
    COMMENT ON COLUMN TB_RENT.RENT_DATE IS '대여일';
    COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '대여회원번호';
    COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '대여도서번호';

    SELECT * FROM TB_RENT;

--샘플데이터 3개정도 추가하기

    INSERT INTO TB_RENT VALUES(100, 1, 1, '20/01/01');
    INSERT INTO TB_RENT VALUES(101, 2, 2, '23/01/02');
    INSERT INTO TB_RENT VALUES(105, 3, 5, DEFAULT);
--NUMBER, NUMBER, NUMBER, DATE, 
--대여번호, 대여회원번호, 대여도서번호, 대여일 

    SELECT *
    FROM TB_RENT;
    --2번 도서를 대여한 회원의 이름, 아이디, 대여일, 반납예정일(대여일+7)을 조회하시오.
    --회원 이름, 회원 아이디
    --RENT_MEM_NO
    -- MEMBER_NO
    
    SELECT MEMBER_NAME, MEMBER_ID , RENT_DATE, RENT_DATE + 7 AS "반납예정일"
    FROM TB_RENT --, TB_BOOK, TB_MEMBER
    JOIN TB_MEMBER ON ( RENT_MEM_NO = MEMBER_NO)
    WHERE RENT_BOOK_NO =2;

/*

com.kh.model.vo.Book 클래스 작성
com.kh.model.vo.Magazine 클래스 작성
com.kh.model.dao.BookDao 클래스 작성
com.kh.controller.BookController 클래스 작성
com.kh.view.BookMenu 클래스 작성

이때, 메뉴는 LibraryRun 파일에 있는 메뉴를 참조하여 만들고,
1~5 번까지 메뉴를 전부 구성해야함.

데이터는 10개 정도의 데이터를 테이블의 샘플 데이터를 추가하도록 한다.

(잃어버린 동규를 찾아서 ~ 윤경이의 백만가지 요리 레시피)
-

실행내용은 JAR파일로 Export 하여 제출할 것!
*/

 DROP TABLE BOOK;
CREATE TABLE BOOK(
    BNO VARCHAR2(20) NOT NULL UNIQUE,       -- 책 번호
    TITLE VARCHAR2(200) NOT NULL,    -- 책 제목
    AUTHOR VARCHAR2(30),    -- 저자
    PUBLISHER VARCHAR2(50), -- 출판사
    PRICE NUMBER,           -- 가격
    DESCRIPTION VARCHAR(500)     -- 설명
  );
COMMENT ON COLUMN BOOK.BNO IS '책 번호';
COMMENT ON COLUMN BOOK.TITLE IS '책 제목';
COMMENT ON COLUMN BOOK.AUTHOR IS '저자';
COMMENT ON COLUMN BOOK.PUBLISHER IS '출판사';
COMMENT ON COLUMN BOOK.PRICE IS '가격';
COMMENT ON COLUMN BOOK.DESCRIPTION IS '설명';
   
    DROP TABLE MAGAZINE;
CREATE TABLE MAGAZINE(
    BNO VARCHAR2(20) NOT NULL UNIQUE,       -- 책 번호
    TITLE VARCHAR2(200) NOT NULL,           -- 책 제목
    AUTHOR VARCHAR2(30),                     -- 저자
    PUBLISHER VARCHAR2(50),                 -- 출판사
    PRICE NUMBER,                           -- 가격
    DESCRIPTION VARCHAR(500),             -- 설명
    YEAR NUMBER,                            -- 출간연도
    MONTH NUMBER                            -- 출간월
  );
COMMENT ON COLUMN MAGAZINE.YEAR IS '출간연도';
COMMENT ON COLUMN MAGAZINE.MONTH IS '출간월';
COMMENT ON COLUMN BOOK.BNO IS '책 번호';
COMMENT ON COLUMN BOOK.TITLE IS '책 제목';
COMMENT ON COLUMN BOOK.AUTHOR IS '저자';
COMMENT ON COLUMN BOOK.PUBLISHER IS '출판사';
COMMENT ON COLUMN BOOK.PRICE IS '가격';
COMMENT ON COLUMN BOOK.DESCRIPTION IS '설명';



 INSERT INTO BOOK VALUES('100', '잃어버린 동규를 찾아서', '김민 박사', '상우 출판사', 8500, '『서경스』, 『르 몽드』 선정 20세기 최고의 책');
 INSERT INTO BOOK VALUES('101', '종열이의 자서전', '지영이가 옮김', '빛나는 진아출판사', 8500, '영화배우 김채혁이 추천한 젊음에 바치는 영혼의 자서전');
 INSERT INTO BOOK VALUES('103', '명식이의 코딩스쿨', '코딩천재 유현동', '기훈이네 동네', 9900, '제 13회 미예가 주는 문학상 수상작');
 INSERT INTO BOOK VALUES('106', '이한별의 미라클모닝', '정민식 박사', '지운이네 출판사', 6300, '택은이도 2번 성공한 미라클모닝');
 INSERT INTO BOOK VALUES('107', '윤경이의 백만가지 요리레시피', '서울에서 온 규호', '집밥최선생 최승균 출판사', 6300, '아이돌 황영찬이 적극 추천한 최고의 레시피');
  
INSERT INTO MAGAZINE VALUES('102', '김태경 과학동아', '편집부 김희섭 선생', '경원 사이언스', 8500, '광현 유튜브에 소개된 과학만화 잡지', 2024, 5);
INSERT INTO MAGAZINE VALUES('104', '승헌이의 여행일기', '은지쓰', '씨네21', 3800, '영화감독 이종호 집필한 영화 전문 잡지', 2021, 4);
INSERT INTO MAGAZINE VALUES('105', '이주영의 데일리룩', '인플루언서 이준영', '태형이네 책방', 12000, '핫걸 김시연의 샤라웃을 받은 잡지', 2024, 10);

COMMIT;

SELECT * FROM BOOK;
SELECT * FROM MAGAZINE;
    
SELECT *
FROM BOOK B
RIGHT JOIN MAGAZINE Z ON (B.BNO=Z.BNO);


    COMMIT;
   
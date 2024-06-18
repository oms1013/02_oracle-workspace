--트리거 실습 예제

--1. 성적테이블(학번, 이름, 국, 영, 수), 학점테이블(학번, 총점수, 평균, 등수) 만들기
--성적테이블 : TB_SCORE
--학점테이블 : TB_GRADE
DROP TABLE TB_SCORE;
CREATE TABLE TB_SCORE(     --성적테이블
    STUDENT_NO VARCHAR(30),   --학번
    STUDENT_NAME VARCHAR(30), --이름
    LAN NUMBER,               --국어
    ENG NUMBER,               --영어
    MATH NUMBER               --수학

);

DROP TABLE TB_GRADE;
CREATE TABLE TB_GRADE(   --학점 테이블
    STUDENTNO VARCHAR(30), --학번
    SUMGRADE NUMBER,        --총 점수
    AVGGRADE NUMBER,        --평균
    RANK NUMBER             --등수

);
--2. 성적테이블에 INSERT 발생하면 자동으로 학점테이블에 INSERT해주는 트리거 생성
--AUTOINSERT
CREATE TRIGGER AUTOINSERT
    AFTER INSERT ON TB_SCORE
    FOR EACH ROW
    
    BEGIN
        UPDATE TB_GRADE 
        SET STUDENTNO = NEW.STUDENT_NO;
        
        UPDATE TB_GRADE 
        SET SUMGRADE = NEW.LAN + NEW.MATH + NEW.ENG;
        
        UPDATE TB_GRADE 
        SET AVGGRADE = (NEW.LAN + NEW.MATH + NEW.ENG)/3;
        
  
    END;
    /
    
    
INSERT INTO TB_SCORE VALUES ('1', '홍길동', 80, 85, 95);


    /*
    CREATE TABLE TB_SCORE(     --성적테이블
    STUDENT_NO VARCHAR(30),   --학번
    STUDENT_NAME VARCHAR(30), --이름
    LAN NUMBER,               --국어
    ENG NUMBER,               --영어
    MATH NUMBER               --수학
);
*/
--3. 성적테이블이 UPDATE되면 해당 국어, 영어, 수학 점수의 값이 오라클 콘솔에 출력되는 트
--리거 생성
--AUTOPRINT



--4. 성적테이블에 INSERT/ UPDATE 되면 등수를 매겨서 저장해주는 프로시저 생성(어려움주의)




--5. 점수 테이블에 학생 데이터가 삭제되면 학점 테이블에도 학생 데이터 삭제 + 나머지 사람 등
--수 매기는 트리거 생성
--AUTODELETE

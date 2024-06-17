--1.춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열" 
--으로 표시하도록 한다.

SELECT DEPARTMENT_NAME AS "학과 명", CATEGORY AS "계열"
FROM TB_DEPARTMENT;

--2.  학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.

SELECT DEPARTMENT_NAME || '의 정원은', CAPACITY || '명 입니다.'
FROM TB_DEPARTMENT;

-- 3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이 
--들어왔다. 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 
--찾아 내도록 하자)
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y' AND SUBSTR(STUDENT_SSN, 8, 1) IN (2,4);
-- 질문하자

--STUDENT_NAME -------------------- 
--한수현 

--4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 핚다. 그 대상자들의 
--학번이 다음과 같을 때 대상자들을 찾는 적젃핚 SQL 구문을 작성하시오. 
  --  A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN( 'A513079', 'A513090', 'A513091', 'A513110', 'A513119' );


--5. 입학정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열을 출력하시오. 
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <=30;

-- 6. 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.  그럼 춘 
--기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7. 혹시 젂산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 핚다. 
--어떠핚 SQL 문장을 사용하면 될 것인지 작성하시오.

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8. 수강신청을 하려고 핚다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는 
--과목들은 어떤 과목인지 과목번호를 조회해보시오.

SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9. 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;


--10. 02 학번 전주 거주자들의 모임을 만들려고 한다. 휴학한사람들은 제외한 재학중인 
--학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N'
ORDER BY STUDENT_NAME;


----------------------------함수---------------------------------
--1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 
--순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가 
--표시되도록 핚다.) ※
SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "이름" , 
 TO_CHAR (ENTRANCE_DATE, 'YYYY-MM-DD') AS"입학연도"
--입학년도  1999-03-01 식으로 수정해야함
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE;


--2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 핚 명 있다고 핚다. 그 교수의 
--이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성핚 SQL 
--문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

--3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단 
--이때 나이가 적은 사람에서 맋은 사람 순서로 화면에 출력되도록 맊드시오. (단, 교수 중 
--2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 핚다. 나이는 ‘맊’으로 
--계산핚다.)

SELECT PROFESSOR_NAME AS "교수 이름" , 
TRUNC(MONTHS_BETWEEN(SYSDATE , SUBSTR(PROFESSOR_SSN,1,6))/12) AS "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8,1) IN (1,3);

--4. 교수들의 이름 중 성을 제외핚 이름맊 출력하는 SQL 문장을 작성하시오. 출력 헤더는 
--?이름? 이 찍히도록 핚다. (성이 2자인 경우는 교수는 없다고 가정하시오)

SELECT SUBSTR(PROFESSOR_NAME,2,2) 
FROM TB_PROFESSOR;

--5. 춘 기술대학교의 재수생 입학자를 구하려고 핚다. 어떻게 찾아낼 것인가?  이때, 
--19살에 입학하면 재수를 하지 않은 것으로 갂주핚다.
SELECT *
FROM TB_STUDENT;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE, SUBSTR(STUDENT_SSN,1,6))/12) =19; 

--6. 2020년 크리스마스는 무슨 요일인가?
/*  ?????
SELECT 
FROM DUAL;
*/

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')  은 각각 몇 년 몇 
--월 몇 일을 의미핛까? 또 TO_DATE('99/10/11','RR/MM/DD'), 
--TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미핛까? 

-- YY는 무조건 현재 세기로 입력하기 때문에
-- TO_DATE('99/10/11','YY/MM/DD')는 2099.10.11를 뜻하며
-- TO_DATE('49/10/11','YY/MM/DD')는 2049.10.11를 뜻한다 

-- RR은 50~99는 이전 세기로 인지하고 00~49는 현재 세기로 인지하기 때문에
-- TO_DATE('99/10/11','RR/MM/DD')는 1999.10.11이며
-- TO_DATE('49/10/11','RR/MM/DD')는 2049.10.11이다.


--8. 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 2000년도 
--이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE NOT SUBSTR(STUDENT_NO, 1,1) = 'A';

--9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단, 
--이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 핚 
--자리까지만 표시한다.

SELECT ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO ='A517178'
GROUP BY STUDENT_NO;


--10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 맊들어 결과값이 
--출력되도록 하시오. 

SELECT DEPARTMENT_NO AS "학과번호", CAPACITY "학생수(명)"
FROM TB_DEPARTMENT;


--11. 지도 교수를 배정받지 못핚 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을 
--작성하시오.  
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;



--12. 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단, 
--이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여 
--소수점 이하 핚 자리까지맊 표시핚다. ※

SELECT STUDENT_NO 
FROM TB_GRADE
GROUP BY STUDENT_NO
HAVING STUDENT_NO = 'A112113';

--13. 학과 별 휴학생 수를 파악하고자 핚다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 
--작성하시오. ※
SELECT DEPARTMENT_NO, COUNT(ABSENCE_YN)  
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NO, ABSENCE_YN
HAVING ABSENCE_YN = 'Y'
ORDER BY DEPARTMENT_NO;



--14.  춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 핚다. 어떤 SQL 
--문장을 사용하면 가능하겠는가? ※

-- SELECT 이름
-- FROM TB_STUDENT

--WHERE문에 COUNT, 이름 카운트 수가 1이 아닌 경우 


--15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총 
--평점을 구하는 SQL 문을 작성하시오. (단, 평점은 소수점 1자리까지맊 반올림하여 
--표시한다.)※

    --SELECT
    --FROM
    --WHERE

-----------------[Additional SELECT - Option]------------------------------
--1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 
--정렬은 이름으로 오름차순 표시하도록 핚다.
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;


--2.  휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
SELECT STUDENT_NAME,STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y' 
ORDER BY TO_DATE(SUBSTR(STUDENT_SSN,1,6));


--3. 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 
--주소를 이름의 오름차순으로 화면에 출력하시오. 단, 출력헤더에는 "학생이름","학번", 
--"거주지 주소" 가 출력되도록 핚다.

SELECT STUDENT_NAME AS "학생이름", STUDENT_NO AS "학번", STUDENT_ADDRESS AS "거주지 주소"
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS, 1,2) IN ('강원', '경기')
ORDER BY STUDENT_NAME;


--4. 현재 법학과 교수 중 가장 나이가 맋은 사람부터 이름을 확인핛 수 있는 SQL 문장을 
--작성하시오. (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 
--내도록 하자)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = 005
ORDER BY TO_DATE(SUBSTR(PROFESSOR_SSN,1,6));

--5. 2004년2학기에 'C3118100' 과목을 수강핚 학생들의 학점을 조회하려고 핚다. 학점이 
--높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 
--작성해보시오. 
SELECT *
FROM TB_GRADE
WHERE TERM_NO = 200402 AND CLASS_NO = 'C3118100'
ORDER BY POINT, STUDENT_NO DESC;


--6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 
--문을 작성하시오.
-- STUDENT_NO(TB_STUDENT), STUDENT_NAME(TB_STUDENT),DEPARTMENT_NAME(TB_DEPARTMENT)
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
ORDER BY STUDENT_NAME;


--7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO);

--8. 과목별 교수 이름을 찾으려고 핚다. 과목 이름과 교수 이름을 출력하는 SQL 문을 
--작성하시오.
--CLASS_NAME(TB_CLASS) 과목 이름                            CLASS_NO
--PROFESSOR_NAME(TB_PROFESSOR) 교수 이름   PROFESSOR_NO
--TB_CLASS_PROFESSOR 여기로 연결 CLASS_NO, PROFESSOR_NO
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);

--9. 8번의 결과 중 ‘인문사회’ 계열에 속핚 과목의 교수 이름을 찾으려고 핚다. 이에 
--해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR CP, TB_CLASS C, TB_PROFESSOR P, TB_DEPARTMENT D
--TB_ CLASS            CLASS NO                  DEPARTMENT_NO
--TB_CLASS_PROFESSOR   CLASS NO  PROFESSOR_NO
--TB DEPARTMENT                                  DEPARTMENT_NO
--TB PROFESSOR                   PROFFESOR_NO
WHERE D.DEPARTMENT_NO=C.DEPARTMENT_NO AND C.CLASS_NO = CP.CLASS_NO
AND P.PROFESSOR_NO = CP.PROFESSOR_NO
AND CATEGORY = '인문사회';

--10. ‘음악학과’ 학생들의 평점을 구하려고 핚다. 음악학과 학생들의 "학번", "학생 이름", 
--"젂체 평점"을 출력하는 SQL 문장을 작성하시오. (단, 평점은 소수점 1자리까지맊 
--반올림하여 표시핚다.)
SELECT STUDENT_NO, STUDENT_NAME, ROUND(AVG(POINT),1)
FROM TB_GRADE
JOIN TB_STUDENT USING (STUDENT_NO)
GROUP BY STUDENT_NO,  STUDENT_NAME;


--11. 학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 젂달하기 
--위핚 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용핛 SQL 문을 
--작성하시오.  단, 출력헤더는 ?학과이름?, ?학생이름?, ?지도교수이름?으로 
--출력되도록 핚다. ※
--SELECT DEPARTMENT_NAME(TB_DEPARTMENT), STUDENT_NAME(TB_STUDENT), 
-- COACH_PROFESSOR_NO(TB_STUDENT), PROFESSOR_NAME(PROFESSOR_NAME)

SELECT DEPARTMENT_NAME AS "학과이름", STUDENT_NAME AS "학생이름", PROFESSOR_NAME AS "지도교수이름"
FROM TB_STUDENT
JOIN TB_PROFESSOR USING(DEPARTMENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)

WHERE STUDENT_NO = 'A313047';


--12. 2007 년도에 '인갂관계롞' 과목을 수강핚 학생을 찾아 학생이름과 수강학기름 표시하는 
--SQL 문장을 작성하시오.  
--TB_CLASS의 CLASS_NO C2604100, CLASS_NAME 인간관계론
--TB_GRADE의 TERM_NO 2007년도, CLASS NO  C2604100 STUDENTNO
--학생이름 TB_STUDENT의 STUDENT_NAME                 STUDENTNO
SELECT STUDENT_NAME, TERM_NO
FROM TB_GRADE 
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_STUDENT USING (STUDENT_NO)
WHERE CLASS_NO = 'C2604100'  AND SUBSTR(TERM_NO,1,4) = '2007';


--13. 예체능 계열 과목 중 과목 담당교수를 핚 명도 배정받지 못핚 과목을 찾아 그 과목 
--이름과 학과 이름을 출력하는 SQL 문장을 작성하시오. ※

--TB_CLASS_PROFESSOR             CLASS_NO, PROFFESOR_NO       CLASS_NO
--교수가 없음
--WHERE PROFESSOR_NO IS NULL

--TB_CLASS  CLASS_NAME            DEPARTMENT_NO                         CLASS_NO
--수업 이름

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_CLASS_PROFESSOR USING (CLASS_NO) 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE CATEGORY = '예체능' AND PROFESSOR_NO IS NULL;


SELECT DEPARTMENT_NAME
FROM TB_DEPARTMENT
WHERE CATEGORY = '예체능' AND DEPARTMENT_NAME IS NULL;

--14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 핚다. 학생이름과 
--지도교수 이름을 찾고 맊일 지도 교수가 없는 학생일 경우 "지도교수 미지정?으로 
--표시하도록 하는 SQL 문을 작성하시오. 단,  출력헤더는 ?학생이름?, ?지도교수?로 
--표시하며 고학번 학생이 먼저 표시되도록 핚다.

SELECT D.STUDENT_NAME AS "학생이름", PROFESSOR_NAME AS "지도교수"
FROM TB_STUDENT D
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE D.DEPARTMENT_NO = 20; 

--15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과 
--이름, 평점을 출력하는 SQL 문을 작성하시오.  

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME, AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
GROUP BY STUDENT_NO, ABSENCE_YN, STUDENT_NAME,DEPARTMENT_NAME
HAVING AVG(POINT) > 4.0 AND ABSENCE_YN = 'N';


--16. 홖경조경학과 젂공과목들의 과목 별 평점을 파악핛 수 있는 SQL 문을 작성하시오.※
-- 학과이름,  --전공과목 , --과목별 평점 


--점수, TB_GRADE의 POINT, 나중에 과목별로 묶어야함               CLASS_NO      

--학과이름, TB_DEPARTMENT의 DEPARTMENT_NAME                               

--TB_CLASS의 전공과목. CLASS_TYPE                             CLASS_NO    
SELECT CLASS_TYPE, AVG(POINT)
FROM TB_CLASS
JOIN TB_GRADE USING (CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO) 
GROUP BY CLASS_TYPE, POINT
HAVING DEPARTMENT_NAME = '환경조경학과';

--17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 
--SQL 문을 작성하시오.※
--학생 이름,   학생 주소, 과 이름 ,
--TB_STUDENT의 STUDENT NAME학생이름, STUDENT_ADDRESS 학생주소 
--TB_DEPARTMENT의 DEPARTMENT_NAME 과 이름 

SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO       '최경희';



--18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL문을 
--작성하시오.※
SELECT ;



--19. 춘 기술대학교의 "홖경조경학과"가 속핚 같은 계열 학과들의 학과 별 젂공과목 평점을 
--파악하기 위핚 적젃핚 SQL 문을 찾아내시오. 단, 출력헤더는 "계열 학과명", 
--"젂공평점"으로 표시되도록 하고, 평점은 소수점 핚 자리까지맊 반올림하여 표시되도록 
--핚다.※


----------------------------------DDL--------------------------------------
--1. 계열 정보를 저장핛 카테고리 테이블을 맊들려고 핚다. 다음과 같은 테이블을 
--작성하시오. 

CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 1
);

--2. 과목 구분을 저장핛 테이블을 맊들려고 핚다. 다음과 같은 테이블을 작성하시오
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    --기본키지정
    NAME VARCHAR2(10)
);

--3. TB_CATAGORY 테이블의 NAME 컬럼에 PRIMARY KEY를 생성하시오. 
--(KEY 이름을 생성하지 않아도 무방함. 맊일 KEY 이를 지정하고자 핚다면 이름은 본인이 
--알아서 적당핚 이름을 사용핚다.) 
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);



--4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오.
ALTER TABLE TB_CLASS MODIFY CLASS_TYPE NOT NULL;


--5. 두 테이블에서 컬럼 명이 NO인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이 
--NAME 인 것은 마찪가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR(10);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR(20);


--6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_ 를 제외핚 테이블 이름이 앞에 
--붙은 형태로 변경핚다. 
--(ex. CATEGORY_NAME)
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;


--7. TB_CATAGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이 
--변경하시오. 
--Primary Key 의 이름은 ?PK_ + 컬럼이름?으로 지정하시오. (ex. PK_CATEGORY_NAME )
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINTS SYS_C007268 TO PK_CLASS_TYPE_NAME;
ALTER TABLE TB_CATEGORY RENAME CONSTRAINTS SYS_C007251 TO PK_CATEGORY_NAME;



--8. 다음과 같은INSERT 문을 수행핚다. 
INSERT INTO TB_CATEGORY VALUES ('공학','Y'); 
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y'); 
INSERT INTO TB_CATEGORY VALUES ('의학','Y'); 
INSERT INTO TB_CATEGORY VALUES ('예체능','Y'); 
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y'); 
COMMIT; 

--9.TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모 
--값으로 참조하도록 FOREIGN KEY를 지정하시오. 이 때 KEY 이름은 
--FK_테이블이름_컬럼이름으로 지정핚다. (ex. FK_DEPARTMENT_CATEGORY ) 

ALTER TABLE TB_DEPARTMENT
  ADD FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

------------------------------view 문제 ----------------------

--10. 춘 기술대학교 학생들의 정보맊이 포함되어 있는 학생일반정보 VIEW를 맊들고자 핚다. 
--아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오. ※

CREATE VIEW VW_학생일반정보
 AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
 FROM TB_STUDENT;
 

 --학번 STUDENT_NO
 --학생이름 STUDENT_NAME
 --주소 STUDENT_ADDRESS



--11. 춘 기술대학교는 1년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행핚다. 
--이를 위해 사용핛 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 맊드시오. 
--이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 (단, 이 VIEW 는 단순 SELECT 
--맊을 핛 경우 학과별로 정렬되어 화면에 보여지게 맊드시오.) ※

--학생이름, 학과이름, 담당교수이름
--STUDENT_NAME, DEPARTMENT_NAME(TB_DEPARTMENT), COACH_PROFESSOR

DROP VIEW VW_지도면담;

CREATE VIEW VW_지도면담
 AS SELECT STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME
 FROM TB_STUDENT
 JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
 JOIN  TB_PROFESSOR ON (PROFESSOR_NO = COACH_PROFESSOR_NO)
 ORDER BY DEPARTMENT_NAME; 
 
 SELECT * FROM VW_지도면담;
 --NULL값은


--12. 모든 학과의 학과별 학생 수를 확인핛 수 있도록 적젃핚 VIEW 를 작성해 보자. ※
CREATE VIEW VW_학과별학생수 
 AS SELECT DEPARTMENT_NAME, CAPACITY "STUDENT_COUNT"
 FROM TB_DEPARTMENT;
 
 SELECT * FROM VW_학과별학생수;

--13. 위에서 생성핚 학생일반정보 View를 통해서 학번이 A213046인 학생의 이름을 본인 
--이름으로 변경하는 SQL 문을 작성하시오. ※


 UPDATE VW_학생일반정보
            SET 
            (
            SELECT STUDENT_NAME 
            FROM TB_STUDENT
        
           WHERE STUDENT_NO = 'A213046')
            FROM TB_STUDENT;

--14. 13 번에서와 같이 VIEW를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW를 
--어떻게 생성해야 하는지 작성하시오. ※


DROP VIEW VW_학생일반정보;

CREATE VIEW OR REPLACE VW_학생일반정보 
 AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
 FROM TB_STUDENT
 WITH READ ONLY; 
 


----------------------------------------------------


--15. 춘 기술대학교는 매년 수강신청 기갂맊 되면 특정 인기 과목들에 수강 신청이 몰려 
--문제가 되고 있다. 최근 3년을 기준으로 수강인원이 가장 맋았던 3 과목을 찾는 구문을 
--작성해보시오.※※


----------------------------------DML-------------------------------------
--1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오.
ALTER TABLE TB_CLASS_TYPE MODIFY CLASS_TYPE_NO VARCHAR(20);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR(20);

INSERT INTO TB_CLASS_TYPE VALUES('01', '전공필수');
INSERT INTO TB_CLASS_TYPE VALUES('02', '전공선택');
INSERT INTO TB_CLASS_TYPE VALUES('03', '교양필수');
INSERT INTO TB_CLASS_TYPE VALUES('04', '교양선택');
INSERT INTO TB_CLASS_TYPE VALUES('05', '논문지도');


-- 2. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보 테이블을 맊들고자 핚다. 
--아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오. (서브쿼리를 이용하시오)
CREATE TABLE TB_학생일반정보
    AS SELECT STUDENT_NO,
    STUDENT_NAME,
    STUDENT_ADDRESS
    FROM TB_STUDENT;
    
       
    --TB_STUDENT 
      -- STUDENT_NO 학번 
      -- STUDENT_NAME 학생이름
      -- STUDENT_ADDRESS 학생 주소
       



 --3. 국어국문학과 학생들의 정보맊이 포함되어 있는 학과정보 테이블을 맊들고자 핚다. 
--아래 내용을 참고하여 적젃핚 SQL 문을 작성하시오. (힌트 : 방법은 다양함, 소신껏 
--작성하시오)
CREATE TABLE TB_국어국문학과 AS
    
    SELECT STUDENT_NO, -- 학번
    STUDENT_NAME, -- 이름
    STUDENT_ADDRESS, -- 주소
    PROFESSOR_NAME -- 교수이름
    
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    JOIN TB_PROFESSOR USING (DEPARTMENT_NO)
    WHERE DEPARTMENT_NAME = '국어국문학과';
    
   --출생년도
   --교수이름



--4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용핛 SQL 문을 작성하시오. (단, 
--반올림을 사용하여 소수점 자릿수는 생기지 않도록 핚다) 

UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY*1.1);


--5. 학번 A413042 인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21 "로 변경되었다고 
--핚다. 주소지를 정정하기 위해 사용핛 SQL 문을 작성하시오. 

SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';


ALTER TABLE TB_STUDENT MODIFY STUDENT_ADDRESS VARCHAR2(300);

UPDATE TB_STUDENT
SET STUDENT_ADDRESS =  "서울시 종로구 숭인동 181-21" --오류 발생
WHERE STUDENT_NO = 'A413042';


--6. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로 
--결정하였다. 이 내용을 반영핛 적젃핚 SQL 문장을 작성하시오. 
--(예. 830530-2124663 ==> 830530 )  

UPDATE TB_STUDENT
SET STUDENT_NO = SUBSTR(STUDENT_NO, 1, 6);

--7. 의학과 김명훈 학생은 2005년 1학기에 자신이 수강핚 '피부생리학' 점수가 
--잘못되었다는 것을 발견하고는 정정을 요청하였다. 담당 교수의 확인 받은 결과 해당 
--과목의 학점을 3.5로 변경키로 결정되었다. 적젃핚 SQL 문을 작성하시오. 

UPDATE TB_GRADE 
SET POINT = 3.5
WHERE STUDENT_NO = 
    (
    SELECT STUDENT_NO
    FROM TB_STUDENT 
    JOIN TB_CLASS USING (DEPARTMENT_NO)
    WHERE STUDENT_NAME = '김명훈' AND CLASS_NAME = '피부생리학'
    AND TERM_NO = '200501'
);

--8. 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거하시오.
DELETE FROM TB_GRADE

WHERE STUDENT_NO IN (
    SELECT STUDENT_NO
    FROM TB_STUDENT
    WHERE ABSENCE_YN = 'Y');
    




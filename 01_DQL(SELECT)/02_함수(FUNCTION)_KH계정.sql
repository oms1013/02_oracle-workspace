/*
       < 함수 FUNCTION>
       전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환함
       
       - 단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴(매 행마다 함수 실행 결과 반환)
       - 그룹 함수  : N개의 값을 읽어들여서 1개의 결과값을 리턴(그룹을 지어 그룹별로 함수 실행 결과 반환)
            
            
        >> SELECT 절에 단일행 함수, 그룹함수는 같이 사용할 수 없음 
          왜? 결과 행의 개수가 다르기 때문 
          
        >> 함수식을 기술 할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
       
             
*/

/*
    < 문자 처리 함수 >

    * LENGTH / LENGTHB   => 결과값 NUMBER타입 
    
    LENGTH(컬럼|'문자열값') : 해당 문자열의 글자수 반환
    LENGTHB(컬럼|'문자열값') : 해당 문자열 값의 바이트 수 반환 

    '김', '나', 'ㄱ' 한글자당 3BYTE 
    영문자, 숫자, 특문  한글자당 1BYTE 
*/

SELECT SYSDATE
FROM DUAL;


SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; --가상 테이블 : 테이블을 쓸 게 없을 때 쓰는 것 

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),EMAIL,
LENGTH(EMAIL),LENGTHB(EMAIL)
FROM EMPLOYEE; --매 행마다 실행이 되고 있음= 단일행 함수


/*
    *INSTR
    문자열로부터 특정 문자의 시작위치를 찾아서 반환
    
    INSTR(컬럼|'문자열', '찾고자하는문자', ['찾을위치의 시작값'], [순번] =>결과값 NUMBER타입)
    
    찾을 위치의 시작값
    1 : 앞에서부터 찾겠다
    -1 : 뒤에서부터 찾겠다 
    
*/

SELECT INSTR ('AABAACAABAAA','B') FROM DUAL;
--찾을 위치의 시작값은 1기본값 => 앞에서부터 찾음,순번도 기본값이 1이다.
--(첫번째 B를 찾아냄)
SELECT INSTR('AABAACAABBAAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAAA', 'B', 1,2) FROM DUAL;
SELECT INSTR('AABAACAABBAAA', 'B', -1,3) FROM DUAL;


SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "위치",INSTR(EMAIL,'@') AS "@위치"
--앞에서부터 첫번째 _
FROM EMPLOYEE;
 

--------------------------------------------------
/*
    *SUBSTR
    문자열에서 특정 문자열을 추출해서 반환(자바의 subString()메소드와 유사
    
    SUBSTR(STRING, POSITION, [LENGTH])   => 결과값이 CHARACTER 타입
    - STRING : 문자타입컬럼 또는 '문자열값'
    - POSITION : 문자열을 추출할 시작위치값
    - LENGTH : 추출할 문자 개수 (생략시 끝까지 의미) 
    
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; 
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL; 
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8,1) AS "성별"
FROM EMPLOYEE; 



-- 여자 사원들만 조회
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = 2 OR SUBSTR(EMP_NO,8,1) = 4;
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');
--IN절을 사용해서 주민번호 8위치에 한글자가 2거나 4면 여자사원
--주민번호 뒷자리 첫글자가 2,4면 여자 사원 


SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (1,3) --따옴표 안써도 알아서 출력됨
--오라클?SQL은 형변환이 자동으로 잘 되는 편
--WHERE NOT SUBSTR(EMP_NO,8,1) IN ('2','4');
ORDER BY 1; --기본적으로 오름차순



-- 함수 중첩 사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1   )
--시작부부터 골뱅이 한칸 이전까지의 결과를 출력 
FROM EMPLOYEE; 





----------------------------------------------------------------
/*
   *LPAD / RPAD
   문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용
   
   LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자하는 문자])

    문자열에 덧붙이고자 하는 문자를 왼쪽, 오른쪽에 덧붙여서 최종 N길이만큼의 문자열 반환
    
*/
SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20) --출력결과가 나란히 나오고 모자란녀석은
--그만큼 공백이 늘어남. 덧붙이고자 하는 문자 생략시 기본값이 공백이 됨 
FROM EMPLOYEE; 

SELECT EMP_NAME, LPAD(EMAIL, 20, '#') --왼쪽정렬
FROM EMPLOYEE; 

SELECT EMP_NAME, RPAD(EMAIL, 20, '#') --오른쪽정렬
FROM EMPLOYEE; 

-- 주민번호 852583 - 2****** (마스킹처리) ☆☆
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;


--주민번호 마스킹 : SUBSTR함수 + RPAD함수
--SELECT EMP_NAME, SUBSTAR(EMP_NO,1,8) ||'******' 이 방법도 가능
--☆☆☆
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') AS "주민번호"
FROM EMPLOYEE;


----------------------------------------------------------------

/*
    LTRIM / RTRIM 
    문자열에서 특정 문자를 제거한 나머지를 반환 
    
    LTRIM / RTRIM (STRING, ['제거할문자들']) => 생략하면 공백 제거해줌
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 
    제거 후 문자열을 반환한다.
    
*/

SELECT LTRIM('        K   H    ') FROM DUAL;
--공백을 제거하고 공백이 아닌 문자가 나오면 제거가 중단됨. 
-- 그래서 출력결과는 ('K    H   ')
SELECT LTRIM('123123KH123', '123') FROM DUAL;
--연달아서 123을 두번 지우고 KH123만 출력
SELECT LTRIM('ACABACCKH', 'ABC')FROM DUAL;
--안에 A,B,C를 전부 제거하고 KH만 남아서 출력 
--즉 덩어리를 지우는게 아니라 포함된걸 전부 제거한다

SELECT RTRIM('5782KH123', '0123456789') FROM DUAL; 
--출력결과 5782KH, 이건 오른쪽에서부터 다지운다

/*  
    *TRIM
    문자열의 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    
    TRIM(제거하고자 하는 문자들 FROM STRING)
    
    TRIM(  [LEADING | TRALLING | BOSS] 
    [제거하고자 하는 문자들 FROM]STRING)
*/

--기본적으론 양쪽의 문자들을 다 찾아 제거
SELECT TRIM ('      K    H     ') FROM DUAL;
--  출력    'K    H'
SELECT TRIM('Z' FROM 'ZZZZZZZKHZZZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZZZZKHZZZZZ') FROM DUAL;
-- LEADING 입력시 LTRIM과 동일하게 왼쪽만지움

--SELECT TRIM(TRALLING 'Z' FROM 'ZZZZZZZKHZZZZZ') FROM DUAL;
-- TRALLING은 오른쪽
--SELECT TRIM(BOSS 'Z' FROM 'ZZZZZZZKHZZZZZ') FROM DUAL;
-- BOSS는 양쪽

/*
    * LOWER / UPPER /  INITCAP
    
     LOWER / UPPER / INITCAP (STRING)  =>   결과값은 CHARACTER타입
    LOWER : 다 소문자로 변경한 문자열 반환(자바에서의 toLowerCase()메소드와 유사
    UPPER : 다 대문자로 변경한 문자열 반환(자바에서의 toUpperCase()메소드와 유사
    LOWER : 단어 앞글자마자 대문자로 변경한 문자열 반환
         
*/

SELECT LOWER('Welcome To My World!') From DUAL;
SELECT UPPER('Welcome To My World!') From DUAL;
SELECT INITCAP('welcome to my world!') FROM DUAL;


--------------------------------------------------------

/*
    *CONCAT 
    문자열을 두개를 전달받아 하나로 합친 후 결과를 반환

    CONCAT(STRING, STRING) =>결과값 CHARACTER 타입
*/

SELECT CONCAT('ABC', '초콜릿') FROM DUAL; 
SELECT 'ABC' || '초콜릿' FROM DUAL; 

SELECT CONCAT('ABC','초콜릿','123')FROM DUAL; --오류발생 : 2개만받을수있음
SELECT 'ABC' || '초콜릿' ||'이이잉' FROM DUAL; 


---------------------------------------------------

/*
   *REPLACE
   
      REPLACE(STRING, STR1, STR2)   =>결과값은 CHARACTER타입
      
*/

--☆☆
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
-- EMAIL의 도메인 내에 'kh.or.kr'을 'gmail.com'으로 변경
FROM EMPLOYEE; 

 ---------------------------------------------------
 
 /*
        <  숫자 처리 함수  >
        
        * ABS
        숫자의 절대값을 구해주는 함수 
        
        ABS(NUMBER)       => 결과값은 NUMBER타입
                
 */
 SELECT ABS(-10) FROM DUAL;
 SELECT ABS(-5.7) FROM DUAL;
 
 ---------------------------------------------------
 
 /*
    *MOD
    두 수를 나눈 나머지값을 반환해주는 함수 
    
    MOD(NUMBER, NUMBER)    => 결과값은 NUMBER 타입! 
    
 */
 SELECT MOD(10, 3) FROM DUAL; 
 SELECT MOD(10.9, 3) FROM DUAL; 
 -------------------------------------------
 /* 
    * ROUND
    반올림한 결과를 반환
    
    ROUND (NUMBER, [위치])   => 결과값은 NUMBER 타입 
 */
 
 SELECT ROUND(123.456, 0) FROM DUAL; --위치 생략시 0 
 SELECT ROUND(123.456, 1) FROM DUAL;
 SELECT ROUND(123.456, 5) FROM DUAL;
 SELECT ROUND(123.456, -2)FROM DUAL;
 
 
 --------------------------------------------------
 /*
    *Ceil
    올림처리 해주는 함수. 
    
    CEIL(NUMBER) 
      
  */
 
 SELECT CEIL(123.152) FROM DUAL; -- 5 이상이 아니더라도 그냥 '올림'
    -- 124 출력

 ----------------------------------------------------------
 
 /*
    * FLOOR
    소수점 아래를 버림처리하는 함수
 
    FLOOR(NUMBER)
  */
 
 SELECT FLOOR(123.152) FROM DUAL;
 -- 123 출력. 무조건 버려서 정수형태로 출력
 
 ------------------------------------------------------------------
 /*
        * TRUNC(절삭하다)
        위치를 지정해서 버림처리
        
        TRUNC(NUMBER, [위치])
 */
 SELECT TRUNC(123.456) FROM DUAL; --위치지정 안하면 FLOOR이랑 다를 바 없음
 SELECT TRUNC(123.456, 1) FROM DUAL; --123.4 출력. 소수점 아래 첫째짜리까지 표현
 SELECT TRUNC(123.456, -1) FROM DUAL; --120
 
 
 --------------------------------------------------------------------------
 
 /*
    < 날짜 처리 함수> 
 */
 
 -- * SYSDATE : 시스템 날짜 및 시간 반환 (현재 날짜 및 시간) 
 SELECT SYSDATE FROM DUAL; --표기가 다 안되서 그렇지 결과 더블클릭하면 
 --시간까지 확인이 가능하다
 
 
 
 -- * MONTHS_BETWEEN(DATE1, DATE2): 두 날짜 사이의 개월 수 => 내부적으로 첫번째로 받은
    --DATE 1의 날짜와 - DATE2 후 나누기 30, 31이 진행됨
    -- 결과값은 NUMBER타입이다
    -- EMPLOYEE 테이블에서 사원명, 입사일, 근무일수, 근무개월수
    SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE)||'일' AS "근무일수"
    , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "근무개월수"
    FROM EMPLOYEE;
 
 
 -- * ADD_MONTHS(DATE, NUMBER) : 특정 날짜에 해당 숫자만큼의 개월수를 
 --  더한 뒤에 날짜를 리턴한다. 결과값은 DATE타입
 SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;
 --오늘로부터 6개월 뒤에 날짜를 반환한다
 
 
 --EMPLOYEE에서 사원명, 입사일, 입사후 6개월이 된 날짜 조회
 SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)AS "수습기간 종료일"
 FROM EMPLOYEE;

    
 --* NEXT_DAY(DATE, 요일(문자|숫자)) : 특정 날짜 이후 가까운 해당 요일의 
 --날짜를 반환해주는 함수
 -- =>결과값은 DATE타입
 SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
 --오늘 날짜 이후 가장 가까운 금요일의 날짜를 출력
 
 
SELECT * FROM NLS_SESSION_PARAMETERS;
-- 설정 조회 명령문
-- 확인해보면 한국어 설정으로 되있음을 알 수 있다. 

ALTER SESSION SET NLS_LANGUAGE= AMERICAN; --KOREAN 
--설정을 영어로 바꿀수 있다. 참고만 

-- * LAST_DAY(DATE) : 해당월의 마지막 날짜를 구해서 반환 
-- => 결과값은 DATE타입!! 

SELECT LAST_DAY(SYSDATE) FROM DUAL; 

--EMPLOYEE에서 사원명, 입사일, 입사한달의 마지막 날짜, 입사한달 근무일한 일수 
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE),
LAST_DAY(HIRE_DATE)-HIRE_DATE+1 AS "입사한 달 근무일수"
FROM EMPLOYEE; 

 /*
     *EXTRACT : 특정 날짜로부터 년도|월|일 값을 추출해서 반환해주는 함수
     
     EXTRACT(YEAR FROM DATE) : 년도만 추출함 
     EXTRACT(MONTH FROM DATE) : 월만 추출함
     EXTRACT(DAY FROM DATE) : 일만 추출함 
  
 */
 --사원명, 입사년도, 입사월, 입사일 조회
 
 SELECT EMP_NAME,  
 EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도",
 EXTRACT(MONTH FROM HIRE_DATE) AS "입사월",
 EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
 FROM EMPLOYEE
  ORDER BY "입사년도", "입사월", "입사일"; --입사년도별 정렬
  --입사년도가 같으면 입사월, 그것도 같으면 입사일
  
----------------------------------------------------------

/*
    < 형변환 함수 > 
    
    * TO_CHAR : 숫자타입 또는 날짜타입 값을 문자타입으로 변환
    
    TO_CHAR(숫자|날짜,[포맷]) =>결과값은 CHARACTER타입!
        
*/
 
 --형변환으로 숫자를 CHAR형으로 바꿈
 SELECT TO_CHAR(1234) FROM DUAL; -- '1234' 로 바뀌어있는거임
 SELECT TO_CHAR(1234, '99999') FROM DUAL;
 --이건 5칸짜리 공간을 확보해서 4칸인 1234 를 넣음.
 -- 99999...는 공간을 비워서 공백을 만든다
 -- 00000...을 넣으면 빈 만큼 앞에 0을 집어넣어서 만듬
 SELECT TO_CHAR(1234, 'L99999') FROM DUAL; 
 -- 화폐 단위가 L이라서 1234원을 표현
 
 SELECT TO_CHAR(1234, '$99999')FROM DUAL;
 SELECT TO_CHAR(1234, 'L99,999')FROM DUAL;
 
 SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
 --화폐단위로 출력할 수 있게 변경, 쉼표도 3줄마다 하나씩 찍어줌 
 FROM EMPLOYEE;
 
 
 ---날짜타입 => 문자타입
 SELECT SYSDATE FROM DUAL;
 SELECT TO_CHAR(SYSDATE) FROM DUAL; --클릭해보면 다름. 날짜타입은
 --달력,시간이 나오지만 이건 문자형이라 날짜까지만 출력됨
 SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; --HH: 12시간형식
 SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; --HH: 24시간형식
 SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL; 
 SELECT TO_CHAR(SYSDATE, 'MON,YYYY') FROM DUAL; 
 
 SELECT EMP_NAME, HIR_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
 FROM EMPLOYEE;
 
 -- EX) 1990년 02월 06일 형식으로 
 SELECT TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"')
 --이런식으로 없는 포맷은 제시할 때 ""로 묶으면 가능하다.
 FROM EMPLOYEE;
 
 
 
 -- 년도와 관련된 포맷
 SELECT TO_CHAR(SYSDATE, 'YYYY'), --2024
        TO_CHAR(SYSDATE, 'YY'), -- 24
        TO_CHAR(SYSDATE, 'RRRR'), --2024
        TO_CHAR(SYSDATE, 'RR'), -- 24
        TO_CHAR(SYSDATE, 'YEAR') -- TWENTY TWENTY-FOUR
                    
 FROM DUAL; 
 
 
 
 
 -- 연도와 관련된 포맷 
 SELECT TO_CHAR(SYSDATE, 'MM'), --06
        TO_CHAR(SYSDATE, 'MON'), --6월
        TO_CHAR(SYSDATE, 'MONTH'), --6월
        TO_CHAR(SYSDATE, 'RM') --VI
 FROM DUAL; 
 
 --일에 대한 포맷
 SELECT TO_CHAR(SYSDATE, 'DDD'), --올해 기준 오늘이 며칠째인지
        TO_CHAR(SYSDATE, 'DD'), -- 이번달 기준 오늘이 며칠째인지 
        TO_CHAR(SYSDATE, 'D') -- 이번주 기준 며칠째인지
 FROM DUAL;
 
 --요일에 대한 포맷
 SELECT TO_CHAR(SYSDATE, 'DAY'), --금요일
        TO_CHAR(SYSDATE, 'DY') --금 
 FROM DUAL; 

------------------------------------------------------
/*
    * TO_DATE : 숫자타입 또는 문자타입 데이터를 
    날짜 타입으로 변환 시켜주는 함수
    
    TO_DATE(숫자|문자, [포맷]) =>결과값 DATE타입
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(110101) FROM DUAL;

-- SELECT TO_DATE(070101) FROM DUAL; --에러, 맨 앞이 0임
SELECT TO_DATE('070101') FROM DUAL; --첫글자 0인경우에는
--문자타입으로 변경하고 해야함. 

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS')  FROM DUAL; --에러

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL; --2014 이상없이 출력
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; --2098년이 출력
--이유 : 저 YY는 무조건 현재 세기 기준으로 판단함. 

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;--2014년은 잘붙어줌
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL;--98년에 잘 붙어줌
--RR은 해당 두자리 년도 값이 50미만일경우 현재 세기 반영, 이상이면 
--이전 세기를 반영해준다. 

--투데이트 사용처는? 
--웹화면같은 곳에서 무조건 문자타입으로 넘어감. 

------------------------------------------------------------
/*
    * TO_NUMBER : 문자타입의 데이터를 숫자타입으로 변환시켜주는 함수 
    
    TO_NUMBER(문자, [포맷])     =>결과값은 NUMBER타입!!
*/
 
 SELECT TO_NUMBER('05196544')FROM DUAL; 
 -- 0이 빠져서 숫자타입으로 저장됨
 
 SELECT '10000000' + '55000' FROM DUAL;
 --자동으로 형변환을 해서 더하는 모습 1055000
 
 SELECT '10,000,000' +'55,000' FROM DUAL;
 --오류 발생, 안에 숫자만 있어야 자동형변환이 된다 
 
 SELECT TO_NUMBER('10,000,000', '99,999,999')+ TO_NUMBER('55,000', '99,999') FROM DUAL;
 --오류난다. 수정해야함
 
 
 /*
    < NULL 처리 함수>
 */
 -- NVL(컬럼, 해당컬럼값이 NULL일경우 반환할 값) 
 SELECT EMP_NAME, BONUS, NVL(BONUS,0) --NULL이면 0으로 반환
 FROM EMPLOYEE;
 
 --전 사원의 이름 보너스포함 연봉 
 SELECT EMP_NAME, BONUS, (SALARY+SALARY *BONUS)*12
 ,(SALARY+SALARY *NVL(BONUS, 0))*12
 --연봉계산중 NULL때문에 연봉결과가 NULL이 되는데, NVL을 통해
 --NULL을 0취급하고 계산하면 정상적으로 연봉이 출력된다
 FROM EMPLOYEE;
 
 SELECT EMP_NAME, NVL(DEPT_CODE, '부서 없음')
 --NVL은 0뿐 아니라 글자도 입력할 수 있다. 부서 결과 NULL->부서 없음
 FROM EMPLOYEE;
 
 --NVL2(컬럼, 반환값1, 반환값2) 
 --컬럼값이 존재할경우 반환값 1을 반환
 --컬럼값이 NULL일 경우 반환값 2를 반환
 
 SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
 --기존의 보너스 있는 인원은 0.7로 변경, 없던 인원들 0.1로 변경
 FROM EMPLOYEE; 
 
 SELECT EMP_NAME, NVL2(DEPT_CODE, '부서 있음', '부서 없음')
 --부서 있던 인원 -> 부서 있음 , 없으면 -> 부서 없음 
 FROM EMPLOYEE;
 
 
 -- NULLIF(비교대상1, 비교대상2)
 -- 두 값이 일치하면 NULL 반환
 -- 두개의 값이 일치하지 않으면 비교대상1 값을 반환
 SELECT NULLIF ('123', '123') FROM DUAL;
 SELECT NULLIF ('123', '456') FROM DUAL;
 
 -------------------------------------------------
 
 /*
    < 선택 함수 >    
    
    * DECODE(비교하고자 하는 대상(컬럼|산술연산|함수식), 
      비교값1, 결과값1, 비교값2, 결과값2, ...)
    
    SWITCH(비교대상)
    CASE 비교값1 : BREAK;
    CASE 비교값2 : BREAK; 
    ...
    DEFAULT 
            
 */
 
 -- 사번, 사원명, 주민번호 
SELECT
EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1), 
DECODE(SUBSTR(EMP_NO, 8,1), '1','남','2','여') "성별" 
FROM EMPLOYEE; 
 
 -- 직원의 급여 조회시 각 직급별로 인상해서 조회 
 -- J7인 사원은 급여를 10% 인상 (SALARY*1.1)
 -- J6인 사원은 급여를 15% 인상 (SALARY*1.5) 
 -- J5인 사원의 급여를 20% 인상 (SALARY*1.2) 
 -- 그 외의 사원은 급여를 5% 인상 (SALARY * 1.05) 
 
 -- 사원명, 직급코드, 기존급여 , 인상된 급여, 
 SELECT EMP_NAME, JOB_CODE, SALARY, 
        DECODE(JOB_CODE, 'J7', SALARY*1.1, 
                          'J6',SALARY*1.15,
                          'J5', SALARY*1.2, 
 SALARY*1.05) AS "인상된 급여"
 FROM EMPLOYEE; 
 
 /*
    *CASE WHEN THEN
    
    CASE WHEN 조건식1 THEN 결과값1
         WHEN 조건식2 THEN 결과값2
         ...
         ELSE 결과값N
          
    END
    
    자바에서의 IF-ELSE IF문
    
 */
 
 SELECT EMP_NAME, SALARY,
        CASE WHEN SALARY >= 5000000 THEN '고급 개발자' 
             WHEN SALARY >= 3500000 THEN '중급 개발자'
             ELSE '초급 개발자'
        END AS "레벨"
FROM EMPLOYEE; 

 
 ------------------ < 그룹 함수 > -----------------
 --1. SUM(숫자타입컬럼) : 해당 컬럼 값들의 총 합계를 구해서 반환해주는 함수
 
 -- EMPLOYEE 테이블의 전 사원 총 급여합 
 SELECT SUM(SALARY) 
 FROM EMPLOYEE; -- 전체사원이 한 그룹으로 묶임
 
 -- 남자 사원들의 총 급여합 
 SELECT SUM(SALARY)
 FROM EMPLOYEE 
 WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); 
 
 --부서코드가 D5인 사원들의 총 연봉합
 
 SELECT SUM(SALARY*12)-- EMP_NAME
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5';
 --SELECT절에 단일행함수, 그룹함수를 같이 사용할수 없음. 
 --EMP_NAME이 들어갈 곳이 없다. 
 
 -- 2.AVG(숫자타입) : 해당 컬럼값들의 평균값을 구해서 반환 
 -- 전체 사원의 평균 급여 조회 
 SELECT ROUND(AVG(SALARY)) 
 FROM EMPLOYEE; 
 
 
 -- 3. MIN(여러타입) :  해당 컬럼값들 중에 가장 작은 값을 구해서 반환
 SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
 FROM EMPLOYEE;
 -- EMPLOYE의 저 값들 중 가장 낮은것들만 모아서 출력
 
 --4. MAX(여러타입): 해당 컬럼값들 중에 가장 큰 값을 구해서 반환
 SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
 FROM EMPLOYEE;
 --MIN의 반대. 마찬가지로 가장 높은거만 모아서 출력
 
 --5. COUNT(*|컬럼|DISTINCT) : 조회된 행 개수를 세서 반환 
 --   COUNT(*) : 조회된 결과의 모든 행 개수를 세서 반환
 --   COUNT(컬럼) : 제시한 해당 컬럼값이 NULL 아닌것만 
 --   COUNT(DISTINCT 컬럼) : 해당 컬럼값 중복을 제거한 후 
 --                         행 개수 세서 반환
 

-- 전체 사원 수 
SELECT COUNT(*) --EMPLOYE의 데이터가 몇개가 있는지
FROM EMPLOYEE; 
--23 출력


--여자 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');
--여자 사원 수(주민번호 뒷자리가 2거나 4일때) 8명 


--보너스 받는 사원 수
SELECT COUNT(BONUS)
FROM EMPLOYEE;
--9명 출력


--부서 배치를 받은 사원 수
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;
--21명 출력 


-- 현재 사원들이 몇개의 부서에 분포되어 있는지 
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;
--6





 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
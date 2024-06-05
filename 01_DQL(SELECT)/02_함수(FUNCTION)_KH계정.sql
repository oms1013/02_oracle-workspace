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

-- 주민번호 852583 - 2****** (마스킹처리)
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;


--주민번호 마스킹 : SUBSTR함수 + RPAD함수
--SELECT EMP_NAME, SUBSTAR(EMP_NO,1,8) ||'******' 이 방법도 가능
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
 
 
 
 
 
 
 
 
 
 
 
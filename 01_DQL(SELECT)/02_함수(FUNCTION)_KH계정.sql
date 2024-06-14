/*
       < �Լ� FUNCTION>
       ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ��
       
       - ������ �Լ� : N���� ���� �о�鿩�� N���� ������� ����(�� �ึ�� �Լ� ���� ��� ��ȯ)
       - �׷� �Լ�  : N���� ���� �о�鿩�� 1���� ������� ����(�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
            
            
        >> SELECT ���� ������ �Լ�, �׷��Լ��� ���� ����� �� ���� 
          ��? ��� ���� ������ �ٸ��� ���� 
          
        >> �Լ����� ��� �� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
       
             
*/

/*
    < ���� ó�� �Լ� >

    * LENGTH / LENGTHB   => ����� NUMBERŸ�� 
    
    LENGTH(�÷�|'���ڿ���') : �ش� ���ڿ��� ���ڼ� ��ȯ
    LENGTHB(�÷�|'���ڿ���') : �ش� ���ڿ� ���� ����Ʈ �� ��ȯ 

    '��', '��', '��' �ѱ��ڴ� 3BYTE 
    ������, ����, Ư��  �ѱ��ڴ� 1BYTE 
*/

SELECT SYSDATE
FROM DUAL;


SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; --���� ���̺� : ���̺��� �� �� ���� �� ���� �� 

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),EMAIL,
LENGTH(EMAIL),LENGTHB(EMAIL)
FROM EMPLOYEE; --�� �ึ�� ������ �ǰ� ����= ������ �Լ�


/*
    *INSTR
    ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷�|'���ڿ�', 'ã�����ϴ¹���', ['ã����ġ�� ���۰�'], [����] =>����� NUMBERŸ��)
    
    ã�� ��ġ�� ���۰�
    1 : �տ������� ã�ڴ�
    -1 : �ڿ������� ã�ڴ� 
    
*/

SELECT INSTR ('AABAACAABAAA','B') FROM DUAL;
--ã�� ��ġ�� ���۰��� 1�⺻�� => �տ������� ã��,������ �⺻���� 1�̴�.
--(ù��° B�� ã�Ƴ�)
SELECT INSTR('AABAACAABBAAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAAA', 'B', 1,2) FROM DUAL;
SELECT INSTR('AABAACAABBAAA', 'B', -1,3) FROM DUAL;


SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "��ġ",INSTR(EMAIL,'@') AS "@��ġ"
--�տ������� ù��° _
FROM EMPLOYEE;
 

--------------------------------------------------
/*
    *SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ(�ڹ��� subString()�޼ҵ�� ����
    
    SUBSTR(STRING, POSITION, [LENGTH])   => ������� CHARACTER Ÿ��
    - STRING : ����Ÿ���÷� �Ǵ� '���ڿ���'
    - POSITION : ���ڿ��� ������ ������ġ��
    - LENGTH : ������ ���� ���� (������ ������ �ǹ�) 
    
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; 
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL; 
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8,1) AS "����"
FROM EMPLOYEE; 



-- ���� ����鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = 2 OR SUBSTR(EMP_NO,8,1) = 4;
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');
--IN���� ����ؼ� �ֹι�ȣ 8��ġ�� �ѱ��ڰ� 2�ų� 4�� ���ڻ��
--�ֹι�ȣ ���ڸ� ù���ڰ� 2,4�� ���� ��� 


SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN (1,3) --����ǥ �Ƚᵵ �˾Ƽ� ��µ�
--����Ŭ?SQL�� ����ȯ�� �ڵ����� �� �Ǵ� ��
--WHERE NOT SUBSTR(EMP_NO,8,1) IN ('2','4');
ORDER BY 1; --�⺻������ ��������



-- �Լ� ��ø ���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1   )
--���ۺκ��� ����� ��ĭ ���������� ����� ��� 
FROM EMPLOYEE; 





----------------------------------------------------------------
/*
   *LPAD / RPAD
   ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
   
   LPAD/RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰����ϴ� ����])

    ���ڿ��� �����̰��� �ϴ� ���ڸ� ����, �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ� ��ȯ
    
*/
SELECT EMP_NAME, EMAIL, LPAD(EMAIL, 20) --��°���� ������ ������ ���ڶ��༮��
--�׸�ŭ ������ �þ. �����̰��� �ϴ� ���� ������ �⺻���� ������ �� 
FROM EMPLOYEE; 

SELECT EMP_NAME, LPAD(EMAIL, 20, '#') --��������
FROM EMPLOYEE; 

SELECT EMP_NAME, RPAD(EMAIL, 20, '#') --����������
FROM EMPLOYEE; 

-- �ֹι�ȣ 852583 - 2****** (����ŷó��) �١�
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;


--�ֹι�ȣ ����ŷ : SUBSTR�Լ� + RPAD�Լ�
--SELECT EMP_NAME, SUBSTAR(EMP_NO,1,8) ||'******' �� ����� ����
--�١١�
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') AS "�ֹι�ȣ"
FROM EMPLOYEE;


----------------------------------------------------------------

/*
    LTRIM / RTRIM 
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ 
    
    LTRIM / RTRIM (STRING, ['�����ҹ��ڵ�']) => �����ϸ� ���� ��������
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� 
    ���� �� ���ڿ��� ��ȯ�Ѵ�.
    
*/

SELECT LTRIM('        K   H    ') FROM DUAL;
--������ �����ϰ� ������ �ƴ� ���ڰ� ������ ���Ű� �ߴܵ�. 
-- �׷��� ��°���� ('K    H   ')
SELECT LTRIM('123123KH123', '123') FROM DUAL;
--���޾Ƽ� 123�� �ι� ����� KH123�� ���
SELECT LTRIM('ACABACCKH', 'ABC')FROM DUAL;
--�ȿ� A,B,C�� ���� �����ϰ� KH�� ���Ƽ� ��� 
--�� ����� ����°� �ƴ϶� ���ԵȰ� ���� �����Ѵ�

SELECT RTRIM('5782KH123', '0123456789') FROM DUAL; 
--��°�� 5782KH, �̰� �����ʿ������� �������

/*  
    *TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    
    TRIM(�����ϰ��� �ϴ� ���ڵ� FROM STRING)
    
    TRIM(  [LEADING | TRALLING | BOSS] 
    [�����ϰ��� �ϴ� ���ڵ� FROM]STRING)
*/

--�⺻������ ������ ���ڵ��� �� ã�� ����
SELECT TRIM ('      K    H     ') FROM DUAL;
--  ���    'K    H'
SELECT TRIM('Z' FROM 'ZZZZZZZKHZZZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZZZZKHZZZZZ') FROM DUAL;
-- LEADING �Է½� LTRIM�� �����ϰ� ���ʸ�����

--SELECT TRIM(TRALLING 'Z' FROM 'ZZZZZZZKHZZZZZ') FROM DUAL;
-- TRALLING�� ������
--SELECT TRIM(BOSS 'Z' FROM 'ZZZZZZZKHZZZZZ') FROM DUAL;
-- BOSS�� ����

/*
    * LOWER / UPPER /  INITCAP
    
     LOWER / UPPER / INITCAP (STRING)  =>   ������� CHARACTERŸ��
    LOWER : �� �ҹ��ڷ� ������ ���ڿ� ��ȯ(�ڹٿ����� toLowerCase()�޼ҵ�� ����
    UPPER : �� �빮�ڷ� ������ ���ڿ� ��ȯ(�ڹٿ����� toUpperCase()�޼ҵ�� ����
    LOWER : �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
         
*/

SELECT LOWER('Welcome To My World!') From DUAL;
SELECT UPPER('Welcome To My World!') From DUAL;
SELECT INITCAP('welcome to my world!') FROM DUAL;


--------------------------------------------------------

/*
    *CONCAT 
    ���ڿ��� �ΰ��� ���޹޾� �ϳ��� ��ģ �� ����� ��ȯ

    CONCAT(STRING, STRING) =>����� CHARACTER Ÿ��
*/

SELECT CONCAT('ABC', '���ݸ�') FROM DUAL; 
SELECT 'ABC' || '���ݸ�' FROM DUAL; 

SELECT CONCAT('ABC','���ݸ�','123')FROM DUAL; --�����߻� : 2��������������
SELECT 'ABC' || '���ݸ�' ||'������' FROM DUAL; 


---------------------------------------------------

/*
   *REPLACE
   
      REPLACE(STRING, STR1, STR2)   =>������� CHARACTERŸ��
      
*/

--�١�
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
-- EMAIL�� ������ ���� 'kh.or.kr'�� 'gmail.com'���� ����
FROM EMPLOYEE; 

 ---------------------------------------------------
 
 /*
        <  ���� ó�� �Լ�  >
        
        * ABS
        ������ ���밪�� �����ִ� �Լ� 
        
        ABS(NUMBER)       => ������� NUMBERŸ��
                
 */
 SELECT ABS(-10) FROM DUAL;
 SELECT ABS(-5.7) FROM DUAL;
 
 ---------------------------------------------------
 
 /*
    *MOD
    �� ���� ���� ���������� ��ȯ���ִ� �Լ� 
    
    MOD(NUMBER, NUMBER)    => ������� NUMBER Ÿ��! 
    
 */
 SELECT MOD(10, 3) FROM DUAL; 
 SELECT MOD(10.9, 3) FROM DUAL; 
 -------------------------------------------
 /* 
    * ROUND
    �ݿø��� ����� ��ȯ
    
    ROUND (NUMBER, [��ġ])   => ������� NUMBER Ÿ�� 
 */
 
 SELECT ROUND(123.456, 0) FROM DUAL; --��ġ ������ 0 
 SELECT ROUND(123.456, 1) FROM DUAL;
 SELECT ROUND(123.456, 5) FROM DUAL;
 SELECT ROUND(123.456, -2)FROM DUAL;
 
 
 --------------------------------------------------
 /*
    *Ceil
    �ø�ó�� ���ִ� �Լ�. 
    
    CEIL(NUMBER) 
      
  */
 
 SELECT CEIL(123.152) FROM DUAL; -- 5 �̻��� �ƴϴ��� �׳� '�ø�'
    -- 124 ���

 ----------------------------------------------------------
 
 /*
    * FLOOR
    �Ҽ��� �Ʒ��� ����ó���ϴ� �Լ�
 
    FLOOR(NUMBER)
  */
 
 SELECT FLOOR(123.152) FROM DUAL;
 -- 123 ���. ������ ������ �������·� ���
 
 ------------------------------------------------------------------
 /*
        * TRUNC(�����ϴ�)
        ��ġ�� �����ؼ� ����ó��
        
        TRUNC(NUMBER, [��ġ])
 */
 SELECT TRUNC(123.456) FROM DUAL; --��ġ���� ���ϸ� FLOOR�̶� �ٸ� �� ����
 SELECT TRUNC(123.456, 1) FROM DUAL; --123.4 ���. �Ҽ��� �Ʒ� ù°¥������ ǥ��
 SELECT TRUNC(123.456, -1) FROM DUAL; --120
 
 
 --------------------------------------------------------------------------
 
 /*
    < ��¥ ó�� �Լ�> 
 */
 
 -- * SYSDATE : �ý��� ��¥ �� �ð� ��ȯ (���� ��¥ �� �ð�) 
 SELECT SYSDATE FROM DUAL; --ǥ�Ⱑ �� �ȵǼ� �׷��� ��� ����Ŭ���ϸ� 
 --�ð����� Ȯ���� �����ϴ�
 
 
 
 -- * MONTHS_BETWEEN(DATE1, DATE2): �� ��¥ ������ ���� �� => ���������� ù��°�� ����
    --DATE 1�� ��¥�� - DATE2 �� ������ 30, 31�� �����
    -- ������� NUMBERŸ���̴�
    -- EMPLOYEE ���̺��� �����, �Ի���, �ٹ��ϼ�, �ٹ�������
    SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE)||'��' AS "�ٹ��ϼ�"
    , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����' AS "�ٹ�������"
    FROM EMPLOYEE;
 
 
 -- * ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� 
 --  ���� �ڿ� ��¥�� �����Ѵ�. ������� DATEŸ��
 SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;
 --���÷κ��� 6���� �ڿ� ��¥�� ��ȯ�Ѵ�
 
 
 --EMPLOYEE���� �����, �Ի���, �Ի��� 6������ �� ��¥ ��ȸ
 SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)AS "�����Ⱓ ������"
 FROM EMPLOYEE;

    
 --* NEXT_DAY(DATE, ����(����|����)) : Ư�� ��¥ ���� ����� �ش� ������ 
 --��¥�� ��ȯ���ִ� �Լ�
 -- =>������� DATEŸ��
 SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
 --���� ��¥ ���� ���� ����� �ݿ����� ��¥�� ���
 
 
SELECT * FROM NLS_SESSION_PARAMETERS;
-- ���� ��ȸ ��ɹ�
-- Ȯ���غ��� �ѱ��� �������� �������� �� �� �ִ�. 

ALTER SESSION SET NLS_LANGUAGE= AMERICAN; --KOREAN 
--������ ����� �ٲܼ� �ִ�. ���� 

-- * LAST_DAY(DATE) : �ش���� ������ ��¥�� ���ؼ� ��ȯ 
-- => ������� DATEŸ��!! 

SELECT LAST_DAY(SYSDATE) FROM DUAL; 

--EMPLOYEE���� �����, �Ի���, �Ի��Ѵ��� ������ ��¥, �Ի��Ѵ� �ٹ����� �ϼ� 
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE),
LAST_DAY(HIRE_DATE)-HIRE_DATE+1 AS "�Ի��� �� �ٹ��ϼ�"
FROM EMPLOYEE; 

 /*
     *EXTRACT : Ư�� ��¥�κ��� �⵵|��|�� ���� �����ؼ� ��ȯ���ִ� �Լ�
     
     EXTRACT(YEAR FROM DATE) : �⵵�� ������ 
     EXTRACT(MONTH FROM DATE) : ���� ������
     EXTRACT(DAY FROM DATE) : �ϸ� ������ 
  
 */
 --�����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
 
 SELECT EMP_NAME,  
 EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵",
 EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��",
 EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
 FROM EMPLOYEE
  ORDER BY "�Ի�⵵", "�Ի��", "�Ի���"; --�Ի�⵵�� ����
  --�Ի�⵵�� ������ �Ի��, �װ͵� ������ �Ի���
  
----------------------------------------------------------

/*
    < ����ȯ �Լ� > 
    
    * TO_CHAR : ����Ÿ�� �Ǵ� ��¥Ÿ�� ���� ����Ÿ������ ��ȯ
    
    TO_CHAR(����|��¥,[����]) =>������� CHARACTERŸ��!
        
*/
 
 --����ȯ���� ���ڸ� CHAR������ �ٲ�
 SELECT TO_CHAR(1234) FROM DUAL; -- '1234' �� �ٲ���ִ°���
 SELECT TO_CHAR(1234, '99999') FROM DUAL;
 --�̰� 5ĭ¥�� ������ Ȯ���ؼ� 4ĭ�� 1234 �� ����.
 -- 99999...�� ������ ����� ������ �����
 -- 00000...�� ������ �� ��ŭ �տ� 0�� ����־ ����
 SELECT TO_CHAR(1234, 'L99999') FROM DUAL; 
 -- ȭ�� ������ L�̶� 1234���� ǥ��
 
 SELECT TO_CHAR(1234, '$99999')FROM DUAL;
 SELECT TO_CHAR(1234, 'L99,999')FROM DUAL;
 
 SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')
 --ȭ������� ����� �� �ְ� ����, ��ǥ�� 3�ٸ��� �ϳ��� ����� 
 FROM EMPLOYEE;
 
 
 ---��¥Ÿ�� => ����Ÿ��
 SELECT SYSDATE FROM DUAL;
 SELECT TO_CHAR(SYSDATE) FROM DUAL; --Ŭ���غ��� �ٸ�. ��¥Ÿ����
 --�޷�,�ð��� �������� �̰� �������̶� ��¥������ ��µ�
 SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; --HH: 12�ð�����
 SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; --HH: 24�ð�����
 SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL; 
 SELECT TO_CHAR(SYSDATE, 'MON,YYYY') FROM DUAL; 
 
 SELECT EMP_NAME, HIR_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
 FROM EMPLOYEE;
 
 -- EX) 1990�� 02�� 06�� �������� 
 SELECT TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"')
 --�̷������� ���� ������ ������ �� ""�� ������ �����ϴ�.
 FROM EMPLOYEE;
 
 
 
 -- �⵵�� ���õ� ����
 SELECT TO_CHAR(SYSDATE, 'YYYY'), --2024
        TO_CHAR(SYSDATE, 'YY'), -- 24
        TO_CHAR(SYSDATE, 'RRRR'), --2024
        TO_CHAR(SYSDATE, 'RR'), -- 24
        TO_CHAR(SYSDATE, 'YEAR') -- TWENTY TWENTY-FOUR
                    
 FROM DUAL; 
 
 
 
 
 -- ������ ���õ� ���� 
 SELECT TO_CHAR(SYSDATE, 'MM'), --06
        TO_CHAR(SYSDATE, 'MON'), --6��
        TO_CHAR(SYSDATE, 'MONTH'), --6��
        TO_CHAR(SYSDATE, 'RM') --VI
 FROM DUAL; 
 
 --�Ͽ� ���� ����
 SELECT TO_CHAR(SYSDATE, 'DDD'), --���� ���� ������ ��ĥ°����
        TO_CHAR(SYSDATE, 'DD'), -- �̹��� ���� ������ ��ĥ°���� 
        TO_CHAR(SYSDATE, 'D') -- �̹��� ���� ��ĥ°����
 FROM DUAL;
 
 --���Ͽ� ���� ����
 SELECT TO_CHAR(SYSDATE, 'DAY'), --�ݿ���
        TO_CHAR(SYSDATE, 'DY') --�� 
 FROM DUAL; 

------------------------------------------------------
/*
    * TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ�� �����͸� 
    ��¥ Ÿ������ ��ȯ �����ִ� �Լ�
    
    TO_DATE(����|����, [����]) =>����� DATEŸ��
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(110101) FROM DUAL;

-- SELECT TO_DATE(070101) FROM DUAL; --����, �� ���� 0��
SELECT TO_DATE('070101') FROM DUAL; --ù���� 0�ΰ�쿡��
--����Ÿ������ �����ϰ� �ؾ���. 

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS')  FROM DUAL; --����

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL; --2014 �̻���� ���
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; --2098���� ���
--���� : �� YY�� ������ ���� ���� �������� �Ǵ���. 

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;--2014���� �ߺپ���
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL;--98�⿡ �� �پ���
--RR�� �ش� ���ڸ� �⵵ ���� 50�̸��ϰ�� ���� ���� �ݿ�, �̻��̸� 
--���� ���⸦ �ݿ����ش�. 

--������Ʈ ���ó��? 
--��ȭ�鰰�� ������ ������ ����Ÿ������ �Ѿ. 

------------------------------------------------------------
/*
    * TO_NUMBER : ����Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ� 
    
    TO_NUMBER(����, [����])     =>������� NUMBERŸ��!!
*/
 
 SELECT TO_NUMBER('05196544')FROM DUAL; 
 -- 0�� ������ ����Ÿ������ �����
 
 SELECT '10000000' + '55000' FROM DUAL;
 --�ڵ����� ����ȯ�� �ؼ� ���ϴ� ��� 1055000
 
 SELECT '10,000,000' +'55,000' FROM DUAL;
 --���� �߻�, �ȿ� ���ڸ� �־�� �ڵ�����ȯ�� �ȴ� 
 
 SELECT TO_NUMBER('10,000,000', '99,999,999')+ TO_NUMBER('55,000', '99,999') FROM DUAL;
 --��������. �����ؾ���
 
 
 /*
    < NULL ó�� �Լ�>
 */
 -- NVL(�÷�, �ش��÷����� NULL�ϰ�� ��ȯ�� ��) 
 SELECT EMP_NAME, BONUS, NVL(BONUS,0) --NULL�̸� 0���� ��ȯ
 FROM EMPLOYEE;
 
 --�� ����� �̸� ���ʽ����� ���� 
 SELECT EMP_NAME, BONUS, (SALARY+SALARY *BONUS)*12
 ,(SALARY+SALARY *NVL(BONUS, 0))*12
 --��������� NULL������ ��������� NULL�� �Ǵµ�, NVL�� ����
 --NULL�� 0����ϰ� ����ϸ� ���������� ������ ��µȴ�
 FROM EMPLOYEE;
 
 SELECT EMP_NAME, NVL(DEPT_CODE, '�μ� ����')
 --NVL�� 0�� �ƴ϶� ���ڵ� �Է��� �� �ִ�. �μ� ��� NULL->�μ� ����
 FROM EMPLOYEE;
 
 --NVL2(�÷�, ��ȯ��1, ��ȯ��2) 
 --�÷����� �����Ұ�� ��ȯ�� 1�� ��ȯ
 --�÷����� NULL�� ��� ��ȯ�� 2�� ��ȯ
 
 SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
 --������ ���ʽ� �ִ� �ο��� 0.7�� ����, ���� �ο��� 0.1�� ����
 FROM EMPLOYEE; 
 
 SELECT EMP_NAME, NVL2(DEPT_CODE, '�μ� ����', '�μ� ����')
 --�μ� �ִ� �ο� -> �μ� ���� , ������ -> �μ� ���� 
 FROM EMPLOYEE;
 
 
 -- NULLIF(�񱳴��1, �񱳴��2)
 -- �� ���� ��ġ�ϸ� NULL ��ȯ
 -- �ΰ��� ���� ��ġ���� ������ �񱳴��1 ���� ��ȯ
 SELECT NULLIF ('123', '123') FROM DUAL;
 SELECT NULLIF ('123', '456') FROM DUAL;
 
 -------------------------------------------------
 
 /*
    < ���� �Լ� >    
    
    * DECODE(���ϰ��� �ϴ� ���(�÷�|�������|�Լ���), 
      �񱳰�1, �����1, �񱳰�2, �����2, ...)
    
    SWITCH(�񱳴��)
    CASE �񱳰�1 : BREAK;
    CASE �񱳰�2 : BREAK; 
    ...
    DEFAULT 
            
 */
 
 -- ���, �����, �ֹι�ȣ 
SELECT
EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1), 
DECODE(SUBSTR(EMP_NO, 8,1), '1','��','2','��') "����" 
FROM EMPLOYEE; 
 
 -- ������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ 
 -- J7�� ����� �޿��� 10% �λ� (SALARY*1.1)
 -- J6�� ����� �޿��� 15% �λ� (SALARY*1.5) 
 -- J5�� ����� �޿��� 20% �λ� (SALARY*1.2) 
 -- �� ���� ����� �޿��� 5% �λ� (SALARY * 1.05) 
 
 -- �����, �����ڵ�, �����޿� , �λ�� �޿�, 
 SELECT EMP_NAME, JOB_CODE, SALARY, 
        DECODE(JOB_CODE, 'J7', SALARY*1.1, 
                          'J6',SALARY*1.15,
                          'J5', SALARY*1.2, 
 SALARY*1.05) AS "�λ�� �޿�"
 FROM EMPLOYEE; 
 
 /*
    *CASE WHEN THEN
    
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         ...
         ELSE �����N
          
    END
    
    �ڹٿ����� IF-ELSE IF��
    
 */
 
 SELECT EMP_NAME, SALARY,
        CASE WHEN SALARY >= 5000000 THEN '��� ������' 
             WHEN SALARY >= 3500000 THEN '�߱� ������'
             ELSE '�ʱ� ������'
        END AS "����"
FROM EMPLOYEE; 

 
 ------------------ < �׷� �Լ� > -----------------
 --1. SUM(����Ÿ���÷�) : �ش� �÷� ������ �� �հ踦 ���ؼ� ��ȯ���ִ� �Լ�
 
 -- EMPLOYEE ���̺��� �� ��� �� �޿��� 
 SELECT SUM(SALARY) 
 FROM EMPLOYEE; -- ��ü����� �� �׷����� ����
 
 -- ���� ������� �� �޿��� 
 SELECT SUM(SALARY)
 FROM EMPLOYEE 
 WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); 
 
 --�μ��ڵ尡 D5�� ������� �� ������
 
 SELECT SUM(SALARY*12)-- EMP_NAME
 FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5';
 --SELECT���� �������Լ�, �׷��Լ��� ���� ����Ҽ� ����. 
 --EMP_NAME�� �� ���� ����. 
 
 -- 2.AVG(����Ÿ��) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ 
 -- ��ü ����� ��� �޿� ��ȸ 
 SELECT ROUND(AVG(SALARY)) 
 FROM EMPLOYEE; 
 
 
 -- 3. MIN(����Ÿ��) :  �ش� �÷����� �߿� ���� ���� ���� ���ؼ� ��ȯ
 SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
 FROM EMPLOYEE;
 -- EMPLOYE�� �� ���� �� ���� �����͵鸸 ��Ƽ� ���
 
 --4. MAX(����Ÿ��): �ش� �÷����� �߿� ���� ū ���� ���ؼ� ��ȯ
 SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
 FROM EMPLOYEE;
 --MIN�� �ݴ�. ���������� ���� �����Ÿ� ��Ƽ� ���
 
 --5. COUNT(*|�÷�|DISTINCT) : ��ȸ�� �� ������ ���� ��ȯ 
 --   COUNT(*) : ��ȸ�� ����� ��� �� ������ ���� ��ȯ
 --   COUNT(�÷�) : ������ �ش� �÷����� NULL �ƴѰ͸� 
 --   COUNT(DISTINCT �÷�) : �ش� �÷��� �ߺ��� ������ �� 
 --                         �� ���� ���� ��ȯ
 

-- ��ü ��� �� 
SELECT COUNT(*) --EMPLOYE�� �����Ͱ� ��� �ִ���
FROM EMPLOYEE; 
--23 ���


--���� ��� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');
--���� ��� ��(�ֹι�ȣ ���ڸ��� 2�ų� 4�϶�) 8�� 


--���ʽ� �޴� ��� ��
SELECT COUNT(BONUS)
FROM EMPLOYEE;
--9�� ���


--�μ� ��ġ�� ���� ��� ��
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;
--21�� ��� 


-- ���� ������� ��� �μ��� �����Ǿ� �ִ��� 
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;
--6





 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
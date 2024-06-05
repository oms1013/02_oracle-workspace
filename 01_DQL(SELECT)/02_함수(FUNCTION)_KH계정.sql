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

-- �ֹι�ȣ 852583 - 2****** (����ŷó��)
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;


--�ֹι�ȣ ����ŷ : SUBSTR�Լ� + RPAD�Լ�
--SELECT EMP_NAME, SUBSTAR(EMP_NO,1,8) ||'******' �� ����� ����
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
 
 
 
 
 
 
 
 
 
 
 
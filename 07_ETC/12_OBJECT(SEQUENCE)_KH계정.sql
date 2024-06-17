
/*
    < ������ SEQUENCE > 
    �ڵ����� ��ȣ �߻������ִ� ������ �ϴ� ��ü 
    �������� ���������� �������� ������Ű�鼭 �������� 
    
    EX) ȸ����ȣ, �����ȣ, �Խñ� ��ȣ, ... 
*/

/*
    1. ������ ��ü ���� 
    
    [ǥ����] 
    CREATE SEQUENCE �������� 
    [START WITH ���ۼ���]           --> ó�� �߻���ų ���۰� ����(�⺻�� 1) 
    [INCREMENT BY ����]            --> � ������ų ���� 
    [MAXVALUE ����]                --> �ִ밪 ����(�⺻�� ���� ŭ)
    [MINVALUE ����]                --> �ּҰ� ����(�⺻�� 1) 
    [CYCLE|NOCYCLE]               --> �� ��ȯ ���� ���� (�⺻�� NOCYCLE) 
    [NOCACHE|CACHE ����Ʈũ��]      --> ĳ�� �޸� �Ҵ� (�⺻�� CACHE 20)
    
    * ĳ�� �޸� : �̸� �߻��� ������ �����ؼ� �����صδ� ���� 
                 �Ź� ȣ��ɶ� ���� ������ ��ȣ�� �����ϴ°� �ƴ϶� 
                 ĳ�� �޸� ������ �̸� ������ ������ ������ �� �� ����(�ӵ��� ������)
                ������ �����Ǹ� => ĳ�ø޸𸮿� �̸� ������ ��ȣ���� �� ���ư���. 
                
    ���̺�� : TB_  
    ���    : VW_
    �������� : SEQ_ 
    Ʈ����  : TRG_
*/

CREATE SEQUENCE SEQ_TEST; 

--[����] ���� ������ �����ϰ� �ִ� �������� ������ ������ �� �� 
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310 
NOCYCLE 
NOCACHE;

/*
    2. ������ ��� 
    
    ��������.CURRVAL : ���� �������� ��(���������� ���������� ����� NEXTVAL�� ��)
    ��������.NEXTVAL : ������ ������ ���� ���� �������Ѽ� �߻���
                      ���� ������ ������ INCREMENT BY �� ��ŭ ������ ��
                     == ��������. CURRVAL + INCREMENT BY ��  
   
    
    
*/


SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--ORA-08002: sequence SEQ_EMPNO.CURRVAL 
--is not yet defined in this session
--���� ���ǵ��� ���� ������ ���� 

 --��? CURRVAL�� ���������� ���������� ����� NEXTVAL�� ���� �����ؼ� �����ִ� �ӽ� ��
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --310

SELECT * FROM USER_SEQUENCES; 
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; 
-- ������ MAXVALUE���� �ʰ��߱� ������
-- ������ �߻���. (����) 

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--CURVAL�� ���������� ������ ���̱� ������ ��� ����

/*
    3. ������ ���� ���� 
    ALTER SEQUENCE �������� 
    [INCREMENT BY ����]           --> � ������ų ���� 
    [MAXVALUE ����]               --> �ִ밪 ����(�⺻�� ���� ŭ)
    [MINVALUE ����]               --> �ּҰ� ����(�⺻�� 1) 
    [CYCLE|NOCYCLE]              --> �� ��ȯ ���� ���� (�⺻�� NOCYCLE) 
    [NOCACHE|CACHE ����Ʈũ��]     --> ĳ�� �޸� �Ҵ� (�⺻�� CACHE 20)
    
    * START WITH�� ����Ұ�
*/


ALTER SEQUENCE SEQ_EMPNO 
INCREMENT BY 10
MAXVALUE 400; 

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;  -- 310+10 =>320;
--NMAXVALUE�� 400���� �����߱� ������ ���������� �۵��Ѵ�. 

--4. ������ ����
DROP SEQUENCE SEQ_EMPNO; 
----------------------------------------------------------------

--�����ȣ�� Ȱ���� ������ ���� 
CREATE SEQUENCE SEQ_EID
START WITH 400 
NOCACHE; 

INSERT 
    INTO EMPLOYEE
        (
            EMP_ID
           ,EMP_NAME
           ,EMP_NO
           ,JOB_CODE
           ,HIRE_DATE
           ,SAL_LEVEL
           )
VALUES 
        (
            SEQ_EID.NEXTVAL
        ,   '������' 
        ,   '111111-1111111'
        ,   'J7'
        ,   SYSDATE
        ,   'S1'
        );
        
SELECT * FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;
        

INSERT 
    INTO EMPLOYEE
        (
            EMP_ID
           ,EMP_NAME
           ,EMP_NO
           ,JOB_CODE
           ,HIRE_DATE
           ,SAL_LEVEL
           )
VALUES 
        (
            SEQ_EID.NEXTVAL
        ,   '������' 
        ,   '111111-1234567'
        ,   'J6'
        ,   SYSDATE
        ,   'S2'
        );
   


































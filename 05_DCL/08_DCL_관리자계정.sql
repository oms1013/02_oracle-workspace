/*
    < DCL : DATE CONTROL LANGUAGE >
    ������ ���� ��� 

    �������� �ý��� ���� �Ǵ� ��ü ���� ������ �ο�(GRANT)�ϰų� ȸ�� 

    > �ý��� ���� : DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ���� 
    > ��ü ���� ���� : Ư�� ��ü���� ������ �� �ִ� ���� 
*/


/*
    *�ý��� ���� ����
    - CREATE SESSION : ���� ������ ����
    - CREATE TABLE : ���̺��� ������ �� �ִ� ���� 
    - CREATE VIEW : �並 ������ �� �ִ� ���� 
    - CREATE SEQUENCE : ������ ������ �� �ִ� ����
    .... : �Ϻδ� Ŀ��Ʈ �ȿ� ���ԵǾ�����. 
    --���� ���⼱ ������ ������ ��� ������ CONNECT
    �ȿ� ǥ�õǾ� ���� 
    
    
*/

-- 1. sample / sample ���� ����
CREATE USER sample IDENTIFIED BY sample;
  --���� : ���� -�׽�Ʈ ���� : ORA-01045 : user SAMPLE lacks CREATE SESSION privilege ; logon denied
  
-- 2. ���� ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE; 

-- 3_1. ���̺� ���� �� �� �ִ� CREATE TABLE ������ �ο� 
GRANT CREATE TABLE TO SAMPLE;

-- 3_2. TABLESPACE �Ҵ�(SAMPLE ���� ���� ) 
ALTER USER SAMPLE QUOTA 2M ON SYSTEM; 

--------------------------------------------

/*
    * ��ü ���� ���� ���� 
      Ư�� ��ü�� �����ؼ� ������ �� �ִ� ���� 
      
      ���� ����  Ư�� ��ü 
      SELECT    TABLE, VIEW, SEQUENCE 
      INSERT    TABLE, VIEW
      UPDATE    TABLE, VIEW 
      DELETE    TABLE, VIEW
      ... 
      
      [ǥ����] 
      GRANT �������� ON Ư����ü TO ������
      
*/

GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
-- KH������ EMPLOYEE ���̺����� ��ȸ ������
-- SAMPLE ������ �ο��� ��

GRANT SELECT ON KH.DEPARTMENT TO SAMPLE;
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;

--------------------------------------------
--GRANT CONNECT, RESOURCE TO ������ : 
-- ���� �� ����� ����. �ް��� ������ �� �ο���

/*
    < �� ROLE > 
    - Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� �� 
    
    CONNECT : ������ �� �ִ� ���� CREATE SESSION
    RESOURCE :  Ư�� ��ü���� ������ �� �ִ� ���� CREATE TABLE, .... 
    
*/

SELECT * 
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE')
ORDER BY 1;












/*
    < VIEW �� > 
    
    SELECT ��(������)�� �����ص� �� �ִ� ��ü
    (���� ���� �� SELECT���� �����صθ� �� �� SELECT���� �Ź� ����� �ʿ� ����!! 
    �ӽ����̺� ���� ����(���� �����Ͱ� ����ִ°� �ƴ�!!  => �������θ� �����ϴ� ������ ���̺�)

*/

--'�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME ='�ѱ�';
 
 
 --'���þ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME ='���þ�';
 
 
 --'�Ϻ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE)
 WHERE NATIONAL_NAME ='�Ϻ�';
  
 ------------------------------------------------------------
 /*
    1.VIEW ���� ��� 
    
    [ǥ����] 
    CREATE VIEW ��� 
    
    [OR REPLACE ] : �並 ������ �� �������ߺ��� �̸��� �䰡 ���ٸ�
    ������ �並 �����ϰ�, ������ �ߺ��� �̸��� �䰡 �ִٸ� �ش� �並 ������(����)
 */
 
 CREATE OR REPLACE VIEW VW_EMPLOYEE 
 AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE);
  
  GRANT CREATE VIEW TO KH; -->������ �������� �����ؾߵ�!!
  
  SELECT * 
  FROM VW_EMPLOYEE;
  
  SELECT * 
  FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME , SALARY 
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON ( LOCATION_ID = LOCAL_CODE)
  JOIN NATIONAL USING (NATIONAL_CODE));
  
 --��� ������ ���� ���̺�!(���������� �����͸� �����ϰ� ������ ����!)
 
 -- '�ѱ�' , '���þ�', '�Ϻ�'�� �ٹ��ϴ� ��� 
 SELECT * 
    FROM VW_EMPLOYEE 
   WHERE NATIONAL_NAME ='�ѱ�';
    
 SELECT * 
    FROM VW_EMPLOYEE 
   WHERE NATIONAL_NAME ='���þ�';
 
 SELECT * 
    FROM VW_EMPLOYEE 
   WHERE NATIONAL_NAME ='�Ϻ�';
 
 
 --[����]
 SELECT * FROM USER_VIEWS;
 
 -----------------------------------------------------------
 /*
     * �� �÷� ��Ī �ο�
       �������� SELECT ���� �Լ����̳� ���������� ����Ǿ����� ��� �ݵ�� ��Ī �����ؾ��� 
 */
 
 -- �� ����� ��� �̸�, ���޸�, ����(��/��), �ٹ������ ��ȸ�� �� �ִ�
 --SELECT�� ��(VW_EMP_JOB)���� ����
 
CREATE OR REPLACE VIEW VW_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
        DECODE(SUBSTR(EMP_NO,8,1), '1', '��', '2' , '��') "����",
        EXTRACT(YEAR FROM SYSDATE)  - EXTRACT(YEAR FROM HIRE_DATE) "�ٹ����" 
    FROM EMPLOYEE 
    JOIN JOB USING(JOB_CODE); 

SELECT * FROM VW_EMP_JOB;

--�Ʒ��� ���� ������ε� ��Ī �ο� ����(��, �̶��� ��� �÷��� ���� ��Ī�� �ۼ��ؾߵ�) 
CREATE OR REPLACE VIEW VW_EMP_JOB(���, �̸�, ���޸�, ����, �ٹ����) 
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
        DECODE(SUBSTR(EMP_NO,8,1), '1', '��', '2' , '��'),
        EXTRACT(YEAR FROM SYSDATE)  - EXTRACT(YEAR FROM HIRE_DATE)  
    FROM EMPLOYEE 
    JOIN JOB USING(JOB_CODE); 

SELECT �̸�, ���޸�
    FROM VW_EMP_JOB 
    WHERE ���� = '��';

SELECT *
    FROM VW_EMP_JOB
    WHERE �ٹ���� >=20;
    
    --�� �����ϰ��� �Ѵٸ�
    
    DROP VIEW VW_EMP_JOB;
-------------------------------------------------------------------------

-- ������ �並 �̿��ؼ� DML ��� ����! 
-- �並 ���ؼ� �����ϰ� �Ǹ� ���� �����Ͱ� ����ִ� ���̽����̺� 

CREATE OR REPLACE VIEW VW_JOB 
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB; 
    
SELECT * FROM VW_JOB; -- �� ���̺�(���� �����Ͱ� ������� ����) 
SELECT * FROM JOB;    -- ���̽� ���̺� (���� �����Ͱ� �������)

-- ���並 ���ؼ� INSERT
INSERT INTO VW_JOB VALUES('J8', '����'); --���̽� ���̺� ���������� INSERT�� �ȴ�. 

--�並 ���ؼ� UPDATE 
UPDATE VW_JOB
    SET JOB_NAME = '�˹�' 
    WHERE JOB_CODE = 'J8'; --���� 

-- �並 ���ؼ� DELETE
DELETE 
    FROM VW_JOB
   WHERE JOB_CODE = 'J8';
   
--------------------------------------------------------------------------------

    --    * ��, DML ��ɾ�� ������ �Ұ����� ��찡 �� ����! 
 --   1) �信 ���� �Ǿ� ���� ���� �÷��� �����Ϸ��� �ϴ� ��� 
 CREATE OR REPLACE VIEW VW_JOB
    AS SELECT JOB_CODE
        FROM JOB;
 
 SELECT * FROM VW_JOB;
 SELECT * FROM JOB; 
 
 -- INSERT 
 INSERT INTO VW_JOB(JOB_CODE, JOB_NAME) VALUES('J8', '����'); 
 
 -- UPDATE(����)  
 UPDATE VW_JOB
    SET JOB_NAME ='����' 
  WHERE JOB_CODE ='J7'; -- ��� 
  
  -- DELETE ����)
  DELETE 
    FROM  VW_JOB 
    WHERE JOB_NAME = '���'; 
 --   2) �信 ���ǵǾ����� ���� �÷� �߿� ���̽� ���̺� �� NOT NULL 
 --      ���������� �����Ǿ��ִ� ���

    CREATE OR REPLACE VIEW VW_JOB
        AS SELECT JOB_NAME
        FROM JOB;

    SELECT * FROM VW_JOB; 
    SELECT * FROM JOB;
    
    --INSERT
    INSERT INTO VW_JOB VALUES('����');
    --�翬�� �۵� ����. VW_JOB���� ���ϸ� ���°� �´µ� ���� ���̽� ���̺���
    --JOB���� ���� �Է��ؾ� �ϴµ� JOB���� ���� �ΰ��� ���� �ϱ� ������
    --���� ���̽����̺� NULL, '����'�� �߰��Ǵµ� NULL�� �߰��Ǹ� �ȵǴϱ�
  
  --UPDATE
  UPDATE VW_JOB 
    SET JOB_NAME = '�˹�'
   WHERE JOB_NAME = '���';
  
  ROLLBACK;
 
 --DELETE(�� �����Ͱ� ���� �ִ� ���� �����Ͱ� �����ϱ� ������ �������� /��, ���ٸ� ���� �ߵ�!!) 
 DELETE 
    FROM VW_JOB
    WHERE JOB_NAME = '���'; 
    
  
 -- 3) �������� �Ǵ� �Լ������� ���ǵǾ��ִ� ���
 CREATE OR REPLACE VIEW  VW_EMP_SAL
    AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 ����
    FROM EMPLOYEE; 

 SELECT * FROM VW_EMP_SAL; 
 SELECT * FROM EMPLOYEE; 


--INSERT (����)  
    INSERT INTO VW_EMP_SAL VALUES(400, '������', 3000000, 3600000);
    
 -- UPDATE 
 -- 200�� ����� ������ 8000�������� 
 UPDATE VW_EMP_SAL 
    SET ���� =  80000000
  WHERE EMP_ID = 200; --���� 
  
-- 200�� ����� �޿��� 700�������� 
UPDATE VW_EMP_SAL 
    SET SALARY = 7000000 -- 8000000 
  WHERE EMP_ID = 200; -- ���� 
  
  ROLLBACK; 
  
  --DELETE 
  DELETE FROM VW_EMP_SAL 
 WHERE ���� = 7200000; 
 
 ROLLBACK; 


 --   4) �׷��Լ�, GROUP BY ���� �ִ� ���
    CREATE OR REPLACE VIEW VW_GROUPDEPT
       AS SELECT DEPT_CODE, SUM(SALARY) "�հ�", FLOOR(AVG(SALARY)) "���"
       FROM EMPLOYEE 
       GROUP BY DEPT_CODE; 
       
    SELECT * FROM VW_GROUPDEPT;
    
    -- INSERT (����) 
    INSERT INTO VW_GROUPDEPT VALUES ('D3',8000000, 4000000); 
    
    --UPDATE (����)
    UPDATE VW_GROUPDEPT
    SET �հ� = 5000000
    WHERE DEPT_CODE = 'D1';
 
    --DELETE (����) 
    DELETE
      FROM VW_GROUPDEPT
    WHERE �հ� = 5210000;

 --   5) DISTINCT ������ ���Ե� ��� 
    CREATE OR REPLACE VIEW VW_DT_JOB
    AS SELECT DISTINCT JOB_CODE 
        FROM EMPLOYEE; 
    
    SELECT * FROM VW_DT_JOB;
    
    -- INSERT (���� ����. NULL���� ���̴� �Ʊ� ������ ������ ����) 
    INSERT INTO VW_DT_JOB VALUES('J8');
     
    -- UPDATE (����) 
    UPDATE VW_DT_JOB
        SET JOB_CODE = 'J9'
     WHERE JOB_CODE = 'J7';
     
     --DELETE (����)  
     DELETE
        FROM VW_DT_JOB 
     WHERE JOB_CODE = 'J4'; 
     
 --   6) JOIN�� �̿��ؼ� ���� ���̺��� ������ѳ��� ��� 
     CREATE OR REPLACE VIEW VW_JOINEMP
        AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
            FROM EMPLOYEE
            JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
        
    SELECT * FROM VW_JOINEMP;
            
        --INSERT
        INSERT INTO VW_JOINEMP VALUES(300, '������', '�ѹ���');
        --JOIN�ؼ� �Ұ����ϴٴ� ������ �߻�
        
        --UPDATE 
        UPDATE VW_JOINEMP
            SET EMP_NAME = '������' 
          WHERE EMP_ID = 200;  --���� 
        
        SELECT * FROM EMPLOYEE;
        --���̽����̺��� EMPLOYEE�� �������� �����Ϸ� �ٲ���ִ� ��� 
        
        
        UPDATE VW_JOINEMP--(����)
            SET DEPT_TITLE = 'ȸ���'
         WHERE EMP_ID =200;
         
         -- ȸ��η� �ٲٷ��� �� DEPARTMENT �� �ǵ���� �ϱ� ������
        
     --DELETE
     DELETE
        FROM VW_JOINEMP
      WHERE EMP_ID =200;
      --���������� ������ 
      
      SELECT * FROM EMPLOYEE;
    
        ROLLBACK;

----------------------------------------------------------------

/*
    *VIEW �ɼ�
    
    [��ǥ����]
    CREATE [OR REPLACE] [FORCE|"NOFORCE"] VIEW ���
    AS �������� 
    [WITH CHECK OPTION] 
    [WITH READ ONLY] ;
    
    1)OR REPLACE : ������ ������ �䰡 ���� ��� ���Ž�Ű��, 
    --�������� ������ ������ ������Ű��
    2)FORCE|NOFORCE
      >FORCE : ���������� ����� ���̺��� �������� �ʾƵ� VIEW�� �����ǰ� �Ҽ� ����
      >NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̿��߸� �䰡 �����ǰ���
      --����� NOFORCE �� ������ �⺻����
    3) WITH CHECK OPTION : DML�� ���������� ����� ���ǿ� ������ �����θ� DML�����ϵ���
    4) WITH READ ONLY : �信 ���ؼ� ��ȸ�� �����ϵ���(DML�� ������ �Ұ�����) 
    
*/
-- 2) FORCE | NOFORCE  
--  NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̿��߸� �䰡 �����ǰ� �ϴ� 
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
 AS SELECT TCODE, TNAME, TCONTECT 
    FROM TT; 
        
        
-- FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �䰡 �켱�� ������ �� 
CREATE OR REPLACE FORCE VIEW VW_EMP
 AS SELECT TCODE, TNAME, TCONTECT 
    FROM TT; 

SELECT * FROM VW_EMP; 

-- TT ���̺��� �����ؾ߸� �׶����� VIEW Ȱ���� ���� 
CREATE TABLE TT(
    TCODE NUMBER, 
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR(30)
);

-- 3) WITH CHECK OPTION : ���������� ����� ���ǿ� �������� �ʴ� ������ ���� �� 
-- ���� �߻� 


--WITH CHECK OPTION �Ⱦ��� 
CREATE OR REPLACE VIEW VW_EMP
    AS SELECT *
        FROM EMPLOYEE 
      WHERE SALARY >= 3000000; 
      
SELECT * FROM VW_EMP; -- 8�� ��ȸ

-- 200�� ����� �޿��� 200�������� ����( ���������� ���ǿ� ���յ��� �ʴ� ������
--���� �õ�!!) 

UPDATE VW_EMP 
    SET SALARY = 2000000
  WHERE EMP_ID = 200; 
  
  SELECT * FROM VW_EMP;
  
    ROLLBACK;
    -- WITH CHECK OPTION ���� 
    CREATE OR REPLACE VIEW VW_EMP
    AS SELECT * 
        FROM EMPLOYEE
       WHERE SALARY >=3000000
    WITH CHECK OPTION; 
    
    SELECT * FROM VW_EMP; 
    
    UPDATE VW_EMP
        SET SALARY =2000000
     WHERE EMP_ID = 200; --���������� ����� ���ǿ� ���յ��� �ʱ� ������ ���� �Ұ�!!
     
     UPDATE VW_EMP
        SET SALARY = 4000000
     WHERE EMP_ID = 200; -- ���������� ����� ���ǿ� ���յǱ� ������ ������ ����
     
     SELECT * FROM EMPLOYEE; 
     
     ROLLBACK;
     
     -- 4) WITH READ ONLY : �信 ���� ��ȸ�� ���� (DML�� ���� �Ұ�) 
     CREATE OR REPLACE VIEW VW_EMP
     AS SELECT EMP_ID, EMP_NAME, BONUS
        FROM EMPLOYEE
      WHERE BONUS IS NOT NULL
    WITH READ ONLY; 
    
    SELECT * FROM VW_EMP;
    
    DELETE 
        FROM VW_EMP
     WHERE EMP_ID = 200; 
     --���� �Ұ�, ��ȸ�� ������ VIEW�� ������ 
     
     
     




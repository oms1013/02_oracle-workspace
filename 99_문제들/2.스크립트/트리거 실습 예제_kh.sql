--Ʈ���� �ǽ� ����

--1. �������̺�(�й�, �̸�, ��, ��, ��), �������̺�(�й�, ������, ���, ���) �����
--�������̺� : TB_SCORE
--�������̺� : TB_GRADE
DROP TABLE TB_SCORE;
CREATE TABLE TB_SCORE(     --�������̺�
    STUDENT_NO VARCHAR(30),   --�й�
    STUDENT_NAME VARCHAR(30), --�̸�
    LAN NUMBER,               --����
    ENG NUMBER,               --����
    MATH NUMBER               --����

);

DROP TABLE TB_GRADE;
CREATE TABLE TB_GRADE(   --���� ���̺�
    STUDENTNO VARCHAR(30), --�й�
    SUMGRADE NUMBER,        --�� ����
    AVGGRADE NUMBER,        --���
    RANK NUMBER             --���

);
--2. �������̺� INSERT �߻��ϸ� �ڵ����� �������̺� INSERT���ִ� Ʈ���� ����
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
    
    
INSERT INTO TB_SCORE VALUES ('1', 'ȫ�浿', 80, 85, 95);


    /*
    CREATE TABLE TB_SCORE(     --�������̺�
    STUDENT_NO VARCHAR(30),   --�й�
    STUDENT_NAME VARCHAR(30), --�̸�
    LAN NUMBER,               --����
    ENG NUMBER,               --����
    MATH NUMBER               --����
);
*/
--3. �������̺��� UPDATE�Ǹ� �ش� ����, ����, ���� ������ ���� ����Ŭ �ֿܼ� ��µǴ� Ʈ
--���� ����
--AUTOPRINT



--4. �������̺� INSERT/ UPDATE �Ǹ� ����� �Űܼ� �������ִ� ���ν��� ����(���������)




--5. ���� ���̺� �л� �����Ͱ� �����Ǹ� ���� ���̺��� �л� ������ ���� + ������ ��� ��
--�� �ű�� Ʈ���� ����
--AUTODELETE

SELECT * FROM TB_BOOK; -- ���� �⺻ ���� ���� ���̺�
SELECT * FROM TB_WRITER; -- �۰�(������/������) �⺻ ���� ���� ���̺�
SELECT * FROM TB_PUBLISHER; -- ���ǻ� �⺻ ���� ���� ���̺�
SELECT * FROM TB_BOOK_AUTHOR; -- ���� �� ������ ���� ���� ���� ���̺�

/*
    1. 4�� ���̺� ���Ե� ������ �� ���� ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT COUNT(*) FROM TB_BOOK; -- 1738
SELECT COUNT(*) FROM TB_WRITER; -- 1052
SELECT COUNT(*) FROM TB_PUBLISHER; -- 11
SELECT COUNT(*) FROM TB_BOOK_AUTHOR; -- 2292

/*
    2. 4�� ���̺��� ������ �ľ��Ϸ��� �Ѵ�. ���õ� ���ó�� 
    TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_DEFAULT, NULLABLE,
    CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME ���� ��ȸ�ϴ� SQL ������ �ۼ��Ͻÿ�.
*/

/*
    3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
*/
SELECT BOOK_NO, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

/*
    4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� ��
    ���� ���� ǥ�õǴ� �۰� �̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO
      FROM TB_WRITER
      WHERE MOBILE_NO LIKE '019%'
      AND WRITER_NM LIKE '��%'
      ORDER BY 1)
WHERE ROWNUM = 1;

/*
    5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�.
    (��� ����� ���۰�(��)������ ǥ�õǵ��� �� ��)
*/
SELECT COUNT(DISTINCT WRITER_NO) AS "�۰�(��)"
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE = '�ű�';

/*
    6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
    (���� ���°� ��ϵ��� ���� ���� ������ ��)
*/
SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300;

/*
    7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM (SELECT * FROM TB_BOOK
      ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM = 1;

/*
    8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
    ��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�.
    (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �� ��)
*/
SELECT "�۰� �̸�", "�� ��"
FROM (SELECT A.WRITER_NO, WRITER_NM AS "�۰� �̸�", COUNT(*) AS "�� ��"
      FROM TB_BOOK_AUTHOR A, TB_WRITER W
      WHERE A.WRITER_NO = W.WRITER_NO
      GROUP BY A.WRITER_NO, WRITER_NM
      ORDER BY 3 DESC)
WHERE ROWNUM <= 3;

/*
    9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���.
    ������ ������� ���� �� �۰��� ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�.
    (COMMIT ó���� ��)
*/
-- �� �۰��� '���� ���ǵ����� ������'
SELECT WRITER_NO, MIN(ISSUE_DATE) AS "���� ���ǵ��� ������"
FROM TB_BOOK_AUTHOR A, TB_BOOK B
WHERE A.BOOK_NO = B.BOOK_NO
GROUP BY WRITER_NO
ORDER BY 1;

UPDATE TB_WRITER W
SET REGIST_DATE = (SELECT "���� ���ǵ��� ������"
                   FROM (SELECT WRITER_NO, MIN(ISSUE_DATE) AS "���� ���ǵ��� ������"
                         FROM TB_BOOK_AUTHOR A, TB_BOOK B
                         WHERE A.BOOK_NO = B.BOOK_NO
                         GROUP BY WRITER_NO) J
                   WHERE J.WRITER_NO = W.WRITER_NO)
WHERE WRITER_NO IN (SELECT WRITER_NO
                    FROM TB_BOOK_AUTHOR
                    GROUP BY WRITER_NO);
COMMIT;

/*
    10. ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�.
    �����δ� �������� ���� �����Ϸ��� �Ѵ�.
    ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�.
    (Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�,
    Reference ���� ���� �̸��� ��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)
*/
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) NOT NULL CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK,
    WRITER_NO VARCHAR2(10) NOT NULL CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER,
    TRANS_LANG VARCHAR2(60),
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO)
);

COMMENT ON COLUMN TB_BOOK_TRANSLATOR.BOOK_NO IS '���� ��ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.WRITER_NO IS '�۰� ��ȣ';
COMMENT ON COLUMN TB_BOOK_TRANSLATOR.TRANS_LANG IS '���� ���';

/*
    11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
    ���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL ������ �ۼ��Ͻÿ�.
    ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�.
    (�̵��� �����ʹ� �� �̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)
*/
INSERT INTO TB_BOOK_TRANSLATOR(BOOK_NO, WRITER_NO)
SELECT BOOK_NO, WRITER_NO
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

DELETE FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

/*
    12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT BOOK_NM, WRITER_NM
FROM TB_BOOK_TRANSLATOR
JOIN TB_BOOK USING(BOOK_NO)
JOIN TB_WRITER USING(WRITER_NO)
WHERE EXTRACT(YEAR FROM ISSUE_DATE) = '2007';

/*
    13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL ������ �ۼ��Ͻÿ�.
    (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, �������� ǥ�õǵ��� �� ��)
*/
CREATE OR REPLACE VIEW VW_BOOK_TRANSLATOR
AS SELECT BOOK_NM, WRITER_NM
   FROM TB_BOOK_TRANSLATOR
   JOIN TB_BOOK USING(BOOK_NO)
   JOIN TB_WRITER USING(WRITER_NO)
   WHERE EXTRACT(YEAR FROM ISSUE_DATE) = '2007'
WITH READ ONLY;

/*
    14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
*/
INSERT INTO TB_PUBLISHER VALUES('�� ���ǻ�', '02-6710-3737', DEFAULT);
COMMIT;

/*
    15. ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT WRITER_NM, COUNT(*)
FROM TB_WRITER
GROUP BY WRITER_NM
HAVING COUNT(*) > 1;

/*
    16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�.
    �ش� �÷��� NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
*/
UPDATE TB_BOOK_AUTHOR
SET COMPOSE_TYPE = '����'
WHERE COMPOSE_TYPE IS NULL;

COMMIT;

/*
    17. �������� �۰� ������ �����Ϸ��� �Ѵ�.
    �繫���� �����̰�, �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰��� �̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT WRITER_NM, OFFICE_TELNO
FROM TB_WRITER
WHERE OFFICE_TELNO LIKE '02%'
AND OFFICE_TELNO LIKE '___-%';

/*
    18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
*/
SELECT WRITER_NM, REGIST_DATE
FROM TB_WRITER
WHERE MONTHS_BETWEEN(TO_DATE('0601', 'RRMM'), REGIST_DATE) / 12 >= 31
ORDER BY 1;

/*
    19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�.
    'Ȳ�ݰ���' ���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
    ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, �������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�. 
*/
SELECT BOOK_NM, PRICE,
       CASE WHEN STOCK_QTY < 5 THEN '�߰��ֹ��ʿ�'
            ELSE '�ҷ�����'
       END AS "������"
FROM TB_BOOK
WHERE PUBLISHER_NM = 'Ȳ�ݰ���'
AND STOCK_QTY < 10
ORDER BY STOCK_QTY DESC, 1;

/*
    20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
    (��� ����� ��������,�����ڡ�,�����ڡ��� ǥ���� ��)
*/
-- ����
SELECT BOOK_NM, BA.WRITER_NO, WRITER_NM
FROM TB_BOOK B
JOIN TB_BOOK_AUTHOR BA ON (B.BOOK_NO = BA.BOOK_NO)
JOIN TB_WRITER W ON (BA.WRITER_NO = W.WRITER_NO)
WHERE BOOK_NM = '��ŸƮ��';

-- ����
SELECT BOOK_NM, BT.WRITER_NO, W.WRITER_NM
FROM TB_BOOK B
JOIN TB_BOOK_TRANSLATOR BT ON (B.BOOK_NO = BT.BOOK_NO)
JOIN TB_WRITER W ON (BT.WRITER_NO = W.WRITER_NO)
WHERE BOOK_NM = '��ŸƮ��';

SELECT BOOK_NM AS "������", W1.WRITER_NM AS "����", W2.WRITER_NM AS "����"
FROM TB_BOOK B
JOIN TB_BOOK_AUTHOR BA ON (B.BOOK_NO = BA.BOOK_NO)
JOIN TB_BOOK_TRANSLATOR BT ON (B.BOOK_NO = BT.BOOK_NO)
JOIN TB_WRITER W1 ON (BA.WRITER_NO = W1.WRITER_NO)
JOIN TB_WRITER W2 ON (BT.WRITER_NO = W2.WRITER_NO)
WHERE BOOK_NM = '��ŸƮ��';

/*
    21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ��� ����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
    (��� ����� ��������, ����� ������, ������(Org)��, ������(New)���� ǥ���� ��.
    ��� ������ ���� ��, ���� ������ ���� ��, ������ ������ ǥ�õǵ��� �� ��)
*/
SELECT BOOK_NM AS "������", STOCK_QTY AS "��� ����", PRICE AS "����(Org)", PRICE * 0.8 AS "����(New)"
FROM TB_BOOK
WHERE MONTHS_BETWEEN(SYSDATE, ISSUE_DATE) / 12 >= 30
AND STOCK_QTY >= 90
ORDER BY 2 DESC, 4 DESC, 1;
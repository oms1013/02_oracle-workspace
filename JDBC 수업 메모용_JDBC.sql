SELECT * FROM MEMBER WHERE USERID = 'admin';
SELECT * FROM MEMBER WHERE USERID = 'user';

SELECT * FROM MEMBER WHERE USERID = '입력한 아이디값';



SELECT * FROM MEMBER WHERE  USERNAME LIKE '%USERNAME%';

SELECT * 
FROM MEMBER
WHERE USERNAME LIKE '%주지%';



--회원 정보 변경(입력값: 유저 ID)
UPDATE MEMBER 
SET 고르기 = '입력값';

--회원 정보 변경(재입력)
UPDATE MEMBER
SET 



--회원 탈퇴(입력값: 유저 ID)
DELETE 
FROM MEMBER
WHERE USERID = '입력값';

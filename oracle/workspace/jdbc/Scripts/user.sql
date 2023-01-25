CREATE SEQUENCE SEQ_USER;

/*회원번호, 아이디, 이름, 비밀번호, 전화번호, 닉네임, 이메일, 주소, 생년월일, 성별, 추천인 아이디*/
CREATE TABLE TBL_USER(
   USER_ID NUMBER CONSTRAINT PK_USER PRIMARY KEY,
   USER_IDENTIFICATION VARCHAR2(500) UNIQUE NOT NULL,
   USER_NAME VARCHAR2(500) NOT NULL,
   USER_PASSWORD VARCHAR2(500) NOT NULL,
   USER_PHONE VARCHAR2(100) NOT NULL,
   USER_NICKNAME VARCHAR2(500),
   USER_EMAIL VARCHAR2(100) CONSTRAINT UK_USER UNIQUE NOT NULL,
   USER_ADDRESS VARCHAR2(500),
   USER_BIRTH DATE,
   USER_GENDER CHAR(1) DEFAULT 'N' CHECK(USER_GENDER IN('M', 'W', 'N')),
   USER_RECOMMENDER_ID VARCHAR2(500)
);

INSERT INTO TBL_USER
(USER_ID, USER_IDENTIFICATION, 
USER_NAME, USER_PASSWORD, USER_PHONE, 
USER_NICKNAME, USER_EMAIL, USER_ADDRESS, 
USER_BIRTH, USER_GENDER, USER_RECOMMENDER_ID)
VALUES(SEQ_USER.NEXTVAL, 'daniel93', '이준상', '1q2w3e4r', '01023451234', 'ljs', 'ljs@gmail.com', 'asd', '1993-06-13', 'M' , '2e3r');

SELECT * FROM TBL_USER tu ;

DROP TABLE TBL_USER;


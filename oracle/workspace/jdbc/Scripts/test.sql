CREATE VIEW REPLY_DTO AS 
(
	SELECT U.USER_ID, U.USER_IDENTIFICATION, U.USER_NAME, U.USER_PASSWORD, 
	U.USER_PHONE, U.USER_NICKNAME, U.USER_EMAIL, U.USER_ADDRESS, U.USER_BIRTH, 
	U.USER_GENDER, U.USER_RECOMMENDER_ID, U.RECOMMEND_COUNT,
	R.REPLY_ID, R.REPLY_CONTENT, R.REPLY_REGISTER_DATE, R.REPLY_UPDATE_DATE, R.BOARD_ID, R.REPLY_GROUP, R.REPLY_DEPTH
	FROM TBL_USER U JOIN TBL_REPLY R
	ON U.USER_ID = R.USER_ID
);

/*CREATE VIEW [이름] AS [쿼리문]*/

SELECT USER_ID, USER_IDENTIFICATION, USER_NAME, USER_PHONE, USER_NICKNAME, USER_EMAIL, USER_ADDRESS, USER_BIRTH, USER_GENDER, USER_RECOMMENDER_ID, REPLY_ID, REPLY_CONTENT, REPLY_REGISTER_DATE, REPLY_UPDATE_DATE, BOARD_ID, REPLY_GROUP, REPLY_DEPTH FROM REPLY_DTO;

/*SELECT MAX(
	SELECT HEIGHT, WEIGHT 
	FROM PLAYER
	WHERE TEAM_ID IS NOT NULL 
)
FROM PLAYER
GROUP BY TEAM_ID ;*/
/*employees 테이블에서
 * 직원의 모든 정보, 부서이름, 도시 이름, 나라 이름, 대륙 이름 출력*/


/* TEAM테이블에서 울산현대와 삼성블루윙즈의
 * 경기날짜 경기장이름 출력 */
SELECT * FROM TEAM t ;
SELECT * FROM STADIUM s ;
SELECT * FROM SCHEDULE s ;

SELECT SCHE_DATE, STADIUM_ID, HOMETEAM_ID , AWAYTEAM_ID 
FROM SCHEDULE S
WHERE STADIUM_ID IN 
(
	SELECT STADIUM_ID FROM TEAM T2
	WHERE TEAM_NAME = '울산현대' OR TEAM_NAME = '삼성블루윙즈'
)
AND HOMETEAM_ID IN (
	SELECT TEAM_ID FROM TEAM T2
	WHERE TEAM_NAME = '울산현대' OR TEAM_NAME = '삼성블루윙즈'
)
AND AWAYTEAM_ID IN (
	SELECT TEAM_ID FROM TEAM T2
	WHERE TEAM_NAME = '울산현대' OR TEAM_NAME = '삼성블루윙즈'
);



/*득실차가 가장 많이 차이나는 경기의
 *경기장이름, 승리팀이름, 승리팀스코어, 패배팀이름, 패배팀스코어, 득실차를 조회*/
/*employees 테이블에서 직원의 모든 정보, 부서이름, 도시 이름, 나라 이름, 대륙 이름 출력*/
SELECT * FROM EMPLOYEES e ;
SELECT * FROM EMP;


/*DEPART ID*/
SELECT * FROM EMPLOYEES e ;

/*LOCATION ID, DEPART NAME, DEPART ID*/
SELECT * FROM DEPARTMENTS d ;

SELECT D.DEPARTMENT_NAME , D.LOCATION_ID, E.*
FROM DEPARTMENTS D JOIN EMPLOYEES E 
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

/*LOCATION ID, CITY*/
SELECT * FROM LOCATIONS l ;

/*LOCATION ID, CONTRIES NAME*/
SELECT * FROM COUNTRIES c ;

/*나라와 도시 연결*/
SELECT COUNTRY_NAME, L.LOCATION_ID, L.CITY 
FROM COUNTRIES C JOIN LOCATIONS L
ON L.COUNTRY_ID = C.COUNTRY_ID ;



SELECT *
FROM LOCATIONS L JOIN DEPARTMENTS D
ON L.LOCATION_ID = D.LOCATION_ID ;

SELECT E.*
FROM LOCATIONS L, DEPARTMENTS D, EMPLOYEES E

SELECT EY.* 
FROM EMPLOYEES EY JOIN EMP EP
ON EY.DEPARTMENT_ID = EP.DEPTNO;

/*SELECT LC.LID
FROM 
(
	SELECT D.DEPARTMENT_NAME , D.LOCATION_ID LID, E.*
	FROM DEPARTMENTS D JOIN EMPLOYEES E 
	ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;
) DE
JOIN (
	SELECT COUNTRY_NAME, L.LOCATION_ID LID, L.CITY 
	FROM COUNTRIES C JOIN LOCATIONS L
	ON L.COUNTRY_ID = C.COUNTRY_ID ;
) LC
ON LC.LID = DE.LID;*/
/* TEAM테이블에서 울산현대와 삼성블루윙즈의 경기날짜 경기장이름 출력 */

/*득실차가 가장 많이 차이나는 경기의 경기장이름, 승리팀이름, 승리팀스코어, 패배팀이름, 패배팀스코어, 득실차를 조회*/
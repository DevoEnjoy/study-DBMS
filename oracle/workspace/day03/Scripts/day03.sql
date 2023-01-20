/*1. PLAYER 테이블에서 TEAM_ID가 'K01'인 선수*/
SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID  FROM PLAYER p
WHERE TEAM_ID = 'K01';

/*2. PLAYER 테이블에서 TEAM_ID가 'K01'이 아닌 선수*/
SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID  FROM PLAYER p
WHERE TEAM_ID != 'K01';

/*3. PLAYER 테이블에서 WEIGHT가 70이상이고 80이하인 선수*/
SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID, WEIGHT  FROM PLAYER p
WHERE WEIGHT >= 70 AND WEIGHT <= 80;
/*이상 이하만*/
SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID, WEIGHT  FROM PLAYER p
WHERE WEIGHT BETWEEN 70 AND 80;

/*4. PLAYER 테이블에서 TEAM_ID가 'K03'이고 HEIGHT가 180미만인 선수*/
SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID, HEIGHT FROM PLAYER p
WHERE TEAM_ID = 'K03' AND HEIGHT < 180;

/*5. PLAYER 테이블에서 TEAM_ID가 'K06'이고 NICKNAME이 '제리'인 선수*/
SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID, NICKNAME  FROM PLAYER p
WHERE TEAM_ID = 'K06' AND NICKNAME = '제리';

/*6. PLAYER 테이블에서 HEIGHT가 170이상이고 WEIGHT가 80이상인 선수 이름*/
SELECT PLAYER_ID, PLAYER_NAME, TEAM_ID, HEIGHT, WEIGHT  FROM PLAYER p
WHERE HEIGHT >= 170 AND WEIGHT >= 80;

/*7. STADIUM 테이블에서 SEAT_COUNT가 30000 초과이고 41000이하인 경기장*/
SELECT SEAT_COUNT FROM STADIUM s
WHERE SEAT_COUNT > 30000 AND SEAT_COUNT <= 41000;

/*8. PLAYER 테이블에서 TEAM_ID가 'K02'이거나 'K07'이고 포지션은 'MF'인 선수*/
SELECT PLAYER_ID , PLAYER_NAME , TEAM_ID ,"POSITION"  FROM PLAYER p
WHERE TEAM_ID IN ('K02', 'K07') AND "POSITION" = 'MF';

/*PLAYER 테이블에서 TEAM_ID가 'K01'인 선수 이름을 내 이름으로 바꾸기*/
SELECT * FROM PLAYER
WHERE TEAM_ID = 'K01';

UPDATE PLAYER 
SET PLAYER_NAME = '이준상'
WHERE TEAM_ID = 'K01';

/*PLAYER 테이블에서 POSITION이 'MF'인 선수 삭제하기*/
SELECT "POSITION" FROM PLAYER p2
WHERE "POSITION" = 'MF';
DELETE FROM PLAYER p 
WHERE "POSITION" = 'MF';

/*PLAYER 테이블에서 HEIGHT가 180이상인 선수 삭제하기*/
SELECT TEAM_ID, PLAYER_ID , PLAYER_NAME , HEIGHT  FROM PLAYER p2 
WHERE HEIGHT >= 180;

DELETE FROM PLAYER p 
WHERE HEIGHT >= 180;

ROLLBACK;


/*PLAYER 테이블에서 NICKNAME이 NULL인 선수 검색*/
SELECT PLAYER_NAME , NVL(NICKNAME, '없음') FROM PLAYER
WHERE NICKNAME IS NULL;

/*PLAYER 테이블에서 POSITION이 NULL인 선수 검색*/
SELECT PLAYER_NAME , "POSITION"  FROM PLAYER p 
WHERE "POSITION" IS NULL;

/*PLAYER 테이블에서 POSITION이 NULL인 선수를 '미정'으로 변경 후 검색*/
SELECT PLAYER_NAME , NVL("POSITION" , '미정') FROM PLAYER
WHERE "POSITION" IS NULL;

/*PLAYER 테이블에서 NATION이 등록되어 있으면 '등록', 아니면 '미등록'으로 검색*/
SELECT PLAYER_NAME ,NVL2(NATION, '등록', '미등록') FROM PLAYER p ;

/*AS(ALIAS): 별칭*/
/*SELECT절에서는 컬럼명 뒤에 띄어쓰고 작성하거나, AS 뒤에 작성한다.*/
SELECT PLAYER_NAME 이름 , NVL(NICKNAME, '없음') 닉네임 FROM PLAYER
WHERE NICKNAME IS NULL;

/*선수 이름과 생일 조회*/
SELECT * FROM PLAYER;
SELECT PLAYER_NAME , BIRTH_DATE FROM PLAYER;

/*PLAYER 테이블에서 BACK_NO를 "등 번호"로, NICKNAME을 "선수 별명"으로 변경하여 검색*/
SELECT * FROM PLAYER;
SELECT BACK_NO "등 번호", NVL(NICKNAME, '없음') "선수 별명" FROM PLAYER;

/*CONCATENATION: 연결, ||*/
/*PLAYER_NAME의 별명은 NICKNAME이다.*/
SELECT PLAYER_NAME || '의 별명은 ' || NVL2(NICKNAME, NICKNAME || '이다', '없다') AS 자기소개 FROM PLAYER;

/*PLAYER_NAME의 영어이름은 E_PLAYER_NAME이다.*/
SELECT PLAYER_NAME || '의 영어 이름은 ' || E_PLAYER_NAME ||'이다.' 자기소개 FROM PLAYER;

/*PLAYER_NAME의 포지션은 POSITION입니다.*/
SELECT PLAYER_NAME || '의 포지션은 ' || "POSITION" || '입니다.' 자기소개 FROM PLAYER;

/*LIKE : 포함된 문자열 값을 찾고, 문자의 개수도 제한을 줄 수 있다.*/
/*
 * [컬럼명] LIKE '';
 * 
 * %: 모든 것
 * _: 글자 수
 * 
 * 예)
 * '%A' : A로 끝나는 모든 값
 * 'A%' : A로 시작하는 모든 값
 * '%A%': A가 포함된 모든 값
 * 'A__': A로 시작하고 3글자인 값
 * '_A' : A로 끝나고 2글자인 값
 */

/*TEAM 테이블에서 '천마'로 끝나는 팀 이름 찾기*/
SELECT TEAM_NAME  FROM TEAM t 
WHERE TEAM_NAME LIKE '%천마';

/*PLAYER 테이블에서 김씨 찾기*/
SELECT PLAYER_NAME  FROM PLAYER
WHERE PLAYER_NAME LIKE '김%';

/*PLAYER 테이블에서 김씨 두 자 찾기*/
SELECT PLAYER_NAME  FROM PLAYER p 
WHERE PLAYER_NAME LIKE '김_';

/*PLAYER 테이블에서 김씨와 이씨 찾기*/
SELECT PLAYER_NAME  FROM PLAYER p 
WHERE (PLAYER_NAME LIKE '김%') OR (PLAYER_NAME LIKE '이%');

/*PLAYER 테이블에서 이씨가 아닌 사람 찾기(NOT)*/
SELECT PLAYER_NAME  FROM PLAYER p 
WHERE NOT PLAYER_NAME LIKE '이%';

/*집계 함수: 결과는 무조건 1개*/
/*
 * ※ NULL은 포함시키지 않는다.
 * ※ WHERE절에서 사용 불가.
 * 
 * 평균	: AVG()
 * 최대값	: MAX()
 * 최소값	: MIN()
 * 총합	: SUM()
 * 개수	: COUNT()
 * 
 * */

SELECT AVG(HEIGHT), MAX(HEIGHT), MIN(HEIGHT), SUM(HEIGHT), COUNT(HEIGHT)  FROM PLAYER p ;

/*PLAYER 테이블에서 HEIGHT로 총 선수 명수 검색*/
SELECT COUNT(NVL(HEIGHT, 0)) 총원 FROM PLAYER;

/*정렬*/
/*
 * ORDER BY 컬럼명, ... ASC	: 오름차순
 * ORDER BY 컬럼명, ... DESC	: 내림차순
 * 
 * */

/*키 순 정렬*/
SELECT PLAYER_NAME , HEIGHT, WEIGHT  FROM PLAYER
WHERE HEIGHT IS NOT NULL
ORDER BY HEIGHT DESC, WEIGHT;
/*SELECT PLAYER_NAME , NVL(HEIGHT, 0) 키  FROM PLAYER p 
ORDER BY HEIGHT DESC ;*/

/*
 * GROUP BY: ~별 (예: 포지션 별 평균 키)
 * 
 * GROUP BY 컬럼명 HAVING 조건식
 * ※ WHERE절에서 우선적으로 처리할 조건식을 작성해야 속도가 빠르다.
 * ※ HAVING절에서는 집계함수 사용 가능
 * 
 * */

/*PLAYER 테이블에서 포지션 종류 검색*/
SELECT * FROM PLAYER;
SELECT "POSITION", COUNT("POSITION")  FROM PLAYER
WHERE "POSITION"  IS NOT NULL
GROUP BY "POSITION" ;

/*PLAYER 테이블에서 몸무게가 80이상인 선수들의 평균키가 180이상인 포지션 검색*/
SELECT "POSITION" , MIN(WEIGHT), AVG(HEIGHT) FROM PLAYER p 
WHERE WEIGHT >= 80
GROUP BY "POSITION"
HAVING AVG(HEIGHT) >= 180;


SELECT "POSITION" 포지션, AVG(HEIGHT), MIN(WEIGHT)   FROM PLAYER p 
WHERE WEIGHT >= 80
GROUP BY "POSITION"
HAVING  AVG(HEIGHT) >= 180; 

/*SELECT "POSITION" FROM PLAYER p2 
WHERE
(
	SELECT HEIGHT FROM PLAYER p3
	WHERE WEIGHT >= 80
	/*GROUP BY HEIGHT HAVING AVG(HEIGHT)*/
) >= HEIGHT;*/

/*EMPLOYEES 테이블에서 JOB_ID별 평균 SALARY가 10000미만인 JOB_ID 검색, JOB_ID 알파벳순 정렬*/
SELECT
	JOB_ID,
	AVG(SALARY)
FROM
	EMPLOYEES e
GROUP BY
	JOB_ID
HAVING
		AVG(SALARY) < 10000
ORDER BY
	JOB_ID;


/*
 * SUB QUERY
 * 
 * FROM절	: IN LINE VIEW
 * SELECT절	: SCALAR SUB QUERY
 * WHERE절	: SUB QUERY
 * */


/*PLAYER 테이블에서 TEAM_ID가 'K01'인 선수 중 포지션이 GK인 선수*/
SELECT * FROM 
(
	SELECT * FROM PLAYER p 
	WHERE TEAM_ID = 'K01'
)
WHERE "POSITION" = 'GK';

/*정남일 선수가 소속된 팀의 선수들 조회*/
SELECT TEAM_ID, PLAYER_NAME  FROM PLAYER p 
WHERE TEAM_ID = 
(
SELECT TEAM_ID 
FROM PLAYER
WHERE PLAYER_NAME = '정남일'
);

/*PLAYER 테이블에서 전체 평균 키와 포지션별 평균 키 구하기*/
SELECT AVG(HEIGHT) FROM PLAYER p ;

SELECT AVG(HEIGHT), "POSITION"  FROM PLAYER p
WHERE "POSITION"  IS NOT NULL
GROUP BY "POSITION";


/*경기장 중 경기 일정이 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회*/
SELECT * FROM STADIUM s
WHERE STADIUM_ID IN 
(
	SELECT STADIUM_ID FROM SCHEDULE s2 
	WHERE S2.SCHE_DATE BETWEEN 20120501 AND 20120502
);

/*EMPLOYEES 테이블에서 평균 급여보다 낮은 사원들의 급여를 20% 인상*/
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.2
WHERE SALARY <
(
	SELECT AVG(E.SALARY) FROM EMPLOYEES E  
);

SELECT SALARY FROM EMPLOYEES e ;
SELECT AVG(SALARY) FROM EMPLOYEES e ;

/*PLAYER 테이블에서 NICKNAME이 NULL인 선수들을 정태민 선수의 닉네임으로 바꾸기*/
SELECT PLAYER_NAME  FROM PLAYER p 
WHERE PLAYER_NAME = '정태민';

UPDATE PLAYER P3
SET P3.NICKNAME  = (
	SELECT P1.NICKNAME FROM PLAYER P1
	WHERE P1.PLAYER_NAME = '정태민'
)
WHERE NICKNAME IS NULL;

SELECT * FROM PLAYER p 
WHERE NICKNAME IS NULL;

/*PLAYER 테이블에서 평균 키보다 큰 선수들 삭제*/
SELECT * FROM PLAYER p ;

DELETE FROM PLAYER p 
WHERE HEIGHT > (SELECT AVG(HEIGHT) FROM PLAYER p2 );

SELECT AVG(HEIGHT) FROM PLAYER p ;
SELECT MIN(HEIGHT) FROM PLAYER p ;

/*JOIN*/
/*
 * 여러 테이블에 흩어져 있는 정보 중
 * 사용자가 필요한 정보만 가져와서 가상의 테이블처럼 만들고 결과를 보여주는 것.
 * 정규화를 통해 조회 테이블이 너무 많이 쪼개져 있으면 작업하기 불편하기 때문에
 * 입력, 수정, 삭제의 성능을 향상시키기 위해서 JOIN을 통해 합친 후 사용한다.
 * */

/*EMP 테이블 사원번호로 DEPT 테이블의 지역 검색*/
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT ENAME, LOC 
FROM DEPT D JOIN EMP E 
ON D.DEPTNO = E.DEPTNO;

/*PLAYER 테이블에서 송종국 선수가 속한 팀의 전화번호 검색하기*/
SELECT TEL, T.TEAM_ID , PLAYER_NAME 
FROM PLAYER P JOIN TEAM T
ON T.TEAM_ID = P.TEAM_ID
WHERE P.PLAYER_NAME = '송종국';

/*JOBS 테이블에서 JOB_ID로 직원들의 JOB_TITLE, EMAIL, 성, 이름 검색*/
SELECT J.JOB_ID, J.JOB_TITLE , E.EMAIL , E.FIRST_NAME , E.LAST_NAME 
FROM JOBS J JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID;

/*EMP 테이블의 SAL을 SALGRADE 테이블의 등급으로 나누기*/
SELECT * FROM SALGRADE s ;
SELECT * FROM EMP;

SELECT S.GRADE, E.SAL 
FROM EMP E JOIN SALGRADE S 
ON E.SAL BETWEEN S.LOSAL AND S.HISAL ;

/*EMPLOYEES 테이블에서 HIREDATE가 2003~2005년까지인 사원의 정보와 부서명 검색*/
/*JOB_TITLE 중 'Manager'라는 문자열이 포함된 직업들의 평균 연봉을 JOB_TITLE별로 검색*/
/*EMP 테이블에서 ENAME에 L이 있는 사원들의 DNAME과 LOC 검색*/
/*축구 선수들 중에서 각 팀별로 키가 가장 큰 선수들 전체 정보 검색*/
/*EMP 테이블에서 사원의 이름과 매니저 이름을 검색*/

SELECT * FROM PLAYER p ;
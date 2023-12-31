--문자 함수 : 문자 데이터를 가공하는것

SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

SELECT *
FROM EMP
WHERE UPPER(ENAME) = UPPER('james');

-- LENGTH : 문자열 길이를 반환
-- LENGTHB : 문자열 바이트 수 반환

SELECT LENGTH('한글'), LENGTHB('한글')
FROM DUAL;

-- SUBSTR / SUBSTRB
-- 데이터베이스 시작위치가 0이 아님, 3번째 매개변수를 생략하면 끝까지
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
FROM EMP;


SELECT JOB, 
 SUBSTR(JOB, -LENGTH(JOB)), -- 음수는 뒤에서부터, 길이에 대한 음수값으로 역순 접근
 SUBSTR(JOB, -LENGTH(JOB), 2),
 SUBSTR(JOB, -3)
FROM EMP;

-- INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지 알고자 할 때 사용
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1,
 INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,    -- 3번째 인자로 찾을 시작 위치 지정
 INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3  -- 3번째 인자는 시작위치, 4번째 인자는 찾으려는 문자가 몇번째 인지
FROM DUAL;

-- 특정 문자가 포함된 행 찾기
SELECT *
FROM EMP 
WHERE INSTR(ENAME, 'S') > 0;

SELECT *
FROM EMP 
WHERE ENAME LIKE '%S%';

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체 할 경우 사용
-- 대체할 문자를 넣지 않으면 해당 문자 삭제

SELECT '010-1234-5678' AS REPLACE_BEFORE,
    REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1, -- 공백으로 대체
	REPLACE('010-1234-5678', '-') AS REPLACE_2 -- 해당 문자 삭제
FROM DUAL;

-- LPAD / RPAD : 기준 공간의 칸 수를 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+') 
FROM dual;

SELECT RPAD('ORACLE', 10, '+') 
FROM dual;

SELECT 'ORACLE', 
    LPAD('ORACLE', 10, '#') AS LPAD_1,
    RPAD('ORACLE', 10, '*') AS RPAD_1,
    LPAD('ORACLE',10) AS LPAD_2,
    LPAD('ORACLE',10) AS RPAD_2
FROM dual;

-- 개인정보 뒤자리 *표시로 출력하기
SELECT 
	RPAD('971225-', 14, '*') AS RPAD_JMNO,
	RPAD('010-1234-', 13, '*') AS RPAD_PHONE
FROM DUAL

-- 문자열을 합치는 CONCAT 함수
SELECT CONCAT(EMPNO, ENAME),
 CONCAT(EMPNO, CONCAT(' : ', ENAME))
 FROM EMP
 WHERE ENAME = 'JAMES';

-- TRIM / LTRIM / RTRIM / : 문자열 내에서 특정 문자열을 지우기 위해 사용
-- 보통 공백제거로 씀
 SELECT '[' || TRIM(' _Oracle_ ') || ']' AS TRIM,
 '[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
 '[' || LTRIM('<_Oracle_>', '<_') || ']' AS LTRIM_2,
 '[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
 '[' || RTRIM('<_Oracle_>', '_>') || ']' AS RTRIM_2
 FROM DUAL;


-- 날짜 데이터를다루는 날짜 함수
-- SYSDATE : 운영체제의 현재 날짜와 시간을 정보를 가져 옴
 SELECT SYSDATE FROM dual;

-- 날짜 데이터는 정수값으로 +,- 가능
 SELECT SYSDATE AS NOW,
    SYSDATE-1 AS YESTERDAY,
    SYSDATE+1 AS TOMORROW
FROM DUAL;

-- 몇 개월 이후 날짜를 구하는 ADD_MONTHS 함수
-- 특정 날짜에 지정한 개월 수 이후 날짜 데이터를 반환하는 함수 
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 3) -- 2번째 인자는 달수를 의미
FROM DUAL;

-- EMP 테이블에서 입사 10주년이 되는 사원들 데이터 출력
SELECT empno, ename, hiredate,
    ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR
from emp;

-- SYSDATE와 ADD_MONTHS 함수를 사용하여 현재 날짜와 6개월 후 날짜가 출력
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE,6)
FROM DUAL;

-- 두 날짜 간의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수

SELECT empno, ename, hiredate, sysdate,
    MONTHS_BETWEEN(hiredate, sysdate) as MOTHS1,
    MONTHS_BETWEEN(sysdate, hiredate) as MOTHS2,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MOTHS3
FROM EMP;

-- 날짜 정보 추출 함수
-- EXTRACT 함수는 날짜 유형의 데이터로부터 날짜 정보를 분리하여 새로운 컬럼의 형태로 추출해 주는 함수

SELECT EXTRACT(YEAR FROM DATE '1998-03-07') AS 년도추출
FROM   DUAL;


SELECT EXTRACT(YEAR FROM DATE '1998-03-07') 
FROM   DUAL;

--오늘 날짜에 대한 정보 조회**
SELECT SYSDATE
FROM DUAL;
--EMP테이블에서 사번, 사원명, 급여 조회  (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)**
SELECT EMPNO, ENAME, ROUND(SAL, -2)
FROM EMP
ORDER BY 3 DESC;
--EMP테이블에서 사원번호가 홀수인 사원들을 조회**
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) = 1;
--EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)**
SELECT ENAME, EXTRACT(YEAR FROM HIREDATE), EXTRACT(MONTH FROM HIREDATE)
FROM EMP;
--EMP테이블에서 9월에 입사한 직원의 정보 조회**
SELECT * 
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;
--EMP테이블에서 81년도에 입사한 직원 조회**
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981;
--EMP테이블에서 이름이 'E'로 끝나는 직원 조회**
SELECT *
FROM EMP
WHERE ENAME LIKE '%E';
--EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회**
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';
--LIKE 사용**
--EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회**
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 12*40)
FROM EMP;
--EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회**
SELECT *
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE)/12 >= 38;
--오늘 날짜에서 년도만 추출**
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;

-- 자료형을 변환하는 형 변환 함수
-- 자동 현변환
SELECT EMPNO, ENAME, EMPNO + '500'
FROM EMP
WHERE ENAME = 'FOOD';

SELECT EMPNO, ENAME, EMPNO + 'ABCD'
FROM EMP
WHERE ENAME = 'FORD';

-- 날짜, 숫자를 문자로 변환하는 TO_CHAR 함수
-- 주로 날짜 데이터를 문자 데이터로 변환하는데 사용
-- 자바의 SimpleDateFormat() 유사


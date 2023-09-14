DESC EMP;
DESC DEPT;
DESC EMP;
DESC salgrade;
------------------------------------------------------------
-- 기본 SELECT 문
--테스트
SELECT * FROM EMP;
--------------------------------------------------------
SELECT EMPNO, ENAME, DEPTNO
FROM EMP;

--
SELECT EMPNO, DEPTNO FROM EMP;
-- 별칭 설정 하기 : AS  열이름 또는 컬럼을 별칭으로 표시 할 수 있음
SELECT ENAME AS 이름, SAL AS 급여, SAL*12+COMM AS 연봉, COMM AS 커미션
FROM EMP;

-- 중복 제거하기 : DISTINCT, 중복된 데이터중 단 하나만 남기고 모두 누락시킴
SELECT DISTINCT JOB, DEPTN FROM EMP;

-- 컬럼값을 계산하는 산술연산자 : +, -, *, /

SELECT ENAME, SAL, SAL * 12 AS 연봉
FROM EMP;
-- WHERE 구문 : 데이터를 조회할 때 사용자가 원하는 조건에 맞는 데이터만 조회하고 싶을 때 사용 
-- 여러 연산자와 함께 사용 함

SELECT * FROM EMP
WHERE DEPTNO = 10;

SELECT * FROM EMP
WHERE EMPNO = 7369;
-- 급여가 2500 초과인 사원번호, 이르, 직무, 급여 출력

SELECT EMPNO, JOB, ENAME, SAL FROM EMP
WHERE SAL > 2500;

SELECT * FROM EMP
WHERE SAL * 12 = 36000;

-- 성과급이 500 초과인 사원 출력
SELECT * FROM EMP
WHERE COMM > 500;

-- 같지 않음을 표현하는 방법은 여러가지 존재 <>, !=, ^=, NOT
SELECT * FROM EMP
WHERE DEPTNO != 30;

SELECT * FROM EMP
WHERE NOT DEPTNO = 30;

-- 급여가 3000이상이고, 부서가 20번인 사원 조회 (2가지 조회를 모두 만족해야 하는 경우)

SELECT *
FROM EMP
WHERE SAL >= 3000 AND DEPTNO = 20;
-- 급여가 300 이상이고, 부서가 20번이고, 입사일이 82년 1월1일 이전 사원 조회

SELECT *
FROM EMP
WHERE SAL >= 3000 AND DEPTNO = 20 AND HIREDATE < '82/01/01';

SELECT * FROM emp
WHERE sal >= 3000 AND (deptno = 20 OR HIREDATE < '82/01/01');

SELECT ENAME FROM EMP
WHERE SAL >= 2500 AND JOB = 'MANAGER';


SELECT *
FROM EMP
WHERE JOB = 'MANAGER'
    OR JOB = 'SALESMAN'
    OR JOB = 'CLERK';
-- IN 연산자 : 포함 여부 확인     
SELECT *
FROM EMP
WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

SELECT *
FROM EMP
WHERE DEPTNO NOT IN(20, 30);

-- BETWEEN A AND B 연산자 : 일정한 범위를 조회할 때 사용하는 연산자
-- 급여가 2000이상 3000이하 인 사원 조회
SELECT *
FROM EMP
WHERE SAL >= 2000 AND SAL <= 3000;

SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

SELECT *
FROM EMP
WHERE EMPNO BETWEEN 7689 AND 9702;

-- LIKE, NOT LIKE 연산자 : 일부문자열 포함 유무로 WHERE조건 
SELECT ENAME FROM EMP
WHERE ENAME LIKE '%S%'; 

-- _는 첫번째 글짜 , _L 에서 L은 두번째 글자 , % 기준으로 어떤 문자든 상관없음
SELECT * FROM EMP
WHERE ENAME LIKE '_L%'; 

SELECT *
	FROM EMP
WHERE ename LIKE '%AM%';

SELECT *
	FROM EMP
WHERE ename NOT LIKE '%AM%';


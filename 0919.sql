-- FROM 절에 사용하는 서브쿼리 (인라인 뷰)
-- FROM절에 직접 테이블을 명시하여 사용하기에는 테이블 내 데이터 규모가 너무 큰 경우 사용
-- 보안이나 특정 목적으로 정보를 제공하는 경우
-- 10번 부서에 해당하는 테이블만 가지고 옴
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
    FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10
        JOIN (SELECT * FROM DEPT) D
        ON E10.DEPTNO = D.DEPTNO;

-- 먼저 정렬하고 해당 갯수만 가져 오기
-- ROWNUM : 오라클에서 제공하는 문법으로 행번호를 자동으로 매겨 줌
-- 정렬된 결과에서 상위 3개를 뽑을려면 테이블을 가져올 때 정렬된 상태로 가져와야 함
SELECT ROWNUM, ENAME, SAL
FROM (SELECT * FROM EMP
        ORDER BY SAL DESC)
WHERE ROWNUM <= 3;

-- SELECT절에 사용하는 서브쿼리 : 스칼라 서브쿼리라고도 부름 (반드시 하나의 결과만 나와야함)
-- 단일행으로 와야 함

SELECT EMPNO, ENAME, JOB, SAL,
    (SELECT GRADE
        FROM SALGRADE
     WHERE E.SAL BETWEEN LOSAL AND HISAL) AS 급여등급,
     DEPTNO,
     (SELECT DNAME
        FROM DEPT
      WHERE E.DEPTNO = DEPT.DEPTNO) AS 부서이름
FROM EMP E;

-- 매 행마다 부서번호가 각 행의 부서번호와 동일한 사원들의 SAL 평균을 구해서 반환
SELECT ENAME, DEPTNO, SAL,
        (SELECT TRUNC(AVG(SAL))
            FROM EMP
            WHERE DEPTNO = E.DEPTNO) AS 부서별평균급여
FROM EMP E

-- 부서 위치가 NEW YORK 인 경우에 본사로, 그 외 부서는 분점으로 반환

SELECT EMPNO, ENAME,
        CASE WHEN DEPTNO = (SELECT DEPTNO
                            FROM DEPT
                            WHERE LOC = 'NEW YORK')
            THEN '본사'
            ELSE '분점'
        END AS 소속
FROM EMP
ORDER BY 소속 DESC;

-- 1. 전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 사원 정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성
SELECT JOB, EMPNO, ENAME, E.SAL, D.DEPTNO, DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND JOB = (SELECT JOB
                FROM EMP
               WHERE ENAME = 'ALLEN');
-- 2. 전체 사원의 평균 급여(SAL)보다 높은 급여를 받는 사원들의 사원 정보, 부서 정보, 급여 등급 정보를 출력하는 
-- SQL문을 작성하세요(단 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 
-- 사원 번호를 기준으로 오름차순으로 정렬하세요).
SELECT E.EMPNO, E.ENAME, D.DNAME, E.SAL, S.GRADE
FROM EMP E 
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN SALGRADE S ON E.SAL 
    BETWEEN S.LOSAL AND S.HISAL
WHERE E.SAL > (SELECT AVG(SAL) FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;

-- 3. 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 
-- 사원들의 사원 정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하세요.
SELECT E.ENAME, D.DNAME
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE D.DEPTNO = 10 AND E.JOB NOT IN (SELECT DISTINCT JOB 
                                    FROM EMP 
                                    WHERE DEPTNO = 30);

-- 4. 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보, 급여 등급 정보를 
-- 다음과 같이 출력하는 SQL문을 작성하세요(단 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 
-- 사용하지 않는 방법을 통해 사원 번호를 기준으로 오름차순으로 정렬하세요).

SELECT E.EMPNO, E.ENAME, S.GRADE
FROM EMP E 
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

-- DML (Data Manupulation Language) : 데이터를 조회(SELECT), 삭제(DELETE), 입력(INSERT), 변경(UPDATE)
-- 테이블이 아니고 데이터를 조작하는 것

-- DML을 하기 위해서 임시 테이블 생성
-- 기존의 DEPT TABLE을 복사해서 DEPT_TEMP 테이블 생성
CREATE TABLE DEPT_TEMP 
AS SELECT * FROM DEPT;

SELECT * FROM EMP_TEMP;

-- DROP TABLE DEPT_TEMP -- 테이블 삭제


-- 테이블에 데이터를 추가하기
INSERT INTO EMP_TEMP(DEPTNO, DNAME, LOC) VALUES(50, 'DATABASE', '서울');

-- 서브쿼리를 이용한 INSERT
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
        FROM EMP E JOIN SALGRADE S
        ON E.SAL BETWEEN S.LOSAL AND S.HISAL
        WHERE S.GRADE = 1;

-- UPDATE : 행의 정보를 변경할 때 사용
-- UPDATE : 테이블이름 SET 변경할 열의 이름과 데이터 'WHERE' '조건식'
SELECT * FROM DEPT_TEMP;

CREATE TABLE DEPT_TEMP2
AS SELECT * FROM DEPT_TEMP;


UPDATE DEPT_TEMP2
    SET DNAME = '프론트'
    WHERE DEPTNO = 20;


CREATE TABLE DEPT_TCL
AS SELECT *
FROM DEPT;

SELECT * FROM DEPT_TCL;

INSERT INTO DEPT_TCL VALUES(60, 'BACKEND', 'INCHEON');
DESC EMP;
DESC DEPT;
DESC EMP;
DESC salgrade;
------------------------------------------------------------
-- �⺻ SELECT ��
--�׽�Ʈ
SELECT * FROM EMP;
--------------------------------------------------------
SELECT EMPNO, ENAME, DEPTNO
FROM EMP;

--
SELECT EMPNO, DEPTNO FROM EMP;
-- ��Ī ���� �ϱ� : AS  ���̸� �Ǵ� �÷��� ��Ī���� ǥ�� �� �� ����
SELECT ENAME AS �̸�, SAL AS �޿�, SAL*12+COMM AS ����, COMM AS Ŀ�̼�
FROM EMP;

-- �ߺ� �����ϱ� : DISTINCT, �ߺ��� �������� �� �ϳ��� ����� ��� ������Ŵ
SELECT DISTINCT JOB, DEPTN FROM EMP;

-- �÷����� ����ϴ� ��������� : +, -, *, /

SELECT ENAME, SAL, SAL * 12 AS ����
FROM EMP;
-- WHERE ���� : �����͸� ��ȸ�� �� ����ڰ� ���ϴ� ���ǿ� �´� �����͸� ��ȸ�ϰ� ���� �� ��� 
-- ���� �����ڿ� �Բ� ��� ��

SELECT * FROM EMP
WHERE DEPTNO = 10;

SELECT * FROM EMP
WHERE EMPNO = 7369;
-- �޿��� 2500 �ʰ��� �����ȣ, �̸�, ����, �޿� ���

SELECT EMPNO, JOB, ENAME, SAL FROM EMP
WHERE SAL > 2500;

SELECT * FROM EMP
WHERE SAL * 12 = 36000;

-- �������� 500 �ʰ��� ��� ���
SELECT * FROM EMP
WHERE COMM > 500;

-- ���� ������ ǥ���ϴ� ����� �������� ���� <>, !=, ^=, NOT
SELECT * FROM EMP
WHERE DEPTNO != 30;

SELECT * FROM EMP
WHERE NOT DEPTNO = 30;

-- �޿��� 3000�̻��̰�, �μ��� 20���� ��� ��ȸ (2���� ��ȸ�� ��� �����ؾ� �ϴ� ���)

SELECT *
FROM EMP
WHERE SAL >= 3000 AND DEPTNO = 20;
-- �޿��� 300 �̻��̰�, �μ��� 20���̰�, �Ի����� 82�� 1��1�� ���� ��� ��ȸ

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
-- IN ������ : ���� ���� Ȯ��     
SELECT *
FROM EMP
WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

SELECT *
FROM EMP
WHERE DEPTNO NOT IN(20, 30);

-- BETWEEN A AND B ������ : ������ ������ ��ȸ�� �� ����ϴ� ������
-- �޿��� 2000�̻� 3000���� �� ��� ��ȸ
SELECT *
FROM EMP
WHERE SAL >= 2000 AND SAL <= 3000;

SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

SELECT *
FROM EMP
WHERE EMPNO BETWEEN 7689 AND 9702;

-- LIKE, NOT LIKE ������ : �Ϻι��ڿ� ���� ������ WHERE���� 
SELECT ENAME FROM EMP
WHERE ENAME LIKE '%S%'; 

-- _�� ù��° ��¥ , _L ���� L�� �ι�° ���� , % �������� � ���ڵ� �������
SELECT * FROM EMP
WHERE ENAME LIKE '_L%'; 

SELECT *
	FROM EMP
WHERE ename LIKE '%AM%';

SELECT *
	FROM EMP
WHERE ename NOT LIKE '%AM%';


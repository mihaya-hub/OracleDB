-- LISTAGG �Լ� : ����Ŭ 11g �������� ��� ����, �׷쿡 ���� �ִ� �����͸� ���η� ������ �� ���
-- LISTAGG �Լ� �⺻ ���� : SELECT [��ȸ�� ��1 �̸�], [��ȸ�� ��2 �̸�], ..., [��ȸ�� ��N �̸�]
--                               LISTAGG([������ ��(�ʼ�)], [�� �����͸� �����ϴ� ������(����)])
--                               WITHIN GROUP(ORDER BY ������ ���� ���� ���� �� (����))
--                        FROM   [��ȸ�� ���̺� �̸�]
--                        WHERE  [��ȸ�� ���� �����ϴ� ���ǽ�]

-- GROUP BY���� �׷�ȭ�Ͽ� �μ� ��ȣ�� �μ� ��ȣ�� ��� �̸� ����ϱ�

SELECT DEPTNO, ENAME
FROM EMP
GROUP BY DEPTNO, ENAME;

-- �μ��� ��� �̸��� ������ �����Ͽ� ����ϱ�

SELECT DEPTNO,
       LISTAGG(ENAME, ', ')
       WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
FROM EMP
GROUP BY DEPTNO;

-- PIVOT, UNPIVOT �Լ� : ����Ŭ 11g �������� ��� ����, PIVOT �Լ��� ���� ���̺� ���� ���� �ٲٰ� UNPIVOT �Լ��� ���� ���̺� ���� ������ �ٲ㼭 ���

-- �μ���, ��å���� �׷�ȭ�Ͽ� �ְ� �޿� ������ ����ϱ�

SELECT DEPTNO, JOB, MAX(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- PIVOT �Լ��� ����Ͽ� ��å��, �μ��� �ְ� �޿��� 2���� ǥ ���·� ����ϱ�

SELECT *
FROM(SELECT DEPTNO, JOB, SAL FROM EMP)
PIVOT(MAX(SAL) FOR DEPTNO IN (10, 20, 30))
ORDER BY JOB;

-- PIVOT �Լ��� ����Ͽ� �μ���, ��å�� �ְ� �޿��� 2���� ǥ ���·� ����ϱ�

SELECT *
FROM(SELECT DEPTNO, JOB, SAL FROM EMP)
PIVOT(MAX(SAL) FOR JOB IN ('CLERK' AS CLERK,
                           'SALESMAN' AS SALESMAN,
                           'PRESIDENT' AS PRESIDENT,
                           'MANAGER' AS MANAGER,
                           'ANALYST' AS ANALYST))
ORDER BY DEPTNO;

-- DECODE���� Ȱ���Ͽ� PIVOT �Լ��� ���� ��� �����ϱ� (����Ŭ 11g ���� ����)

SELECT DEPTNO,
       MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK",
       MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN",
       MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT",
       MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER",
       MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- UNPIVOT �Լ��� ����Ͽ� ���� ���е� �׷��� ������ ����ϱ�

SELECT *
FROM (SELECT DEPTNO,
             MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK",
             MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN",
             MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT",
             MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER",
             MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
      FROM EMP
      GROUP BY DEPTNO
      ORDER BY DEPTNO)
UNPIVOT(SAL FOR JOB IN (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST))
ORDER BY DEPTNO, JOB;

-- EMP ���̺��� �̿��Ͽ� �μ� ��ȣ(DEPTNO), ��� �޿�(AVG_SAL), �ְ� �޿�(MAX_SAL), ���� �޿�(MIN_SAL), ��� ��(CNT)�� ���
-- ��, ��� �޿��� ����� �� �Ҽ����� �����ϰ� �� �μ� ��ȣ���� ���

SELECT DEPTNO,
       TRUNC(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
FROM EMP
GROUP BY DEPTNO;

-- ���� ��å(JOB)�� �����ϴ� ����� 3�� �̻��� ��å�� �ο����� ���

SELECT JOB, 
       COUNT(*)
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- ������� �Ի� ����(HIRE_YEAR)�� �������� �μ����� �� ���� �Ի��ߴ��� ���

SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR,
       DEPTNO,
       COUNT(*) AS CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;

-- �߰� ����(COMM)�� �޴� ��� ���� ���� �ʴ� ��� ���� ���

SELECT NVL2(COMM, 'O', 'X') AS EXIST_COMM,
       COUNT(*) AS CNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

-- �� �μ��� �Ի� ������ ��� ��, �ְ� �޿�, �޿� ��, ��� �޿��� ����ϰ� �� �μ��� �Ұ�� �Ѱ踦 ���

SELECT DEPTNO,
       TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR,
       COUNT(*) AS CNT,
       MAX(SAL) AS MAX_SAL,
       SUM(SAL) AS SUM_SAL,
       AVG(SAL) AS AVG_SAL
FROM EMP
GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));
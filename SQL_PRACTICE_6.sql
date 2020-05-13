-- ���� ���� : SQL���� �����ϴ� �� �ʿ��� �����͸� �߰��� ��ȸ�ϱ� ���� SQL�� ���ο��� ����ϴ� SELECT��
--           ���� ������ ��� ���� ����Ͽ� ����� �����ϴ� ������ ���� ������� �θ���

-- ���� ������ JONES�� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ�

SELECT *
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE ENAME = 'JONES');
             
-- ���� ������ Ư¡
-- 1. ���� ������ �����ڿ� ���� �� �Ǵ� ��ȸ ����� �����ʿ� ���̸� ��ȣ ()�� ��� ���
-- 2. Ư���� ��� ��츦 ������ ��κ��� ���� ���������� ORDER BY���� ����� �� ����
-- 3. ���� ������ SELECT���� ����� ���� ���� ������ �� ���� ���� �ڷ����� ���� ������ �����ؾ���
-- 4. ���� ������ �ִ� SELECT���� ��� �� ���� �Բ� ����ϴ� ���� ������ ������ ������ ȣȯ �����ؾ� ��

-- ������ ���� ���� : ���� ����� �� �ϳ��� ������ ������ ���� ����
--                 ������ ������(> >= = <= < <> ^= !=)�� ����Ͽ� ��
--                 ���� �������� ����� �Լ��� ��� ���� �ϳ��� �� ������ ���� �����μ� ��� ����

-- ���� ���� �ȿ� �Լ��� ����� ���

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE E.DEPTNO = 20
  AND E.SAL > (SELECT AVG(SAL) FROM EMP);
  
-- ������ ���� ���� : ���� ��� ���� ���� ���� ������ ���� ����
--                 ������ ������(IN ANY,SOME ALL EXISTS)�� ����Ͽ� ��

-- IN ������ : ���� ������ �����Ͱ� ���� ������ ��� �� �ϳ��� ��ġ�� �����Ͱ� �ִٸ� TRUE

-- �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ����ϱ�

SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
              FROM EMP
              GROUP BY DEPTNO);
              
-- ANY, SOME ������ : ���� ������ ���ǽ��� �����ϴ� ���� ������ ����� �ϳ� �̻��̸� TRUE

-- ANY ������ ����ϱ�

SELECT *
FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL)
                 FROM EMP
                 GROUP BY DEPTNO);
                 
-- SOME ������ ����ϱ�

SELECT *
FROM EMP
WHERE SAL = SOME (SELECT MAX(SAL)
                  FROM EMP
                  GROUP BY DEPTNO);
-- � �� ������(=)�� ����� ���� IN �����ڸ� ����ϴ� �Ͱ� ������ ���� ����� ���� ������ ��κ� IN �����ڸ� ���

-- 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ�

SELECT *
FROM EMP
WHERE SAL < ANY (SELECT SAL
                 FROM EMP
                 WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO;
-- ANY, SOME �����ڴ� ���� ���� ��� �� �� �ּ��� �ϳ��� �����ϸ� ���� ���� ���ǽ��� ����� TRUE�� �ǹǷ�
-- �� ��� ���� ���� ��� �� ���� ū ������ ���� �޿��� ���� ���� ���� ���� ��� TRUE�� �ȴ�
-- ����, �ִ� �޿����� ���� �޿��� �޴� ��� ������ ��µȴ�

-- ALL ������ : ���� ������ ���ǽ��� ���� ������ ��� ��ΰ� �����ϸ� TRUE

-- 30�� �μ� ������� �ּ� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ�

SELECT *
FROM EMP
WHERE SAL < ALL (SELECT SAL
                 FROM EMP
                 WHERE DEPTNO = 30);
                 
-- 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ�

SELECT *
FROM EMP
WHERE SAL > ALL (SELECT SAL
                 FROM EMP
                 WHERE DEPTNO = 30);
-- ALL �����ڴ� ���� ���� ��� ����� ��� ������ �����ϴ� ���� ���� ��� �ุ TRUE�� �ǹǷ�
-- �� ��� ���� ���� ��� �� ���� ū ������ ���� �޿��� ���� ���� ���� ���� TRUE�� �ȴ�
-- ����, �ִ� �޿����� ���� �޿��� �޴� ��� ������ ��µȴ�

-- EXISTS ������ : ���� ������ ����� �����ϸ�(��, ���� 1�� �̻�) TRUE

-- ���� ���� ��� ���� �����ϴ� ���

SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME
              FROM DEPT
              WHERE DEPTNO = 10);
-- ���� ������ ��� ���� �����ϱ� ������ EMP�� ��� ���� ���

-- ���� ���� ��� ���� �������� �ʴ� ���

SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME
              FROM DEPT
              WHERE DEPTNO = 50);
-- ���� ������ ��� ���� �������� �ʱ� ������ �ƹ� �൵ ��µ��� ����

-- ���߿� ���� ���� : ���� ������ SELECT���� ���� �����͸� ���� �� �����ϴ� ���
--                 ���� ������ ���� ���� ��ȣ�� ���� ����ϰ� ���� ���������� ��ȣ�� ���� �����Ϳ� ���� �ڷ��� �����͸� SELECT���� ����Ͽ� ���

-- ���߿� ���� ���� ����ϱ�

SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                        FROM EMP
                        GROUP BY DEPTNO);

-- �ζ��� �� : FROM���� ����ϴ� ���� ����
--           Ư�� ���̺� ��ü�� �ƴ� SELECT���� ���� �Ϻ� �����͸� ������ �� �� ��Ī�� �־� ����� �� �ִ�

-- �ζ��� �� ����ϱ�

SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
     (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

-- WITH�� �⺻ ���� : WITH
--                  [��Ī1] AS (SELECT��1),
--                  [��Ī2] AS (SELECT��2),
--                  ...
--                  [��ĪN] AS (SELECT��N)
--                  SELECT ...
--                  FROM [��Ī1], [��Ī2], ..., [��ĪN] ...
-- �ζ��� ��� FROM���� �ʹ� ���� ���� ������ �����ϸ� �������̳� ���� ���� ����� �־ ���

-- WITH�� ����ϱ�

WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D   AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

-- ��Į�� ���� ���� : SELECT���� ����ϴ� ���� ����
--                 �� �ϳ��� ����� ��ȯ�ϵ��� �ۼ��Ͽ��� ��

-- ��Į�� ���� ���� ����ϱ�

SELECT EMPNO, ENAME, JOB, SAL,
       (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
       DEPTNO,
       (SELECT DNAME FROM DEPT WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
FROM EMP E;

-- ��ü ��� �� ALLEN�� ���� ��å(JOB)�� ������� ��� ����, �μ� ������ ���

SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND E.JOB = (SELECT JOB
                FROM EMP
                WHERE ENAME = 'ALLEN');
                
-- ��ü ����� ��� �޿�(SAL)���� ���� �޿��� �޴� ������� ��� ����, �μ� ����, �޿� ��� ������ ���
-- ��, �޿��� ���� ������ ����ϵ� �޿��� ���� ��� ��� ��ȣ�� �������� �������� ����

SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
  AND E.SAL BETWEEN S.LOSAL AND S.HISAL
  AND E.SAL > (SELECT AVG(SAL)
               FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;

-- 10�� �μ��� �ٹ��ϴ� ��� �� 30�� �μ����� �������� �ʴ� ��å�� ���� ������� ��� ����, �μ� ������ ���

SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND E.DEPTNO = 10
  AND E.JOB NOT IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 30);
  
-- ��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� ��� ����, �޿� ��� ������ ���
-- ��, ���� ������ Ȱ���� �� ������ ���� ������ ����ϴ� ����� ������� �ʴ� ����� ���� ��� ��ȣ�� �������� ������������ ����

-- ������ ���� ������ ������� �ʴ� ���

SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
  AND E.SAL > (SELECT MAX(SAL)
               FROM EMP
               WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

-- ������ ���� ������ ����ϴ� ���

SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
  AND E.SAL > ALL (SELECT DISTINCT SAL
                   FROM EMP
                   WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;
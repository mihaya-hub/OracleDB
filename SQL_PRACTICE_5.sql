-- JOIN : �� �� �̻��� ���̺��� �����Ͽ� �ϳ��� ���̺�ó�� ���

-- FROM���� ���� ���̺� �����ϱ�

SELECT *
FROM EMP, DEPT
ORDER BY EMPNO;

-- � ���� : ���̺��� ������ �Ŀ� ��� ���� �� ���̺��� Ư�� ���� ��ġ�� �����͸� �������� �����ϴ� ���

-- �� �̸��� ���ϴ� ���ǽ����� �����ϱ�

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;

-- ���̺� �̸��� ��Ī���� ǥ���ϱ�

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

-- ���� SELECT ���� ����� �� ��� ���� ����ϴ��� *�� ������� �ʰ� ����� ���� �ϳ��ϳ� ���� ������ش�
-- Ư�� ���� ���� ����ų� �����ǰų� �Ǵ� � ������ �����Ǿ��� ��� �� ��ȭ�� ���� �� ��ȭ�� ���� ���α׷� ������ ���� ���� �� �ֱ� ����

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

-- �� ���� : � ���� ��� ���� ���

-- �޿� ������ �����ϴ� ���ǽ����� �����ϱ�

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- ��ü ���� : �ϳ��� ���̺��� ���� ���� ���̺�ó�� Ȱ���Ͽ� �����ϴ� ���

-- ���� ���̺��� �� �� ����Ͽ� ��ü �����ϱ�

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO
ORDER BY EMPNO;

-- �ܺ� ���� : ���� ���� ���� NULL�� ó���ϴ� ���� �������� ����ϴ� ���� ���

-- ������ Ȯ���� ��ü ������ ��� ����ڰ� ���� �ְ� �����ڴ� ������� ���ܵ�
-- ��� ������ NULL�̴��� ����ϵ��� �ܺ� ���� ���

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY EMPNO;

-- ���� �ܺ� ���� ( (+)�� �����ʿ� ���� ) : ���� ���� �������� ������ �� �������� ���� ���ο� ������� ���
-- ������ �ܺ� ���� ( (+)�� ���ʿ� ���� ) : ������ ���� �������� ���� �� �������� ���� ���ο� ������� ���

-- SQL-99 ǥ�� ���������� ����

-- NATURAL JOIN : � ������ ����� ����� �� �ִ� ���� ���, ���� ����� �Ǵ� �� ���̺� �̸��� �ڷ����� ���� ���� ã�� �� �� ���� �������� � ������ ���ִ� ���

-- NATURAL JOIN�� ����Ͽ� �����ϱ�

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
       DEPTNO, D.DNAME, D.LOC
FROM EMP E NATURAL JOIN DEPT D
ORDER BY DEPTNO, E.EMPNO;
-- ���� ������ WHERE���� �ִ� ���� ���� ��İ� �޸� SQL-99 ��� ������ FROM���� ���� Ű���带 ����ϴ� ���·� �ۼ�
-- ���� �� DEPTNO�� �������� �ڵ����� � ������ �ǹǷ� ���� ���� DEPTNO�� ����� �� ���̺� �̸��� ������ �ȵ�

-- JOIN ~ USING : � ������ ����� ����� �� �ִ� ���� ���, NATURAL JOIN�� �ڵ����� ���� ���� �����ϴ� �Ͱ� �޸� USING Ű���忡 ���� �������� ����� ���� ����Ͽ� ���

-- JOIN ~ USING�� ����Ͽ� �����ϱ�

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
       DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D USING (DEPTNO)
WHERE SAL >= 3000
ORDER BY DEPTNO, E.EMPNO;

-- JOIN ~ ON : ���� ���뼺�ִ� ���� ���, ���� WHERE���� �ִ� ���� ���ǽ��� ON Ű���� ���� �ۼ��ϰ� �� ���� ��� ���� �ɷ� ���� ���� WHERE ���ǽ��� ���� ����ϴ� ���

-- JOIN ~ ON���� � �����ϱ�

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
       E.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE SAL <= 3000
ORDER BY E.DEPTNO, EMPNO;

-- OUTER JOIN : �ܺ� ���ο� ���, �ٸ� SQL-99 ����� ���ΰ� ���������� WHERE���� �ƴ� FROM������ �ܺ� ������ ����
-- ���� �ܺ� ���� -     ����  : WHERE TABLE1.COL1 = TABLE2.COL1(+)
--                  SQL-99 : FROM TABLE1 LEFT OUTER JOIN TABLE2 ON (���� ���ǽ�)
-- ������ �ܺ� ���� -   ����  : WHERE TABLE1.COL1(+) = TABLE2.COL1
--                  SQL-99 : FROM TABLE1 RIGHT OUTER JOIN TABLE2 ON (���� ���ǽ�)
-- ��ü �ܺ� ���� -     ����  : �⺻ ������ ���� (UNION ���� �����ڸ� Ȱ��)
--                  SQL-99 : FROM TABLE1 FULL OUTER JOIN TABLE2 ON (���� ���ǽ�)

-- ���� �ܺ� ������ SQL-99�� �ۼ��ϱ�

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
FROM EMP E1 LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;

-- �� �� �̻��� ���̺��� ������ �� : FROM TABLE1 JOIN TABLE2 ON (���ǽ�) JOIN TABLE3 ON (���ǽ�)

-- �޿�(SAL)�� 2000�ʰ��� ������� �μ� ����, ��� ������ ���
-- ��, SQL-99 ���� ��İ� SQL-99 ����� ���� ���

-- SQL-99 ���� ���

SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND E.SAL > 2000
ORDER BY DEPTNO, EMPNO;

-- SQL-99 ���

SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.SAL
FROM DEPT D JOIN EMP E ON (D.DEPTNO = E.DEPTNO)
WHERE E.SAL > 2000
ORDER BY D.DEPTNO, E.EMPNO;

-- �� �μ��� ��� �޿�, �ִ� �޿�, �ּ� �޿�, ������� ���
-- ��, SQL-99 ���� ��İ� SQL-99 ����� ���� ���

-- SQL-99 ���� ���

SELECT D.DEPTNO, D.DNAME,
       TRUNC(AVG(E.SAL)) AS AVG_SAL,
       MAX(E.SAL) AS MAX_SAL,
       MIN(E.SAL) AS MIN_SAL,
       COUNT(*) AS CNT
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO, D.DNAME
ORDER BY D.DEPTNO;

-- SQL-99 ���

SELECT D.DEPTNO, D.DNAME,
       TRUNC(AVG(E.SAL)) AS AVG_SAL,
       MAX(E.SAL) AS MAX_SAL,
       MIN(E.SAL) AS MIN_SAL,
       COUNT(*) AS CNT
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
GROUP BY D.DEPTNO, D.DNAME
ORDER BY D.DEPTNO;

-- ��� �μ� ������ ��� ������ �μ� ��ȣ, ��� �̸������� �����Ͽ� ���
-- ��, SQL-99 ���� ��İ� SQL-99 ����� ���� ���

-- SQL-99 ���� ���

SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE D.DEPTNO = E.DEPTNO(+)
ORDER BY D.DEPTNO, E.ENAME;

-- SQL-99 ���

SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM DEPT D LEFT OUTER JOIN EMP E ON (D.DEPTNO = E.DEPTNO)
ORDER BY D.DEPTNO, E.ENAME;

-- ��� �μ� ����, ��� ����, �޿� ��� ����, �� ����� ���� ����� ������ �μ� ��ȣ, ��� ��ȣ ������ �����Ͽ� ���
-- ��, SQL-99 ���� ��İ� SQL-99 ����� ���� ���

-- SQL-99 ���� ���

SELECT D.DEPTNO, D.DNAME,
       E1.EMPNO, E1.ENAME, E1.MGR, E1.SAL,
       S.LOSAL, S.HISAL, S.GRADE,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
FROM DEPT D, EMP E1, SALGRADE S, EMP E2
WHERE D.DEPTNO = E1.DEPTNO(+)
  AND E1.SAL BETWEEN S.LOSAL(+) AND S.HISAL(+)
  AND E1.MGR = E2.EMPNO(+)
ORDER BY D.DEPTNO, E1.EMPNO;

-- SQL-99 ���

SELECT D.DEPTNO, D.DNAME,
       E1.EMPNO, E1.ENAME, E1.MGR, E1.SAL,
       S.LOSAL, S.HISAL, S.GRADE,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
FROM DEPT D LEFT OUTER JOIN EMP E1 ON (D.DEPTNO = E1.DEPTNO)
     LEFT OUTER JOIN SALGRADE S ON (E1.SAL BETWEEN S.LOSAL AND S.HISAL)
     LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY D.DEPTNO, E1.EMPNO;
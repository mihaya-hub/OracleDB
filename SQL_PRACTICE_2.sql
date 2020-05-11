-- ������ �Լ� --

-- SUM �Լ� �⺻ ���� : SUM([DISTINCT, ALL �� �ϳ��� �����ϰų� �ƹ� ���� �������� ����(����)]
--                        [�հ踦 ���� ���̳� ������, �Լ��� ����� ������(�ʼ�)])
--                    OVER(�м��� ���� ���� ������ ����)(����)

-- SUM �Լ��� ����Ͽ� �޿� �հ� ����ϱ�
/*
SELECT SUM(SAL) 
FROM EMP;
*/

-- �޿� �հ� ���ϱ�(DISTINCT, ALL ���)
/*
SELECT SUM(DISTINCT SAL),
       SUM(ALL SAL),
       SUM(SAL)
FROM EMP;
*/
-- DISTINCT �ɼ��� �ߺ� ���� �����ϰ� �հ踦 ����. ALL �ɼ��� �ߺ� �� ���� �հ踦 ���� (�ƹ� �ɼǵ� �������� ������ ALL)

-- COUNT �Լ� �⺻ ���� : COUNT([DISTINCT, ALL �� �ϳ��� �����ϰų� �ƹ� ���� �������� ����(����)]
--                            [������ ���� ���̳� ������, �Լ��� ����� ������(�ʼ�)])
--                      OVER(�м��� ���� ���� ���� ����)(����)

-- EMP ���̺��� ������ ���� ����ϱ�
/*
SELECT COUNT(*)
FROM EMP;
*/

-- �μ� ��ȣ�� 30���� ���� �� ���ϱ�
/*
SELECT COUNT(*)
FROM EMP
WHERE DEPTNO = 30;
*/

-- COUNT �Լ��� ����Ͽ� �޿� ���� ���ϱ�(DISTINCT, ALL ���)
/*
SELECT COUNT(DISTINCT SAL),
       COUNT(ALL SAL),
       COUNT(SAL)
FROM EMP;
*/

-- COUNT �Լ��� ����Ͽ� �߰� ���� �� ���� ����ϱ�
/*
SELECT COUNT(COMM)
FROM EMP;
*/

-- COUNT �Լ��� IS NOT NULL�� ����Ͽ� �߰� ���� �� ���� ����ϱ�
/*
SELECT COUNT(COMM)
FROM EMP
WHERE COMM IS NOT NULL;
*/
-- NULL �����ʹ� COUNT ��ȯ �������� ���ܵ� (IS NOT NULL �ᵵ �Ƚᵵ ���� ���)

-- MAX/MIN �Լ� �⺻ ���� : MAX/MIN([DISTINCT, ALL �� �ϳ��� �����ϰų� �ƹ� ���� �������� ����(����)]
--                        [�ִ�/�ּڰ��� ���� ���̳� ������, �Լ��� ����� ������(�ʼ�)]
--                    OVER(�м��� ���� ���� ���� ����)(����)

-- �μ� ��ȣ�� 10���� ������� �ִ� �޿� ����ϱ�
/*
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 10;
*/

-- �μ� ��ȣ�� 10���� ������� �ּ� �޿� ����ϱ�
/*
SELECT MIN(SAL)
FROM EMP
WHERE DEPTNO = 10;
*/

-- ��¥ �����Ϳ� MAX/MIN �Լ� ����ϱ�
-- �μ� ��ȣ�� 20�� ����� �Ի��� �� ���� �ֱ� �Ի��� ����ϱ�
/*
SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;
*/
-- �Ի� ������ ū ����� �� �ֱ�

-- �μ� ��ȣ�� 20�� ����� �Ի��� �� ���� ������ �Ի��� ����ϱ�
/*
SELECT MIN(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;
*/
-- �Ի� ������ ���� ����� �� ������

-- AVG �Լ� �⺻ ���� : AVG([DISTINCT, ALL �� �ϳ��� �����ϰų� �ƹ� ���� �������� ����(����)]
--                        [��� ���� ���� ���̳� ������, �Լ��� ����� ������(�ʼ�)]
--                    OVER(�м��� ���� ���� ������ ����)(����)

-- �μ� ��ȣ�� 30�� �ÿ����� ��� �޿� ����ϱ�
/*
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 30;
*/

-- ���� �����ڸ� ����Ͽ� �� �μ��� ��� �޿� ����ϱ�
/*
SELECT AVG(SAL), '10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT AVG(SAL), '20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT AVG(SAL), '30' AS DEPTNO FROM EMP WHERE DEPTNO = 30;
*/
-- �� ����� ���ŷο� ����� �Ӹ� �ƴ϶� ���Ŀ� Ư�� �μ��� �߰��ϰų� ������ ������ SQL���� �����ؾ� �ϹǷ� �ٶ������� ����

-- GROUP BY �� �⺻ ���� : SELECT    [��ȸ�� ��1 �̸�], [��ȸ�� ��2 �̸�], ..., [��ȸ�� ��N �̸�]
--                       FROM      [��ȸ�� ���̺� �̸�]
--                       WHERE     [��ȸ�� ���� �����ϴ� ���ǽ�]
--                       GROUP BY  [�׷�ȭ�� ���� ����(���� �� ���� ����)]
--                       ORDER BY  [�����Ϸ��� �� ����]

-- GROUP BY�� ����Ͽ� �μ��� ��� �޿� ����ϱ�
/*
SELECT AVG(SAL), DEPTNO
FROM EMP
GROUP BY DEPTNO;
*/

-- �μ� ��ȣ �� ��å�� ��� �޿��� �����ϱ�
/*
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;
*/

-- GROUP BY�� ������ : ������ �Լ��� ������� ���� �Ϲ� ���� GROUP BY���� ������� ������ SELECT������ ����� �� ����
/*
SELECT ENAME, DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;
*/
-- GROUP BY���� ������� ���� ENAME�� ���� ������ �����ǹǷ� ���� �߻�
-- [Error] Execution (140: 8): ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
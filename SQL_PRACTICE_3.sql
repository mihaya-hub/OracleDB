-- GROUP BY���� ������ �ִ� HAVING��

-- HAVING�� �⺻ ���� : SELECT   [��ȸ�� ��1 �̸�], [��ȸ�� ��2 �̸�], ..., [��ȸ�� ��N �̸�]
--                    FROM     [��ȸ�� ���̺� �̸�]
--                    WHERE    [��ȸ�� ���� �����ϴ� ���ǽ�]
--                    GROUP BY [�׷�ȭ�� �� ����(���� �� ���� ����)]
--                    HAVING   [��� �׷��� �����ϴ� ���ǽ�]
--                    ORDER BY [�����Ϸ��� �� ����]

-- GROUP BY���� HAVING���� ����Ͽ� ����ϱ�

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;


-- HAVING�� ������ : HAVING���� WHERE���� ����ϴٰ� ������ �� ������ WHERE���� ��� ��� ���� �����ϰ�, HAVING���� �׷�ȭ�� ����� ��¿��� �����ϹǷ� ���ӻ��� ���� �ٸ�
-- HAVING�� ��� WHERE���� �߸� ������� ���

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE AVG(SAL) >= 2000
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- ��� ���� �����ϴ� WHERE�������� �׷�ȭ�� ������ AVG(SAL)�� �����ϴ� ���ǽ��� ������ �� �����Ƿ� ���� �߻�
-- [Error] Execution (24: 7): ORA-00934: �׷� �Լ��� �㰡���� �ʽ��ϴ�

-- WHERE���� HAVING���� ������

-- WHERE���� ������� �ʰ� HAVING���� ����� ���

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
   HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;


-- WHERE���� HAVING���� ��� ����� ���

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

-- WHERE���� GROUP BY���� HAVING���� ����ϴ� ������ �׷�ȭ���� ���� �����ϱ� ������ �޿�(SAL)�� 3000�� �Ѵ� ����� ���� ���ܵǼ� �׷�ȭ ��� �������� ����

-- �׷�ȭ�� ���õ� �Լ�

-- ROLLUP �Լ� �⺻ ���� : SELECT [��ȸ�� ��1 �̸�], [��ȸ�� ��2 �̸�], ..., [��ȸ�� ��N �̸�]
--                       FROM   [��ȸ�� ���̺� �̸�]
--                       WHERE  [��ȸ�� ���� �����ϴ� ���ǽ�]
--                       GROUP BY ROLLUP([�׷�ȭ �� ����(���� �� ���� ����])
-- CUBE �Լ� �⺻ ���� : SELECT [��ȸ�� ��1 �̸�], [��ȸ�� ��2 �̸�], ..., [��ȸ�� ��N �̸�]
--                     FROM   [��ȸ�� ���̺� �̸�]
--                     WHERE  [��ȸ�� ���� �����ϴ� ���ǽ�]
--                     GROUP BY CUBE([�׷�ȭ �� ����(���� �� ���� ����])
-- �׷�ȭ �������� �հ踦 �Բ� ����ϴµ� ����մϴ�.

-- ROLLUP �Լ��� ������ �׷�ȭ

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);


-- CUBE �Լ��� ������ �׷�ȭ

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;


-- ROLLUP(A, B, C)
-- 1. A �׷캰 B �׷캰 C �׷쿡 �ش��ϴ� ��� ���
-- 2. A �׷캰 B �׷쿡 �ش��ϴ� ��� ���
-- 3. A �׷쿡 �ش��ϴ� ��� ���
-- 4. ��ü ������ ��� ���
-- �� N���� ���� �����ϸ� N+1���� ������ ��µ�

-- CUBE(A, B, C)
-- 1. A �׷캰 B �׷캰 C �׷쿡 �ش��ϴ� ��� ���
-- 2. A �׷캰 B �׷쿡 �ش��ϴ� ��� ���
-- 3. B �׷캰 C �׷쿡 �ش��ϴ� ��� ���
-- 4. A �׷캰 C �׷쿡 �ش��ϴ� ��� ���
-- 5. A �׷쿡 �ش��ϴ� ��� ���
-- 6. B �׷쿡 �ش��ϴ� ��� ���
-- 7. C �׷쿡 �ش��ϴ� ��� ���
-- 8. ��ü ������ ��� ���
-- �� N���� ���� �����ϸ� 2^N���� ������ ��µ�

-- GROUPING SETS �Լ� �⺻ ���� : SELECT [��ȸ�� ��1 �̸�], [��ȸ�� ��2 �̸�], ..., [��ȸ�� ��N �̸�]
--                              FROM   [��ȸ�� ���̺� �̸�]
--                              WHERE  [��ȸ�� ���� �����ϴ� ���ǽ�]
--                              GROUP BY GROUPING SETS([�׷�ȭ �� ����(���� �� ���� ����)]
-- ���� �׷�ȭ ��� ���� ��� ���� ���� ���� �������� ����մϴ�.

-- GROUPING SETS �Լ��� ����Ͽ� ������ �׷��� ���� ����ϱ�

SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

-- ROLLUP�� CUBE �Լ�ó�� ���� ��׷�, �ұ׷�� ���� ���������� �׷�ȭ�ϴ� ���� �ƴ� ������ ���� ���� ��׷����� ó���Ͽ� ���


-- �׷�ȭ �Լ� : ������ ��ü�� �����̳� Ư���� ���� ����� ���������� ������ �׷�ȭ �������� �ĺ��� ���� �������� ������ ���� �������� ���

-- GROUPING �Լ� �⺻ ���� : SELECT [��ȸ�� ��1 �̸�], [��ȸ�� ��2 �̸�], ..., [��ȸ�� ��N �̸�],
--                                GROUPING([GROUP BY���� ROLLUP �Ǵ� CUBE�� ����� �׷�ȭ �� �� �̸�])
--                         FROM   [��ȸ�� ���̺� �̸�]
--                         WHERE  [��ȸ�� ���� �����ϴ� ���ǽ�]
--                         GROUP BY ROLLUP �Ǵ� CUBE([�׷�ȭ�� ��])
-- ���� ����� �׷�ȭ ��� ���� �׷�ȭ�� �̷���� ������ �������� ���θ� ����մϴ�.

-- DEPTNO, JOB���� �׷�ȭ ��� ���θ� GROUPING �Լ��� Ȯ���ϱ�

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL),
       GROUPING(DEPTNO),
       GROUPING(JOB)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

-- ���� ���� ����� GROUPING �Լ��� ����� ���� �׷�ȭ�Ǿ� ��µǾ����� 1, �׷�ȭ���� ���� ����� 0�� �����

-- DECODE������ GROUPING �Լ��� �����Ͽ� ��� ǥ���ϱ�

SELECT DECODE(GROUPING(DEPTNO), 1, 'ALL_DEPT', DEPTNO) AS DEPTNO,
       DECODE(GROUPING(JOB), 1, 'ALL_JOB', JOB) AS JOB,
       COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

-- GROUPING �Լ��� ����� ���� DECODE���� �̿��Ͽ� ����� ǥ����

-- GROUPING_ID �Լ� �⺻ ���� : SELECT [��ȸ�� ��1 �̸�], [��ȸ�� ��2 �̸�], ..., [��ȸ�� ��N �̸�],
--                                   GROUPING_ID([�׷�ȭ ���θ� Ȯ���� ��(���� �� ���� ����)]
--                            FROM   [��ȸ�� ���̺� �̸�]
--                            WHERE  [��ȸ�� ���� �����ϴ� ���ǽ�]
--                            GROUP BY ROLLUP �Ǵ� CUBE([�׷�ȭ�� ��])
-- GROUPING �Լ�ó�� Ư�� ���� �׷�ȭ ���θ� ����� �� ������, �˻��� ���� ���� �� ������ �� �ֽ��ϴ�.

-- DEPTNO, JOB�� �Բ� ����� GROUPING_ID �Լ� ����ϱ�

SELECT DEPTNO, JOB, COUNT(*), SUM(SAL),
       GROUPING(DEPTNO),
       GROUPING(JOB),
       GROUPING_ID(DEPTNO, JOB)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;


-- GROUPING_ID �Լ��� ����� ����� �׷�ȭ ��Ʈ ����(grouping bit vector)������ ��Ÿ����
-- GROUPING_ID(A, B)
-- �׷�ȭ �� ��      �׷�ȭ ��Ʈ ����       ���� ���
--    A, B              0 0                0
--     A                0 1                1
--     B                1 0                2
--    NONE              1 1                3
-- ������ ���� ������ ���� ��µ� 0 Ȥ�� 1�� �̷���� �׷�ȭ ��Ʈ ���� ���� 2������ ���� 10������ �ٲ� ���� ���� ����� ��µ�
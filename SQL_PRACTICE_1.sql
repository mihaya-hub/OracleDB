-- TO_DATE �Լ� �⺻ ���� : TO_DATA('[���ڿ� ������(�ʼ�)]', '[�νĵ� ��¥����(�ʼ�)]')

-- 1981�� 6�� 1�� ���Ŀ� �Ի��� ��� ���� ����ϱ�

SELECT *
    FROM EMP
    WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

-- ���� ���� �������� ��¥ ������ ����ϱ�

SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49,
       TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49,
       TO_DATE('50/12/10', 'YY/MM/DD') AS RR_YEAR_50,
       TO_DATE('50/12/10', 'RR/MM/DD') AS RR_YEAR_50,
       TO_DATE('51/12/10', 'YY/MM/DD') AS RR_YEAR_51,
       TO_DATE('51/12/10', 'RR/MM/DD') AS RR_YEAR_51
FROM DUAL;

-- * �� �ڸ��� ������ ǥ���� ���� YY, RR ��뿡 ���� �ʿ�
--      YY : � �� �ڸ� ���� �ԷµǾ �� ������ ������ ������ ���
--      RR : 00~49, 50~99�� ���Ͽ� ���� ����� ��¥ �����͸� ���


-- NVL �Լ� �⺻ ���� : NVL([NULL���� ���θ� �˻��� ������ �Ǵ� ��(�ʼ�)], [���� �����Ͱ� NULL�� ��� ��ȯ�� ������(�ʼ�)])

-- NVL �Լ��� ����Ͽ� ����ϱ�

SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM,
       NVL(COMM, 0),
       SAL+NVL(COMM, 0)
FROM EMP;

-- NVL2 �Լ� �⺻ ���� : NVL2([NULL���� ���θ� �˻��� ������ �Ǵ� ��(�ʼ�)],
--                          [�� �����Ͱ� NULL�� �ƴ� ��� ��ȯ�� ������ �Ǵ� ����(�ʼ�)],
--                          [�� �����Ͱ� NULL�� ��� ��ȯ�� ������ �Ǵ� ����(�ʼ�)])

-- NVL2 �Լ��� ����Ͽ� ����ϱ�

SELECT EMPNO, ENAME, COMM,
       NVL2(COMM, 'O', 'X'),
       NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
FROM EMP;

-- DECODE �Լ� �⺻ ���� : DECODE([�˻� ����� �� �� �Ǵ� ������, �����̳� �Լ��� ���],
--                              [����1], [�����Ͱ� ����1�� ��ġ�� �� ��ȯ�� ���],
--                              [����2], [�����Ͱ� ����2�� ��ġ�� �� ��ȯ�� ���],
--                              ...
--                              [����n], [�����Ͱ� ����n�� ��ġ�� �� ��ȯ�� ���],
--                              [�� ����1~����n�� ��ġ�� ��찡 ���� �� ��ȯ�� ���])

-- DECODE �Լ��� ����Ͽ� ����ϱ�

SELECT EMPNO, ENAME, JOB, SAL,
       DECODE(JOB,
              'MANAGER', SAL*1.1,
              'SALESMAN', SAL*1.05,
              'ANALYST', SAL,
              SAL*1.03) AS UPSAL
FROM EMP;

-- CASE�� �⺻ ���� : CASE [�˻� ����� �� �� �Ǵ� ������, �����̳� �Լ��� ���(����)]
--                       WHEN [����1] THEN [����1�� ��� ���� TRUE�� ��, ��ȯ�� ���]
--                       WHEN [����2] THEN [����2�� ��� ���� TRUE�� ��, ��ȯ�� ���]
--                       ...
--                       WHEN [����n] THEN [����n�� ��� ���� TRUE�� ��, ��ȯ�� ���]
--                       ELSE [�� ����1~����n�� ��ġ�ϴ� ��찡 ���� �� ��ȯ�� ���]
--                  END

-- CASE���� ����Ͽ� ����ϱ�

SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
       WHEN 'MANAGER' THEN SAL*1.1
       WHEN 'SALESMAN' THEN SAL*1.05
       WHEN 'ANALYST' THEN SAL
       ELSE SAL*1.03
    END AS UPSAL
FROM EMP;

-- �� ���� ���� ��� ���� �޶����� CASE��

SELECT EMPNO, ENAME, COMM,
    CASE
       WHEN COMM IS NULL THEN '�ش���� ����'
       WHEN COMM = 0 THEN '���� ����'
       WHEN COMM > 0 THEN '���� : ' || COMM
    END AS COMM_TEXT
FROM EMP; 

-- ���� Ǯ�� --

-- EMP ���̺��� ��� �̸�(ENAME)�� �ټ� ���� �̻��̸� ���� ���� �̸��� ��� ������ ���
-- MASKING_EMPNO ������ ��� ��ȣ(EMPNO) �� �� �ڸ� �� ���ڸ��� * ��ȣ�� ���
-- MASKING_ENAME ������ ��� �̸�(ENAME)�� ù ���ڸ� ���� �ְ� ������ ���� ����ŭ * ��ȣ�� ���

SELECT EMPNO,
       RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS MASKING_EMPNO,
       ENAME,
       RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
FROM EMP
WHERE LENGTH(ENAME) >= 5
  AND LENGTH(ENAME) < 6;

-- EMP ���̺��� ������� �� ��� �ٹ��� ���� 21.5�� �̰� �Ϸ� �ٹ� �ð��� 8�ð��� ��, ������� �Ϸ� �޿�(DAY_PAY)�� �ñ�(TIME_PAY)�� ���
-- (��, �Ϸ� �޿��� �Ҽ��� �� ��° �ڸ����� ������, �ñ��� �� ��° �ڸ����� �ݿø�)

SELECT EMPNO, ENAME, SAL,
       TRUNC(SAL / 21.5, 2) AS DAY_PAY,
       ROUND(SAL / (21.5 * 8), 1) AS TIME_PAY
FROM EMP;

-- EMP ���̺��� ������� �Ի���(HIREDATE)�� �������� 3������ ���� �� ù ��° �����Ͽ� �������� �� ��, �������� �Ǵ� ��¥(R_JOB)�� YYYY-MM-DD �������� ���
-- (��, �߰� ����(COMM)�� ���� ����� �߰� ������ N/A�� ���)

SELECT EMPNO, ENAME, HIREDATE,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '������'), 'YYYY-MM-DD') AS R_DATE,
       NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;

-- EMP ���̺��� ���� ����� ��� ��ȣ�� ���ǿ� �°� ��ȯ�Ͽ� CHG_MGR���� ���
-- ���� --
-- ���� ����� ��� ��ȣ�� �������� ���� ��� : 0000
-- ���� ����� ��� ��ȣ �� �� �ڸ��� 75�� ��� : 5555
-- ���� ����� ��� ��ȣ �� �� �ڸ��� 76�� ��� : 6666
-- ���� ����� ��� ��ȣ �� �� �ڸ��� 77�� ��� : 7777
-- ���� ����� ��� ��ȣ �� �� �ڸ��� 78�� ��� : 8888
-- �� �� ���� ��� ��� ��ȣ�� ��� : ���� ���� ����� ��� ��ȣ �״�� ���\

SELECT EMPNO, ENAME, MGR,
       CASE
           WHEN MGR IS NULL THEN '0000'
           WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '75' THEN '5555'
           WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '76' THEN '6666'
           WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '77' THEN '7777'
           WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '78' THEN '8888'
           ELSE TO_CHAR(MGR)
       END AS CHG_MGR
FROM EMP;
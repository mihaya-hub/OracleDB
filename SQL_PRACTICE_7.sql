-- ������ ���۾� DML (DATA MANIPULATION LANGUAGE) : �����͸� �߰�, ����, ������ �� ����ϴ� ��ɾ�

-- �ǽ��� �ʿ��� ���̺� �����Ͽ� �����ϱ�

CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

-- INSERT�� �⺻ ���� : INSERT INTO ���̺� �̸� (��1, ��2, ..., ��N)
--                    VALUES (��1�� �� ������, ��2�� �� ������, ..., ��N�� �� ������)
-- ���̺� �����͸� �߰��ϴ� �� ���

-- DEPT_TEMP ���̺� ������ �߰��ϱ�
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
               VALUES (50, 'DATABASE', 'SEOUL');
SELECT * FROM DEPT_TEMP;
-- INSERT������ ������ �� ������ �� ���� �Է��� ������ ������ ��ġ���� �ʰų� �ڷ����� ���� �ʴ� ��� �Ǵ� �� ���̸� �ʰ��ϴ� �����͸� �����ϴ� ��쿡�� ������ �߻��Ͽ� ������� ����

-- INSERT���� �� ���� ���� ������ �߰��ϱ�
INSERT INTO DEPT_TEMP
     VALUES (60, 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
-- INSERT���� �����ϴ� ���� ������ �� ������, �ش� ���̺� �����Ǿ� �ִ� �� ����, �� ����, �ڷ��� �� ���� ��� ���� �־�� ��

-- ���̺� NULL ������ �Է��ϱ�

-- NULL�� ����� �Է� : �����Ϳ� NULL�� �Է��Ͽ� ��������� ����

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
               VALUES (70    , 'WEB', NULL);
SELECT * FROM DEPT_TEMP;

-- NULL�� �Ͻ��� �Է� : INSERT���� NULL�� ���� �� �� �̸��� �ƿ� �Է����� �ʴ� ��

INSERT INTO DEPT_TEMP (DEPTNO, LOC)
               VALUES (90    , 'INCHEON');
SELECT * FROM DEPT_TEMP;

-- �ǽ��� �ʿ��� ���̺��� �� ������ �����Ͽ� �����ϱ�

CREATE TABLE EMP_TEMP AS SELECT * FROM EMP WHERE 1 <> 1;
-- WHERE���� ������ 1 <> 1 �̱� ������ �� ���� ���ǽĿ� ������ ��� �׻� FALSE�� �Ǿ� ���� ��������� �ʴ´�

-- INSERT������ ��¥ ������ �Է��ϱ� (��¥ ���̿� / �Է�)

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (9999, 'ȫ�浿', 'PRESIDENT', NULL, '2020/05/14', 5000, 1000, 10);
SELECT * FROM EMP_TEMP;

-- INSERT������ ��¥ ������ �Է��ϱ� (��¥ ���̿� - �Է�)

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (1111, '������', 'MANAGER', 9999, '2020-05-14', 4000, NULL, 20);
SELECT * FROM EMP_TEMP;

-- TO_DATE �Լ��� ����Ͽ� ��¥ ������ �Է��ϱ�

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (2111, '�̼���', 'MANAGER', 9999,
                      TO_DATE('05/15/2020', 'MM/DD/YYYY'), 4000, NULL, 20);
SELECT * FROM EMP_TEMP;

-- SYSDATE�� ����Ͽ� ��¥ ������ �Է��ϱ�

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (3111, '��û��', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);
SELECT * FROM EMP_TEMP;

-- ���� ������ ���� ������ �߰��ϱ� (EMP ���̺�� SALGRADE ���̺��� ħ���Ͽ� �޿� ����� 1�� ����� �߰�)

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
        FROM EMP E, SALGRADE S
        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
          AND S.GRADE = 1;
SELECT * FROM EMP_TEMP;

-- �ǽ��� �ʿ��� ���̺� �����Ͽ� �����ϱ�

CREATE TABLE DEPT_TEMP2 AS SELECT * FROM DEPT;

-- UPDATE�� �⺻ ���� : UPDATE [������ ���̺�]
--                    SET    [������ ��1] = [������], [������ ��2] = [������], ..., [������ ��N] = [������]
--                    WHERE  [�����͸� ������ ��� ���� �����ϱ� ���� ����]
-- ���̺� �ִ� ������ ������ ������ �� ���

-- ������ ��ü �����ϱ�

UPDATE DEPT_TEMP2
   SET LOC = 'SEOUL';
SELECT * FROM DEPT_TEMP2;
-- DEPT_TEMP2 ���̺��� LOC ���� �����͸� ��� SEOUL�� ����
-- �ϰ������� �����ϴ� ���� ��ġ ����

-- ������ ������ �ǵ�����

ROLLBACK;
SELECT * FROM DEPT_TEMP2;
-- TCL (TRANSACTION CONTROL LANGUAGE) ��ɾ� �� �ϳ�
-- ������ ���� ���Ŀ� ����� DML ��ɾ ����ϴ� ��ɾ�

-- ������ �Ϻκи� �����ϱ�

UPDATE DEPT_TEMP2
   SET DNAME    = 'DATABASE',
       LOC      = 'SEOUL'
 WHERE DEPTNO   = 40;
SELECT * FROM DEPT_TEMP2;
-- WHERE ���ǽĿ� ����� �μ� ��ȣ�� 40���� ���� �����͸� �����

-- ���������� ������ �Ϻκ� �����ϱ�

UPDATE DEPT_TEMP2
   SET (DNAME, LOC) = (SELECT DNAME, LOC
                         FROM DEPT
                        WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
SELECT * FROM DEPT_TEMP2;

-- UPDATE�� ����� �� ������ : ���輺�� ū ��ɾ��̹Ƿ� WHERE���� ������ �ʼ�
--                          WHERE���� SELECT���� �־� �����ϱ� �� �̸� Ȯ���غ��� ������ �ʿ�

-- �ǽ��� �ʿ��� ���̺� �����Ͽ� �����ϱ�

CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;

-- DELETE�� �⺻ ���� : DELETE FROM [���̺� �̸�]
--                    WHERE [������ ��� ���� �����ϱ� ���� ���ǽ�]
-- ���̺� �ִµ����͸� ������ �� ���

-- ������ �Ϻκи� �����ϱ�

DELETE FROM EMP_TEMP2
 WHERE JOB = 'MANAGER';
SELECT * FROM EMP_TEMP2;
-- WHERE ���ǽĿ� ����� ��� JOB�� �����Ͱ� MANAGER�� ������ �ุ ����

-- ���� ������ ����Ͽ� ������ �����ϱ�
-- �޿� ����� 3����� 30�� �μ��� ����鸸 ����

DELETE FROM EMP_TEMP2
 WHERE EMPNO IN (SELECT E.EMPNO
                   FROM EMP_TEMP2 E, SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                    AND S.GRADE = 3
                    AND E.DEPTNO = 30);
SELECT * FROM EMP_TEMP2;

-- ������ ��ü �����ϱ�

DELETE FROM EMP_TEMP2;
SELECT * FROM EMP_TEMP2;
-- WHERE�� ���ǽ��� �����Ƿ� ��� �����͸� Ư�� ���� �ʱ� ������ ���̺��� ��� �����Ͱ� ����
-- Ư���� ��츦 �����ϸ� ��� �����͸� ����� ���� ��ġ ����
-- UPDATE���� ���������� ������ ��ɾ��̹Ƿ� WHERE���� ���ǽ� ������ �ʼ�

-- ������ �����ϱ� ���� ���̺���� �����Ͽ� �����ϱ�

CREATE TABLE CHAP10_EMP AS SELECT * FROM EMP;
CREATE TABLE CHAP10_DEPT AS SELECT * FROM DEPT;
CREATE TABLE CHAP10_SALGRADE AS SELECT * FROM SALGRADE;

-- ����� ���� CHAP10_DEPT ���̺� 50, 60, 70, 80�� �μ��� ����ϴ� SQL�� �ۼ�

INSERT INTO CHAP10_DEPT (DEPTNO, DNAME, LOC)
                 VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO CHAP10_DEPT (DEPTNO, DNAME, LOC)
                 VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10_DEPT (DEPTNO, DNAME, LOC)
                 VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10_DEPT (DEPTNO, DNAME, LOC)
                 VALUES (80, 'DML', 'BUNDANG');
                 
-- ����� ���� CHAP10_EMP ���̺� 8���� ��� ������ ����ϴ� SQL�� �ۼ�
INSERT INTO CHAP10_EMP
     VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, TO_DATE('2016-01-02', 'YYYY-MM-DD'), 4500, NULL, 50);
INSERT INTO CHAP10_EMP
     VALUES(7202, 'TEST_USER2', 'CLERK', 7201, TO_DATE('2016-02-21', 'YYYY-MM-DD'), 1800, NULL, 50);
INSERT INTO CHAP10_EMP
     VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, TO_DATE('2016-04-11', 'YYYY-MM-DD'), 3400, NULL, 60);
INSERT INTO CHAP10_EMP
     VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, TO_DATE('2016-05-31', 'YYYY-MM-DD'), 2700, 300, 60);
INSERT INTO CHAP10_EMP
     VALUES(7205, 'TEST_USER5', 'CLERK', 7201, TO_DATE('2016-07-20', 'YYYY-MM-DD'), 2600, NULL, 70);
INSERT INTO CHAP10_EMP
     VALUES(7206, 'TEST_USER6', 'CLERK', 7201, TO_DATE('2016-09-08', 'YYYY-MM-DD'), 2600, NULL, 70);
INSERT INTO CHAP10_EMP
     VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, TO_DATE('2016-10-28', 'YYYY-MM-DD'), 2300, NULL, 80);
INSERT INTO CHAP10_EMP
     VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, TO_DATE('2018-03-09', 'YYYY-MM-DD'), 1200, NULL, 80);
     
-- CHAP10_EMP ���̺� ���� ��� �� 50�� �μ����� �ٹ��ϴ� ������� ��� �޿����� ���� �޿��� �ް� �ִ� ������� 70�� �μ��� �ű�� SQL�� �ۼ�

UPDATE CHAP10_EMP
   SET DEPTNO = 70
 WHERE SAL > (SELECT AVG(SAL)
                FROM CHAP10_EMP
               WHERE DEPTNO = 50);
 
-- CHAP10_EMP ���̺� ���� ��� ��, 60�� �μ��� ��� �߿� �Ի����� ���� ���� ������� �ʰ� �Ի��� ����� �޿��� 10% �λ��ϰ� 80�� �μ��� �ű�� SQL�� �ۼ�

UPDATE CHAP10_EMP
   SET SAL = SAL * 1.1,
       DEPTNO = 80
 WHERE HIREDATE > (SELECT MIN(HIREDATE)
                     FROM CHAP10_EMP
                    WHERE DEPTNO = 60);
                    
-- CHAP10_EMP ���̺� ���� ��� ��, �޿� ����� 5�� ����� �����ϴ� SQL�� �ۼ�

DELETE FROM CHAP10_EMP
 WHERE EMPNO IN (SELECT E.EMPNO
                   FROM CHAP10_EMP E, CHAP10_SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                    AND S.GRADE = 5);
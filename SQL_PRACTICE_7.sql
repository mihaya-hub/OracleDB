-- 데이터 조작어 DML (DATA MANIPULATION LANGUAGE) : 데이터를 추가, 변경, 삭제할 때 사용하는 명령어

-- 실습에 필요한 테이블 복사하여 생성하기

CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

-- INSERT문 기본 형식 : INSERT INTO 테이블 이름 (열1, 열2, ..., 열N)
--                    VALUES (열1에 들어갈 데이터, 열2에 들어갈 데이터, ..., 열N에 들어갈 데이터)
-- 테이블에 데이터를 추가하는 데 사용

-- DEPT_TEMP 테이블에 데이터 추가하기
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
               VALUES (50, 'DATABASE', 'SEOUL');
SELECT * FROM DEPT_TEMP;
-- INSERT문에서 지정한 열 개수와 각 열에 입력할 데이터 개수가 일치하지 않거나 자료형이 맞지 않는 경우 또는 열 길이를 초과하는 데이터를 지정하는 경우에는 오류가 발생하여 실행되지 않음

-- INSERT문에 열 지정 없이 데이터 추가하기
INSERT INTO DEPT_TEMP
     VALUES (60, 'NETWORK', 'BUSAN');
SELECT * FROM DEPT_TEMP;
-- INSERT문에 지정하는 열은 생략할 수 있으나, 해당 테이블에 설정되어 있는 열 순서, 열 개수, 자료형 및 길이 모두 맞춰 주어야 함

-- 테이블에 NULL 데이터 입력하기

-- NULL의 명시적 입력 : 데이터에 NULL을 입력하여 명시적으로 지정

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
               VALUES (70    , 'WEB', NULL);
SELECT * FROM DEPT_TEMP;

-- NULL의 암시적 입력 : INSERT문에 NULL이 들어가야 할 열 이름을 아예 입력하지 않는 것

INSERT INTO DEPT_TEMP (DEPTNO, LOC)
               VALUES (90    , 'INCHEON');
SELECT * FROM DEPT_TEMP;

-- 실습에 필요한 테이블을 열 구조만 복사하여 생성하기

CREATE TABLE EMP_TEMP AS SELECT * FROM EMP WHERE 1 <> 1;
-- WHERE절의 조건이 1 <> 1 이기 때문에 각 행을 조건식에 대입한 결과 항상 FALSE가 되어 행은 만들어지지 않는다

-- INSERT문으로 날짜 데이터 입력하기 (날짜 사이에 / 입력)

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (9999, '홍길동', 'PRESIDENT', NULL, '2020/05/14', 5000, 1000, 10);
SELECT * FROM EMP_TEMP;

-- INSERT문으로 날짜 데이터 입력하기 (날짜 사이에 - 입력)

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (1111, '성춘향', 'MANAGER', 9999, '2020-05-14', 4000, NULL, 20);
SELECT * FROM EMP_TEMP;

-- TO_DATE 함수를 사용하여 날짜 데이터 입력하기

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (2111, '이순신', 'MANAGER', 9999,
                      TO_DATE('05/15/2020', 'MM/DD/YYYY'), 4000, NULL, 20);
SELECT * FROM EMP_TEMP;

-- SYSDATE를 사용하여 날짜 데이터 입력하기

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
              VALUES (3111, '심청이', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);
SELECT * FROM EMP_TEMP;

-- 서브 쿼리로 여러 데이터 추가하기 (EMP 테이블과 SALGRADE 테이블을 침조하여 급여 등급이 1인 사원만 추가)

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
        FROM EMP E, SALGRADE S
        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
          AND S.GRADE = 1;
SELECT * FROM EMP_TEMP;

-- 실습에 필요한 테이블 복사하여 생성하기

CREATE TABLE DEPT_TEMP2 AS SELECT * FROM DEPT;

-- UPDATE문 기본 형식 : UPDATE [변경할 테이블]
--                    SET    [변경할 열1] = [데이터], [변경할 열2] = [데이터], ..., [변경할 열N] = [데이터]
--                    WHERE  [데이터를 변경할 대상 행을 선별하기 위한 조건]
-- 테이블에 있는 데이터 내용을 수정할 때 사용

-- 데이터 전체 수정하기

UPDATE DEPT_TEMP2
   SET LOC = 'SEOUL';
SELECT * FROM DEPT_TEMP2;
-- DEPT_TEMP2 테이블의 LOC 열의 데이터를 모두 SEOUL로 변경
-- 일괄적으로 변경하는 경우는 흔치 않음

-- 수정한 내용을 되돌리기

ROLLBACK;
SELECT * FROM DEPT_TEMP2;
-- TCL (TRANSACTION CONTROL LANGUAGE) 명령어 중 하나
-- 정해진 시점 이후에 실행된 DML 명령어를 취소하는 명령어

-- 데이터 일부분만 수정하기

UPDATE DEPT_TEMP2
   SET DNAME    = 'DATABASE',
       LOC      = 'SEOUL'
 WHERE DEPTNO   = 40;
SELECT * FROM DEPT_TEMP2;
-- WHERE 조건식에 명시한 부서 번호가 40번인 행의 데이터만 변경됨

-- 서브쿼리로 데이터 일부분 수정하기

UPDATE DEPT_TEMP2
   SET (DNAME, LOC) = (SELECT DNAME, LOC
                         FROM DEPT
                        WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;
SELECT * FROM DEPT_TEMP2;

-- UPDATE문 사용할 때 유의점 : 위험성이 큰 명령어이므로 WHERE절의 검증이 필수
--                          WHERE절을 SELECT문에 넣어 실행하기 전 미리 확인해보는 습관이 필요

-- 실습에 필요한 테이블 복사하여 생성하기

CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;

-- DELETE문 기본 형식 : DELETE FROM [테이블 이름]
--                    WHERE [삭제할 대상 행을 선별하기 위한 조건식]
-- 테이블에 있는데이터를 삭제할 때 사용

-- 데이터 일부분만 삭제하기

DELETE FROM EMP_TEMP2
 WHERE JOB = 'MANAGER';
SELECT * FROM EMP_TEMP2;
-- WHERE 조건식에 명시한 대로 JOB열 데이터가 MANAGER인 데이터 행만 삭제

-- 서브 쿼리를 사용하여 데이터 삭제하기
-- 급여 등급이 3등급인 30번 부서의 사원들만 삭제

DELETE FROM EMP_TEMP2
 WHERE EMPNO IN (SELECT E.EMPNO
                   FROM EMP_TEMP2 E, SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                    AND S.GRADE = 3
                    AND E.DEPTNO = 30);
SELECT * FROM EMP_TEMP2;

-- 데이터 전체 삭제하기

DELETE FROM EMP_TEMP2;
SELECT * FROM EMP_TEMP2;
-- WHERE절 조건식이 없으므로 대상 데이터를 특정 짓지 않기 때문에 테이블의 모든 데이터가 삭제
-- 특별한 경우를 제외하면 모든 데이터를 지우는 경우는 흔치 않음
-- UPDATE문과 마찬가지로 위험한 명령어이므로 WHERE절의 조건식 검증이 필수

-- 문제를 진행하기 위한 테이블들을 복사하여 생성하기

CREATE TABLE CHAP10_EMP AS SELECT * FROM EMP;
CREATE TABLE CHAP10_DEPT AS SELECT * FROM DEPT;
CREATE TABLE CHAP10_SALGRADE AS SELECT * FROM SALGRADE;

-- 교재와 같이 CHAP10_DEPT 테이블에 50, 60, 70, 80번 부서를 등록하는 SQL문 작성

INSERT INTO CHAP10_DEPT (DEPTNO, DNAME, LOC)
                 VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO CHAP10_DEPT (DEPTNO, DNAME, LOC)
                 VALUES (60, 'SQL', 'ILSAN');
INSERT INTO CHAP10_DEPT (DEPTNO, DNAME, LOC)
                 VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO CHAP10_DEPT (DEPTNO, DNAME, LOC)
                 VALUES (80, 'DML', 'BUNDANG');
                 
-- 교재와 같이 CHAP10_EMP 테이블에 8명의 사원 정보를 등록하는 SQL문 작성
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
     
-- CHAP10_EMP 테이블에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL문 작성

UPDATE CHAP10_EMP
   SET DEPTNO = 70
 WHERE SAL > (SELECT AVG(SAL)
                FROM CHAP10_EMP
               WHERE DEPTNO = 50);
 
-- CHAP10_EMP 테이블에 속한 사원 중, 60번 부서의 사원 중에 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL문 작성

UPDATE CHAP10_EMP
   SET SAL = SAL * 1.1,
       DEPTNO = 80
 WHERE HIREDATE > (SELECT MIN(HIREDATE)
                     FROM CHAP10_EMP
                    WHERE DEPTNO = 60);
                    
-- CHAP10_EMP 테이블에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문 작성

DELETE FROM CHAP10_EMP
 WHERE EMPNO IN (SELECT E.EMPNO
                   FROM CHAP10_EMP E, CHAP10_SALGRADE S
                  WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                    AND S.GRADE = 5);
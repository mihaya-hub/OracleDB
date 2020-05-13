-- JOIN : 두 개 이상의 테이블을 연결하여 하나의 테이블처럼 출력

-- FROM절에 여러 테이블 선언하기

SELECT *
FROM EMP, DEPT
ORDER BY EMPNO;

-- 등가 조인 : 테이블을 연결한 후에 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정하는 방식

-- 열 이름을 비교하는 조건식으로 조인하기

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;

-- 테이블 이름을 별칭으로 표현하기

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

-- 보통 SELECT 절을 사용할 때 모든 열을 출력하더라도 *를 사용하지 않고 출력할 열을 하나하나 직접 명시해준다
-- 특정 열이 새로 생기거나 삭제되거나 또는 어떤 이유로 수정되었을 경우 그 변화의 감지 및 변화에 따른 프로그램 수정이 쉽지 않을 수 있기 때문

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

-- 비등가 조인 : 등가 조인 방식 외의 방식

-- 급여 범위를 지정하는 조건식으로 조인하기

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 자체 조인 : 하나의 테이블을 여러 개의 테이블처럼 활용하여 조인하는 방식

-- 같은 테이블을 두 번 사용하여 자체 조인하기

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO
ORDER BY EMPNO;

-- 외부 조인 : 조인 기준 열의 NULL을 처리하는 것을 목적으로 사용하는 조인 방식

-- 위에서 확인한 자체 조인의 결과 상급자가 없는 최고 직급자는 결과에서 제외됨
-- 어느 한쪽이 NULL이더라도 출력하도록 외부 조인 사용

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+)
ORDER BY EMPNO;

-- 왼쪽 외부 조인 ( (+)가 오른쪽에 붙음 ) : 왼쪽 열을 기준으로 오른쪽 열 데이터의 존재 여부와 상관없이 출력
-- 오른쪽 외부 조인 ( (+)가 왼쪽에 붙음 ) : 오른쪽 열을 기준으로 왼쪽 열 데이터의 존재 여부와 상관없이 출력

-- SQL-99 표준 문법에서의 조인

-- NATURAL JOIN : 등가 조인을 대신해 사용할 수 있는 조인 방식, 조인 대상이 되는 두 테이블에 이름과 자료형이 같은 열을 찾은 후 그 열을 기준으로 등가 조인을 해주는 방식

-- NATURAL JOIN을 사용하여 조인하기

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
       DEPTNO, D.DNAME, D.LOC
FROM EMP E NATURAL JOIN DEPT D
ORDER BY DEPTNO, E.EMPNO;
-- 조인 조건이 WHERE절에 있는 기존 조인 방식과 달리 SQL-99 방식 조인은 FROM절에 조인 키워드를 사용하는 형태로 작성
-- 공통 열 DEPTNO을 기준으로 자동으로 등가 조인이 되므로 기준 열인 DEPTNO를 명시할 때 테이블 이름을 붙히면 안됨

-- JOIN ~ USING : 등가 조인을 대신해 사용할 수 있는 조인 방식, NATURAL JOIN이 자동으로 기준 열을 지정하는 것과 달리 USING 키워드에 조인 기준으로 사용할 열을 명시하여 사용

-- JOIN ~ USING을 사용하여 조인하기

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
       DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D USING (DEPTNO)
WHERE SAL >= 3000
ORDER BY DEPTNO, E.EMPNO;

-- JOIN ~ ON : 가장 범용성있는 조인 방식, 기존 WHERE절에 있는 조인 조건식을 ON 키워드 옆에 작성하고 그 밖의 출력 행을 걸러 내기 위한 WHERE 조건식을 따로 사용하는 방식

-- JOIN ~ ON으로 등가 조인하기

SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
       E.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE SAL <= 3000
ORDER BY E.DEPTNO, EMPNO;

-- OUTER JOIN : 외부 조인에 사용, 다른 SQL-99 방식의 조인과 마찬가지로 WHERE절이 아닌 FROM절에서 외부 조인을 선언
-- 왼쪽 외부 조인 -     기존  : WHERE TABLE1.COL1 = TABLE2.COL1(+)
--                  SQL-99 : FROM TABLE1 LEFT OUTER JOIN TABLE2 ON (조인 조건식)
-- 오른쪽 외부 조인 -   기존  : WHERE TABLE1.COL1(+) = TABLE2.COL1
--                  SQL-99 : FROM TABLE1 RIGHT OUTER JOIN TABLE2 ON (조인 조건식)
-- 전체 외부 조인 -     기존  : 기본 문법은 없음 (UNION 집합 연산자를 활용)
--                  SQL-99 : FROM TABLE1 FULL OUTER JOIN TABLE2 ON (조인 조건식)

-- 왼쪽 외부 조인을 SQL-99로 작성하기

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
FROM EMP E1 LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;

-- 세 개 이상의 테이블을 조인할 때 : FROM TABLE1 JOIN TABLE2 ON (조건식) JOIN TABLE3 ON (조건식)

-- 급여(SAL)가 2000초과인 사원들의 부서 정보, 사원 정보를 출력
-- 단, SQL-99 이전 방식과 SQL-99 방식을 각각 사용

-- SQL-99 이전 방식

SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND E.SAL > 2000
ORDER BY DEPTNO, EMPNO;

-- SQL-99 방식

SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.SAL
FROM DEPT D JOIN EMP E ON (D.DEPTNO = E.DEPTNO)
WHERE E.SAL > 2000
ORDER BY D.DEPTNO, E.EMPNO;

-- 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원수를 출력
-- 단, SQL-99 이전 방식과 SQL-99 방식을 각각 사용

-- SQL-99 이전 방식

SELECT D.DEPTNO, D.DNAME,
       TRUNC(AVG(E.SAL)) AS AVG_SAL,
       MAX(E.SAL) AS MAX_SAL,
       MIN(E.SAL) AS MIN_SAL,
       COUNT(*) AS CNT
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO, D.DNAME
ORDER BY D.DEPTNO;

-- SQL-99 방식

SELECT D.DEPTNO, D.DNAME,
       TRUNC(AVG(E.SAL)) AS AVG_SAL,
       MAX(E.SAL) AS MAX_SAL,
       MIN(E.SAL) AS MIN_SAL,
       COUNT(*) AS CNT
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
GROUP BY D.DEPTNO, D.DNAME
ORDER BY D.DEPTNO;

-- 모든 부서 정보와 사원 정보를 부서 번호, 사원 이름순으로 정렬하여 출력
-- 단, SQL-99 이전 방식과 SQL-99 방식을 각각 사용

-- SQL-99 이전 방식

SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE D.DEPTNO = E.DEPTNO(+)
ORDER BY D.DEPTNO, E.ENAME;

-- SQL-99 방식

SELECT D.DEPTNO, D.DNAME,
       E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM DEPT D LEFT OUTER JOIN EMP E ON (D.DEPTNO = E.DEPTNO)
ORDER BY D.DEPTNO, E.ENAME;

-- 모든 부서 정보, 사원 정보, 급여 등급 정보, 각 사원의 직속 상관의 정보를 부서 번호, 사원 번호 순서로 정렬하여 출력
-- 단, SQL-99 이전 방식과 SQL-99 방식을 각각 사용

-- SQL-99 이전 방식

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

-- SQL-99 방식

SELECT D.DEPTNO, D.DNAME,
       E1.EMPNO, E1.ENAME, E1.MGR, E1.SAL,
       S.LOSAL, S.HISAL, S.GRADE,
       E2.EMPNO AS MGR_EMPNO,
       E2.ENAME AS MGR_ENAME
FROM DEPT D LEFT OUTER JOIN EMP E1 ON (D.DEPTNO = E1.DEPTNO)
     LEFT OUTER JOIN SALGRADE S ON (E1.SAL BETWEEN S.LOSAL AND S.HISAL)
     LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO)
ORDER BY D.DEPTNO, E1.EMPNO;
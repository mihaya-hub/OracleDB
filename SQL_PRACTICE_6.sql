-- 서브 쿼리 : SQL문을 실행하는 데 필요한 데이터를 추가로 조회하기 위해 SQL문 내부에서 사용하는 SELECT문
--           서브 쿼리의 결과 값을 사용하여 기능을 수행하는 영억은 메인 쿼리라고 부른다

-- 서브 쿼리로 JONES의 급여보다 높은 급여를 받는 사원 정보 출력하기

SELECT *
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE ENAME = 'JONES');
             
-- 서브 쿼리의 특징
-- 1. 서브 쿼리는 연산자와 같은 비교 또는 조회 대상의 오른쪽에 놓이며 괄호 ()로 묶어서 사용
-- 2. 특수한 몇몇 경우를 제외한 대부분의 서브 쿼리에서는 ORDER BY절을 사용할 수 없음
-- 3. 서브 쿼리의 SELECT절에 명시한 열은 메인 쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정해야함
-- 4. 서브 쿼리에 있는 SELECT문의 결과 행 수는 함께 사용하는 메인 쿼리의 연산자 종류와 호환 가능해야 함

-- 단일행 서브 쿼리 : 실행 결과가 단 하나의 행으로 나오는 서브 쿼리
--                 단일행 연산자(> >= = <= < <> ^= !=)를 사용하여 비교
--                 서브 쿼리에서 사용한 함수의 결과 값이 하나일 때 단일행 서브 쿼리로서 사용 가능

-- 서브 쿼리 안에 함수를 사용한 경우

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE E.DEPTNO = 20
  AND E.SAL > (SELECT AVG(SAL) FROM EMP);
  
-- 다중행 서브 쿼리 : 실행 결과 행이 여러 개로 나오는 서브 쿼리
--                 다중행 연산자(IN ANY,SOME ALL EXISTS)를 사용하여 비교

-- IN 연산자 : 메인 쿼리의 데이터가 서브 쿼리의 결과 중 하나라도 일치한 데이터가 있다면 TRUE

-- 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력하기

SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
              FROM EMP
              GROUP BY DEPTNO);
              
-- ANY, SOME 연산자 : 메인 쿼리의 조건식을 만족하는 서브 쿼리의 결과가 하나 이상이면 TRUE

-- ANY 연산자 사용하기

SELECT *
FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL)
                 FROM EMP
                 GROUP BY DEPTNO);
                 
-- SOME 연산자 사용하기

SELECT *
FROM EMP
WHERE SAL = SOME (SELECT MAX(SAL)
                  FROM EMP
                  GROUP BY DEPTNO);
-- 등가 비교 연산자(=)를 사용할 때는 IN 연산자를 사용하는 것과 완전히 같은 결과를 내기 때문에 대부분 IN 연산자를 사용

-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력하기

SELECT *
FROM EMP
WHERE SAL < ANY (SELECT SAL
                 FROM EMP
                 WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO;
-- ANY, SOME 연산자는 서브 쿼리 결과 값 중 최소한 하나라도 만족하면 메인 쿼리 조건식의 결과가 TRUE가 되므로
-- 이 경우 서브 쿼리 결과 중 가장 큰 값보다 적은 급여를 가진 메인 쿼리 행은 모두 TRUE가 된다
-- 따라서, 최대 급여보다 적은 급여를 받는 사원 정보가 출력된다

-- ALL 연산자 : 메인 쿼리의 조건식을 서브 쿼리의 결과 모두가 만족하면 TRUE

-- 30번 부서 사원들의 최소 급여보다 적은 급여를 받는 사원 정보 출력하기

SELECT *
FROM EMP
WHERE SAL < ALL (SELECT SAL
                 FROM EMP
                 WHERE DEPTNO = 30);
                 
-- 30번 부서 사원들의 최대 급여보다 많은 급여를 받는 사원 정보 출력하기

SELECT *
FROM EMP
WHERE SAL > ALL (SELECT SAL
                 FROM EMP
                 WHERE DEPTNO = 30);
-- ALL 연산자는 서브 쿼리 결과 값들과 모두 조건이 만족하는 메인 쿼리 결과 행만 TRUE가 되므로
-- 이 경우 서브 쿼리 결과 중 가장 큰 값보다 많은 급여를 가진 메인 쿼리 행이 TRUE가 된다
-- 따라서, 최대 급여보다 많은 급여를 받는 사원 정보가 출력된다

-- EXISTS 연산자 : 서브 쿼리의 결과가 존재하면(즉, 행이 1개 이상) TRUE

-- 서브 쿼리 결과 값이 존재하는 경우

SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME
              FROM DEPT
              WHERE DEPTNO = 10);
-- 서브 쿼리의 결과 값이 존재하기 때문에 EMP의 모든 행이 출력

-- 서브 쿼리 결과 값이 존재하지 않는 경우

SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME
              FROM DEPT
              WHERE DEPTNO = 50);
-- 서브 쿼리의 결과 값이 존재하지 않기 때문에 아무 행도 출력되지 않음

-- 다중열 서브 쿼리 : 서브 쿼리의 SELECT절에 비교할 데이터를 여러 개 지정하는 방식
--                 메인 쿼리에 비교할 열을 괄호로 묶어 명시하고 서브 쿼리에서는 괄호로 묶은 데이터와 같은 자료형 데이터를 SELECT절에 명시하여 사용

-- 다중열 서브 쿼리 사용하기

SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                        FROM EMP
                        GROUP BY DEPTNO);

-- 인라인 뷰 : FROM절에 사용하는 서브 쿼리
--           특정 테이블 전체가 아닌 SELECT문을 통해 일부 데이터를 추출해 온 후 별칭을 주어 사용할 수 있다

-- 인라인 뷰 사용하기

SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
     (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

-- WITH절 기본 형식 : WITH
--                  [별칭1] AS (SELECT문1),
--                  [별칭2] AS (SELECT문2),
--                  ...
--                  [별칭N] AS (SELECT문N)
--                  SELECT ...
--                  FROM [별칭1], [별칭2], ..., [별칭N] ...
-- 인라인 뷰로 FROM절에 너무 많은 서브 쿼리를 지정하면 가독성이나 성능 저하 우려가 있어서 사용

-- WITH절 사용하기

WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D   AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO;

-- 스칼라 서브 쿼리 : SELECT절에 사용하는 서브 쿼리
--                 단 하나의 결과만 반환하도록 작성하여야 함

-- 스칼라 서브 쿼리 사용하기

SELECT EMPNO, ENAME, JOB, SAL,
       (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
       DEPTNO,
       (SELECT DNAME FROM DEPT WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
FROM EMP E;

-- 전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 사원 정보, 부서 정보를 출력

SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND E.JOB = (SELECT JOB
                FROM EMP
                WHERE ENAME = 'ALLEN');
                
-- 전체 사원의 평균 급여(SAL)보다 높은 급여를 받는 사원들의 사원 정보, 부서 정보, 급여 등급 정보를 출력
-- 단, 급여가 많은 순으로 출력하되 급여가 같을 경우 사원 번호를 기준으로 오름차순 정렬

SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
  AND E.SAL BETWEEN S.LOSAL AND S.HISAL
  AND E.SAL > (SELECT AVG(SAL)
               FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;

-- 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원 정보, 부서 정보를 출력

SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND E.DEPTNO = 10
  AND E.JOB NOT IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 30);
  
-- 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보, 급여 등급 정보를 출력
-- 단, 서브 쿼리를 활용할 때 다중행 서브 쿼리를 사용하는 방법과 사용하지 않는 방법을 통해 사원 번호를 기준으로 오름차순으로 정렬

-- 다중행 서브 쿼리를 사용하지 않는 방법

SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
  AND E.SAL > (SELECT MAX(SAL)
               FROM EMP
               WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

-- 다중행 서브 쿼리를 사용하는 방법

SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
  AND E.SAL > ALL (SELECT DISTINCT SAL
                   FROM EMP
                   WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;
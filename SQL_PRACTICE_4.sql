-- LISTAGG 함수 : 오라클 11g 버전부터 사용 가능, 그룹에 속해 있는 데이터를 가로로 나열할 때 사용
-- LISTAGG 함수 기본 형식 : SELECT [조회할 열1 이름], [조회할 열2 이름], ..., [조회할 열N 이름]
--                               LISTAGG([나열할 열(필수)], [각 데이터를 구분하는 구분자(선택)])
--                               WITHIN GROUP(ORDER BY 나열할 열의 정렬 기준 열 (선택))
--                        FROM   [조회할 테이블 이름]
--                        WHERE  [조회할 행을 선별하는 조건식]

-- GROUP BY절로 그룹화하여 부서 번호와 부서 번호와 사원 이름 출력하기

SELECT DEPTNO, ENAME
FROM EMP
GROUP BY DEPTNO, ENAME;

-- 부서별 사원 이름을 나란히 나열하여 출력하기

SELECT DEPTNO,
       LISTAGG(ENAME, ', ')
       WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
FROM EMP
GROUP BY DEPTNO;

-- PIVOT, UNPIVOT 함수 : 오라클 11g 버전부터 사용 가능, PIVOT 함수는 기존 테이블 행을 열로 바꾸고 UNPIVOT 함수는 기존 테이블 열을 행으로 바꿔서 출력

-- 부서별, 직책별로 그룹화하여 최고 급여 데이터 출력하기

SELECT DEPTNO, JOB, MAX(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- PIVOT 함수를 사용하여 직책별, 부서별 최고 급여를 2차원 표 형태로 출력하기

SELECT *
FROM(SELECT DEPTNO, JOB, SAL FROM EMP)
PIVOT(MAX(SAL) FOR DEPTNO IN (10, 20, 30))
ORDER BY JOB;

-- PIVOT 함수를 사용하여 부서별, 직책별 최고 급여를 2차원 표 형태로 출력하기

SELECT *
FROM(SELECT DEPTNO, JOB, SAL FROM EMP)
PIVOT(MAX(SAL) FOR JOB IN ('CLERK' AS CLERK,
                           'SALESMAN' AS SALESMAN,
                           'PRESIDENT' AS PRESIDENT,
                           'MANAGER' AS MANAGER,
                           'ANALYST' AS ANALYST))
ORDER BY DEPTNO;

-- DECODE문을 활용하여 PIVOT 함수와 같은 출력 구현하기 (오라클 11g 이전 버전)

SELECT DEPTNO,
       MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK",
       MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN",
       MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT",
       MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER",
       MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- UNPIVOT 함수를 사용하여 열로 구분된 그룹을 행으로 출력하기

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

-- EMP 테이블을 이용하여 부서 번호(DEPTNO), 평균 급여(AVG_SAL), 최고 급여(MAX_SAL), 최저 급여(MIN_SAL), 사원 수(CNT)를 출력
-- 단, 평균 급여를 출력할 때 소수점을 제외하고 각 부서 번호별로 출력

SELECT DEPTNO,
       TRUNC(AVG(SAL)) AS AVG_SAL,
       MAX(SAL) AS MAX_SAL,
       MIN(SAL) AS MIN_SAL,
       COUNT(*) AS CNT
FROM EMP
GROUP BY DEPTNO;

-- 같은 직책(JOB)에 종사하는 사원이 3명 이상인 직책과 인원수를 출력

SELECT JOB, 
       COUNT(*)
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- 사원들의 입사 연도(HIRE_YEAR)를 기준으로 부서별로 몇 명이 입사했는지 출력

SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR,
       DEPTNO,
       COUNT(*) AS CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;

-- 추가 수당(COMM)을 받는 사원 수와 받지 않는 사원 수를 출력

SELECT NVL2(COMM, 'O', 'X') AS EXIST_COMM,
       COUNT(*) AS CNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

-- 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력하고 각 부서별 소계와 총계를 출력

SELECT DEPTNO,
       TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR,
       COUNT(*) AS CNT,
       MAX(SAL) AS MAX_SAL,
       SUM(SAL) AS SUM_SAL,
       AVG(SAL) AS AVG_SAL
FROM EMP
GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));
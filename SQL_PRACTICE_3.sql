-- GROUP BY절에 조건을 주는 HAVING절

-- HAVING절 기본 형식 : SELECT   [조회할 열1 이름], [조회할 열2 이름], ..., [조회할 열N 이름]
--                    FROM     [조회할 테이블 이름]
--                    WHERE    [조회할 행을 선별하는 조건식]
--                    GROUP BY [그룹화할 열 지정(여러 개 지정 가능)]
--                    HAVING   [출력 그룹을 제한하는 조건식]
--                    ORDER BY [정렬하려는 열 지정]

-- GROUP BY절과 HAVING절을 사용하여 출력하기

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;


-- HAVING절 유의점 : HAVING절과 WHERE절이 비슷하다고 생각할 수 있지만 WHERE절은 출력 대상 행을 제한하고, HAVING절은 그룹화된 대상을 출력에서 제한하므로 쓰임새가 전혀 다름
-- HAVING절 대신 WHERE절을 잘못 사용했을 경우

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE AVG(SAL) >= 2000
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- 출력 행을 제한하는 WHERE절에서는 그룹화된 데이터 AVG(SAL)를 제한하는 조건식을 지정할 수 없으므로 오류 발생
-- [Error] Execution (24: 7): ORA-00934: 그룹 함수는 허가되지 않습니다

-- WHERE절과 HAVING절의 차이점

-- WHERE절을 사용하지 않고 HAVING절만 사용한 경우

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
   HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;


-- WHERE절과 HAVING절을 모두 사용한 경우

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

-- WHERE절이 GROUP BY절과 HAVING절을 사용하는 데이터 그룹화보다 먼저 제한하기 때문에 급여(SAL)가 3000이 넘는 사원이 먼저 제외되서 그룹화 대상에 속하지도 못함

-- 그룹화와 관련된 함수

-- ROLLUP 함수 기본 형식 : SELECT [조회할 열1 이름], [조회할 열2 이름], ..., [조회할 열N 이름]
--                       FROM   [조회할 테이블 이름]
--                       WHERE  [조회할 행을 선별하는 조건식]
--                       GROUP BY ROLLUP([그룹화 열 지정(여러 개 지정 가능])
-- CUBE 함수 기본 형식 : SELECT [조회할 열1 이름], [조회할 열2 이름], ..., [조회할 열N 이름]
--                     FROM   [조회할 테이블 이름]
--                     WHERE  [조회할 행을 선별하는 조건식]
--                     GROUP BY CUBE([그룹화 열 지정(여러 개 지정 가능])
-- 그룹화 데이터의 합계를 함께 출력하는데 사용합니다.

-- ROLLUP 함수를 적용한 그룹화

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);


-- CUBE 함수를 적용한 그룹화

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;


-- ROLLUP(A, B, C)
-- 1. A 그룹별 B 그룹별 C 그룹에 해당하는 결과 출력
-- 2. A 그룹별 B 그룹에 해당하는 결과 출력
-- 3. A 그룹에 해당하는 결과 출력
-- 4. 전체 데이터 결과 출력
-- 즉 N개의 열을 지정하면 N+1개의 조합이 출력됨

-- CUBE(A, B, C)
-- 1. A 그룹별 B 그룹별 C 그룹에 해당하는 결과 출력
-- 2. A 그룹별 B 그룹에 해당하는 결과 출력
-- 3. B 그룹별 C 그룹에 해당하는 결과 출력
-- 4. A 그룹별 C 그룹에 해당하는 결과 출력
-- 5. A 그룹에 해당하는 결과 출력
-- 6. B 그룹에 해당하는 결과 출력
-- 7. C 그룹에 해당하는 결과 출력
-- 8. 전체 데이터 결과 출력
-- 즉 N개의 열을 지정하면 2^N개의 조합이 출력됨

-- GROUPING SETS 함수 기본 형식 : SELECT [조회할 열1 이름], [조회할 열2 이름], ..., [조회할 열N 이름]
--                              FROM   [조회할 테이블 이름]
--                              WHERE  [조회할 행을 선별하는 조건식]
--                              GROUP BY GROUPING SETS([그룹화 열 지정(여러 개 지정 가능)]
-- 여러 그룹화 대상 열의 결과 값을 각각 같은 수준으로 출력합니다.

-- GROUPING SETS 함수를 사용하여 열별로 그룹을 묶어 출력하기

SELECT DEPTNO, JOB, COUNT(*)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

-- ROLLUP과 CUBE 함수처럼 열을 대그룹, 소그룹과 같이 계층적으로 그룹화하는 것이 아닌 지정한 열을 각각 대그룹으로 처리하여 출력


-- 그룹화 함수 : 데이터 자체의 가공이나 특별한 연산 기능을 수행하지는 않지만 그룹화 데이터의 식별이 쉽고 가독성을 높히기 위한 목적으로 사용

-- GROUPING 함수 기본 형식 : SELECT [조회할 열1 이름], [조회할 열2 이름], ..., [조회할 열N 이름],
--                                GROUPING([GROUP BY절에 ROLLUP 또는 CUBE에 명시한 그룹화 할 열 이름])
--                         FROM   [조회할 테이블 이름]
--                         WHERE  [조회할 행을 선별하는 조건식]
--                         GROUP BY ROLLUP 또는 CUBE([그룹화할 열])
-- 현재 결과가 그룹화 대상 열의 그룹화가 이루어진 상태의 집계인지 여부를 출력합니다.

-- DEPTNO, JOB열의 그룹화 결과 여부를 GROUPING 함수로 확인하기

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL),
       GROUPING(DEPTNO),
       GROUPING(JOB)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

-- 현재 행의 결과가 GROUPING 함수에 명시한 열이 그룹화되어 출력되었으면 1, 그룹화되지 않은 결과면 0을 출력함

-- DECODE문으로 GROUPING 함수를 적용하여 결과 표기하기

SELECT DECODE(GROUPING(DEPTNO), 1, 'ALL_DEPT', DEPTNO) AS DEPTNO,
       DECODE(GROUPING(JOB), 1, 'ALL_JOB', JOB) AS JOB,
       COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

-- GROUPING 함수의 결과에 따라 DECODE문을 이용하여 결과를 표기함

-- GROUPING_ID 함수 기본 형식 : SELECT [조회할 열1 이름], [조회할 열2 이름], ..., [조회할 열N 이름],
--                                   GROUPING_ID([그룹화 여부를 확인할 열(여러 개 지정 가능)]
--                            FROM   [조회할 테이블 이름]
--                            WHERE  [조회할 행을 선별하는 조건식]
--                            GROUP BY ROLLUP 또는 CUBE([그룹화할 열])
-- GROUPING 함수처럼 특정 열의 그룹화 여부를 출력할 수 있으며, 검사할 열을 여러 개 지정할 수 있습니다.

-- DEPTNO, JOB을 함께 명시한 GROUPING_ID 함수 사용하기

SELECT DEPTNO, JOB, COUNT(*), SUM(SAL),
       GROUPING(DEPTNO),
       GROUPING(JOB),
       GROUPING_ID(DEPTNO, JOB)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;


-- GROUPING_ID 함수를 사용한 결과는 그룹화 비트 벡터(grouping bit vector)값으로 나타난다
-- GROUPING_ID(A, B)
-- 그룹화 된 열      그룹화 비트 벡터       최종 결과
--    A, B              0 0                0
--     A                0 1                1
--     B                1 0                2
--    NONE              1 1                3
-- 지정할 열의 순서에 따라 출력된 0 혹은 1로 이루어진 그룹화 비트 벡터 값을 2진수로 보고 10진수로 바꾼 값이 최종 결과로 출력됨
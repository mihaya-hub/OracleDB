-- 다중행 함수 --

-- SUM 함수 기본 형식 : SUM([DISTINCT, ALL 중 하나를 선택하거나 아무 값도 지정하지 않음(선택)]
--                        [합계를 구할 열이나 연산자, 함수를 사용한 데이터(필수)])
--                    OVER(분석을 위한 여러 문법을 지정)(선택)

-- SUM 함수를 사용하여 급여 합계 출력하기
/*
SELECT SUM(SAL) 
FROM EMP;
*/

-- 급여 합계 구하기(DISTINCT, ALL 사용)
/*
SELECT SUM(DISTINCT SAL),
       SUM(ALL SAL),
       SUM(SAL)
FROM EMP;
*/
-- DISTINCT 옵션은 중복 값을 제외하고 합계를 구함. ALL 옵션은 중복 값 포함 합계를 구함 (아무 옵션도 지정하지 않으면 ALL)

-- COUNT 함수 기본 형식 : COUNT([DISTINCT, ALL 중 하나를 선택하거나 아무 값도 지정하지 않음(선택)]
--                            [개수를 구할 열이나 연산자, 함수를 사용한 데이터(필수)])
--                      OVER(분석을 위한 여러 문법 지정)(선택)

-- EMP 테이블의 데이터 개수 출력하기
/*
SELECT COUNT(*)
FROM EMP;
*/

-- 부서 번호가 30번인 직원 수 구하기
/*
SELECT COUNT(*)
FROM EMP
WHERE DEPTNO = 30;
*/

-- COUNT 함수를 사용하여 급여 개수 구하기(DISTINCT, ALL 사용)
/*
SELECT COUNT(DISTINCT SAL),
       COUNT(ALL SAL),
       COUNT(SAL)
FROM EMP;
*/

-- COUNT 함수를 사용하여 추가 수당 열 개수 출력하기
/*
SELECT COUNT(COMM)
FROM EMP;
*/

-- COUNT 함수와 IS NOT NULL을 사용하여 추가 수당 열 개수 출력하기
/*
SELECT COUNT(COMM)
FROM EMP
WHERE COMM IS NOT NULL;
*/
-- NULL 데이터는 COUNT 반환 개수에서 제외됨 (IS NOT NULL 써도 안써도 같은 결과)

-- MAX/MIN 함수 기본 형식 : MAX/MIN([DISTINCT, ALL 중 하나를 선택하거나 아무 값도 지정하지 않음(선택)]
--                        [최댓값/최솟값을 구할 열이나 연산자, 함수를 사용한 데이터(필수)]
--                    OVER(분석을 위한 여러 문법 지정)(선택)

-- 부서 번호가 10번인 사원들의 최대 급여 출력하기
/*
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 10;
*/

-- 부서 번호가 10번인 사원들의 최소 급여 출력하기
/*
SELECT MIN(SAL)
FROM EMP
WHERE DEPTNO = 10;
*/

-- 날짜 데이터에 MAX/MIN 함수 사용하기
-- 부서 번호가 20인 사원의 입사일 중 제일 최근 입사일 출력하기
/*
SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;
*/
-- 입사 연도가 큰 사원이 더 최근

-- 부서 번호가 20인 사원의 입사일 중 제일 오래된 입사일 출력하기
/*
SELECT MIN(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;
*/
-- 입사 연도가 작은 사원이 더 오래됨

-- AVG 함수 기본 형식 : AVG([DISTINCT, ALL 중 하나를 선택하거나 아무 값도 지정하지 않음(선택)]
--                        [평균 값을 구할 열이나 연산자, 함수를 사용한 데이터(필수)]
--                    OVER(분석을 위한 여러 문법을 지정)(선택)

-- 부서 번호가 30인 시원들의 평균 급여 출력하기
/*
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 30;
*/

-- 집합 연산자를 사용하여 각 부서별 평균 급여 출력하기
/*
SELECT AVG(SAL), '10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT AVG(SAL), '20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT AVG(SAL), '30' AS DEPTNO FROM EMP WHERE DEPTNO = 30;
*/
-- 위 방식은 번거로운 방법일 뿐만 아니라 이후에 특정 부서를 추가하거나 삭제할 때마다 SQL문을 수정해야 하므로 바람직하지 않음

-- GROUP BY 절 기본 형식 : SELECT    [조회할 열1 이름], [조회할 열2 이름], ..., [조회할 열N 이름]
--                       FROM      [조회할 테이블 이름]
--                       WHERE     [조회할 행을 선별하는 조건식]
--                       GROUP BY  [그룹화할 열을 지정(여러 개 지정 가능)]
--                       ORDER BY  [정렬하려는 열 지정]

-- GROUP BY를 사용하여 부서별 평균 급여 출력하기
/*
SELECT AVG(SAL), DEPTNO
FROM EMP
GROUP BY DEPTNO;
*/

-- 부서 번호 및 직책별 평균 급여로 정렬하기
/*
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;
*/

-- GROUP BY절 유의점 : 다중행 함수를 사용하지 않은 일반 열은 GROUP BY절에 명시하지 않으면 SELECT절에서 사용할 수 없음
/*
SELECT ENAME, DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;
*/
-- GROUP BY절에 명시하지 않은 ENAME은 여러 행으로 구성되므로 오류 발생
-- [Error] Execution (140: 8): ORA-00979: GROUP BY 표현식이 아닙니다.
-- TO_DATE 함수 기본 형식 : TO_DATA('[문자열 데이터(필수)]', '[인식될 날짜형태(필수)]')

-- 1981년 6월 1일 이후에 입사한 사원 정보 출력하기

SELECT *
    FROM EMP
    WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');

-- 여러 가지 형식으로 날짜 데이터 출력하기

SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR_49,
       TO_DATE('49/12/10', 'RR/MM/DD') AS RR_YEAR_49,
       TO_DATE('50/12/10', 'YY/MM/DD') AS RR_YEAR_50,
       TO_DATE('50/12/10', 'RR/MM/DD') AS RR_YEAR_50,
       TO_DATE('51/12/10', 'YY/MM/DD') AS RR_YEAR_51,
       TO_DATE('51/12/10', 'RR/MM/DD') AS RR_YEAR_51
FROM DUAL;

-- * 두 자리로 연도를 표현할 때는 YY, RR 사용에 주의 필요
--      YY : 어떤 두 자리 수가 입력되어도 현 시점의 동일한 연도로 계산
--      RR : 00~49, 50~99를 비교하여 비교적 가까운 날짜 데이터를 계산


-- NVL 함수 기본 형식 : NVL([NULL인지 여부를 검사할 데이터 또는 열(필수)], [앞의 데이터가 NULL일 경우 반환할 데이터(필수)])

-- NVL 함수를 사용하여 출력하기

SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM,
       NVL(COMM, 0),
       SAL+NVL(COMM, 0)
FROM EMP;

-- NVL2 함수 기본 형식 : NVL2([NULL인지 여부를 검사할 데이터 또는 열(필수)],
--                          [앞 데이터가 NULL이 아닐 경우 반환할 데이터 또는 계산식(필수)],
--                          [앞 데이터가 NULL일 경우 반환할 데이터 또는 계산식(필수)])

-- NVL2 함수를 사용하여 출력하기

SELECT EMPNO, ENAME, COMM,
       NVL2(COMM, 'O', 'X'),
       NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
FROM EMP;

-- DECODE 함수 기본 형식 : DECODE([검사 대상이 될 열 또는 데이터, 연산이나 함수의 결과],
--                              [조건1], [데이터가 조건1과 일치할 때 반환할 결과],
--                              [조건2], [데이터가 조건2와 일치할 때 반환할 결과],
--                              ...
--                              [조건n], [데이터가 조건n과 일치할 때 반환할 결과],
--                              [위 조건1~조건n과 일치한 경우가 없을 때 반환할 결과])

-- DECODE 함수를 사용하여 출력하기

SELECT EMPNO, ENAME, JOB, SAL,
       DECODE(JOB,
              'MANAGER', SAL*1.1,
              'SALESMAN', SAL*1.05,
              'ANALYST', SAL,
              SAL*1.03) AS UPSAL
FROM EMP;

-- CASE문 기본 형식 : CASE [검사 대상이 될 열 또는 데이터, 연산이나 함수의 결과(선택)]
--                       WHEN [조건1] THEN [조건1의 결과 값이 TRUE일 때, 반환할 결과]
--                       WHEN [조건2] THEN [조건2의 결과 값이 TRUE일 때, 반환할 결과]
--                       ...
--                       WHEN [조건n] THEN [조건n의 결과 값이 TRUE일 때, 반환할 결과]
--                       ELSE [위 조건1~조건n과 일치하는 경우가 없을 때 반환할 결과]
--                  END

-- CASE문을 사용하여 출력하기

SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
       WHEN 'MANAGER' THEN SAL*1.1
       WHEN 'SALESMAN' THEN SAL*1.05
       WHEN 'ANALYST' THEN SAL
       ELSE SAL*1.03
    END AS UPSAL
FROM EMP;

-- 열 값에 따라서 출력 값이 달라지는 CASE문

SELECT EMPNO, ENAME, COMM,
    CASE
       WHEN COMM IS NULL THEN '해당사항 없음'
       WHEN COMM = 0 THEN '수당 없음'
       WHEN COMM > 0 THEN '수당 : ' || COMM
    END AS COMM_TEXT
FROM EMP; 

-- 문제 풀기 --

-- EMP 테이블에서 사원 이름(ENAME)이 다섯 글자 이상이며 여섯 글자 미만인 사원 정보를 출력
-- MASKING_EMPNO 열에는 사원 번호(EMPNO) 앞 두 자리 외 뒷자리를 * 기호로 출력
-- MASKING_ENAME 열에는 사원 이름(ENAME)의 첫 글자만 보여 주고 나머지 글자 수만큼 * 기호로 출력

SELECT EMPNO,
       RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS MASKING_EMPNO,
       ENAME,
       RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
FROM EMP
WHERE LENGTH(ENAME) >= 5
  AND LENGTH(ENAME) < 6;

-- EMP 테이블에서 사원들의 월 평균 근무일 수가 21.5일 이고 하루 근무 시간이 8시간일 때, 사원들의 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 출력
-- (단, 하루 급여는 소수점 세 번째 자리에서 버리고, 시급은 두 번째 자리에서 반올림)

SELECT EMPNO, ENAME, SAL,
       TRUNC(SAL / 21.5, 2) AS DAY_PAY,
       ROUND(SAL / (21.5 * 8), 1) AS TIME_PAY
FROM EMP;

-- EMP 테이블에서 사원들이 입사일(HIREDATE)을 기준으로 3개월이 지난 후 첫 번째 월요일에 정직원이 될 때, 정직원이 되는 날짜(R_JOB)을 YYYY-MM-DD 형식으로 출력
-- (단, 추가 수당(COMM)이 없는 사원의 추가 수당은 N/A로 출력)

SELECT EMPNO, ENAME, HIREDATE,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_DATE,
       NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;

-- EMP 테이블에서 직속 상관의 사원 번호를 조건에 맞게 변환하여 CHG_MGR열에 출력
-- 조건 --
-- 직속 상관의 사원 번호가 존재하지 않을 경우 : 0000
-- 직속 상관의 사원 번호 앞 두 자리가 75일 경우 : 5555
-- 직속 상관의 사원 번호 앞 두 자리가 76일 경우 : 6666
-- 직속 상관의 사원 번호 앞 두 자리가 77일 경우 : 7777
-- 직속 상관의 사원 번호 앞 두 자리가 78일 경우 : 8888
-- 그 외 직속 상관 사원 번호의 경우 : 본래 직속 상관의 사원 번호 그대로 출력\

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
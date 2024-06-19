-- 2024.06.19 SQL 5일차_01. 조인의 종류
-- 1. JOIN의 종류
-- 1.1. INNER JOIN : 교집합, 일반적으로 사용하는 조인
-- 1.2. OUTER JOIN : 합집합, 모두 출력하는 조인
-- ex) 사원명과 부서명을 출력하시오.
SELECT COUNT(*) FROM EMPLOYEE; -- 23개의 결과값
-- [INNER JOIN] => 교집합 
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; --21개의 결과값
-- 2개는 왜 빠졌을까? DEPT_CODE가 NULL인 데이터가 빠짐.
-- => 이것을 INNER JOIN이라고 함.

SELECT * FROM EMPLOYEE; -- 23개의 결과값(23명, DEPT_CODE 2명 NULL)
-- [LEFT OUTER JOIN] 은 왼쪽 테이블이 가지고 있는 모든 데이터를 출력
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; --23개의 결과값, 

-- [RIGHT OUTER JOIN] 은 오른쪽 테이블이 가지고 있는 모든 데이터 출력
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID; --24개의 결과값

-- [FULL OUTER JOIN] 은 양쪽 테이블이 가지고 있는 모든 데이터를 출력
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 오라클 전용 구문, JOIN사용해보기
-- [오라클의 INNER JOIN]
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;
-- [오라클의 LEFT OUTER JOIN]
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);
-- [오라클의 RIGHT OUTER JOIN]
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;
-- [오라클의 FULL OUTER JOIN은 존재하지 않는다]



-- @JOIN 종합실습
--------------------------------------------------------------------------------
-- 1. 주민번호가 1970년대 생이면서 성별이 여자이고, 성이 전씨인
--    직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
--------------------------------------------------------------------------------
SELECT 
        EMP_NAME "사원명",
        EMP_NO "주민번호",
        DEPT_TITLE "부서명",
        JOB_NAME "직급명"
    FROM EMPLOYEE 
        JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
        JOIN JOB USING(JOB_CODE)
    WHERE 
        (EMP_NO LIKE '7%-2%' 
        AND EMP_NAME LIKE'전%');
--------------------------------------------------------------------------------
--2. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
--------------------------------------------------------------------------------
SELECT
    EMP_ID "사번",
    EMP_NAME "사원명",
    JOB_NAME "부서명"
FROM EMPLOYEE JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%형%';
--------------------------------------------------------------------------------
--3. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
--------------------------------------------------------------------------------
    SELECT 
        EMP_NAME "사원명",
        JOB_NAME "직급명",
        DEPT_CODE "부서코드",
        DEPT_TITLE "부서명"
    FROM EMPLOYEE 
        JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
        JOIN JOB USING(JOB_CODE)
    WHERE 
        DEPT_TITLE LIKE '해외영업_부'
        -- DEPT_ID IN ('D5', 'D6', 'D7')
    ORDER BY 3 ASC;
--------------------------------------------------------------------------------
-- 4. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
--     ** JOIN 순서가 중요한 문제
--------------------------------------------------------------------------------
    SELECT 
        EMP_NAME "사원명",
        BONUS "보너스 포인트",
        DEPT_TITLE "부서명",
        LOCAL_NAME "지역명"
    FROM EMPLOYEE
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    WHERE BONUS IS NOT NULL;
--------------------------------------------------------------------------------
--5. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
--------------------------------------------------------------------------------
 SELECT 
        EMP_NAME "사원명",
        JOB_NAME "직급명",
        DEPT_TITLE "부서명",
        LOCAL_NAME "지역명"
    FROM EMPLOYEE 
        JOIN JOB USING(JOB_CODE)
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    WHERE 
        DEPT_CODE IN ('D2')
    ORDER BY 1 ASC;
--------------------------------------------------------------------------------
--6. 급여등급테이블의 최대급여(MAX_SAL)보다 많이 받는 직원들의 
--   사원명, 직급명, 급여, 연봉을 조회하시오.
--     (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 조인할 것)
--   데이터 없음!
--------------------------------------------------------------------------------
SELECT 
    EMP_NAME "사원명", 
    JOB_NAME"직급명", 
    MIN_SAL,
    SALARY"월급", 
    MAX_SAL,
    SALARY*12 "연봉"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN SAL_GRADE USING(SAL_LEVEL)
WHERE SALARY> MAX_SAL;

SELECT *FROM SAL_GRADE;
--------------------------------------------------------------------------------
--7. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
--------------------------------------------------------------------------------
SELECT 
        EMP_NAME "사원명",
        DEPT_TITLE "부서명",
        LOCAL_NAME "지역명",
        NATIONAL_NAME "국가명"
    FROM EMPLOYEE 
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
        JOIN NATIONAL USING(NATIONAL_CODE)
    WHERE NATIONAL_CODE IN ('KO', 'JP');
    
--------------------------------------------------------------------------------
--8. 보너스포인트가 없는 직원들 중에서 
--   직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오. 
--   단, join과 IN 사용할 것
--------------------------------------------------------------------------------
SELECT
    EMP_NAME "사원명", 
    JOB_NAME "직급명", 
    SALARY "월급",
    BONUS "보너스"
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE BONUS IS NULL
AND JOB_NAME IN ('차장', '사원');
-- 24.06.18 SQL 4일차_03. 오라클 조인
-- 1. JOIN
--   두개 이상의 테이블에서 연관성을 가지고 있는 데이터들을 따로 분류하여 새로운 가상의 테이블을 만듬
--     -> 여러 테이블의 레코드를 조합하여 하나의 레코드로 만듬


-- 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID;

-- 오라클 전용구문
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE,JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- ANSI 표준 구문 -- 오라클 기본구문보다는 전체가 다 사용하는 구문으로 하는 습관 들이기
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB
ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 테이블에 별칭 부여
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J
ON E.JOB_CODE = J.JOB_CODE;

-- 조인하는 컬럼 같을 때 USING 구문 씀
SELECT EMP_ID, EMP_NAME, JOB_NAME, JOB_CODE
FROM EMPLOYEE E
JOIN JOB J
USING(JOB_CODE);

--------------------------------------------------------------------------------
-- @ 실습문제1
-- 부서명과 지역명을 출력하세요. 
--------------------------------------------------------------------------------
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
--------------------------------------------------------------------------------
--[윤경]
    SELECT
        D.DEPT_TITLE "부서명",
        L.LOCAL_NAME "지역명"
    FROM DEPARTMENT D, LOCATION l
    WHERE LOCATION_ID = LOCAL_CODE;
    
--[뱅큐]
    SELECT DEPT_TITLE, LOCAL_NAME
    FROM DEPARTMENT
    JOIN LOCATION
    ON LOCATION_ID = LOCAL_CODE;
--------------------------------------------------------------------------------
-- @ 실습문제2
-- 사원명과 직급명을 출력하세요.
-- EMPLOYEE.EMP_NAME
-- JOB.JOB_NAME
-- JOB.JOB_CODE = EMPLOYEE.JOB_CODE
--------------------------------------------------------------------------------
-- [윤경]
    SELECT
        EMP_NAME "사원명",
        JOB_NAME "직급명"
    FROM EMPLOYEE JOIN JOB
    ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
    
-- [뱅큐]
    SELECT EMP_NAME, JOB_NAME 
    FROM EMPLOYEE
    JOIN JOB
    USING(JOB_CODE);
--------------------------------------------------------------------------------
-- @ 실습문제3
-- 지역명과 국가명을 출력하세요.
--------------------------------------------------------------------------------
--[윤경]
    SELECT
        LOCAL_NAME "지역명",
        NATIONAL_NAME "국가명"
    FROM LOCATION JOIN NATIONAL
    USING(NATIONAL_CODE);
    
--[뱅큐]
    SELECT LOCAL_NAME, NATIONAL_NAME
    FROM LOCATION JOIN NATIONAL
    USING(NATIONAL_CODE);
--------------------------------------------------------------------------------

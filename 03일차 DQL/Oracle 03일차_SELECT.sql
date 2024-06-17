-- 24.06.17 SQL 3일차_02.SELECT

DESC EMPLOYEE;
-- [RESULT SET : 데이터를 조회한 결과]
--  ResultSet : SELECT 구문에 의해 반환된 행들의 집합
--  ResultSet은  0개 이상의 행이 포함될 수 있음.
--  ResultSet은 특정한 기준에 의해 정렬될 수 있음.
--  특정 컬럼이나 특정행을 조회할 수 있음.

-- 1. 전제 컬럼 조회
SELECT * FROM EMPLOYEE;

-- 2. 특정 컬럼만 조회
--    (SELECT 컬럼명, 컬럼명 FROM 테이블명)
SELECT EMP_ID, EMP_NAME FROM EMPLOYEE;

-- 3. 특정 행만 조회
SELECT * FROM EMPLOYEE WHERE EMP_ID='200';

--------------------------------------------
-- [연산 예제]------------------------------
-- 1.EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함),
--       실수령액(총 수령액-(월급*세금 3%))가 출력되도록 하시오.
-- 2. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오.
--    (SYSDATE를 사용하면 현재 시간 출력)
-- 3. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율 출력하시오.

DESC EMPLOYEE;
SELECT * FROM EMPLOYEE;
-- 이름 : EMP_NAME
-- 월급 : SALARY
-- 연봉 : SALARY*!2

-- 1.EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함),
--       실수령액(총 수령액-(월급*세금 3%))가 출력되도록 하시오.
-- 연봉 : SALARY*12
SELECT EMP_NAME, SALARY*12 FROM EMPLOYEE;
-- 총수령액 : SALARY*12+SALARY*NVL(BONUS,0)
-- *** NVL : 보너스 없는 사람 NULL일 때 오류 안나도록 하는 것
SELECT EMP_NAME "이름", SALARY*12+SALARY*NVL(BONUS,0) FROM EMPLOYEE;
-- 실수령액 :
SELECT EMP_NAME "이름", 
    SALARY*12 AS 연봉,
    SALARY*12+SALARY*NVL(BONUS,0) "총수령액",
    (SALARY*12+SALARY*NVL(BONUS,0)) - (SALARY*0.03) AS "실수령액"
FROM EMPLOYEE;


SELECT * FROM EMPLOYEE;
-- 2. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오.
--    (SYSDATE를 사용하면 현재 시간 출력)
SELECT EMP_NAME, HIRE_DATE, SYSDATE FROM EMPLOYEE;
-- 근무 일수 계산
SELECT EMP_NAME, HIRE_DATE "입사일", SYSDATE "오늘날짜", ROUND(SYSDATE - HIRE_DATE) "근무 일수" FROM EMPLOYEE;


-- 3. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율 출력하시오.
SELECT 
    EMP_NAME "이름",
    SALARY "월급", 
    NVL(BONUS, 0) "보너스율" 
FROM EMPLOYEE;
-- WHERE을 이용한 조건에 맞는 사람 선택!
SELECT 
    EMP_NAME "이름",
    SALARY "월급", 
    NVL(BONUS, 0) "보너스율" 
FROM EMPLOYEE WHERE ROUND(SYSDATE - HIRE_DATE) >= (365*20) ;




--[정렬]------------------------------------
-- SELECT
-- 1. 오름차순 정렬(작은 수 -> 큰 수), 널값은 제일 아래로
SELECT * FROM EMPLOYEE
ORDER BY EMP_ID ASC;

-- 2. 내림차순 정렬(큰 수 -> 작은 수), 널값은 제일 위로 감
SELECT * FROM EMPLOYEE
ORDER BY EMP_ID DESC;

--------------------------------------------
-- [비교연산자 예제]------------------------
-- 1.EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오.
SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_NAME LIKE '__연';

-- 2.EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 
--   사원의 이름, 전화번호를 출력하시오.
SELECT EMP_NAME, PHONE FROM EMPLOYEE WHERE PHONE NOT LIKE '010%';
-- 3.EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서,
--   DEPT_CODE가 D9 또는 D6이고 고용일이 90/01/01 ~ 00/12/01이면서, 
--   월급이 270만원이상인 사원의 전체 정보를 출력하시오
SELECT * FROM EMPLOYEE 
WHERE 
    EMAIL LIKE '%s%' 
    AND DEPT_CODE IN ('D9', 'D6') 
    -- AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
    AND (HIRE_DATE >= '90/01/01' AND HIRE_DATE<='01/12/01')
    -- AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01'
    AND SALARY >= 2700000;

-- EMPLOYEE 테이블에서 ~~~ 전체 정보를 출력하세요. 
--  (SELECT * FROM EMPLOYEE WHERE~~~~
-- 조건 1 : 메일주소의 's'가 들어가면서,
--  (EMAIL LIKE '%s%' AND
-- 조건 2 : DEPT_CODE가 D9 또는 D6이고
--  (AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6');
--  (AND DEPT_CODE IN ('D9', 'D6')
-- 조건 3 : 고용일이 90/01/01 ~ 00/12/01이면서,
--  (AND (HIRE_DATE >= '90/01/01' AND HIRE_DATE<='01/12/01')
--  (AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01'
-- 조건 4 : 월급이 270만원이상인
--  (AND SALARY >= 2700000;



--------------------------------------------
------- [비교연산자 최종 실습 문제]---------
--------------------------------------------

--------------------------------------------
-- 문제1. 
-- 입사일이 오늘기준으로 5년 이상, 10년 이하인 
-- 직원의 이름,주민번호,급여,입사일을 검색하여라
--------------------------------------------
-- 출력 : 이름, 주민번호, 급여, 입사일

SELECT 
EMP_NAME "이름", EMP_NO"주민번호", SALARY"급여", HIRE_DATE"입사일", ROUND(SYSDATE - HIRE_DATE) "근무 일수" 
FROM EMPLOYEE 
WHERE ROUND(SYSDATE-HIRE_DATE) >= (365*5) AND ROUND(SYSDATE-HIRE_DATE)<=(365*10);

--------------------------------------------
-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라.
--(퇴사 여부 : ENT_YN)
--------------------------------------------
SELECT 
EMP_NAME "이름", DEPT_CODE "부서코드", HIRE_DATE"급여", HIRE_DATE "고용일", ROUND(ENT_DATE - HIRE_DATE) "근무 기간", ENT_DATE "퇴직일" 
FROM EMPLOYEE 
WHERE ENT_DATE IS NOT NULL;
--WHERE ENT_YN = 'Y';

--------------------------------------------
-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.
--------------------------------------------
SELECT EMP_NAME "이름", SALARY*1.5 "급여", FLOOR((SYSDATE - HIRE_DATE)/365) "근속년수"
FROM EMPLOYEE
WHERE FLOOR((SYSDATE - HIRE_DATE)/365) >= 10
-- 1. HIRE_DATE 컬럼 순서대로 오름차순
-- ORDER BY HIRE_DATE ASC;
-- 2. 근속년수라고 지정한 대로 오름차순
-- ORDER BY 근속년수 ASC;
-- 3. 3번째 컬럼대로 오름차순 
ORDER BY 3 ASC;

-- ROUND : 반올림
-- CEIL : 올림
-- FLOOR : 버림
--------------------------------------------
-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
--------------------------------------------
SELECT EMP_NAME "이름", EMP_NO "주민번호", EMAIL "이메일", PHONE "폰번호", SALARY "급여"
FROM EMPLOYEE
WHERE 
    HIRE_DATE BETWEEN '99/01/01' AND '10/01/01' 
    AND SALARY <=2000000;

--------------------------------------------
-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.
--------------------------------------------
SELECT EMP_NAME "이름", EMP_NO "주민번호", SALARY "급여", NVL(DEPT_CODE, '없음') "부서코드"
FROM EMPLOYEE
WHERE 
    SALARY BETWEEN 2000000 AND 3000000 
    AND EMP_NO LIKE '___4___2%'
ORDER BY EMP_NO DESC;

--------------------------------------------
-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
--------------------------------------------
SELECT EMP_NAME "이름",SALARY "월급", FLOOR((SYSDATE-HIRE_DATE)/1000) "지급횟수",SALARY*0.10*FLOOR((SYSDATE-HIRE_DATE)/1000) "특별보너스"
FROM EMPLOYEE
WHERE 
    (EMP_NO LIKE '%-1%' OR EMP_NO LIKE '%-3%')
    AND BONUS IS NULL
ORDER BY 이름 ASC;


--------------------------------------------
-- 실습1------------------------------------
-- 관리자(MANAGER_ID)도 없고 부서 배치(DEPT_CODE)도 받지 않은  
-- 직원의 이름 조회하시오
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE 
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL
AND DEPT_CODE IS NULL;

-- 실습2
-- 부서배치를 받지 않았지만 보너스를 지급하는 직원 전체 정보 조회
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;


--------------------------------------------
------------------ extra -------------------
--------------------------------------------
-- extra1
-- EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?
--------------------------------------------
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';
--------------------------------------------
-- extra2
-- EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?
--------------------------------------------
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' escape '\';

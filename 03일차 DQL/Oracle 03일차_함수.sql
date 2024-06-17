-- 24.06.17 SQL 3일차_03. 함수
--[오라클 함수의 종류]
-- 1. 단일행 함수 - 결과값 여러개
-- 2. 다중행 함수 - 결과값 1개(그룹함수)
SELECT SUM(SALARY) FROM EMPLOYEE;

SELECT SYSDATE-HIRE_DATE FROM EMPLOYEE;
SELECT TRUNC(SYSDATE-HIRE_DATE,2) FROM EMPLOYEE;

-- A. 숫자 처리 함수
-- 종류 : ABS(절대값), MOD(나머지), TRUNC(소숫점 지정 버림), FLOOR(버림), ROUND(반올림), CEIL(올림)
--      (TIP : 함수의 결과를 테스트 해볼 수 있게 해주는 가상의 테이블 DUAL)
        SELECT SYSDATE FROM DUAL;
-- 1) 절대값 : SELCET ABS(N) : N의 절대값
    SELECT ABS(-3) FROM DUAL; -- 결과 : 3
    SELECT ABS(-1) FROM DUAL;
-- 2) 나머지 : SELECT MOD(A, B) : A를 B로 나눈 나머지
    SELECT MOD(35, 3) FROM DUAL;  -- 결과 : 2 


SELECT SYSDATE FROM DUAL;

-- B. 문자 처리 함수

-- C. 날짜 처리 함수
--  TIP : 함수는 소괄호를 붙여서 사용한다. 소괄호 안에는 전달값을 넣어준다.
--  종류 : ADD_MONTHS(), MONTHS_BETWEEN(), LAST_DAY(), EXTRACT, SYSDATE
--  1) ADD_MONTHS() : 기준날짜로부터 숫자만큼의 개월 수 뒤를 출력해줌
    SELECT ADD_MONTHS(SYSDATE, 2) FROM DUAL;  -- 오늘로부터 2개월 뒤 출력
--  2) MONTHS_BETWEEN('날짜', '날짜');
    SELECT MONTHS_BETWEEN(SYSDATE, '24/05/07') FROM DUAL;
--  3) LAST_DAY 마지막 날짜를 구해줌
    SELECT LAST_DAY(SYSDATE) FROM DUAL; -- 해당월의 마지막 날짜
    SELECT LAST_DAY(SYSDATE)+1 FROM DUAL;  -- 해당월의 마지막 날짜 +1일
    SELECT LAST_DAY('24/02/23')+1 FROM DUAL;  -- 24년 2월 마지막 날짜 + 1일
--  4) EXTRACT 년도, 월, 일을 DATE에서 추출해줌
    SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
    SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL;    
    SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;
    
-------------------------------------------------------------------------------
------------------------ [예제] -----------------------------------------------
-------------------------------------------------------------------------------
-- ex1) EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오.
SELECT EMP_NAME "이름", HIRE_DATE "입사일", ADD_MONTHS(HIRE_DATE, 3) "3개월 후"
FROM EMPLOYEE;


-------------------------------------------------------------------------------
-- ex2) EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오.
-------------------------------------------------------------------------------
SELECT EMP_NAME "이름", HIRE_DATE "입사일", FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "근무 개월수"
FROM EMPLOYEE;


-------------------------------------------------------------------------------
-- ex3) EMPLOYEE 테이블에서 사원이름, 입사일, 입사월의 마지막날을 조회하세요. 
-------------------------------------------------------------------------------
SELECT EMP_NAME"이름", HIRE_DATE"입사일", LAST_DAY(HIRE_DATE)"입사월의 마지막날" 
FROM EMPLOYEE;


-------------------------------------------------------------------------------
-- ex4) EMPLOYEE 테이블에서 사원이름, 입사 년도, 입사 월, 입사 일을 조회하시오.
-------------------------------------------------------------------------------
SELECT EMP_NAME"이름", 
    EXTRACT(YEAR FROM HIRE_DATE)||'년'"입사 년도",
    EXTRACT(MONTH FROM HIRE_DATE)||'월'"입사 월",
    EXTRACT(DAY FROM HIRE_DATE)||'일'"입사 일"
FROM EMPLOYEE;

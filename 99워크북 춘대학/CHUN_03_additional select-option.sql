-- CHUN 03. Additional Select - option
-- YOON : 11, 12, 13, 14, 15


--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_13PAGE
-- 3.01. 학생 이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 
-- 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
--------------------------------------------------------------------------------
SELECT
STUDENT_NAME "학생 이름"
, STUDENT_ADDRESS 주소지
FROM TB_STUDENT
ORDER BY 1 ASC;
--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_13PAGE
-- 3.02. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
--------------------------------------------------------------------------------
SELECT
STUDENT_NAME
, STUDENT_SSN
FROM TB_STUDENT
ORDER BY 2 DESC;

--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_14PAGE
-- 3.03. 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의
-- 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오. 단, 출력헤더에는
-- "학생이름", "학번", "거주지 주소"가 출력되도록 한다. 
--------------------------------------------------------------------------------
SELECT
    STUDENT_NAME 학생이름
    , STUDENT_NO 학번
    , STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%'
AND STUDENT_ADDRESS LIKE '경기도%' OR STUDENT_ADDRESS LIKE '강원도%'; 

--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_14PAGE
-- 3.04. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 
-- SQL 문장을 작성하시오. (법학과의 '학과코드'는 학과테이블을 조회해서 찾자)--005
--------------------------------------------------------------------------------
SELECT
PROFESSOR_NAME
, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO LIKE '005'
ORDER BY 2 ASC;

--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_15PAGE
-- 3.05. 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는
-- 작성해보시오. 
--------------------------------------------------------------------------------
SELECT
STUDENT_NO
, POINT
FROM TB_GRADE
WHERE CLASS_NO LIKE 'C3118100' 
AND TERM_NO LIKE '200402'
ORDER BY POINT DESC, STUDENT_NO ASC;
-- 다중정렬 : 중요도가 높은 거를 먼저 써야함.
--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_15PAGE
-- 3.06. 학생번호, 학생이름, 학과 이름을 학생이름으로 오름차순으로 정렬하여 출력
--------------------------------------------------------------------------------
SELECT
STUDENT_NO
, STUDENT_NAME
, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_16PAGE
-- 3.08. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL문 작성
--------------------------------------------------------------------------------
SELECT
CLASS_NAME
, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_17PAGE
-- 3.09. 8번의 결과 중 '인문사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
--------------------------------------------------------------------------------
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
WHERE CATEGORY='인문사회';
--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_17PAGE
-- 3.10. ‘음악학과’ 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", 
-- "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오. 
-- (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)
--------------------------------------------------------------------------------
SELECT 
    STUDENT_NO 학번
    ,STUDENT_NAME "학생이름"
    , ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT
    JOIN TB_GRADE USING(STUDENT_NO)
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '음악학과'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1 ASC;
-- 조인 순서 바꿔도 오류나지 않음.

--------------------------------------------------------------------------------
-- 3.11. 학번이 A313047 인 학생이 학교에 나오고 있지 않다. 
-- 지도 교수에게 내용을 전달하기 위한 
-- 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 
-- 이때 사용할 SQL 문을 작성하시오. 
-- (단, 출력헤더는 '학과이름‛, '학생이름‛, '지도교수이름‛ 으로 출력되도록 한다.)
--------------------------------------------------------------------------------
--[윤경]
SELECT 
    DEPARTMENT_NAME "학과이름",
    STUDENT_NAME "학생이름",
    PROFESSOR_NAME "지도교수이름"
FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
WHERE STUDENT_NO IN ('A313047');
-- 조인 순서 바꾸면 오류

--------------------------------------------------------------------------------
--[BENGq]
SELECT 
(SELECT DEPARTMENT_NAME FROM TB_DEPARTMENT WHERE DEPARTMENT_NO = STD.DEPARTMENT_NO) "학과이름"
, STUDENT_NAME "학생이름"
, (SELECT PROFESSOR_NAME FROM TB_PROFESSOR WHERE PROFESSOR_NO = STD.COACH_PROFESSOR_NO) "지도교수 이름"
FROM TB_STUDENT STD WHERE STUDENT_NO = 'A313047';

--------------------------------------------------------------------------------
-- 3.12. 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아 학생이름과 수강학기를 
-- 표시하는 SQL문장을 작성하시오. 
--------------------------------------------------------------------------------
SELECT
    STUDENT_NAME,
    TERM_NO "TERM_NAME"
FROM TB_STUDENT
    LEFT OUTER JOIN TB_GRADE USING(STUDENT_NO)
    LEFT OUTER JOIN TB_CLASS USING(CLASS_NO)
WHERE CLASS_NAME IN ('인간관계론') 
    AND TERM_NO LIKE '2007__';

-- [벵큐]
SELECT
STUDENT_NAME, TERM_NO "TERM_NAME"
FROM(
SELECT*FROM TB_GRADE WHERE TERM_NO LIKE '2007%' AND CLASS_NO
= (SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME = '인간관계론')
)JOIN TB_STUDENT USING(STUDENT_NO);
--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_18PAGE
-- 3.13. 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아
-- 그 과목 이름과 학과 이름을 출력하는 SQL문장을 작성하시오. 
--------------------------------------------------------------------------------
-- [윤경]
SELECT
CLASS_NAME
, DEPARTMENT_NAME
FROM TB_CLASS
LEFT OUTER JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE CATEGORY LIKE '예체능'
AND PROFESSOR_NO IS NULL;

--------------------------------------------------------------------------------
-- => TB_CLASS_PROFESSOR를 조인할 때, 
--    LEFT OUTER JOIN을 해야지 TB_CLASS의 882개의 데이터에 
--    776개의 TB_CLASS_FROFESSOR의 데이터를 매칭하고, 
--    매칭되는 데이터가 없는 경우 => NULL로 표시됨
-- => NULL = 클래스는 개설됐지만 교수가 없는 경우

--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_19PAGE
-- 3.14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 
-- 학생 이름과 지도교수 이름을 찾고 만일 지도교수가 없는 학생일 경우 '지도교수 미지정' 으로
-- 표시하도록 하는 SQL문을 작성하시오. 단, 출력헤더는 학생이름, 지도교수로 표시하며 고학번 학생이 먼저 표시되도록 한다. 
--------------------------------------------------------------------------------
SELECT 
STUDENT_NAME "학생이름", 
NVL(PROFESSOR_NAME, '지도교수 미지정') "지도교수"
--, ENTRANCE_DATE
FROM TB_STUDENT S
LEFT OUTER JOIN TB_PROFESSOR P ON S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
WHERE DEPARTMENT_NAME = '서반아어학과'
ORDER BY ENTRANCE_DATE;


--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_19PAGE
-- 3.15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아
-- 그 학생의 학번, 이름, 학과, 이름, 평점을 출력하는 SQL문을 작성하시오.
--------------------------------------------------------------------------------
SELECT 
    STUDENT_NO "학번"
    , STUDENT_NAME "이름"
    , DEPARTMENT_NAME "학과 이름"
    , ROUND(AVG(POINT), 2) "평점" 
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) 
JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN = 'N' 
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME 
HAVING ROUND(AVG(POINT),2) >= 4.0;
-- 조인순서 바꿔도 오류나지 않음.

--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_20PAGE
-- 3.16. 환경조경학과 전공과목들의 과목별 평점을 파악할 수 있는 SQL 문을 작성하시오.
--------------------------------------------------------------------------------
SELECT
    CLASS_NO
    , CLASS_NAME
    ,ROUND(AVG(POINT),8)
FROM TB_GRADE
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '환경조경학과' AND CLASS_TYPE LIKE '전공%'
GROUP BY CLASS_NO, CLASS_NAME;
-- 조인 순서 바뀌면 오류남

-- 조인 순서 어떻게 정하고, 
-- 그룹 컬럼 어떻게 정하지?

SELECT COUNT(*) FROM TB_GRADE; --5035
SELECT COUNT(*) FROM TB_CLASS; --882
SELECT COUNT(*) FROM TB_DEPARTMENT; --63
--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_20PAGE
-- 3.17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 
-- 주소를 출력하는 SQL문을 작성하시오.
--------------------------------------------------------------------------------
-- 최경희학생과 같은 과를 다니는 학생들의 그룹
SELECT
    STUDENT_NAME
    , STUDENT_ADDRESS
FROM TB_STUDENT 
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_STUDENT WHERE STUDENT_NAME = '최경희'); 

-- 서브쿼리

--------------------------------------------------------------------------------
-- WORKBOOK V.2.0_21PAGE
-- 3.18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 작성
--------------------------------------------------------------------------------
SELECT 
STUDENT_NAME
, STUDENT_NO =(
FROM TB_STUDENT
WHERE STUDENT_NO = (SELECT STUDENT_NO FROM TB_GRADE;

SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '국어국문학과')

SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '국어국문학과';



SELECT STUDENT_NAME, AVG(POINT)
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NAME LIKE = '국어국문학과'
GROUP BY STUDENT_NO, DEPARTMENT_NAME;

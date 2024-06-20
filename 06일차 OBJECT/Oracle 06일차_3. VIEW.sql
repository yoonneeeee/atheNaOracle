-- 2024.06.19 SQL 6일차_03. 오라클 객체(심화과정 시작...)

-- 1. VIEW
-- 1.1. 정의 
-- 1.1.1. 실제 테이블에 근거한 논리적인 가상의 테이블
--        (사용자에게 하나의 테이블처럼 사용 가능하게 함)
-- 1.1.2. SELECT 쿼리의 실행 결과를 화면에 저장한 논리적이 가상의 테이블
--        (실질적인 데이터를 저장하고 있지 않지만, 하나의 테이블처럼 사용 가능)
--
-- 1.2. 종류 
-- 1.2.1. Stored View(저장O) - 이름을 붙여서 저장함.
-- 1.2.2. Inline View(저장X) - From 절 뒤에 적는 서브쿼리
-- 
-- 1.3. 특징
-- 1.3.1. 주의사항 : VIEW를 만들 때에는 권한이 필요함(GRANT CREATE VIEW TO 계정;)
-- 1.3.2. 테이블에 있는 데이터를 보여줄 뿐이며, 데이터 자체를 포함하고 있는 것은 아님. 
-- 1.3.3. 저장 장치 내에 물리적으로 존재하지 않고, 가상 테이블로 만들어짐
-- 1.3.4. 물리적인 실제 테이블과의 링크 개념임
-- 1.3.5. 컬럼에 산술처리도 가능함(EX. SALARY*12)
-- 1.3.6. JOIN을 활용한 VIEW 생성 가능
-- 1.3.7. VIEW를 수정하면 원본도 수정됨!!
-- 
-- 1.4. 목적
-- 1.4.1. 원본 테이블이 아닌 뷰를 통해 특정 데이터만 보이도록 함. 
-- 1.4.2. 특정 사용자가 원본 테이블에 접근하여 모든 데이터를 보게 하는 것을 방지함
--
-- 1.5. 옵션
-- 1.5.1. OR REPLACE : 수정할 때 사용하는 옵션
-- 1.5.2. FORCE/NOFORCE : 기본 테이블에 존재하지 않더라도 뷰를 생성하는 옵션
-- 1.5.3. WITH CHECK OPTION : WHERE 조건에 사용한 컬럼의 값을 수정하지 못하게 하는 옵션
-- 1.5.4. WITH READ ONLY : VIEW에 대해 조회만 가능하며 DML을 불가능하게 하는 옵션
--        - 쿼리의 제일 마지막에 붙여줌
-- 
-- 2. SEQUECE 객체
        SELECT * FROM USER_TCL;
-- USER_NO 컬럼에 저장되는 데이터는 1부터 시작하여 1씩 증가함. 
-- 일용자일때는 1, 이용자일때는 2,...
-- USER_NO 컬럼에 들어가는 데이터는 누군가 기억하고 있어야 함. 
-- 마지막 번호가 몇번이었는지 몇씩 증가해서 들어가야하는지를 기억하고 있어야 함.
-- 그런 역할을 하는 것이 바로바로 SEQUENCE임.

-- 2.1. 개요
-- 2.1.1. 순차적으로 정수 값을 자동으로 생성하는 객체, 자동 번호 발생기(채번기)의 역할을 함. 
-- 2.1.2. 사용법 : CREATE SEQUENCE 시퀀스명; -> 기본값으로부터 생성(1부터 1씩 증가)
-- 2.2. SEQUENCE 옵션
-- 2.2.1. MINVALUE : 발생시킬 최소값 지정
-- 2.2.2. MAXVALUE : 발생시킬 최대값 지정
-- 2.2.3. START WITHE : 처음 발생시킬 시작값 지정, 기본값 1
-- 2.2.4. INCREMENT BY : 다음 값에 대한 증가치, 기본값 1
-- 2.2.5. NOCYCLE : 시퀀스 값이 최대값까지 증가를 완료하면 CYCLE은 START WITH로 다시 시작한다. 
-- 2.2.6. NOCACHE : 메모리 상에서 시퀀스값을 관리, 기본값 20, NOCACHE를 안하면 갑자기 시퀀스값이 증가하게 됨.
--
-- 2.3. SEQUENCE 사용방법
-- 2.3.1. 문법
--      CREATE SEQUENCE 시퀀스명
--      MINVALUE 1
--      MAXVALUE 100000
--      START WITH 1
--      INCREMENT BY 1
--      NOCYCLE
--      NOCACHE
-- 2.3.2. 사용법
--      시퀀스명.NEXTVAL 또는 시퀀스명.CURRVAL을
--      SELECT의 뒤 또는 INSERT INTO VALUES의 전달값으로 작성
-- 2.3.3. 수정

-------------------------------------------------------------------------------
-- [KH계정에 VIEW를 생성할 수 있는 권한을 부여]
GRANT CREATE VIEW TO KH;

--------------------------------------------------------------------------------
-- 1.2.1. Stored View(저장O) - 이름을 붙여서 저장함.
--------------------------------------------------------------------------------
-- [VIEW 생성] : 별칭을 지정할 수 있음. 
CREATE VIEW EMP_VIEW
AS SELECT EMP_ID "아이디", DEPT_CODE "부서명", JOB_CODE, MANAGER_ID "매니저"
FROM EMPLOYEE;

-- [생성된 VIEW 결과 확인]
SELECT * FROM EMP_VIEW;

-- [생성된 VIEW 삭제]
DROP VIEW EMP_VIEW;

--------------------------------------------------------------------------------
-- 1.2.2. Inline View(저장X) - From 절 뒤에 적는 서브쿼리
--------------------------------------------------------------------------------
SELECT * FROM (SELECT EMP_ID , DEPT_CODE , JOB_CODE, MANAGER_ID
FROM EMPLOYEE);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- ex) 연봉정보를 가지고 있는 VIEW를 생성하시오.(ANNUAL_SALARY_VIEW)
-- 사번, 이름, 급여, 연봉
--------------------------------------------------------------------------------

CREATE VIEW ANNUAL_SALARY_VIEW(사번, 이름, 급여, 연봉)
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 FROM EMPLOYEE;

SELECT * FROM ANNUAL_SALARY_VIEW;

--------------------------------------------------------------------------------
-- ex) 전체 직원의 사번, 이름, 직급명, 부서명, 지역명을 볼 수 있는 VIEW를 생성하시오(ALL_INFO_VIEW)
--------------------------------------------------------------------------------
CREATE VIEW ALL_INFO_VIEW(사번, 이름, 직급명, 부서명, 지역명)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

SELECT * FROM ALL_INFO_VIEW;
--------------------------------------------------------------------------------
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE;
SELECT * FROM V_EMPLOYEE;
--------------------------------------------------------------------------------
-- 선동일의 DEPT_CODE를 D8로 바꾸는 DML을 작성하시오. 
--------------------------------------------------------------------------------
UPDATE V_EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE EMP_NAME IN ('선동일');

SELECT * FROM EMPLOYEE;

-- VIEW를 수정했더니 원본도 수정됨..
-- VIEW와 원본은 링크가 되어있어서 VIEW수정시 원본도 수정됨.
-- 확인했으면 ROOLBACK!
ROLLBACK;
--------------------------------------------------------------------------------
-- 1.5. 옵션
-- 1.5.1. OR REPLACE : 수정할 때 사용하는 옵션
-- 기존VIEW에 컬럼을 추가하여 만들고 싶다면?????
--------------------------------------------------------------------------------
-- 1안) 지우고 만들기
    DROP VIEW V_EMPLOYEE;

    CREATE VIEW V_EMPLOYEE
    AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
    FROM EMPLOYEE;

    SELECT * FROM V_EMPLOYEE;
--------------------------------------------------------------------------------
-- 2안) 수정하기
    CREATE OR REPLACE VIEW V_EMPLOYEE
    AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
    FROM EMPLOYEE;

    SELECT * FROM V_EMPLOYEE;
--------------------------------------------------------------------------------
-- 1.5.3. WITH CHECK OPTION : WHERE 조건에 사용한 컬럼의 값을 수정하지 못하게 하는 옵션
--------------------------------------------------------------------------------
    CREATE OR REPLACE VIEW V_EMPLOYEE
    AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
    FROM EMPLOYEE WITH READ ONLY;
    
        SELECT * FROM V_EMPLOYEE;

     UPDATE V_EMPLOYEE
     SET EMP_NAME = '선동열'  
     WHERE EMP_ID = '200';
--ORA-42399: cannot perform a DML operation on a read-only view

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- @실습예제1
-- KH계정 소유의 한 EMPLOYEE, JOB, DEPARTMENT 테이블의 일부 정보를 사용자에게 공개하려고 한다.
-- 사원아이디, 사원명, 직급명, 부서명, 관리자명, 입사일의 컬럼정보를 뷰(V_EMP_INFO)를 (읽기 전용으로)
-- 생성하여라.
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
    CREATE OR REPLACE VIEW V_EMP_INFO 
    AS SELECT
        EMP_ID "사번", 
        EMP_NAME "이름", 
        JOB_NAME "직급", 
        NVL(DEPT_TITLE, '미정') "부서", 
        NVL((SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID), '없음') "담당 매니저", 
        HIRE_DATE "입사일"
    FROM EMPLOYEE E 
    LEFT JOIN JOB USING(JOB_CODE)
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WITH READ ONLY;

DROP VIEW V_EMP_INFO;
SELECT * FROM V_EMP_INFO;
--------------------------------------------------------------------------------
-- [데이터 딕셔너리(DD, DATA DICTIONARY)]
-- -> DBMS 설치할 때 자동으로 만들어지며 자원을 효율적으로 관리하기 위해
--    다양한 정보를 저장한 시스템 테이블
-- -> 데이터 딕셔너리는 사용자가 테이블을 생성하거나 사용자를 변경하는 등의
--    작업을 할 때 데이터베이스 서버(오라클)에 의해 자동으로 갱신되는 테이블임.
--    사용자는 데이터 딕셔너리의 내용을 직접 수정하거나 삭제할 수 없음.
-- -> 데이터 딕셔너리 안에는 중요한 정보가 많이 있기 떄문에 사용자가 이를 활용하려면
--    데이터 딕셔너리 뷰를 사용하게 됨. 
-- [데이터 딕셔너리의 종류]
-- 1. USER_XXX : 접속한 계정이 소유한 객체 등에 관한 정보를 조회함.
        SELECT * FROM USER_VIEWS;
        SELECT * FROM USER_CONSTRAINTS;
        SELECT * FROM USER_SYS_PRIVS;
        SELECT * FROM USER_ROLE_PRIVS;
-- 2. ALL_XXX : 접속한 계정이 권한 부여 받은 것과 소유한 모든 것에 관한 정보를 조회함.
        SELECT * FROM ALL_TABLES;
        SELECT * FROM ALL_VIEWS;
-- 3. DBA_XXX : 데이터베이스 관리자만 접근이 가능한 객체 등의 정보 조회
        SELECT * FROM DBA_TABLES;

--------------------------------------------------------------------------------
-- SEQUECE 객체
        SELECT * FROM USER_TCL;
-- USER_NO 컬럼에 저장되는 데이터는 1부터 시작하여 1씩 증가함. 
-- 일용자일때는 1, 이용자일때는 2,...
-- USER_NO 컬럼에 들어가는 데이터는 누군가 기억하고 있어야 함. 
-- 마지막 번호가 몇번이었는지 몇씩 증가해서 들어가야하는지를 기억하고 있어야 함.
-- 그런 역할을 하는 것이 바로바로 SEQUENCE임.
--------------------------------------------------------------------------------
    CREATE SEQUENCE SEQ_KH_USER_NO
    MINVALUE 1
    MAXVALUE 100000
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
    
    DROP SEQUENCE SEQ_KH_USER_NO;
    SELECT * FROM USER_SEQUENCES;
    
    
    SELECT SEQ_KH_USER_NO.NEXTVAL FROM DUAL;  -- 첫 nextval은 시퀀스를 개시함. 필수조건
    
    SELECT SEQ_KH_USER_NO.CURRVAL FROM DUAL;  -- nextval을 실행한 후 현재 시퀀스값 조회
    
    SELECT * FROM USER_TCL;
    DELETE FROM USER_TCL;
    COMMIT;
    
    INSERT INTO USER_TCL
    VALUES(SEQ_KH_USER_NO.NEXTVAL, 'khuser01', '일용자');
    INSERT INTO USER_TCL
    VALUES(SEQ_KH_USER_NO.NEXTVAL, 'khuser02', '이용자');
    INSERT INTO USER_TCL
    VALUES(SEQ_KH_USER_NO.NEXTVAL, 'khuser03', '삼용자');
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- @실습문제1
-- 고객이 상품주문시 사용할 테이블 ORDER_TBL을 만들고, 다음과 같이 컬럼을 구성하세요.

-- ORDER_NO(주문NO) : NUMBER, PK
-- USER_ID(고객아이디) : VARCHAR2(40)
-- PRODUCT_ID(주문상품 아이디) : VARCHAR2(40)
-- PRODUCT_CNT(주문갯수) : NUMBER
-- ORDER_DATE : DATE, DEFAULT SYSDATE

-- SEQ_ORDER_NO 시퀀스를 생성하여 다음의 데이터를 추가하세요.
-- * kang님이 saewookkang상품을 5개 주문하셨습니다.
-- * gam님이 gamjakkang상품을 30개 주문하셨습니다.
-- * ring님이 onionring상품을 50개 주문하셨습니다.
--------------------------------------------------------------------------------
CREATE TABLE ORDER_TBL(
    ORDER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(40),
    PRODUCT_ID VARCHAR2(40),
    PRODUCT_CNT NUMBER,
    ORDER_DATE DATE DEFAULT SYSDATE
    );
COMMENT ON COLUMN ORDER_TBL.ORDER_NO IS '주문NO';
COMMENT ON COLUMN ORDER_TBL.USER_ID IS '고객아이디';
COMMENT ON COLUMN ORDER_TBL.PRODUCT_ID IS '주문상품 아이디';
COMMENT ON COLUMN ORDER_TBL.PRODUCT_CNT IS '주문갯수';
COMMENT ON COLUMN ORDER_TBL.ORDER_DATE IS '주문날짜';

DESC ORDER_TBL;

    DROP SEQUENCE SEQ_ORDER_NO;
-- 시퀀스 생성
    CREATE SEQUENCE SEQ_ORDER_NO
    MINVALUE 1
    MAXVALUE 100000
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
    DROP SEQUENCE SEQ_ORDER_NO;
    SELECT * FROM USER_SEQUENCES;
    DESC ORDER_TBL;
    
INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'kang', 'saewookkang', 5, DEFAULT);

select * from order_tbl;

INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'gam', 'gamjakkang', 30, DEFAULT);

INSERT INTO ORDER_TBL
VALUES(SEQ_ORDER_NO.NEXTVAL, 'ring', 'onionring', 50, DEFAULT);

select * from order_tbl;

commit;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- @실습문제2
-- KH_MEMBER 테이블을 생성하세요
-- 컬럼 : MEMBER_ID, MEMBER_NAME, MEMBER_AGE, MEMBER_JOIN_COM
-- 자료형 : NUMBER, VARCHAR2(20), NUMBER, NUMBER
-- 1. ID값은 500번부터 시작하여 10씩 증가하여 저장
-- 2. JOIN_COM값은 1번부터 시작하여 1씩 증가하여 저장
-- MEMBER_ID    MEMBER_NAME     MEMBER_AGE      MEMBER_JOIN_COM
--  500             홍길동         20                  1
--  510             청길동         30                  2
--  520             외길동         40                  3
--  530             고길동         50                  4
--------------------------------------------------------------------------------
CREATE TABLE KH_MEMBER(
    MEMBER_ID NUMBER,
    MEMBER_NAME VARCHAR2(20),
    MEMBER_AGE NUMBER,
    MEMBER_JOIN_COM NUMBER
    );
    
select * from KH_MEMBER;

    CREATE SEQUENCE SEQ_KH_MEMBER_ID
    MINVALUE 500
    MAXVALUE 100000000
    START WITH 500
    INCREMENT BY 10
    NOCYCLE
    NOCACHE;

    
    CREATE SEQUENCE SEQ_KH_MEMBER_JOIN_COM
    MINVALUE 1
    MAXVALUE 100000000
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
    
    INSERT INTO KH_MEMBER
    VALUES(SEQ_KH_MEMBER_ID.NEXTVAL, '홍길동', '20', SEQ_KH_MEMBER_JOIN_COM.NEXTVAL);
    INSERT INTO KH_MEMBER
    VALUES(SEQ_KH_MEMBER_ID.NEXTVAL, '청길동', '30', SEQ_KH_MEMBER_JOIN_COM.NEXTVAL);
    INSERT INTO KH_MEMBER
    VALUES(SEQ_KH_MEMBER_ID.NEXTVAL, '외길동', '40', SEQ_KH_MEMBER_JOIN_COM.NEXTVAL);
    INSERT INTO KH_MEMBER
    VALUES(SEQ_KH_MEMBER_ID.NEXTVAL, '고길동', '50', SEQ_KH_MEMBER_JOIN_COM.NEXTVAL);
    
    SELECT * FROM KH_MEMBER;
--------------------------------------------------------------------------------
SELECT * FROM KH_MEMBER;
COMMIT;

-- 2.4. 시퀀스 수정
-- ALTER를 이용해서 옵션들을 수정하면 됨.
ALTER SEQUENCE SEQ_KH_MEMBER_ID
-- START WITH 변경 불가 -> 삭제 후 다시 생성
INCREMENT BY 10
MAXVALUE 100000000000;

ROLLBACK;

SELECT * FROM user_sequences;
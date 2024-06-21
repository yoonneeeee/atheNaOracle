-- 24.06.21 SQL 7일차_01.오라클 객체 - Role
-- 오라클 객체
-- DB를 효율적으로 관리 또는 동작하게 하는 요소
-- 오라클 객체의 종류 
-- 사용자(user), 테이블(table), 뷰(view), 시퀀스(sequence), 역할(role), 인덱스(index)
-- 프로시저(procedual), 함수(function), 트리거( trigger), 동의어(sysonym), 
-- 커서 (cursor), 패키지(package)...

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

-- 3. ROLE
-- 3.1. 개요
-- 3.1.1. 사용자에게 여러 개의 권한을 한번에 부여할 수 있는 데이터베이스 객체
-- 3.1.2. 사용자에게 권한을 부여할 때 한개 씩 부여하게 된다면 권한 부여 및 회수의 관리가
--        불편하므로 사용하는 객체임

-- 4. INDEX
-- 4.1. 개요
-- 4.1.1. SQL 명령문의 처리속도를 향상시키기 위해서 컬럼에 대해 생성하는 오라클 객체
-- 4.1.2. KEY와 VALUE 형태로 생성이 되며 KEY에는 인덱스로 만들 컬럼값
--        VALUE에는 행이 저장된 주소값이 저장됨. 
-- 4.1.3.1. 장점 : 검색속도가 빨라지고 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킬 수 있음. 
-- 4.1.3.2. 단점 : 인덱스를 위한 추가 저장 공간이 필요하고 인덱스를 생성하는 데 시간이 걸림.
--                 데이터의 변경 작업이 자주 일어나는 테이블에 INDEX 생성 시 오히려 성능저하가 발생 할 수 있음. 
       -- [어떤 컬럼에 인덱스를 만들면 좋을까?]
       -- 데이터 값이 중복된 것이 없는 고유한 데이터값을 가지는 컬럼에 만드는 것이 가장 좋음
       -- 그리고 자주 사용되는 컬럼에 만들면 좋음! 절대벅이지는 않음
       -- [효율적인 인덱스 사용 예]
       -- 1. WHERE절에 자주 사용되는 컬럼에 인덱스 생성
       --  > 전체 데이터 중에 10 ~ 15% 이내의 데이터를 검색하는 경우, 중복이 많지 않은 컬럼이어야 함.
       -- 2. 두 개 이상의 컬럼 WHERE절이나 조인(JOIN)조건으로 자주 사용되는 경우
       -- 3. 한번 입력된 데이터의 변경이 자주 일어나지 않는 경우
       -- 4. 한 테이블에 저장된 데이터 용량이 상당히 클 경우
--------------------------------------------------------------------------------
/*
    DCL(Data Control Language) : GRANT 'REVOKE
    권한 부여 및 회수는 관리자 세션(빨간색)에서 사용 가능
    관리자 계정
    1) SYSTEM : 일반 관리자, 대부분의 권한을 가지고 있음.
    2) SYS : DB  생성/삭제 권한이 있음. 로그인 옵션으로 AS SYSDBA를 적어줘야 함.
*/
SELECT * FROM DBA_SYS_PRIVS 
ORDER BY 2 ASC;  -- 시스템 계정으로 조회해야 조회 가능...
GRANT CONNECT, RESOURCE TO KH;
-- CONNET, RESOURCE 는 권한이 모여있는 ROLE 이다.
-- ROLE에 부여된 시스템 권한 확인

SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'CONNECT';  --KH계정에서 사용
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT';  -- 관리자 계정에서 사용
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE';  -- 관리자 계정에서 사용
-- CREATE VIEW 권한이 RESOUCE ROLE에 없었기 때문에 따로 권한 부여를 해줌
-- GRANT CREATE VIEW TO KH;

SELECT * FROM ROLE_SYS_PRIVS WHERE ROLE = 'CONNECT';  --KH계정에서 사용
-- ROLE에 부여된 테이블 권한
SELECT * FROM ROLE_TAB_PRIVS;
-- 계정에 부여된 롤과 권한 확인
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM USER_SYS_PRIVS;
--------------------------------------------------------------------------------
-- INDEX

SELECT * FROM EMPLOYEE;

-- 인덱스 생성
CREATE INDEX IND_EMP_ENAME
ON EMPLOYEE(EMP_NAME);

SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;

DROP INDEX IND_EMP_ENAME;

CREATE INDEX IND_EMP_INFO
ON EMPLOYEE(EMP_ID, EMP_NO, SALARY);

SELECT EMP_ID, EMP_NO, SALARY FROM EMPLOYEE;
-- 튜닝 시 사용되는 명령어
-- 1)
        EXPLAIN PLAN FOR
        SELECT EMP_ID, EMP_NO, SALARY
        FROM EMPLOYEE
        WHERE EMP_ID = '2%';  -- 결과 : 설명되었씁니다. 
        
        SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- 2)
    SET TIMING ON;
    SELECT EMP_ID, EMP_NO, SALARY
    FROM EMPLOYEE
    WHERE EMP_ID LIKE '2%'; -- 블록잡고 'F10' 눌러보기
    SET TIMING OFF;
    -- F10으로 실행하여 오라클 PLAN 확인 가능, 튜닝시 사용됨.
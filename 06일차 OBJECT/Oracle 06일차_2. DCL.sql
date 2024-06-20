-- 2024.06.19 SQL 6일차_02. DCL, TCL

-- 1. TCL(Transaction Control Language)
-- 1.1. 종류 : COMMIT, ROLLBACK, SAVEPOINT
-- 1.2. 정의 : 트랜젝션이란?
--             - 한꺼번에 수행되어야 할 최소의 작업 단위를 말함. 
--             - ex) ATM 출금, 계좌이체 등이 트랜젝션의 예
--                  1) 카드 투입
--                  2) 메뉴 선택
--                  3) 금액 입력
--                  4) 비밀번호 입력
--                  5) 출금 완료
--             - ex) 계좌이체
--                  1. 송금 버튼 터치
--                  2. 계좌번호 입력
--                  3. 은행명 선택
--                  4. 금액 입력
--                  5. 비밀번호
--                  6. 이체 버튼 터치
-- 1.2.1. ORACLE DBMS 트랜젝션?
--        INSERT 수행 OR UPDATE 수행 OR DELETE수행이 되었다면 그 뒤에 추가 작업이 
--        있을 것으로 간주하고 처리 -> 트랜젝션이 걸렸다. 
-- 1.3. TCL 명령어
-- 1.3.1. COMMIT : 트랜젝션 작업이 정상 완료되어 변경 내용을 영구히 저장(모든 savepoint 삭제)
-- 1.3.2. ROLLBACK : 트랜젝션 작업을 모두 취소하고 가장 최근 commit 시점으로 이동.
-- 1.3.3. SAVEPOINT <savepoint명> : 현재 트랜젝션 작업 시점이 이름을 지정함.(임시서장이라고도 함)
--        하나의 트랜젝션에서 구역을 나눌 수 있음.
--------------------------------------------------------------------------------
-- 2. DCL(Data Control Language)
-- 2.1. 정의 : DB에 대한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어이다.
-- 2.2. 종류 : Grant, revoke( commit, rollback)
-- 2.2.1. GRANT : 권한의 부여 : 시스템 계정에서만 가능
-- 2.2.2. REVOKE : 부여한 권한의 회수 : 시스템 계정에서만 가능
-- 2.3. 특징 
-- 2.3.1. 권한 부여 및 회수는 system 계정에서만 가능(red)


--------------------------------------------------------------------------------
DROP TABLE USER_TCL;
CREATE TABLE USER_TCL(
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(30) PRIMARY KEY,
    USER_NAME VARCHAR2(20) NOT NULL );
    
DESC USER_TCL;

INSERT INTO USER_TCL
    VALUES(1, 'khuser01', '일용자');
    COMMIT;
    INSERT INTO USER_TCL
    VALUES(2, 'khuser02', '이용자');
    COMMIT;
    INSERT INTO USER_TCL
    VALUES(3, 'khuser03', '삼용자');

SAVEPOINT YOON;  -- 임시 저장 : Savepoint이(가) 생성되었습니다.

    INSERT INTO USER_TCL
    VALUES(4, 'khuser04', '사용자');
    
SELECT * FROM USER_TCL;
ROLLBACK TO YOON; -- SAVE POINT로 이동, 이름은 아무거나 지정해도 됨ㅎ 

ROLLBACK;  -- 최종 커밋한 시점으로 이동, SAVEPOINT 삭제
COMMIT;
--------------------------------------------------------------------------------
-- 1.3. TCL 명령어 TEST
--------------------------------------------------------------------------------
-- 1용자 추가 후, COMMIT한 뒤에
-- 2용자 추가를 하고 

-- 3용자까지 추가한 뒤, SAVEPOINT 설정 후 4용자를 추가하고

-- 이전에 설정한 SAVEPOINT로 가면 3용자까지 밖에 보이지 않음. 
-- 이때 롤백으로 이동하면, 최종 커밋 시점인 일용자 추가한 상태로 되돌아감

-- 단, 세이브 포인트 설정 한 뒤 4용자 추가 후 COMMIT을 한 뒤에
-- 세이브 포인트로 이동하면 오류남!

-- => COMMIT 최종저장 상태 ; 아무리 그 전에 SAVEPOINT(임시저장)을 해놔도 COMMIT한 게 최종 상태임
--------------------------------------------------------------------------------
DESC USER_GRADE;
ALTER TABLE USER_GRADE
DROP COLUMN REG_DATE;
INSERT INTO USER_GRADE
VALUES(10, '일반회원');

COMMIT;
ROLLBACK;


--------------------------------------------------------------------------------
-- 2. DCL(Data Control Language)
-- 2.1. 정의 : DB에 대한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어이다.
-- 2.2. 종류 : Grant, revoke( commit, rollback)
-- 2.2.1. GRANT : 권한의 부여 : 시스템 계정에서만 가능
-- 2.2.2. REVOKE : 부여한 권한의 회수 : 시스템 계정에서만 가능
--------------------------------------------------------------------------------
SELECT * FROM CHUN.TB_CLASS;
-- KH에게 CHUN에 있는 TB_CLASS를 조회할 권한이 없음..
-- 권한 부여를 해야지만 조회가 가능함 
-- [권한부여 @SYSTEM계정]
GRANT SELECT ON CHUN.TB_CLASS TO KH;
-- [권환회수 @SYSTEM계정] 권환 회수하여 조회 차단함.
REVOKE SELECT ON CHUN.TB_CLASS FROM KH;

SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM USER_SYS_PRIVS;
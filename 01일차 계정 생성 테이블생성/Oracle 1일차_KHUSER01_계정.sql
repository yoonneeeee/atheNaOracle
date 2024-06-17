show user;

-- 1. 컬럼의 데이터 타입없이 테이블을 생성하여 오류남
-- -> 데이터 타입 작성
-- 2. 권한이 없는 상태에서 테이블을 생성하여 오류남
-- -> System_계정에서 RESOURCE 권한 부여
-- 3. KHUSER 접속 해제 후, 새로운 워크시트 말고 기존 워크시트에서 우측 상단 접속을 선택하여
-- -> 명령어 재실행

-- 데이터베이스에 테이블을 만들었다..
CREATE TABLE EMPLOYEE(
    NAME VARCHAR2(20),
    T_CODE VARCHAR2(10),
    D_CODE VARCHAR2(10),
    AGE NUMBER
);
SELECT * FROM EMPLOYEE;
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('일용자', 'T1', 'D1', 33);
INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('이용자', 'T2', 'D2', 44);
INSERT INTO EMPLOYEE
VALUES('삼용자', 'T1', 'D2', 32);

DROP TABLE EMPLOYEE;
-- 테이블까지 완전히 없애는 것
DELETE FROM EMPLOYEE;
-- 테이블 안의 내용을 모두 지우는 것
DELETE FROM EMPLOYEE WHERE NAME = '이용자' AND D_CODE = 'D2';
-- 일부 선택하여 내용을 지우는 것
UPDATE EMPLOYEE SET T_CODE = 'T3';
-- T-CODE 부분 모두 변경
UPDATE EMPLOYEE SET T_CODE = 'T3' WHERE NAME = '일용자';
-- 일용자란 이름을 가진 사람의 T_CODE만 지정하여 수정
SELECT NAME, T_CODE, D_CODE, AGE From EMPLOYEE
where name = '일용자';
-- 일용자의 이름을 가진 사람의 정보 조회

select * from employee;
-- 전체 내용 조회


-- 이름이 STUDENT_TBL인 테이블을 만드세요. 
-- 이름, 나이, 학년, 주소를 저장할 수 있도록 하며
-- 일용자 21, 1, 서울시 중구를 저장해주세요. 
-- 일용자를 사용자로 바꿔주세요. 
-- 데이터를 삭제하는 쿼리문을 작성하고 작동를 확인하시고
-- 테이블을 삭제하는 쿼리문을 작성하여 테이블이 사라진 것을 확인하세요. 

CREATE TABLE STUDENT_TBL(
    NAME VARCHAR2(20),
    AGE NUMBER,
    GRADE NUMBER,
    ADDRESS VARCHAR2(20)
);

SELECT * FROM STUDENT_TBL;
ROLLBACK;
INSERT INTO STUDENT_TBL(NAME, AGE, GRADE, ADDRESS)
VALUES('일용자', 21, 1, '서울시 중구');
INSERT INTO STUDENT_TBL(NAME, AGE, GRADE, ADDRESS)
VALUES('이용자', 22, 2, '서울시 광진구');
COMMIT;
UPDATE STUDENT_TBL SET NAME = '사용자' WHERE NAME = '일용자';

DELETE FROM STUDENT_TBL;
-- 테이블 안의 내용을 모두 지우는 것

DROP TABLE STUDENT_TBL;
-- 테이블까지 완전히 없애는 것


-- 아이디가 KHUSER02 비밀번호가 KHUSER02인 계정을 생성하고
-- 접속이 되도록하고, 테이블도 만들 수 있도록 하세요. (권한 부여)
CREATE USER KHUSER02 IDENTIFIED BY KHUSER02;
-- 계정 생성
GRANT CONNECT TO KHUSER02;
-- 계정 연결
GRANT RESOURCE TO KHUSER02;
-- 계정 테이블 생성 권한 부여



CREATE USER ATHENA99 IDENTIFIED BY ATHENA99;
SHOW USER;
GRANT CONNECT TO ATHENA99;
GRANT RESOURCE TO ATHENA99;

create table user_no_constraint(
user_no number,
user_id varchar2(20),
user_pwd varchar2(30),
user_name varchar2(30),
user_gender varchar2(20),
user_phone varchar2(30),
user_email varchar2(50)
);













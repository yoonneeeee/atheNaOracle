-- 06/14 --
SELECT * FROM EMPLOYEE;
SELECT * FROM STUDENT_TBL;

CREATE TABLE USER_NO_CONSTRANT(
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

SELECT * FROM USER_NO_CONSTRANT;

-- 1. kuser01, pass01, 일용자, 남, 01028227379, kuser01@gmail.com
INSERT INTO USER_NO_CONSTRANT 
VALUES(1,'kuser01', 'pass01', '일용자', '남', '01028227379', 'kuser01@gmail.com');
ROLLBACK; -- 저장 X
COMMIT; -- 저장 O

-- 제약 조건
INSERT INTO USER_NO_CONSTRANT
VALUES(null, null, '', null, null, null, null);
-- null : 비어있는 것
-- '' : 문자열 안에 아무것도 없는 것

INSERT INTO USER_NO_CONSTRANT
VALUES(2, 'khuer02', null, null, null, null, null); -- 이와 같은 경우를 방지하기 위해 제약 조건이 필요

 -- NULL 방지
CREATE TABLE USER_NOTNULL (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL, -- 컬럼 레벨 방식
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

INSERT INTO USER_NOTNULL
VALUES(2, 'khuer02', null, null, null, null, null); -- 오류 발생, null 값 입력 불가

INSERT INTO USER_NOTNULL
VALUES(2, 'khuer02', 'pass01', '일용자', null, null, null); -- 오류 발생 X

SELECT * FROM USER_NOTNULL;

 -- 중복 방지
CREATE TABLE USER_UNIQUE (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE, 
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

INSERT INTO USER_UNIQUE
VALUES(2, 'khuer02', 'pass01', '일용자', null, null, null); -- 2번 실행 시 중복 데이터 추가 안 됨

-- UNIQUE 제약 조건으로 중복은 막았으나 NULL은 막지 못함
INSERT INTO USER_UNIQUE
VALUES(2, null, 'pass01', '일용자', null, null, null);

-- 중복 방지 & NULL 입력 방지
CREATE TABLE USER_PRIMARY_KEY ( -- 중복 방지 & NULL 입력 방지
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE NOT NULL, 
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

DROP TABLE USER_PRIMARY_KEY;

CREATE TABLE USER_PRIMARY_KEY (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) PRIMARY KEY, 
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);
-- USER_PRIMARY_KEY 테이블 > 모델 선택 시, USER_ID 앞에 P로 표시됨
INSERT INTO USER_PRIMARY_KEY
VALUES(1, null, 'pass01', '일용자', null, null, null); -- 오류 발생

INSERT INTO USER_PRIMARY_KEY
VALUES(2, 'khuser01', 'pass01', '일용자', null, null, null);

CREATE TABLE USER_CHECK (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) PRIMARY KEY, 
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')), -- M 또는 F로 입력해야 함
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50)
);

-- 같은 성별을 다양하게 입력될 수 있음
INSERT INTO USER_CHECK
VALUES(1, 'khuser01', 'pass01', '일용자', '남', null, null);
INSERT INTO USER_CHECK
VALUES(2, 'khuser02', 'pass02', '이용자', '남자', null, null);
INSERT INTO USER_CHECK
VALUES(3, 'khuser03', 'pass03', '삼용자', 'Male', null, null);

DROP TABLE USER_CHECK;

-- CHECK 제약 조건에 맞게 입력하고 실행
INSERT INTO USER_CHECK
VALUES(1, 'khuser01', 'pass01', '일용자', 'M', null, null);

SELECT * FROM USER_CHECK;

-- 지금까지 배운 제약조건
-- NOT NULL : NULL이 못 들어가게 함
-- UNIQUE : 중복이 안되게 함. NULL은 가능
-- PRIMARY KEY : 중복이 안되고 NULL도 안됨. 유일한 값
-- CHECK, CHECK ( 컬럼명 IN (값1, 값2) ) : 저장한 값만 들어가게 함

CREATE TABLE USER_DEFAULT (
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(20) PRIMARY KEY, 
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')), -- M 또는 F로 입력해야 함
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50),
    USER_DATE DATE DEFAULT SYSDATE -- DATE : 년/월/일, 간소화
);

INSERT INTO USER_DEFAULT
VALUES(1, 'khuser01', 'pass01', '일용자', 'M', '01082829292', 'khuser01@gmail.com', '24/06/14');
INSERT INTO USER_DEFAULT
VALUES(2, 'khuser02', 'pass02', '이용자', 'M', '01082829292', 'khuser02@gmail.com', SYSDATE); -- SYSDATE : 현재 날짜

DROP TABLE USER_DEFAULT;

INSERT INTO USER_DEFAULT
VALUES(1, 'khuser01', 'pass01', '일용자', 'M', '01082829292', 'khuser01@gmail.com', '24/06/14');
INSERT INTO USER_DEFAULT
VALUES(2, 'khuser02', 'pass02', '이용자', 'M', '01082829292', 'khuser02@gmail.com', DEFAULT); -- 간소화
INSERT INTO USER_DEFAULT
VALUES(3, 'khuser03', 'pass03', '삼용자', 'M', '01082829292', 'khuser03@gmail.com', SYSDATE + 7);

SELECT * FROM USER_DEFAULT;

-- 제약 조건
-- 1. NOT NULL : 필수(무결성 보장) : null이 들어가지 않게함
-- 2. UNIQUE : 중복이 되지 않게함.
-- 3. PRIMARY KEY : 필수(무결성 보장) : 중복이 안되고 null이 되지 않도록 함
-- 4. CHECK : 지정된 값만 저장하도록 함
-- 5. DEFAULT : 지정된 함수나 표현식으로 실행되도록 함
-- 6. FOREIGN KEY(외래키

CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

SELECT * FROM USER_GRADE;
INSERT INTO USER_GRADE VALUES(10, '일반회원');
INSERT INTO USER_GRADE VALUES(20, '우수회원');
INSERT INTO USER_GRADE VALUES(30, '특별회원');
INSERT INTO USER_GRADE VALUES(40, 'VIP회원');
DELETE FROM USER_GRADE WHERE GRADE_CODE = 40;

CREATE TABLE USER_FOREIGN_KEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER VARCHAR2(10) CHECK(USER_GENDER IN('M', 'F')),
    USER_PHONE VARCHAR2(30),
    USER_EMAIL VARCHAR2(50),
    USER_DATE DATE DEFAULT SYSDATE,
    GRADE_CODE NUMBER REFERENCES USER_GRADE(GRADE_CODE) ON DELETE SET NULL
);

DROP TABLE USER_FOREIGN_KEY;
-- USER_FOREIGN_KEY에 있는 GRADE_CODE는 USER_GRADE의 GRADE_CODE가 가지고 있는 10, 20, 30만 넣을 수 있어요.
-- 10, 20, 30 외에 40은 안돼요. 50도 안돼요

SELECT * FROM USER_FOREIGN_KEY;
INSERT INTO USER_FOREIGN_KEY
VALUES(1, 'khuser01', 'pass01', '일용자', 'M', null, null, DEFAULT, 10);
INSERT INTO USER_FOREIGN_KEY
VALUES(2, 'khuser02', 'pass02', '이용자', 'M', null, null, DEFAULT, 20);
INSERT INTO USER_FOREIGN_KEY
VALUES(3, 'khuser03', 'pass03', '삼용자', 'M', null, null, DEFAULT, 30);
INSERT INTO USER_FOREIGN_KEY
VALUES(4, 'khuser04', 'pass04', '사용자', 'M', null, null, DEFAULT, 40);
UPDATE USER_FOREIGN_KEY
SET GRADE_CODE = null WHERE USER_ID = 'khuser04';
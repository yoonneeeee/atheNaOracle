-- CHUN 04. DDL
-- YOON : 5,6,7,8

--------------------------------------------------------------------------------
-- 4.01. 계열 정보를 저장할 카테고리 테이블을 만들려고 한다. 
-- 다음과 같은 테이블을 작성하시오.
--------------------------------------------------------------------------------
CREATE TABLE TB_CATEGORY(
NAME VARCHAR2(10),
USE_YN CHAR(1) DEFAULT 'Y'
);

--------------------------------------------------------------------------------
-- 4.02. 과목 구분을 저장할 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
--------------------------------------------------------------------------------
CREATE TABLE TB_CLASS_TYPE(
NO VARCHAR2(5) PRIMARY KEY,
NAME VARCHAR2(10)
);

--------------------------------------------------------------------------------
--4.03. TB_CATEGORY 테이블의 NAME 컬럼에 PRIMARY KEY 를 생성하시오.
-- (KEY 이름을 생성하지 않아도 무방함. 
-- 만일 KEY 이름을 지정하고자 한다면 이름은 본인이 알아서 적당한 이름을 사용한다.)
--------------------------------------------------------------------------------
-- PRIMARY KEY 이름을 PK로 지정하였습니다.
ALTER TABLE TB_CATEGORY
ADD CONSTRAINT PK PRIMARY KEY(NAME);

--------------------------------------------------------------------------------
-- 4.04. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오.
--------------------------------------------------------------------------------
ALTER TABLE TB_CLASS_TYPE
MODIFY NAME NOT NULL;
COMMIT;
--------------------------------------------------------------------------------
-- 4.05. 두 테이블에서 컬럼 명이 NO인 것은 기존 타입을 유지하면서 크기는 10으로, 
-- 컬럼명이 NAME인 것은 마찬가지로 기존 타입을 유지하며서 크기 20으로 변경하시오. 
--------------------------------------------------------------------------------
ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CLASS_TYPE 
MODIFY NAME VARCHAR2(20);
ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR2(20);
--------------------------------------------------------------------------------
-- 4.06. 두 테이블의 NO컬럼과 NAME컬럼의 이름을 각 각 TB_를 제외한 
-- 테이블 이름이 앞에 붙은 형태로 변경한다. 
-- EX) CATEGORY_NAME
--------------------------------------------------------------------------------
ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE 
RENAME COLUMN NAME TO CLASS_TYPE_NAME;
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;
--------------------------------------------------------------------------------
-- 4.07. TB_CATAGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 
-- 이름을 다음과 같이 변경하시오.
-- Primary Key 의 이름은 ‚PK_ + 컬럼이름‛ 으로 지정하시오. 
-- (ex. PK_CATEGORY_NAME )
--------------------------------------------------------------------------------
ALTER TABLE TB_CATEGORY
RENAME CONSTRAINT PK TO PK_CATEGORY_NAME;
-- PRIMARY KEY 이름을 PK로 지정하였습니다.

--------------------------------------------------------------------------------
-- 4.08. 다음과 같은 INSERT 문을 수행한다. 
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;
--------------------------------------------------------------------------------
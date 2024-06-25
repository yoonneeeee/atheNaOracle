-- 24.06.24 SQL 8일차_03. 오라클 객체 TRIGGER

-- 트리거 : 방아쇠, 연쇄반응
-- 특정 이벤트나 DDL, DML 문장이 실행되었을 때
-- 자동적으로 일련의 동작(Operation) 처리가 수행되도록 하는 데이터베이스 객체 중 하나임
-- 예시) 회원탈퇴가 이루어진 경우 탈퇴한 회원 정보를 일정기간 저장해야 하는 경우
-- 예시2) 데이터 변경이 있을 때 조작한 데이터에 대한 로그(이력)을 남겨야 하는 경우

-- [정의 및 특징]
-- 트리거(Trigger)는 테이블에서 어떤 이벤트가 발생했을 때 자동으로 실행되는 것을 의미한다. 
-- 예를 들어, 어떤 테이블에서 특정한 이벤트 DML문(update, insert, delete)가 발생했을 때, 
-- 실행시키고자 하는 추가 쿼리 작업들을 자동으로 수행할 수 있게끔 트리거를 미리 설정하는 것이다. 
-- 즉! 사용자가 직접 호출하는 것이 아니라, 데이터베이스에서 자동적으로 호출하는 것이 가장 큰 특징이다. 

-- [트리거 사용 방법]
-- CREATE TRIGGER 트리거명
-- BEFORE (OR AFTER)
-- DELETE (OR UPDATE OF INSERT) ON 테이블명
-- [FOR EACH ROW]
-- BEGIN 
--      (실행문)
-- END;
-- /

--------------------------------------------------------------------------------
-- TRIGGER
-- 예제1. 사원 테이블에 새로운 데이터가 들어오면 '신입사원이 입사하였습니다.'를 출력하기
--------------------------------------------------------------------------------

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, PHONE, JOB_CODE, SAL_LEVEL)
VALUES((SELECT MAX(EMP_ID)+1 FROM EMPLOYEE), '이용자', '00624-3223444', '01028272733', 'J5', 'S5');
-- 트리거 생성 후 지정된 테이블에 명령어를 실행하면 트리거가 동작됨.
-- 신입사원이 입사하였습니다. 
-- 1 행 이(가) 삽입되었습니다. 
CREATE OR REPLACE TRIGGER TRG_EMP_NEW
AFTER 
INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사하였습니다.');
END;
/
-- Trigger TRG_EMP_SALARY이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
-- TRIGGER
-- 예제2. EMPLOYEE 테이블에 급여정보가 변경되면 전후 정보를 화면에 출력하는 트리거를 생성하시오.
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_EMP_SALARY
AFTER
UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF(:OLD.SALARY != : NEW.SALARY) --EMPLOYEE 테이블에서 샐러리가 업데이트 됐을 때만 실행되도록 IF문 추가
    THEN
        DBMS_OUTPUT.PUT_LINE('급여정보가 변경되었습니다. ');
        DBMS_OUTPUT.PUT_LINE('변경 전 : '|| :OLD.SALARY); -- 변경 전 레코드
        DBMS_OUTPUT.PUT_LINE('변경 후 : '|| :NEW.SALARY); -- 변경 후 레코드
    END IF;
END;
/
-- Trigger TRG_EMP_SALARY이(가) 컴파일되었습니다.
UPDATE EMPLOYEE SET SALARY = 2000000 WHERE EMP_ID = '211';
--  급여정보가 변경되었습니다. 
--  변경 전 : 2000000
--  변경 후 : 4000000
--  1 행 이(가) 업데이트되었습니다.
-- 정보가 나오지 않으면 COMMIT 해보기(메모)


ROLLBACK;
SELECT * FROM EMPLOYEE WHERE EMP_ID = '211';

--------------------------------------------------------------------------------
-- 의사레코드 OLD, NEW
-- FOR EACH ROW를 사용
-- 1. INSERT : OLD -> NULL, NEW (올드값은 없고, 뉴만 있음)
-- 2. UPDATE : OLD, NEW (올드, 뉴 둘 다 있음)
-- 3. DELETE : OLD, NEW -> NULL (올드값은 있으나, 뉴값이 없음)
---------------------------------------------------------------------------------- 
-- @실습예제1
-- 1. 제품 PRODUCT 테이블은 숫자로 된 
-- PCODE컬럼이 있고 PRIMARY KEY로 지정, 
-- 문자열 크기 30인 PNAME인 컬럼, 
-- 문자열 크기 30인 BRAND컬럼, 
-- 숫자로 된 PRICE 컬럼, 
-- 숫자로 되어 있고 기본값이 0인 STOCK컬럼이 있음
--------------------------------------------------------------------------------
SELECT *FROM PRODUCT;
DROP TABLE PRODUCT;
CREATE TABLE PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNEME VARCHAR2(30),
    BRAND VARCHAR2(30),
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);
--------------------------------------------------------------------------------
-- 2. 제품 입출고 PRODUCT_IO 테이블은 숫자로 된 IOCODE 컬럼이 있고 PRIMARY KEY로 지정,
-- 숫자로 된 PCODE컬럼, 날짜로 된 PDATE 컬럼, 숫자로된 AMOUNT컬럼, 문자열 크기가 10인
-- STATUS컬럼이 있음. STATUS컬럼은 입고 또는 출고만 입력가능함.
-- PCODE는 PRODUCT 테이블의 PCODE를 참조하여 외래키로 설정되어 있음.
--------------------------------------------------------------------------------
SELECT * FROM PRODUCT_IO;
DROP TABLE PRODUCT_IO;
CREATE TABLE PRODUCT_IO(
    IOCODE NUMBER PRIMARY KEY,
    PCODE NUMBER, --컬럼레벨에서 외래키추가 CONSTRAINT FK_PRODUCT_IO REFERENCES PRODUCT(PCODE) ,
    PDATE DATE,
    AMOUNT NUMBER,
    STATUS VARCHAR2(10) CHECK (STATUS IN('입고', '출고')),
    CONSTRAINT FK_PRODUCT_IO FOREIGN KEY(PCODE) REFERENCES PRODUCT(PCODE)
    );  -- ㄴ>테이블 레벨에서 외래키 추가

--------------------------------------------------------------------------------
-- 3. 시퀀스는 SEQ_PRODUCT_PCODE, SEQ_PRODUCTIO_IOCODE라는 이름으로 기본값으로 설정되어있음.
--------------------------------------------------------------------------------
--DROP SEQUENCE SEQ_PRODUCT_PCODE;
--DROP SEQUENCE SEQ_PRODUCT_PCODE;
CREATE SEQUENCE SEQ_PRODUCT_PCODE
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;
--DROP SEQUENCE SEQ_PRODUCTIO_IOCODE;
CREATE SEQUENCE SEQ_PRODUCTIO_IOCODE
NOCYCLE
NOCACHE;

--------------------------------------------------------------------------------
-- 4. 트리거의 이름은 TRG_PRODUCT 이고 
-- PRODUCT_IO 테이블에 입고를 하면 
-- PRODUCT 테이블에 STOCK 컬럼에 값을 추가하고 
-- PRODUCT_IO 테이블에 출고를 하면 
-- STOCK 컬럼에 값을 빼주는 역할을 함.
--------------------------------------------------------------------------------
DROP TRIGGER TRG_PRODUCT;
CREATE OR REPLACE TRIGGER TRG_PRODUCT
AFTER
INSERT ON PRODUCT_IO --새로 들어가는 것이므로 OLD 없음
FOR EACH ROW
BEGIN   
IF : NEW.STATUS = '입고'
    THEN
        -- INSERT INTO PRODUCT_IO VALUES(1, 1, SYSDATE, 10, '입고');
        UPDATE PRODUCT SET STOCK = STOCK + :NEW.AMOUNT WHERE PCODE = :NEW.PCODE;
    ELSIF : NEW.STATUS = '출고'
    THEN 
        --INSERT INTO PRODUCT_IO VALUES(1, 1, SYSDATE, 5, '출고');
        UPDATE PRODUCT SET STOCK = STOCK - :NEW.AMOUNT WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/


SELECT * FROM PRODUCT;
DESC PRODUCT_IO;

-- 5. 제품 테이블 정보 입력
INSERT INTO PRODUCT VALUES(SEQ_PRODUCT_PCODE.NEXTVAL, '갤럭시폰', '삼성', 2000000, DEFAULT);
INSERT INTO PRODUCT VALUES(SEQ_PRODUCT_PCODE.NEXTVAL, '아이폰', '애플', 2500000, DEFAULT);
INSERT INTO PRODUCT VALUES(SEQ_PRODUCT_PCODE.NEXTVAL, '대륙폰', '샤오미', 2500000, DEFAULT);
DESC PRODUCT;
COMMIT;
--6. 제품 출고 테이블 INSERT -> 입고이면 재고에 +1, 출고이면 재고에 -1
INSERT INTO PRODUCT_IO VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL, 1, SYSDATE, 10, '입고');
INSERT INTO PRODUCT_IO VALUES(SEQ_PRODUCTIO_IOCODE.NEXTVAL, 1, SYSDATE, 5, '출고');
COMMIT;
SELECT * FROM PRODUCT;
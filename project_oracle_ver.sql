-- project DB Script 
--# 작성/검수자 : 박선영, 윤태한, 서창욱, 백희원 
--# 요청 테이블 : 학생테이블, 교수테이블, 학과테이블, 과목테이블, 수강신청 테이블(각 학생별)
--# 설명안)
--    1. 문자열은 제한 varchar2(150)으로 설정(한글로 인한 데이터 크기 고려). 숫자데이터는 number으로 설정.
--    2. 입력 필수 데이터는 not null로 설정.
--    3. 교수테이블에서 학과번호에 대한 null 허용은 학과가 지정되지 않은 교수가 존재하는 경우 고려.
--    4. 트랜잭션 당 commit 처리.
--    5. 필요에 따른 FK 설정 (현재는 설정안함 - 성능, 복잡 문제 고려).
--    6. 학과번호(1 : 컴퓨터공학과), 교수번호(100~), 과목번호(10~), 학번(xxxxxxxxx) 으로 정의.
--    7. 기초데이터란 프로시저 검증을 거치지 않고 임의로 넣은 데이터를 의미.
--    8. 패키지는 사용하지 않는다.
-------------------------------------------
--# 학생테이블
create table student(
  stu_id varchar2(150) not null,
  stu_name varchar2(150),
  stu_password varchar2(150),
  stu_birth varchar2(20),
  stu_number number not null,
  stu_address varchar2(150),
  stu_deptno number not null,
  stu_grade number,
  stu_email varchar2(150),
  stu_phonenumber varchar2(150),
  stu_photo varchar2(150),
  primary key(stu_number)
);

desc student;
select * from student;

drop table student;
delete from student;

commit;
-- $ 기초데이터 삽입
insert into student(stu_id, stu_name, stu_password, stu_birth, stu_number, stu_address, stu_deptno, stu_grade,stu_email, stu_phonenumber, stu_photo) 
values('scw0531', '서창욱','tjckd246!','92/04/06',201158102,'경기도 수원시',1,4,'scw05313315@gmail.com','01042084757','seopicture.png');

commit;
-------------------------------------------
--# 교수테이블
create table professor(
  pro_name varchar2(150),
  pro_number number not null,
  pro_phonenumber varchar2(150),
  pro_id varchar2(150) not null,
  pro_password varchar2(150),
  pro_address varchar2(150),
  pro_deptno number,
  pro_email varchar2(150),
  primary key(pro_number)
);

desc professor;
select * from professor;

drop table professor;
delete from professor;

commit;
-- $ 기초데이터 삽입
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('홍길동', 100, '01011112222', 'pro123', 'pro123', '서울특별시 강남구', 1, 'pro123@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('임꺽정', 101, '01022223333', 'pro456', 'pro456', '서울특별시 종로구', 1, 'pro456@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('김철수', 102, '01044445555', 'pro789', 'pro789', '서울특별시 금천구', 1, 'pro789@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('김영희', 103, '01066667777', 'pro987', 'pro987', '서울특별시 강동구', 1, 'pro987@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('나철수', 104, '01088889999', 'pro654', 'pro654', '서울특별시 강북구', 1, 'pro654@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('나영희', 105, '01012121212', 'pro432', 'pro432', '서울특별시 강서구', 1, 'pro432@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('박철수', 106, '01023232323', 'pro111', 'pro111', '서울특별시 중구', 1, 'pro111@gmail.com');
commit;
-------------------------------------------
--# 학과테이블
create table department(
  dept_no number,
  dept_name varchar2(150) not null,
  primary key(dept_no)
);

desc department;
select * from department;

drop table department;

commit;
-- $ 기초데이터 삽입
insert into department(dept_no, dept_name) values(1, '컴퓨터공학과');
insert into department(dept_no, dept_name) values(2, '경영학과');

commit;
-------------------------------------------
--# 과목테이블
create table course(
  c_number number,
  c_name varchar2(150),
  c_date_time varchar2(150),
  c_grade number,
  pro_number number,
  dept_no number,
  primary key(c_number, c_date_time) 
);

desc course;
select * from course;

drop table course;
delete from course;

commit;
-- $ 기초데이터 삽입
-- *1 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(10, 'Introduction to Computer Engineering', 3, 'Mon|1',100, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(10, 'Introduction to Computer Engineering', 3, 'Mon|2',100);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(10, 'Introduction to Computer Engineering', 3, 'Wed|3',100);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(10, 'Introduction to Computer Engineering', 3, 'Wed|4',100);
-- *2 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(11, 'Database', 3, 'Mon|3',101);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(11, 'Database', 3, 'Mon|4',101);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(11, 'Database', 3, 'Wed|1',101);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(11, 'Database', 3, 'Wed|2',101);
-- *3 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(12, 'algorithm', 3, 'Tue|1',102);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(12, 'algorithm', 3, 'Tue|2',102);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(12, 'algorithm', 3, 'Thu|3',102);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(12, 'algorithm', 3, 'Thu|4',102);
-- *4 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(13, 'Java programming', 3, 'Tue|3',103);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(13, 'Java programming', 3, 'Tue|4',103);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(13, 'Java programming', 3, 'Thu|1',103);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(13, 'Java programming', 3, 'Thu|2',103);
-- *5 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(14, 'Artificial intelligence', 3, 'Mon|1',104);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(14, 'Artificial intelligence', 3, 'Mon|2',104);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(14, 'Artificial intelligence', 3, 'Mon|3',104);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(14, 'Artificial intelligence', 3, 'Mon|4',104);
-- *6 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(15, 'Web Programming', 3, 'Thu|1',105);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(15, 'Web Programming', 3, 'Thu|2',105);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(15, 'Web Programming', 3, 'Thu|3',105);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(15, 'Web Programming', 3, 'Thu|4',105);
-- *7 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(16, 'Logic circuit', 3, 'Mon|7',106);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(16, 'Logic circuit', 3, 'Mon|8',106);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(16, 'Logic circuit', 3, 'Mon|9',106);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number) values(16, 'Logic circuit', 3, 'Mon|10',106);

commit;

-- print course list
SELECT c_number, c_name, c_grade FROM course GROUP BY c_number, c_name, c_grade;
-------------------------------------------
--# 수강신청 등록 테이블
create table enroll(
  stu_number number,
  c_number number,
  c_memo varchar2(150),
  primary key(stu_number, c_number)
);

desc enroll;
select * from enroll;

drop table enroll;
delete from enroll;

commit;

-- $ 기초데이터 삽입
insert into enroll(stu_number, c_number, c_memo) values(201158102, 10, '');
insert into enroll(stu_number, c_number, c_memo) values(201158102, 11, '');
-------------------------------------------
--# 나의 수강신청 목록 출력
SELECT c.c_number, c.c_name, c.c_date_time, c.c_grade, e.c_memo FROM course c, enroll e WHERE c.c_number = e.c_number;
-------------------------------------------
--# 특정 수강신청 과목에 대한 정보 출력
SELECT c.c_number, c.c_date_time FROM course c WHERE c.c_number = 14;
-------------------------------------------
--# 나의 수강신청 목록 개수 구하기
SELECT COUNT(*) AS course_count FROM enroll;
-------------------------------------------
--# 수강신청과목 리스트 개수 구하기
select COUNT(*) AS count_col from (SELECT COUNT(*) AS col_count FROM course GROUP BY c_number, c_name, c_grade);
-------------------------------------------
--# 로그인 관련 프로시저
--$ 기능 : 로그인 유효성 검사, 아이디 중복검사, 학생등록
create or replace procedure PRO_LOGIN_ENROLL(
  -- 매개변수 선언
  in_pro_type IN number, -- type = 1(로그인 유효검사), type = 2(학생등록), type = 3(아이디 중복검사)
  in_stu_id IN student.stu_id%TYPE,
  in_stu_name IN student.stu_name%TYPE,
  in_stu_password IN student.stu_password%TYPE,
  in_stu_birth IN student.stu_birth%TYPE,
  in_stu_number IN student.stu_number%TYPE,
  in_stu_address IN student.stu_address%TYPE,
  in_stu_deptno IN student.stu_deptno%TYPE,
  in_stu_grade IN student.stu_grade%TYPE,
  in_stu_email IN student.stu_email%TYPE,
  in_stu_phonenumber IN student.stu_phonenumber%TYPE,
  in_stu_photo IN student.stu_photo%TYPE,
  out_result OUT number
)
IS
-- 커서정의, 사용할 변수 정의
v_result_col number;
BEGIN
  IF in_pro_type = 1 THEN
    -- 로그인 유효 검증
    SELECT COUNT(*) INTO v_result_col FROM student
		WHERE stu_id = in_stu_id AND stu_password = in_stu_password;
    IF v_result_col = 1 THEN
      out_result := 1;
    ELSE
      out_result := 0;
    END IF;
    COMMIT;
  -- 학생 등록
  ELSIF in_pro_type = 2 THEN
    INSERT INTO student(stu_id, stu_password,stu_name,stu_birth, stu_number,stu_address,stu_deptno,stu_grade,stu_email,stu_phonenumber,stu_photo ) 
    VALUES(in_stu_id, in_stu_password,in_stu_name,in_stu_birth, in_stu_number, in_stu_address,in_stu_deptno,in_stu_grade,in_stu_email,in_stu_phonenumber,in_stu_photo);
    out_result := 1;
    COMMIT;
  -- 아이디 중복 검사
  ELSIF in_pro_type = 3 THEN
    SELECT COUNT(*) INTO v_result_col FROM student WHERE stu_id = in_stu_id;
    IF v_result_col = 1 THEN
      out_result := 1;
    ELSE
      out_result := 0;
    END IF;
    COMMIT;
  ELSE
    out_result := 0;
    COMMIT;
  END IF;
EXCEPTION -- 예외처리
WHEN OTHERS THEN
  out_result := -1;
  ROLLBACK;
END;

--* 프로시저 실행 (OUT변수 반환)
SET SERVEROUTPUT ON -- dbms_output이 가능하게 해준느 설정
DECLARE
  retval number; -- out변수
BEGIN
  PRO_LOGIN_ENROLL(1, 'scw0531', '서창욱','tjckd246!','92/04/06',201158102,'경기도 수원시',1,4,'scw05313315@gmail.com','01042084757','seopicture.png', retval);
  DBMS_OUTPUT.PUT_LINE('return value: '||retval);
END;
-------------------------------------------
--# 수강신청 관련 프로시저
--$ 기능 : 수강신청, 수강삭제, 수강내역 메모추가
create or replace procedure PRO_COURSE_MANAGE(
   in_pro_type IN number, -- type = 1(신청), type = 2(제거), type = 3(메모추가)
   in_stu_number IN enroll.stu_number%TYPE,
   in_c_number IN enroll.c_number%TYPE,
   in_c_memo IN enroll.c_memo%TYPE,
   out_result OUT number
)
IS
-- 커서정의, 변수정의
BEGIN
  IF in_pro_type = 1 THEN
    -- 신청
    out_result := 1;
    COMMIT;
  -- 신청과목 제거
  ELSIF in_pro_type = 2 THEN
    DELETE FROM enroll 
		WHERE stu_number = in_stu_number AND c_number = in_c_number;
    out_result := sql%rowcount;
    COMMIT;
  -- 메모추가
  ELSIF in_pro_type = 3 THEN
    UPDATE enroll SET c_memo = in_c_memo 
		WHERE stu_number = in_stu_number AND c_number = in_c_number;
    out_result := sql%rowcount;
    COMMIT;
  ELSE
    out_result := 0;
    COMMIT;
  END IF;
EXCEPTION -- 예외처리
WHEN OTHERS THEN
  out_result := -1;
  ROLLBACK;
END;

--* 프로시저 실행 (OUT변수 반환)
SET SERVEROUTPUT ON -- dbms_output이 가능하게 해준느 설정
DECLARE
  retval number; -- out변수
BEGIN
  PRO_COURSE_MANAGE(2,201158102, 11, ' ',  retval); -- 메모추가 경우
  DBMS_OUTPUT.PUT_LINE('return value: '||retval);
END;
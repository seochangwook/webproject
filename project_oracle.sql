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
  stu_gender varchar2(20),
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
insert into student(stu_id, stu_name, stu_password, stu_birth, stu_number, stu_address, stu_deptno, stu_grade,stu_email, stu_phonenumber, stu_photo, stu_gender) 
values('scw0531', '서창욱','ml+NyDubF6ehc9fTbuwhLg==!','92/04/06',201158102,'경기도 수원시',1,4,'scw05313315@gmail.com','01042084757','seopicture.png', '남');

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
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('김가영', '107', '01085462344', 'pro552', 'dsfaspro', '서울특별시 강동구', '2', 'rfesd@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('백아람', '108', '01025455252', 'pro852', 'gfghfpro', '서울특별시 마포구', '3', 'eddd@lotte.net ');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('장한주', '109', '01024324868', 'pro865', 'wdwaaspro', '서울특별시 관악구', '4', 'yhgvcx@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('강우진', '110', '01025254848', 'pro850', 'ghfghpro', '서울특별시 성동구', '5', 'kjhgfd@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('은희수', '111', '01056561519', 'pro120', '1351pro', '서울특별시 중구', '6', 'jhg@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('홍설', '112', '01024484325', 'pro130', '946514pro', '서울특별시 서대문구', '7', 'sdcvjb@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('이경우', '113', '01046674266', 'pro140', '2465146pro', '서울특별시 은평구', '8', 'gfcd@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('양유진', '114', '01044454546', 'pro150', 'ijkpro9ik', '서울특별시 강서구', '9', 'jhrf6@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('홍지원', '115', '01036456484', 'pro160', '7ujkmpro', '서울특별시 구로구', '10', 'jhgf4e@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('강효진', '116', '01033635345', 'pro170', '7ujpro', '서울특별시 강서구', '11', 'yg5r@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('장민수', '117', '01022444414', 'pro180', '9ik7ypro7u', '서울특별시 은평구', '12', 'erfg5v@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('주신영', '118', '01042448458', 'pro190', '9ipro76yh', '서울특별시 송파구', '13', '4ed5rf@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('유진아', '119', '01054554542', 'pro221', '7upro09o', '서울특별시 중랑구', '14', '4r78u@lotte.net');

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
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('3', '문헌정보학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('4', '정보보호학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('5', '생명공학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('6', '멀티미디어학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('7', '간호학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('8', '경제학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('9', '영어영문학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('10', '일어일문학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('11', '중어중문학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('12', '독어독문학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('13', '불어불문학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('14', '유아교육학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('15', '과학교육과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('16', '컴퓨터교육과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('17', '심리학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('18', '범죄심리학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('19', '정치외교학과');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('20', '행정학과');

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
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(10, 'Introduction to Computer Engineering', 3, 'Mon|1',100, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(10, 'Introduction to Computer Engineering', 3, 'Mon|2',100, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(10, 'Introduction to Computer Engineering', 3, 'Wed|3',100, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(10, 'Introduction to Computer Engineering', 3, 'Wed|4',100, 1);
-- *2 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(11, 'Database', 3, 'Mon|3',101, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(11, 'Database', 3, 'Mon|4',101, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(11, 'Database', 3, 'Wed|1',101, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(11, 'Database', 3, 'Wed|2',101, 1);
-- *3 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(12, 'algorithm', 3, 'Tue|1',102, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(12, 'algorithm', 3, 'Tue|2',102, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(12, 'algorithm', 3, 'Thu|3',102, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(12, 'algorithm', 3, 'Thu|4',102, 1);
-- *4 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(13, 'Java programming', 3, 'Tue|3',103, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(13, 'Java programming', 3, 'Tue|4',103, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(13, 'Java programming', 3, 'Thu|1',103, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(13, 'Java programming', 3, 'Thu|2',103, 1);
-- *5 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(14, 'Artificial intelligence', 3, 'Mon|1',104, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(14, 'Artificial intelligence', 3, 'Mon|2',104, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(14, 'Artificial intelligence', 3, 'Mon|3',104, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(14, 'Artificial intelligence', 3, 'Mon|4',104, 1);
-- *6 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(15, 'Web Programming', 3, 'Thu|1',105, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(15, 'Web Programming', 3, 'Thu|2',105, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(15, 'Web Programming', 3, 'Thu|3',105, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(15, 'Web Programming', 3, 'Thu|4',105, 1);
-- *7 course
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(16, 'Logic circuit', 3, 'Mon|7',106, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(16, 'Logic circuit', 3, 'Mon|8',106, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(16, 'Logic circuit', 3, 'Mon|9',106, 1);
insert into course(c_number, c_name, c_grade, c_date_time, pro_number, DEPT_NO) values(16, 'Logic circuit', 3, 'Mon|10',106, 1);

INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('17', 'Information Service for E-Government', 'Tue|3', '4', '107', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('17', 'Information Service for E-Government', 'Tue|4', '4', '107', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('17', 'Information Service for E-Government', 'Thu|1', '4', '107', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('17', 'Information Service for E-Government', 'Thu|2', '4', '107', '3');

INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('18', 'Social Informatics for Information Professionals', 'Wed|2', '3', '301', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('18', 'Social Informatics for Information Professionals', 'Wed|3', '3', '301', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('18', 'Social Informatics for Information Professionals', 'Thu|4', '3', '301', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('18', 'Social Informatics for Information Professionals', 'Thu|5', '3', '301', '3');

INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('19', 'Fundamentals of Metadata', 'Wed|3', '2', '401', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('19', 'Fundamentals of Metadata', 'Wed|4', '2', '401', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('19', 'Fundamentals of Metadata', 'Fri|3', '2', '401', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('19', 'Fundamentals of Metadata', 'Fri|4', '2', '401', '3');

INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('20', 'Analysis of Information Users', 'Mon|1', '1', '402', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('20', 'Analysis of Information Users', 'Mon|2', '1', '402', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('20', 'Analysis of Information Users', 'Tue|1', '1', '402', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('20', 'Analysis of Information Users', 'Tue|2', '1', '402', '3');

INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('23', 'Graduation Certification', 'Tue|1', '4', '302', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('23', 'Graduation Certification', 'Tue|2', '4', '302', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('23', 'Graduation Certification', 'Wed|1', '4', '302', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('23', 'Graduation Certification', 'Wed|2', '4', '302', '3');

INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('21', 'Management of Types of Libraries', 'Thu|1', '3', '303', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('21', 'Management of Types of Libraries', 'Thu|2', '3', '303', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('21', 'Management of Types of Libraries', 'Fri|1', '3', '303', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('21', 'Management of Types of Libraries', 'Fri|2', '3', '303', '3');

INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('25', 'Information Resources by Subject Specialties', 'Mon|7', '2', '404', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('25', 'Information Resources by Subject Specialties', 'Mon|8', '2', '404', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('25', 'Information Resources by Subject Specialties', 'Wed|7', '2', '404', '3');
INSERT INTO course(C_NUMBER, C_NAME, C_DATE_TIME, C_GRADE, PRO_NUMBER, DEPT_NO) VALUES ('25', 'Information Resources by Subject Specialties', 'Wed|8', '2', '404', '3');

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
insert into enroll(stu_number, c_number, c_memo) values(201158102, 12, '');
-------------------------------------------
--# 나의 수강신청 목록 출력
SELECT c.c_number, c.c_name, c.c_date_time, c.c_grade, e.c_memo FROM course c, enroll e WHERE c.c_number = e.c_number;
-------------------------------------------
--# 특정 수강신청 과목에 대한 정보 출력
SELECT c.c_number, c.c_name, c.c_date_time FROM course c WHERE c.c_number = 11;
-------------------------------------------
--# 나의 수강신청 목록 개수 구하기
SELECT COUNT(*) AS course_count FROM enroll;
-------------------------------------------
--# 수강신청과목 리스트 개수 구하기
select COUNT(*) AS count_col from (SELECT COUNT(*) AS col_count FROM course GROUP BY c_number, c_name, c_grade);
-------------------------------------------
--# 로그인 관련 프로시저
--$ 기능 : 로그인 유효성 검사, 아이디 중복검사, 학생등록, 
create or replace procedure PRO_LOGIN_ENROLL(
  -- 매개변수 선언
  in_pro_type IN number, -- type = 1(로그인 유효검사), type = 2(학생등록), type = 3(아이디 중복검사), type = 4(학생정보 수정)
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
  out_result OUT varchar2
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
      out_result := 'true';
    ELSE
      out_result := 'false';
    END IF;
    COMMIT;
  -- 학생 등록
  ELSIF in_pro_type = 2 THEN
    INSERT INTO student(stu_id, stu_password,stu_name,stu_birth, stu_number,stu_address,stu_deptno,stu_grade,stu_email,stu_phonenumber,stu_photo ) 
    VALUES(in_stu_id, in_stu_password,in_stu_name,in_stu_birth, in_stu_number, in_stu_address,in_stu_deptno,in_stu_grade,in_stu_email,in_stu_phonenumber,in_stu_photo);
    out_result := '1';
    COMMIT;
  -- 아이디 중복 검사
  ELSIF in_pro_type = 3 THEN
    SELECT COUNT(*) INTO v_result_col FROM student WHERE stu_id = in_stu_id;
    IF v_result_col = 1 THEN
      out_result := '1';
    ELSE
      out_result := '0';
    END IF;
    COMMIT;
  -- 학생 정보 수정
  ELSIF in_pro_type = 4 THEN
    UPDATE student SET stu_id = in_stu_id, stu_password = in_stu_password, stu_name = in_stu_name, stu_birth = in_stu_birth, stu_number = in_stu_number, stu_address = in_stu_address, stu_deptno = in_stu_deptno,
    stu_grade = in_stu_grade, stu_email = in_stu_email, stu_phonenumber = in_stu_phonenumber, stu_photo = in_stu_photo where stu_number = in_stu_number;
    out_result := sql%rowcount;
    COMMIT;
  ELSE
    out_result := '0';
    COMMIT;
  END IF;
EXCEPTION -- 예외처리
WHEN OTHERS THEN
  out_result := '-1';
  ROLLBACK;
END;

--* 프로시저 실행 (OUT변수 반환)
SET SERVEROUTPUT ON -- dbms_output이 가능하게 해준느 설정
DECLARE
  retval number; -- out변수
BEGIN
  PRO_LOGIN_ENROLL(1, 'scw0531', '서창욱','tjckd246!','92/04/06',201158102,'경기도 수원시',1,4,'scw05313315@gmail.com','01042084757','seopicture.png', retval);
  --PRO_LOGIN_ENROLL(4, 'scw0531', '서창욱','tjckd246!','92/04/06',2011581023,'경기도 수원시',1,4,'scw05313315@gmail.com','01042084757','seopicture.png', retval); -- 수정모드
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
CURSOR course_grade_check IS
  SELECT c.c_number, c.c_grade FROM course c, enroll e
  WHERE c.c_number = e.c_number AND e.stu_number = in_stu_number OR c.c_number = in_c_number
  GROUP BY c.c_number, c.c_grade;

v_count_row number(2);
v_total_grade number(2);
v_get_grade number(2) := 0;
v_c_number number(2);
BEGIN
  IF in_pro_type = 1 THEN
    -- 신청
    -- 1단계 : 시간이 겹치는지 확인
    SELECT count(*)AS count_row INTO v_count_row FROM course c, enroll e WHERE c.c_number = e.c_number AND e.stu_number = in_stu_number
    AND c.c_date_time IN (SELECT c.c_date_time FROM course c WHERE c.c_number = in_c_number);
    
    -- count가 0이면 등록 성공
    IF v_count_row = 0 THEN
      -- 2단계 : 학점체크
      OPEN course_grade_check;
      LOOP
        FETCH course_grade_check INTO v_c_number, v_total_grade;
          EXIT  WHEN  course_grade_check%NOTFOUND;
          v_get_grade := v_get_grade + v_total_grade;
      END  LOOP;
      CLOSE course_grade_check;
      IF v_get_grade > 9 THEN 
        out_result := 0;
      ELSE
        INSERT INTO enroll(stu_number, c_number, c_memo) VALUES(in_stu_number, in_c_number, in_c_memo);
        out_result := 1;
      END IF;
      COMMIT;
    ELSE
      out_result := 0;
      COMMIT;
    END IF;
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
  --PRO_COURSE_MANAGE(3,201158102, 14, 'good course',  retval); -- 메모추가 경우
  PRO_COURSE_MANAGE(2,201158102, 14, ' ',  retval); -- 수강신청 경우
  DBMS_OUTPUT.PUT_LINE('return value: '||retval);
END;
-------------------------------------------
--# 나의 수강신청 목록 출력
SELECT stu_number, c.c_number, c.c_name, c.c_date_time, c.c_grade, e.c_memo 
FROM course c, enroll e 
WHERE c.c_number = e.c_number AND e.STU_NUMBER= 201158102
GROUP BY c.cnumber
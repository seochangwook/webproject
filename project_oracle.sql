-- project DB Script 
--# �ۼ�/�˼��� : �ڼ���, ������, ��â��, ����� 
--# ��û ���̺� : �л����̺�, �������̺�, �а����̺�, �������̺�, ������û ���̺�(�� �л���)
--# �����)
--    1. ���ڿ��� ���� varchar2(150)���� ����(�ѱ۷� ���� ������ ũ�� ���). ���ڵ����ʹ� number���� ����.
--    2. �Է� �ʼ� �����ʹ� not null�� ����.
--    3. �������̺��� �а���ȣ�� ���� null ����� �а��� �������� ���� ������ �����ϴ� ��� ���.
--    4. Ʈ����� �� commit ó��.
--    5. �ʿ信 ���� FK ���� (����� �������� - ����, ���� ���� ���).
--    6. �а���ȣ(1 : ��ǻ�Ͱ��а�), ������ȣ(100~), �����ȣ(10~), �й�(xxxxxxxxx) ���� ����.
--    7. ���ʵ����Ͷ� ���ν��� ������ ��ġ�� �ʰ� ���Ƿ� ���� �����͸� �ǹ�.
--    8. ��Ű���� ������� �ʴ´�.
-------------------------------------------
--# �л����̺�
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
-- $ ���ʵ����� ����
insert into student(stu_id, stu_name, stu_password, stu_birth, stu_number, stu_address, stu_deptno, stu_grade,stu_email, stu_phonenumber, stu_photo, stu_gender) 
values('scw0531', '��â��','ml+NyDubF6ehc9fTbuwhLg==!','92/04/06',201158102,'��⵵ ������',1,4,'scw05313315@gmail.com','01042084757','seopicture.png', '��');

commit;
-------------------------------------------
--# �������̺�
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
-- $ ���ʵ����� ����
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('ȫ�浿', 100, '01011112222', 'pro123', 'pro123', '����Ư���� ������', 1, 'pro123@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('�Ӳ���', 101, '01022223333', 'pro456', 'pro456', '����Ư���� ���α�', 1, 'pro456@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('��ö��', 102, '01044445555', 'pro789', 'pro789', '����Ư���� ��õ��', 1, 'pro789@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('�迵��', 103, '01066667777', 'pro987', 'pro987', '����Ư���� ������', 1, 'pro987@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('��ö��', 104, '01088889999', 'pro654', 'pro654', '����Ư���� ���ϱ�', 1, 'pro654@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('������', 105, '01012121212', 'pro432', 'pro432', '����Ư���� ������', 1, 'pro432@gmail.com');
insert into professor(pro_name, pro_number, pro_phonenumber, pro_id, pro_password, pro_address, pro_deptno, pro_email)
values('��ö��', 106, '01023232323', 'pro111', 'pro111', '����Ư���� �߱�', 1, 'pro111@gmail.com');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('�谡��', '107', '01085462344', 'pro552', 'dsfaspro', '����Ư���� ������', '2', 'rfesd@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('��ƶ�', '108', '01025455252', 'pro852', 'gfghfpro', '����Ư���� ������', '3', 'eddd@lotte.net ');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('������', '109', '01024324868', 'pro865', 'wdwaaspro', '����Ư���� ���Ǳ�', '4', 'yhgvcx@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('������', '110', '01025254848', 'pro850', 'ghfghpro', '����Ư���� ������', '5', 'kjhgfd@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('�����', '111', '01056561519', 'pro120', '1351pro', '����Ư���� �߱�', '6', 'jhg@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('ȫ��', '112', '01024484325', 'pro130', '946514pro', '����Ư���� ���빮��', '7', 'sdcvjb@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('�̰��', '113', '01046674266', 'pro140', '2465146pro', '����Ư���� ����', '8', 'gfcd@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('������', '114', '01044454546', 'pro150', 'ijkpro9ik', '����Ư���� ������', '9', 'jhrf6@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('ȫ����', '115', '01036456484', 'pro160', '7ujkmpro', '����Ư���� ���α�', '10', 'jhgf4e@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('��ȿ��', '116', '01033635345', 'pro170', '7ujpro', '����Ư���� ������', '11', 'yg5r@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('��μ�', '117', '01022444414', 'pro180', '9ik7ypro7u', '����Ư���� ����', '12', 'erfg5v@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('�ֽſ�', '118', '01042448458', 'pro190', '9ipro76yh', '����Ư���� ���ı�', '13', '4ed5rf@lotte.net');
INSERT INTO professor(PRO_NAME, PRO_NUMBER, PRO_PHONENUMBER, PRO_ID, PRO_PASSWORD, PRO_ADDRESS, PRO_DEPTNO, PRO_EMAIL) 
VALUES ('������', '119', '01054554542', 'pro221', '7upro09o', '����Ư���� �߶���', '14', '4r78u@lotte.net');

commit;
-------------------------------------------
--# �а����̺�
create table department(
  dept_no number,
  dept_name varchar2(150) not null,
  primary key(dept_no)
);

desc department;
select * from department;

drop table department;

commit;
-- $ ���ʵ����� ����
insert into department(dept_no, dept_name) values(1, '��ǻ�Ͱ��а�');
insert into department(dept_no, dept_name) values(2, '�濵�а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('3', '���������а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('4', '������ȣ�а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('5', '������а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('6', '��Ƽ�̵���а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('7', '��ȣ�а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('8', '�����а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('9', '������а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('10', '�Ͼ��Ϲ��а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('11', '�߾��߹��а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('12', '������а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('13', '�Ҿ�ҹ��а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('14', '���Ʊ����а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('15', '���б�����');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('16', '��ǻ�ͱ�����');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('17', '�ɸ��а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('18', '���˽ɸ��а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('19', '��ġ�ܱ��а�');
INSERT INTO department(DEPT_NO, DEPT_NAME) VALUES ('20', '�����а�');

commit;
-------------------------------------------
--# �������̺�
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
-- $ ���ʵ����� ����
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
--# ������û ��� ���̺�
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

-- $ ���ʵ����� ����
insert into enroll(stu_number, c_number, c_memo) values(201158102, 10, '');
insert into enroll(stu_number, c_number, c_memo) values(201158102, 11, '');
insert into enroll(stu_number, c_number, c_memo) values(201158102, 12, '');
-------------------------------------------
--# ���� ������û ��� ���
SELECT c.c_number, c.c_name, c.c_date_time, c.c_grade, e.c_memo FROM course c, enroll e WHERE c.c_number = e.c_number;
-------------------------------------------
--# Ư�� ������û ���� ���� ���� ���
SELECT c.c_number, c.c_name, c.c_date_time FROM course c WHERE c.c_number = 11;
-------------------------------------------
--# ���� ������û ��� ���� ���ϱ�
SELECT COUNT(*) AS course_count FROM enroll;
-------------------------------------------
--# ������û���� ����Ʈ ���� ���ϱ�
select COUNT(*) AS count_col from (SELECT COUNT(*) AS col_count FROM course GROUP BY c_number, c_name, c_grade);
-------------------------------------------
--# �α��� ���� ���ν���
--$ ��� : �α��� ��ȿ�� �˻�, ���̵� �ߺ��˻�, �л����, 
create or replace procedure PRO_LOGIN_ENROLL(
  -- �Ű����� ����
  in_pro_type IN number, -- type = 1(�α��� ��ȿ�˻�), type = 2(�л����), type = 3(���̵� �ߺ��˻�), type = 4(�л����� ����)
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
-- Ŀ������, ����� ���� ����
v_result_col number;
BEGIN
  IF in_pro_type = 1 THEN
    -- �α��� ��ȿ ����
    SELECT COUNT(*) INTO v_result_col FROM student
		WHERE stu_id = in_stu_id AND stu_password = in_stu_password;
    IF v_result_col = 1 THEN
      out_result := 'true';
    ELSE
      out_result := 'false';
    END IF;
    COMMIT;
  -- �л� ���
  ELSIF in_pro_type = 2 THEN
    INSERT INTO student(stu_id, stu_password,stu_name,stu_birth, stu_number,stu_address,stu_deptno,stu_grade,stu_email,stu_phonenumber,stu_photo ) 
    VALUES(in_stu_id, in_stu_password,in_stu_name,in_stu_birth, in_stu_number, in_stu_address,in_stu_deptno,in_stu_grade,in_stu_email,in_stu_phonenumber,in_stu_photo);
    out_result := '1';
    COMMIT;
  -- ���̵� �ߺ� �˻�
  ELSIF in_pro_type = 3 THEN
    SELECT COUNT(*) INTO v_result_col FROM student WHERE stu_id = in_stu_id;
    IF v_result_col = 1 THEN
      out_result := '1';
    ELSE
      out_result := '0';
    END IF;
    COMMIT;
  -- �л� ���� ����
  ELSIF in_pro_type = 4 THEN
    UPDATE student SET stu_id = in_stu_id, stu_password = in_stu_password, stu_name = in_stu_name, stu_birth = in_stu_birth, stu_number = in_stu_number, stu_address = in_stu_address, stu_deptno = in_stu_deptno,
    stu_grade = in_stu_grade, stu_email = in_stu_email, stu_phonenumber = in_stu_phonenumber, stu_photo = in_stu_photo where stu_number = in_stu_number;
    out_result := sql%rowcount;
    COMMIT;
  ELSE
    out_result := '0';
    COMMIT;
  END IF;
EXCEPTION -- ����ó��
WHEN OTHERS THEN
  out_result := '-1';
  ROLLBACK;
END;

--* ���ν��� ���� (OUT���� ��ȯ)
SET SERVEROUTPUT ON -- dbms_output�� �����ϰ� ���ش� ����
DECLARE
  retval number; -- out����
BEGIN
  PRO_LOGIN_ENROLL(1, 'scw0531', '��â��','tjckd246!','92/04/06',201158102,'��⵵ ������',1,4,'scw05313315@gmail.com','01042084757','seopicture.png', retval);
  --PRO_LOGIN_ENROLL(4, 'scw0531', '��â��','tjckd246!','92/04/06',2011581023,'��⵵ ������',1,4,'scw05313315@gmail.com','01042084757','seopicture.png', retval); -- �������
  DBMS_OUTPUT.PUT_LINE('return value: '||retval);
END;
-------------------------------------------
--# ������û ���� ���ν���
--$ ��� : ������û, ��������, �������� �޸��߰�
create or replace procedure PRO_COURSE_MANAGE(
   in_pro_type IN number, -- type = 1(��û), type = 2(����), type = 3(�޸��߰�)
   in_stu_number IN enroll.stu_number%TYPE,
   in_c_number IN enroll.c_number%TYPE,
   in_c_memo IN enroll.c_memo%TYPE,
   out_result OUT number
)
IS
-- Ŀ������, ��������
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
    -- ��û
    -- 1�ܰ� : �ð��� ��ġ���� Ȯ��
    SELECT count(*)AS count_row INTO v_count_row FROM course c, enroll e WHERE c.c_number = e.c_number AND e.stu_number = in_stu_number
    AND c.c_date_time IN (SELECT c.c_date_time FROM course c WHERE c.c_number = in_c_number);
    
    -- count�� 0�̸� ��� ����
    IF v_count_row = 0 THEN
      -- 2�ܰ� : ����üũ
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
  -- ��û���� ����
  ELSIF in_pro_type = 2 THEN
    DELETE FROM enroll 
		WHERE stu_number = in_stu_number AND c_number = in_c_number;
    out_result := sql%rowcount;
    COMMIT;
  -- �޸��߰�
  ELSIF in_pro_type = 3 THEN
    UPDATE enroll SET c_memo = in_c_memo 
		WHERE stu_number = in_stu_number AND c_number = in_c_number;
    out_result := sql%rowcount;
    COMMIT;
  ELSE
    out_result := 0;
    COMMIT;
  END IF;
EXCEPTION -- ����ó��
WHEN OTHERS THEN
  out_result := -1;
  ROLLBACK;
END;

--* ���ν��� ���� (OUT���� ��ȯ)
SET SERVEROUTPUT ON -- dbms_output�� �����ϰ� ���ش� ����
DECLARE
  retval number; -- out����
BEGIN
  --PRO_COURSE_MANAGE(3,201158102, 14, 'good course',  retval); -- �޸��߰� ���
  PRO_COURSE_MANAGE(2,201158102, 14, ' ',  retval); -- ������û ���
  DBMS_OUTPUT.PUT_LINE('return value: '||retval);
END;
-------------------------------------------
--# ���� ������û ��� ���
SELECT stu_number, c.c_number, c.c_name, c.c_date_time, c.c_grade, e.c_memo 
FROM course c, enroll e 
WHERE c.c_number = e.c_number AND e.STU_NUMBER= 201158102
GROUP BY c.cnumber
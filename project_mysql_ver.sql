#database use
use test;
-------------------------------------------

#user table create
create table user(
	user_id varchar(40) not null,
	user_password varchar(60) not null,
	primary key(user_id)
);

describe user;

#table drop
DROP TABLE user;
-------------------------------------------

#course table create
create table course(
	c_number Integer not null,
	c_name varchar(60) not null,
	c_date_time varchar(10) not null,
    c_grade Integer,
	primary key(c_number, c_name, c_date_time)
);

describe course;

#table drop
DROP TABLE course;
-------------------------------------------

#enroll table create
create table enroll(
	user_id varchar(40) not null,
	c_number integer not null,
	extra varchar(50),
	primary key(user_id, c_number)
);

describe enroll;

#table drop
DROP TABLE enroll;
-------------------------------------------

#나의 수강신청 목록 출력
SELECT c.c_number, c.c_name, c.c_date_time, c.c_grade, e.extra FROM course c, enroll e WHERE c.c_number = e.c_number;

#수강신청할 과목에 대한 정보 출력
SELECT c.c_number, c.c_date_time FROM course c WHERE c.c_number = 1;

#나의 수강신청 목록 개수 구하기
SELECT COUNT(*) AS course_count FROM enroll;
-------------------------------------------

#수강신청과목 리스트 개수 구하기
select COUNT(*) AS count_col from (SELECT COUNT(*) AS col_count FROM course GROUP BY c_number, c_name, c_grade) AS temp;
-------------------------------------------

#enroll부분 프로시저 (enroll + delete + update)
USE `test`;
DROP procedure IF EXISTS `enroll_procedure`;

DELIMITER $$
USE `test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `enroll_procedure`(
	IN in_user_id varchar(40),
    IN in_c_number integer,
    IN in_course_extra varchar(50),
    IN in_type integer,
    OUT out_result_val varchar(50)
)
BEGIN
	#DECLARE value
    DECLARE v_count_row Integer;
    DECLARE v_total_grade Integer;
    DECLARE v_get_grade Integer DEFAULT 0;
    DECLARE v_c_number Integer;
    DECLARE done INT DEFAULT FALSE;
    
    #Cursor define
    DECLARE course_grade_check CURSOR  FOR 
    SELECT c.c_number, c.c_grade FROM course c, enroll e 
    WHERE c.c_number = e.c_number AND e.user_id = in_user_id OR c.c_number = in_c_number 
    GROUP BY c.c_number, c.c_grade;
    
    #Cursor End value
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    #ERROR EXCEPTION
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET out_result_val = 4;
	END;
    
    IF in_type = 0 THEN
		#시간이 겹치는지 확인
		SELECT count(*)AS count_row INTO v_count_row FROM course c, enroll e WHERE c.c_number = e.c_number AND e.user_id = in_user_id
		AND c.c_date_time IN (SELECT c.c_date_time FROM course c WHERE c.c_number = in_c_number);
        
        #Time Check Success
        IF v_count_row = 0 THEN
            #Cursor open
			OPEN course_grade_check;
			#Loop
			read_loop: LOOP
			
			FETCH course_grade_check INTO v_c_number, v_total_grade;
				SET v_get_grade = v_get_grade + v_total_grade;
                
				IF done THEN
					LEAVE read_loop;
				END IF;
                
			END LOOP;
			CLOSE course_grade_check;
            
            #grade check fail (over total grade)
            IF v_get_grade > 12 THEN
				SET out_result_val = '0';
			#grade check success (over total grade)
			ELSE
				INSERT INTO enroll(user_id, c_number, extra) VALUES(in_user_id, in_c_number, in_course_extra);
				SET out_result_val = '1';
			END IF;
		#Time Check Fail
		ELSE
			SET out_result_val = '0';
		END IF;
	END IF;
    
    #update enroll
    IF in_type = 1 THEN
		UPDATE enroll SET extra = in_course_extra 
		WHERE user_id = in_user_id AND c_number = in_c_number;
        
        #affected row value return
        SET out_result_val = ROW_COUNT();
    END IF;
    
    #delete enroll
    IF in_type = 2 THEN
		DELETE FROM enroll 
		WHERE user_id = in_user_id AND c_number = in_c_number;
	
		#affected row value return
        SET out_result_val = ROW_COUNT();
	END IF;
END$$

DELIMITER ;

#enroll Call insert_enroll
CALL enroll_procedure('scw3315', 3, ' ', 0, @out_result_val);
#update Call course
CALL enroll_procedure('scw3315', 6, 'gseo', 1,  @out_result_val);
#delete Call course
CALL enroll_procedure('scw3315', 3, '', 2,  @out_result_val);

#select out value(return check)
SELECT @out_result_val;

#select enroll table
SELECT * FROM enroll;

#delete enroll table
DELETE FROM enroll;

#insert
INSERT INTO enroll(user_id, c_number, extra) VALUES('scw3315', 4, '');
-------------------------------------------

#user부분 프로시저 (login check + user enroll)
USE `test`;
DROP procedure IF EXISTS `user_procedure`;

DELIMITER $$
USE `test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_procedure`(
	IN in_id varchar(40),
    IN in_password varchar(60),
    IN in_type Integer,
    OUT out_check Integer
)
BEGIN
	DECLARE v_result_col Integer;
    
    #ERROR EXCEPTION
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SET out_check = 4;
	END;
    
    #login check
    IF in_type = 0 THEN
		SELECT COUNT(*) INTO v_result_col FROM user
		WHERE user_id = in_id AND user_password = in_password;
    
		IF v_result_col = 1 THEN
			SET out_check = 1;
		ELSE
			SET out_check = 0;
		END IF;
	END IF;
    
    #enroll user (회원가입 로직 시 추가가능)
    IF in_type = 1 THEN
		INSERT INTO user(user_id, user_password) VALUES(in_id, in_password);
        
        SET out_check = 1;
	END IF;
END$$

DELIMITER ;

#insert_user Call insert_user
CALL user_procedure('scw3315', 'a84528ae015e7c6045f0e68bf20ebef6', 1,  @out_check);
CALL user_procedure('scw0531', 'c0a6fedc92611f7f52666ceca75d0bed', 1,  @out_check);

#login_check call
CALL user_procedure('scw3314', 'a84528ae015e7c6045f0e68bf20ebef6', 0, @out_check);

#select print
SELECT @out_check;

#select call insert_user
SELECT * FROM user;

#delete user
DELETE FROM user;
-------------------------------------------

#course 부분 프로시저(enroll course)
USE `test`;
DROP procedure IF EXISTS `course_procedure`;

DELIMITER $$
USE `test`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `course_procedure`(
	IN in_c_number Integer,
    IN in_c_name varchar(50),
    IN in_c_grade Integer,
	IN in_c_date_time varchar(10)
)
BEGIN
    DECLARE v_grade Integer;
    
    IF in_c_grade > 3 THEN
		SET v_grade = 3;
	ELSE
		SET v_grade = in_c_grade;
	END IF;
    
	INSERT INTO course(c_number, c_name, c_grade, c_date_time) 
    VALUES(in_c_number, in_c_name, v_grade, in_c_date_time);
END$$

DELIMITER ;

#1 course
CALL course_procedure(1, 'Introduction to Computer Engineering', 3, 'Mon|1');
CALL course_procedure(1, 'Introduction to Computer Engineering', 3, 'Mon|2');
CALL course_procedure(1, 'Introduction to Computer Engineering', 3, 'Wed|3');
CALL course_procedure(1, 'Introduction to Computer Engineering', 3, 'Wed|4');

#2 course
CALL course_procedure(2, 'Database', 3, 'Mon|3');
CALL course_procedure(2, 'Database', 3, 'Mon|4');
CALL course_procedure(2, 'Database', 3, 'Wed|1');
CALL course_procedure(2, 'Database', 3, 'Wed|2');

#3 course
CALL course_procedure(3, 'algorithm', 3, 'Tue|1');
CALL course_procedure(3, 'algorithm', 3, 'Tue|2');
CALL course_procedure(3, 'algorithm', 3, 'Thu|3');
CALL course_procedure(3, 'algorithm', 3, 'Thu|4');

#4 course
CALL course_procedure(4, 'Java programming', 3, 'Tue|3');
CALL course_procedure(4, 'Java programming', 3, 'Tue|4');
CALL course_procedure(4, 'Java programming', 3, 'Thu|1');
CALL course_procedure(4, 'Java programming', 3, 'Thu|2');

#5 course
CALL course_procedure(5, 'Artificial intelligence', 3, 'Mon|1');
CALL course_procedure(5, 'Artificial intelligence', 3, 'Mon|2');
CALL course_procedure(5, 'Artificial intelligence', 3, 'Mon|3');
CALL course_procedure(5, 'Artificial intelligence', 3, 'Mon|4');

#6 course
CALL course_procedure(6, 'Web Programming', 3, 'Thu|1');
CALL course_procedure(6, 'Web Programming', 3, 'Thu|2');
CALL course_procedure(6, 'Web Programming', 3, 'Thu|3');
CALL course_procedure(6, 'Web Programming', 3, 'Thu|4');

#7 course
CALL course_procedure(7, 'Logic circuit', 3, 'Mon|7');
CALL course_procedure(7, 'Logic circuit', 3, 'Mon|8');
CALL course_procedure(7, 'Logic circuit', 3, 'Wed|9');
CALL course_procedure(7, 'Logic circuit', 3, 'Wed|10');

#select course table
SELECT * FROM course;

#print course list
SELECT c_number, c_name, c_grade FROM course GROUP BY c_number, c_name, c_grade;

#delete course table
DELETE FROM course;
-------------------------------------------

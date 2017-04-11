--pl/sql考试
--基础题

CREATE OR REPLACE PACKAGE CUX_EXAM_13041_PKG IS
	--2.声明数据类型
	TYPE MSTUD IS RECORD(
		STUDENT_NO     HAND_STUDENT.STUDENT_NO%TYPE,
		STUDENT_NAME   HAND_STUDENT.STUDENT_NAME%TYPE,
		STUDENT_AGE    HAND_STUDENT.STUDENT_AGE%TYPE,
		STUDENT_GENDER HAND_STUDENT.STUDENT_GENDER%TYPE,
		COURSE_NO      HAND_COURSE.COURSE_NO%TYPE,
		COURSE_NAME    HAND_COURSE.COURSE_NAME%TYPE,
		TEACHER_NAME   HAND_TEACHER.TEACHER_NAME%TYPE,
		CORE           HAND_STUDENT_CORE.CORE%TYPE,
		AVG_CORE       NUMBER,
		MAX_CORE       NUMBER,
		MIN_CORE       NUMBER);
	--1.声明游标引用类型
	TYPE REF_CURSOR IS REF CURSOR RETURN MSTUD;
	--3.创建一个方法，返回类型为 ref_cursor，
	--取出分数低于课程平均分的学生信息：学号、姓名、课程编号、课程名、教师、分数、课程平均分、课程最高分、最低分。（7分)
	FUNCTION AVG_STU(COUR_NO VARCHAR2) RETURN REF_CURSOR;
    --5.创建一个方法，根据参数的教师编号，返回这个教师的直接领导的教师编号。
    --如果不存在，返回-1， 如果存在多条记录，返回-2，如果存在其他异常，返回-3	SELECT * FROM hand_teacher
    FUNCTION get_manager(man_no VARCHAR2) RETURN NUMBER;
END CUX_EXAM_13041_PKG;
/

CREATE OR REPLACE PACKAGE BODY CUX_EXAM_13041_PKG IS
	--3.创建一个方法，返回类型为 ref_cursor，
	--取出分数低于课程平均分的学生信息：学号、姓名、课程编号、课程名、教师、分数、课程平均分、课程最高分、最低分。（7分)
	FUNCTION AVG_STU(COUR_NO VARCHAR2) RETURN REF_CURSOR IS
		STUINFO MSTUD;
		CURSOR STUC IS(
			SELECT STU.STUDENT_NO,
				   STU.STUDENT_NAME,
				   STU.STUDENT_AGE,
				   STU.STUDENT_GENDER,
				   COUR.COURSE_NO,
				   COUR.COURSE_NAME,
				   TEA.TEACHER_NAME,
				   MCORE.CORE
			  FROM HAND_STUDENT      STU,
				   HAND_COURSE       COUR,
				   HAND_TEACHER      TEA,
				   HAND_STUDENT_CORE MCORE
			 WHERE STU.STUDENT_NO = MCORE.STUDENT_NO
			   AND COUR.COURSE_NO = MCORE.COURSE_NO
			   AND COUR.TEACHER_NO = TEA.TEACHER_NO
			   AND MCORE.CORE < (SELECT AVG(CORE)
								   FROM HAND_STUDENT_CORE
								  GROUP BY COURSE_NO
								 HAVING COURSE_NO = COUR_NO));
	BEGIN
		RETURN NULL;
	END AVG_STU;

	--5.创建一个方法，根据参数的教师编号，返回这个教师的直接领导的教师编号。
	--如果不存在，返回-1， 如果存在多条记录，返回-2，如果存在其他异常，返回-3 SELECT * FROM hand_teacher
	FUNCTION GET_MANAGER(man_no VARCHAR2) RETURN NUMBER IS
		icount NUMBER;
        flag NUMBER;
	BEGIN
		SELECT COUNT(tea.teacher_no) INTO icount FROM hand_teacher man,hand_teacher tea WHERE tea.manager_no=man.teacher_no AND man.teacher_no=man_no;
        IF icount=1 THEN
        	flag:= 1;
        ELSIF icount>1 THEN
        	flag:= -2;
        END IF;
        RETURN flag;
	EXCEPTION
    	WHEN no_data_found THEN
        	RETURN -1;
        WHEN OTHERS THEN
        	RETURN -3;
	END GET_MANAGER;
END CUX_EXAM_13041_PKG;
/

SELECT CUX_EXAM_13041_PKG.get_manager('t001') FROM dual;
SELECT * FROM hand_teacher man,hand_teacher tea WHERE tea.manager_no=man.teacher_no  AND man.teacher_no='&man_no';

SELECT * FROM hand_teacher;
INSERT INTO hand_teacher VALUES('t004','王老师','t001');
INSERT INTO hand_teacher VALUES('t005','卫老师','t002');




SELECT * FROM hand_student;--(student_no,student_name,student_age,student_gender)
SELECT * FROM hand_teacher;--(teacher_no,teacher_name,manager_no)
SELECT * FROM hand_course;--(course_no,course_name,teacher_no)
SELECT * FROM hand_student_core;--(student_no,course_no,core)

--进阶题
--1.(1)创建一个历史表 hand_teacher_his, 其中包括 hand_teacher 表的所有字段,
-- last_update_date（处理日期）以及 operation（操作类型） 。（3分）
CREATE TABLE hand_teacher_his AS (SELECT * FROM hand_teacher WHERE 1=2);


--2.写一个匿名块，在system(system/manager)用户下执行。
--新建一个directory : HAND_DIR_TEMP , 物理地址为虚拟机的 c:\temp 目录, 
--并授权 读写 权限给student1用户，然后将hand_exam_data.txt这个文件放到c:\temp 目录下。（5分)





SELECT * FROM user_tables;
SELECT * FROM hand_student;--(student_no,student_name,student_age,student_gender)
SELECT * FROM hand_teacher;--(teacher_no,teacher_name,manager_no)
SELECT * FROM hand_course;--(course_no,course_name,teacher_no)
SELECT * FROM hand_student_core;--(student_no,course_no,core)
SELECT * FROM hand_teacher_his;


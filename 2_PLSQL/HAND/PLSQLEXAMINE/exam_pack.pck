create or replace package exam_pack is
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

end exam_pack;
/
create or replace package body exam_pack is
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
end exam_pack;
/

--A.写一个匿名块，创建一张临时表，hand_teacher_temp, 结构与 hand_teacher 相同。
--取所有课程及格率高于50%的教师信息，插入到 hand_teacher_temp 表中。（15分）
--a.查询所有课程以及及格率高于50%的教师的信息
--1.三表连接打印出课程,教师,成绩信息
SELECT *
  FROM HAND_COURSE COUR, HAND_TEACHER TEA, HAND_STUDENT_CORE CORES
 WHERE COUR.TEACHER_NO = TEA.TEACHER_NO
   AND COUR.COURSE_NO = CORES.COURSE_NO;
--2.
   
   
--2.对查询结果进行分组
SELECT tea.teacher_no,
	   tea.teacher_name,
       cour.course_no,
       cour.course_name
  FROM HAND_COURSE COUR, HAND_TEACHER TEA, HAND_STUDENT_CORE CORES
 WHERE COUR.TEACHER_NO = TEA.TEACHER_NO
   AND COUR.COURSE_NO = CORES.COURSE_NO
   GROUP BY tea.teacher_no,tea.teacher_name,cour.course_no,cour.course_name;














--
select courseno, count_stus / sum_stus pct--查出课程表,及格率
       from (select students.course_no courseno,
			       students.stus sum_stus,
                    count_infos.count_stus  count_stus
       				     
                                 
               from (select sc.course_no,count(sc.student_no) stus--每门课的编号和选择总人数
                       from hand_student_core sc
                      group by sc.course_no) students,
                    
                    (select sc1.course_no,count(sc1.student_no) count_stus --每门课的编号和通过人数
                       from hand_student_core sc1
                      where sc1.core > 60
                      group by sc1.course_no) count_infos
              where students.course_no = count_infos.course_no);



--数据库信息
SELECT * FROM user_tables;
SELECT * FROM hand_student;
SELECT * FROM hand_student_core;
SELECT * FROM hand_teacher;
SELECT * FROM hand_course;
SELECT * FROM hand_teacher_his;







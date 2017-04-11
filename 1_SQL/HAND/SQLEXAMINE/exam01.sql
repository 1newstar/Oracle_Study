SELECT * FROM USER_TABLES;

--1.查询"J2SE"这门课，分数在60（包括）至70（包括）之间的学生信息。
--分别用两种比较操作符。显示（学生姓名、分数） （6分）
SELECT *
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO
   AND CORES.CORE BETWEEN 60 AND 70
   AND CORES.COURSE_NO =
       (SELECT COURSE_NO FROM HAND_COURSE WHERE COURSE_NAME = 'J2SE');

--2.查询工作15年以上的老师的信息，以及该老师有哪些学生。
--显示（老师姓名、学生姓名)。不出现重复行。（5分）
SELECT COUR_TEAC.TEACHERNO AS TEACHER_NO,
       (SELECT TEACHER_NAME
          FROM HAND_TEACHER
         WHERE TEACHER_NO = COUR_TEAC.TEACHERNO) AS TEACHER_NAME,
       STUDENTNAME AS STUDENT_NAME
  FROM (SELECT COURSE.COURSE_NO   AS COURSENO,
               COURSE.COURSE_NAME AS COURSENAME,
               COURSE.TEACHER_NO  AS TEACHERNO
          FROM HAND_COURSE COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15)) COUR_TEAC,
       (SELECT CORES.COURSE_NO AS COURSENO,
               (SELECT STUDENT_NAME
                  FROM HAND_STUDENT
                 WHERE STUDENT_NO = CORES.STUDENT_NO) AS STUDENTNAME
          FROM HAND_STUDENT_CORE CORES) SOUR_STU
 WHERE COUR_TEAC.COURSENO = SOUR_STU.COURSENO;

--3.查询每名老师的授课人次（比如刘老师授A、B两个课程，A、B两个课程分别有3名、5名学生选择，那么刘老师的授课人次为8）
--显示（老师姓名、授课人次）。（5分）
SELECT TEA.TEACHER_NAME, COUNT(CORES.STUDENT_NO)
  FROM HAND_TEACHER TEA, HAND_COURSE COUR, HAND_STUDENT_CORE CORES
 WHERE TEA.TEACHER_NO = COUR.TEACHER_NO
   AND COUR.COURSE_NO = CORES.COURSE_NO
 GROUP BY TEA.TEACHER_NAME;
 
--4.查询学过"胡明星"老师或者"刘阳"老师的课的同学。
--显示（学号、姓名），不出现重复行。（6分）
--a.获取两个老师的编号
SELECT TEACHER_NO, TEACHER_NAME
  FROM HAND_TEACHER
 WHERE TEACHER_NAME IN ('刘阳', '胡明星');
--b.根据id获取两位老师教的课程id
SELECT COURSE_NO, COURSE_NAME
  FROM HAND_COURSE
 WHERE TEACHER_NO IN (SELECT TEACHER_NO
                        FROM HAND_TEACHER
                       WHERE TEACHER_NAME IN ('刘阳', '胡明星'));
--c.根据课程no获取学生编号
SELECT STUDENT_NO
  FROM HAND_STUDENT_CORE
 WHERE COURSE_NO IN
       (SELECT COURSE_NO
          FROM HAND_COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE TEACHER_NAME IN ('刘阳', '胡明星')));
--d.根据学生no获取学生信息
SELECT STUDENT_NO, STUDENT_NAME
  FROM HAND_STUDENT
 WHERE STUDENT_NO IN
       (SELECT STUDENT_NO
          FROM HAND_STUDENT_CORE
         WHERE COURSE_NO IN
               (SELECT COURSE_NO
                  FROM HAND_COURSE
                 WHERE TEACHER_NO IN
                       (SELECT TEACHER_NO
                          FROM HAND_TEACHER
                         WHERE TEACHER_NAME IN ('刘阳', '胡明星'))));

--5.查询所有学生的选课信息，如没有选课，默认显示选课为"J2SE"，授课老师为"谌燕"，分数为空。
--显示（学号、姓名、选课、分数）（6分）
SELECT STU.STUDENT_NO 学号,
       STU.STUDENT_NAME 姓名,
       NVL((SELECT COURSE_NAME
             FROM HAND_COURSE
            WHERE COURSE_NO = CORES.COURSE_NO),
           'J2SE') 选课,
       CORES.CORE 分数
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO(+);

--6.查询既学过"刘阳"老师又学过"谌燕"老师的课的学生信息。
--分别用以下方式：
-- a、集合。（4分）
-- b、除集合方式以外的其他方式。（4分）
--解b
--a.获取两个老师的编号
SELECT TEACHER_NO, TEACHER_NAME
  FROM HAND_TEACHER
 WHERE TEACHER_NAME IN ('刘阳', '谌燕');
--b.根据id获取两位老师教的课程id
SELECT COURSE_NO, COURSE_NAME, TEACHER_NO
  FROM HAND_COURSE
 WHERE TEACHER_NO IN (SELECT TEACHER_NO
                        FROM HAND_TEACHER
                       WHERE TEACHER_NAME IN ('刘阳', '谌燕'));
--c.根据课程id获取学生的编号
SELECT CORES.STUDENT_NO, COUNT(CORES.COURSE_NO)
  FROM HAND_STUDENT_CORE CORES
 WHERE COURSE_NO IN
       (SELECT COURSE_NO
          FROM HAND_COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE TEACHER_NAME IN ('刘阳', '谌燕')))
 GROUP BY CORES.STUDENT_NO
HAVING COUNT(CORES.COURSE_NO) > 1;

--d.根据编号获取学生信息 , it's ok
SELECT *
  FROM HAND_STUDENT
 WHERE STUDENT_NO IN (SELECT CORES.STUDENT_NO
                        FROM HAND_STUDENT_CORE CORES
                       WHERE COURSE_NO IN
                             (SELECT COURSE_NO
                                FROM HAND_COURSE
                               WHERE TEACHER_NO IN
                                     (SELECT TEACHER_NO
                                        FROM HAND_TEACHER
                                       WHERE TEACHER_NAME IN ('刘阳', '谌燕')))
                       GROUP BY CORES.STUDENT_NO
                      HAVING COUNT(CORES.COURSE_NO) > 1);

--7.查询各门课程的平均分（保留2位小数，小数位四舍五入，两位小数需显示出来，比如88，需显示成88.00）。
--显示（课程编号，课程名称，平均分）（5分） 
SELECT CORES.COURSE_NO AS 课程编号,
       (SELECT COURSE_NAME
          FROM HAND_COURSE
         WHERE COURSE_NO = CORES.COURSE_NO) AS 课程名称,
       TO_CHAR(ROUND(AVG(CORES.CORE), 2), '999.99') AS 平均分
  FROM HAND_COURSE COUR, HAND_STUDENT_CORE CORES
 WHERE COUR.COURSE_NO = CORES.COURSE_NO
 GROUP BY CORES.COURSE_NO;

--8.查询出每名学生的所有课程平均分（比如李波选了A课程60分，B课程80分，那么他的平均分为70分）,并从高到低进行排序。
--显示（学生姓名，平均分）（6分）
SELECT STU.STUDENT_NAME AS 学生姓名,
       TO_CHAR(ROUND(AVG(CORES.CORE), 2), '999.99') AS 平均分
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO
 GROUP BY STU.STUDENT_NAME
 ORDER BY 平均分;

--9.查询出每门课程学生的排名（从高到低进行排序，用分析函数）。
--相同的分数，名次一样。连续排序，比如，有2个第一名，1个第二名，则排名为1，1，2。
--显示（课程名，学生姓名，分数，名次）（7分）

--10.按如下格式，查询显示出各学生的J2ST、Java Web、SSH三门课的成绩，没有成绩的，显示为空。（7分）
--学生姓名   j2se   java web    ssh
SELECT STU.STUDENT_NAME,
       DECODE(COURSE_NAME, 'J2SE', CORES.CORE, NULL) AS "J2SE",
       DECODE(COURSE_NAME, 'Java Web', CORES.CORE, NULL) AS "Java Web",
       DECODE(COURSE_NAME, 'SSH', CORES.CORE, NULL) "SSH"
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES, HAND_COURSE COUR
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO(+)
   AND CORES.COURSE_NO = COUR.COURSE_NO(+);

--11.查询教师"刘阳"向下的各级教师的编号及姓名:（无主管的教师也需要显示）。
--显示（教师编号、教师名称、主管编号、主管名称）（7分）

--12.查出各门课程中，分数低于平均分的学生信息。
--显示（学生姓名、课程名称、学生的分数）（7分）
--a.获取平均分
SELECT AVG(CORE) FROM HAND_STUDENT_CORE GROUP BY COURSE_NO;
--b.获取学生信息, it's ok!
SELECT STU.STUDENT_NAME AS 学生姓名,
       (SELECT COURSE_NAME
          FROM HAND_COURSE
         WHERE COURSE_NO = CORES.COURSE_NO) AS 课程名称,
       CORES.CORE AS 分数,
       (SELECT TO_CHAR(ROUND(AVG(CORE), 2), '999.99')
          FROM HAND_STUDENT_CORE
         WHERE COURSE_NO = CORES.COURSE_NO
         GROUP BY COURSE_NO) 平均分
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO
   AND CORES.CORE < (SELECT AVG(CORE)
                       FROM HAND_STUDENT_CORE
                      WHERE COURSE_NO = CORES.COURSE_NO
                      GROUP BY COURSE_NO);

--13.分别根据教师、教师和课程、课程、全部，这四个维度，统计选课的平均分数。
--显示（教师名称、课程名称、平均分）（7分）
SELECT TEA.TEACHER_NAME 教师名称,
       COUR.COURSE_NAME 课程名称,
       TO_CHAR(ROUND(AVG(CORES.CORE), 2), '999.99') 平均分
  FROM HAND_TEACHER TEA, HAND_COURSE COUR, HAND_STUDENT_CORE CORES
 WHERE TEA.TEACHER_NO = COUR.TEACHER_NO
   AND COUR.COURSE_NO = CORES.COURSE_NO
 GROUP BY TEA.TEACHER_NAME, COUR.COURSE_NAME;

--14.假设60以下（不包括60）没有学分，60（包括）至70（不包括）算1个学分，
--70（包括）至90（不包括）算2个学分，90（包括）至100（包括）算3个学分，
--查询出总学分超过3分的学生信息。显示（学生姓名、学分总数）（8分）
--a.
SELECT *
  FROM HAND_STUDENT STU, HAND_STUDENT_CORE CORES
 WHERE STU.STUDENT_NO = CORES.STUDENT_NO;

--数据库数据
SELECT * FROM HAND_STUDENT;
SELECT * FROM HAND_TEACHER;
SELECT * FROM HAND_COURSE;
SELECT * FROM HAND_COURSE_TIME;
SELECT * FROM HAND_STUDENT_CORE;

SELECT (TO_CHAR(SYSDATE, 'yyyy') > 2015) FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'yyyy') FROM DUAL;

SELECT MONTHS_BETWEEN(TO_DATE('2016-12-12', 'yyyy-mm-dd'),
                      TO_DATE('2016-10-20', 'yyyy-mm-dd'))
  FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'yyyy') FROM DUAL;

--2.查询工作15年以上的老师的信息，以及该老师有哪些学生。
--显示（老师姓名、学生姓名)。不出现重复行。（5分）
--a.15年工龄的老师
SELECT *
  FROM HAND_TEACHER
 WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15;
--b.15年工龄老师带的课
SELECT *
  FROM HAND_COURSE
 WHERE TEACHER_NO IN
       (SELECT TEACHER_NO
          FROM HAND_TEACHER
         WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15);
--c.选择15年工龄老师的课程的学生编号
SELECT *
  FROM HAND_STUDENT_CORE
 WHERE COURSE_NO IN
       (SELECT COURSE_NO
          FROM HAND_COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15));
--d.连接b表和c表
SELECT DISTINCT (SELECT TEACHER_NAME
          FROM HAND_TEACHER
         WHERE TEACHER_NO = BTAB.TEACHER_NO),
       (SELECT STUDENT_NAME
          FROM HAND_STUDENT
         WHERE STUDENT_NO = CTAB.STUDENT_NO)
  FROM (SELECT *
          FROM HAND_COURSE
         WHERE TEACHER_NO IN
               (SELECT TEACHER_NO
                  FROM HAND_TEACHER
                 WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15)) BTAB,
       (SELECT *
          FROM HAND_STUDENT_CORE
         WHERE COURSE_NO IN
               (SELECT COURSE_NO
                  FROM HAND_COURSE
                 WHERE TEACHER_NO IN
                       (SELECT TEACHER_NO
                          FROM HAND_TEACHER
                         WHERE MONTHS_BETWEEN(SYSDATE, HRIE_DATE) / 12 > 15))) CTAB
 WHERE BTAB.COURSE_NO = CTAB.COURSE_NO;

--数据库数据
SELECT * FROM HAND_STUDENT;
SELECT * FROM HAND_TEACHER;
SELECT * FROM HAND_COURSE;
SELECT * FROM HAND_COURSE_TIME;
SELECT * FROM HAND_STUDENT_CORE;



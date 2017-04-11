--1.显示工资涨幅，员工编号，原来的工资和增加的工资： 
-- 部门号10、50、110的有5%的涨幅，部门号为60的涨10%，工资部门号为20和80涨幅为15%，部门为90的不涨工资
SELECT DECODE(DEPARTMENT_ID,
              10,
              '5%',
              50,
              '5%',
              110,
              '5%',
              60,
              '10%',
              20,
              '15%',
              80,
              '15%',
              90,
              '0%',
              NULL) AS RAISE,
       EMPLOYEE_ID,
       SALARY,
       DECODE(DEPARTMENT_ID,
              10,
              0.05 * SALARY,
              50,
              0.05 * SALARY,
              110,
              0.05 * SALARY,
              60,
              0.1 * SALARY, 
              20,
              0.15 * SALARY,
              80,
              0.15 * SALARY,
              90,
              0 * SALARY,
              NULL) AS NEW_SAL
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (10, 20, 50, 60, 80, 90, 110);

--2.找出哪个工作的最大工资大于整个公司内最大的工资的一半，使用with子句，显示出工作名，最大工资
--a.获取公司的最大工资的一半
--b.获取每个符合条件的工作id
--c.展示各个工作的详细信息及其最大薪资情况
SELECT EMP.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS WHERE JOB_ID = EMP.JOB_ID),
       MAX(EMP.SALARY)
  FROM EMPLOYEES EMP
 GROUP BY JOB_ID
HAVING MAX(SALARY) > (SELECT MAX(SALARY) / 2 FROM EMPLOYEES)
 ORDER BY MAX(SALARY) DESC;

--3.使用EXISTS/NOT EXISTS 找出部门员工数不大于3的部门信息，显示部门编号，部门名称
--a.获取员工人数小于4(不大于3)的部门的id
--b.根据id获取部门信息,it's ok!
SELECT *
  FROM DEPARTMENTS
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                           FROM EMPLOYEES
                          GROUP BY DEPARTMENT_ID
                         HAVING COUNT(EMPLOYEE_ID) < 4);

--4.显示员工编号、上司、等级、姓，要求姓前面加上下划线，等级越低横线越长

--5.将employees表复制到EMP_CPY,在EMP_CPY上添加SEX列，根据实际情况，将sex列内容补充完整;复习group rollup函数




--1.查询工资最低的员工的信息
SELECT * FROM EMPLOYEES WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES);

--2.查询平均工资信息最低的部门信息
SELECT DEPARTMENT_ID, AVG(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
SELECT DEP.*
  FROM DEPARTMENTS DEP
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING AVG(SALARY) = (SELECT MIN(AVG(SALARY))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID));

--3.查询平均工资最低的部门信息和该部门的平均工资
SELECT DEP.*,
       ROUND((SELECT AVG(SALARY)
               FROM EMPLOYEES
              WHERE DEPARTMENT_ID = DEP.DEPARTMENT_ID),
             2) AVG_SAL
  FROM DEPARTMENTS DEP
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING AVG(SALARY) = (SELECT MIN(AVG(SALARY))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID));

--a.输出50号部门的平均工资
SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;
SELECT AVG(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID = 50;
--以上两句是等效的

--4.查询平均工资最高的job信息
--a.列出所有工作的平均工资
SELECT JOB_ID, AVG(SALARY) FROM EMPLOYEES GROUP BY JOB_ID;
--b.找到最高的
SELECT MAX(AVG(SALARY)) FROM EMPLOYEES GROUP BY JOB_ID;
--c.获取最高的工作的job_id
SELECT JOB_ID
  FROM EMPLOYEES
 GROUP BY JOB_ID
HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY)) FROM EMPLOYEES GROUP BY JOB_ID);
--d.根据获取的job_id得到job的详细信息,it's ok!
SELECT *
  FROM JOBS
 WHERE JOB_ID = (SELECT JOB_ID
                   FROM EMPLOYEES
                  GROUP BY JOB_ID
                 HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY))
                                        FROM EMPLOYEES
                                       GROUP BY JOB_ID));

--5.查询平均工资高于公司平均工资的部门有哪些
--a.获取公司的平均工资
SELECT AVG(SALARY) FROM EMPLOYEES;
--b.获取高于公司平均工资的部门的id
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM EMPLOYEES);
--c.根据id获取详细信息, it's ok!
SELECT DEP.*,
       ROUND((SELECT AVG(SALARY)
               FROM EMPLOYEES
              WHERE DEPARTMENT_ID = DEP.DEPARTMENT_ID),
             2) AVG_SAL
  FROM DEPARTMENTS DEP
 WHERE DEPARTMENT_ID IN
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM EMPLOYEES));

--6.查询公司中所有manager的信息
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEES);

--7.各个部门中，最高部门中最低的那个部门的最低工资是多少
--分析：各个部门中最高工资最低的那个部门的最低工资
--a.获取各个部门的最高工资,排序为了后面便于分析,最高工资最低的是10号部门，为4400
SELECT DEPARTMENT_ID, MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY MAX(SALARY);
--b.获取最高工资最低的那个部门的最高工资
SELECT MIN(MAX(SALARY)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
--c.获取最高工资最低的那个部门的部门编号
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) = (SELECT MIN(MAX(SALARY))
                        FROM EMPLOYEES
                       GROUP BY DEPARTMENT_ID);
--d.根据上一步获取的部门编号获取该部门的最低工资, it's ok!
SELECT MIN(SALARY)
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING MAX(SALARY) = (SELECT MIN(MAX(SALARY))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID));

--8.查询平均工资最高的部门的manager的详细信息
--a.列出所有部门的部门id和平均工资
SELECT DEPARTMENT_ID, AVG(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY AVG(SALARY) DESC;
--b.获取平均工资最高的部门的最高工资
SELECT MAX(AVG(SALARY)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
--c.根据最高平均工资获取部门id
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY))
                        FROM EMPLOYEES
                       GROUP BY DEPARTMENT_ID);
--d.根据部门id获取manager的id
SELECT MANAGER_ID
  FROM DEPARTMENTS
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID));
--e.根据manager_id获取manager的详细信息, it's ok!
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID =
       (SELECT MANAGER_ID
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID =
               (SELECT DEPARTMENT_ID
                  FROM EMPLOYEES
                 GROUP BY DEPARTMENT_ID
                HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY))
                                       FROM EMPLOYEES
                                      GROUP BY DEPARTMENT_ID)));

--9.查询2005年进公司的所有员工中工资最高的员工的信息
--a.获取所有2005年进入公司的员工的最高工资
SELECT *
  FROM EMPLOYEES
 WHERE TO_CHAR(HIRE_DATE, 'yyyy') = '2005'
 ORDER BY SALARY DESC;
SELECT MAX(SALARY)
  FROM EMPLOYEES
 WHERE TO_CHAR(HIRE_DATE, 'yyyy') = '2005';
--b.获取最高工资员工的编号,并确保是2005年入职
SELECT EMPLOYEE_ID
  FROM EMPLOYEES
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES
                  WHERE TO_CHAR(HIRE_DATE, 'yyyy') = '2005')
   AND TO_CHAR(HIRE_DATE, 'yyyy') = '2005';
--c.根据编号获取员工信息, it's ok!
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID IN
       (SELECT EMPLOYEE_ID
          FROM EMPLOYEES
         WHERE SALARY =
               (SELECT MAX(SALARY)
                  FROM EMPLOYEES
                 WHERE TO_CHAR(HIRE_DATE, 'yyyy') = '2005')
           AND TO_CHAR(HIRE_DATE, 'yyyy') = '2005');

SELECT HIRE_DATE FROM EMPLOYEES ORDER BY HIRE_DATE;



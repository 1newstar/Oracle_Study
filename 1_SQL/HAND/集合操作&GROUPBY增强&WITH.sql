SELECT employees.FIRST_NAME,
  employees.LAST_NAME
FROM employees
ORDER BY employees.DEPARTMENT_ID;

--一.集合操作
--1.union/union all
SELECT employee_id,job_id FROM employees
UNION
SELECT employee_id,job_id FROM job_history;

SELECT employee_id,job_id FROM employees
UNION ALL
SELECT employee_id,job_id FROM job_history;

--2.intersect
SELECT employee_id,job_id FROM employees
intersect
SELECT employee_id,job_id FROM job_history;

--3.minus
SELECT employee_id,job_id FROM employees
minus
SELECT employee_id,job_id FROM job_history;

--t.
SELECT employee_id,job_id FROM employees ORDER BY employee_id;
SELECT employee_id,job_id FROM job_history ORDER BY employee_id; --101*2 102 114 122 176*2 200*2 201

--二.增强
--1.group by 子句增强
SELECT department_id,job_id,AVG(salary) FROM employees GROUP BY department_id,job_id;

SELECT department_id,job_id,AVG(salary) FROM employees GROUP BY ROLLUP(department_id,job_id);

SELECT department_id,AVG(salary) FROM employees GROUP BY department_id;

SELECT DISTINCT department_id FROM departments;


SELECT * FROM user_tables;


--练习

--1.查询部门的部门号,其中不包括job_id是'ST_CLERK'的部门号
SELECT department_id FROM departments
MINUS
SELECT department_id FROM employees WHERE job_id='ST_CLERK';

--2.查询10,50,20号部门的job_id,department_id,并且department_id按10,50,20的顺序排列
SELECT JOB_ID, DEPARTMENT_ID,1,no_prin 
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 10
UNION
SELECT JOB_ID, DEPARTMENT_ID,2
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50
UNION
SELECT JOB_ID, DEPARTMENT_ID,3
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 20
 ORDER BY 3 ASC;
 
 /*
 执行pl/sql命令:COLUMN no_prin noprint;
 并且向第三列添加别名 no_prin  
 */


--3.查询所有员工的last_name,department_id和department_name
SELECT LAST_NAME, DEPARTMENT_ID, TO_CHAR(NULL)
  FROM EMPLOYEES
UNION
SELECT TO_CHAR(NULL), DEPARTMENT_ID, DEPARTMENT_NAME
  FROM DEPARTMENTS;




--with的使用
WITH DEPT_COSTS AS
 (SELECT DEP.DEPARTMENT_NAME, SUM(EMP.SALARY) AS DEPT_TOTAL
    FROM EMPLOYEES EMP, DEPARTMENTS DEP
   WHERE EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
   GROUP BY DEP.DEPARTMENT_NAME),
AVG_COST AS
 (SELECT SUM(DEPT_TOTAL) / COUNT(*) AS DEPT_AVG FROM DEPT_COSTS)
SELECT *
  FROM DEPT_COSTS
 WHERE DEPT_TOTAL > (SELECT DEPT_AVG FROM AVG_COST)
 ORDER BY DEPARTMENT_NAME;


--递归查询
SELECT EMPLOYEE_ID,
       MANAGER_ID,
       LEVEL, --得到等级
       LPAD(FIRST_NAME, LENGTH(FIRST_NAME) + (LEVEL * 2), '_') AS EMP_LEVEL --lpad(字段名,填充长度,填充的字符)
  FROM EMPLOYEES
 START WITH FIRST_NAME = 'Steven' --查询结果中起始根节点的限定条件
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID; --连接条件（存在父子关系）

--集合操作(并集,交集,差集)
--1.并集  关键字: union/union all     去重/不去重
SELECT employee_id,job_id FROM EMPLOYEES UNION SELECT employee_id,job_id FROM JOB_HISTORY;
SELECT employee_id,job_id FROM EMPLOYEES UNION ALL SELECT employee_id,job_id FROM JOB_HISTORY ORDER BY employee_id;
--2.交集  关键字:interset  

--3.差集  关键字:minus

--exist/not exist

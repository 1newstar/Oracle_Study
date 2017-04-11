--子查询练习2
--1.查询和Zlotkey相同部门的员工姓名和雇佣日期
--a.获取Zlotkey员工的信息
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Zlotkey';
--b.查询相同部门的员工的信息
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME = 'Zlotkey') AND last_name <> 'Zlotkey';

--2.查询工资比公司平均工资高的员工的员工号，姓名和工资
--a.获取公司的平均员工工资
SELECT AVG(salary) FROM employees; 
--b.获取比平均工资高的员工信息
SELECT * FROM employees WHERE salary>(SELECT AVG(salary) FROM employees);

--3.查询各个部门中工资比本部门平均工资高的员工的信息
--a.获取各个部门的平均工资
SELECT department_id,AVG(salary) FROM employees GROUP BY department_id HAVING department_id=80;
--b.查询比平均工资高的员工信息
SELECT * FROM employees emp WHERE salary>(SELECT AVG(salary) FROM employees GROUP BY department_id HAVING department_id=emp.department_id);






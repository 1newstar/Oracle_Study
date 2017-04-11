--多行函数(输入多行，返回一行)
--1.分组函数(max min sum avg count)
SELECT COUNT(1),
  COUNT(2),
  COUNT(*)
FROM employees;
--1.返回dep非null且不重复的记录总数
SELECT COUNT(DISTINCT department_id) FROM employees;
--2.查询emp表中各个部门的平均工资
SELECT COUNT(*) FROM departments;
SELECT department_id,
  ROUND(AVG(salary),2)
FROM employees
WHERE department_id IN (40,60,80)
GROUP BY department_id;
--3.查询各个部门不同工种的平均工资
SELECT department_id,
  job_id,
  ROUND(AVG(salary),2)
FROM EMPLOYEES
GROUP BY department_id,
  job_id;
SELECT * FROM EMPLOYEES;
--having ... group ...
SELECT DEPARTMENT_ID,
  ROUND(AVG(SALARY),2)
FROM employees
GROUP BY DEPARTMENT_ID
HAVING AVG(salary)>6000
ORDER BY DEPARTMENT_ID;
--4.显示各个部门平均工资最大值
SELECT MAX(AVG(salary))
FROM employees
GROUP BY DEPARTMENT_ID;
--5.查询具有各个job_id的员工人数
SELECT job_id,COUNT(*) FROM EMPLOYEES GROUP BY job_id;
--6.查询employees中有多少个部门
SELECT SUM(nvl2(COUNT(DEPARTMENT_ID),1,1))
FROM employees
GROUP BY DEPARTMENT_ID; --错误待定
SELECT COUNT(DISTINCT DEPARTMENT_ID) FROM employees;
--7.查询全公司奖金基数的平均值(没有奖金的人按照0计算)
SELECT AVG(commission_pct),
  AVG(NVL(commission_pct,0)),
  SUM(commission_pct)/COUNT(employee_id)
FROM employees;
--8.查询各个部门的平均工资
SELECT department_id,
  ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id;
--9.查询toronto城市员工的平均工资
SELECT 'Toronto',
  AVG(salary)
FROM employees emp,
  departments dep,
  locations loc
WHERE emp.DEPARTMENT_ID =dep.DEPARTMENT_ID
AND dep.LOCATION_ID     =loc.LOCATION_ID
AND lower(loc.city)     ='toronto';
--10.(有员工的城市)各个城市的平均工资
SELECT loc.city,
  ROUND(AVG(emp.SALARY),2)
FROM employees emp,
  departments dep,
  locations loc
WHERE emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
AND dep.LOCATION_ID    =loc.LOCATION_ID
GROUP BY loc.city;  
--11.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算再内
select emp.last_name,min(emp.salary) from employees emp group by last_name,manager_id;
select MANAGER_ID from employees group by manager_id;

--12.查询所有

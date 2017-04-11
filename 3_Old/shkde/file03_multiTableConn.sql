--多表连接查询
SELECT * FROM user_tables;
SELECT * FROM employees;
SELECT * FROM departments;
--获取员工姓名及其所属部门的名称
SELECT employees.employee_id,
  employees.last_name,
  departments.department_name
FROM employees,
  departments
WHERE employees.department_id=departments.DEPARTMENT_ID;
SELECT * FROM employees;
--1.查询所有员工及其领导关系
SELECT emp.last_name
  ||'的领导是'
  ||man.last_name AS "领导关系"
FROM employees emp,
  employees man
WHERE emp.manager_id=man.employee_id;
--2.1.显示所有员工的姓名，部门号和部门名称
SELECT emp.last_name,
  dep.DEPARTMENT_ID,
  dep.DEPARTMENT_NAME
FROM employees emp,
  departments dep
WHERE emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;
--2.查询90号部门的员工的job_id和90号部门的location_id
SELECT * FROM employees;
SELECT * FROM departments;
SELECT emp.job_id,
  emp.last_name,
  dep.department_id,
  dep.location_id
FROM employees emp,
  departments dep
WHERE emp.department_id=dep.department_id
AND dep.department_id  =90;
--3.选择所有有奖金的员工的last_name,department_name,loaction_id,city
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NOT NULL;
SELECT * FROM user_tables;
SELECT * FROM employees;
SELECT * FROM LOCATIONS;
SELECT * FROM departments;
SELECT emp.last_name,
  emp.commission_pct,
  dep.department_name,
  loc.location_id,
  loc.city
FROM employees emp,
  departments dep,
  locations loc
WHERE emp.commission_pct IS NOT NULL
AND emp.department_id     =dep.department_id
AND dep.location_id       =loc.location_id;
--②
SELECT emp.last_name,
  emp.commission_pct,
  dep.department_name,
  loc.location_id,
  loc.city
FROM employees emp
JOIN departments dep
ON emp.department_id =dep.department_id
JOIN locations loc
ON dep.location_id        =loc.location_id
WHERE emp.commission_pct IS NOT NULL ;
--4.查询city在toronto工作的员工
SELECT * FROM locations;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT emp.last_name,
  emp.job_id,
  emp.DEPARTMENT_ID,
  dep.DEPARTMENT_NAME,
  loc.city
FROM employees emp,
  departments dep,
  locations loc
WHERE loc.city       ='Toronto'
AND emp.DEPARTMENT_ID=dep.DEPARTMENT_ID
AND dep.location_id  = loc.location_id;
SELECT SUBSTR(to_date('2016-10-12','yyyy-mm-dd'),1,2) FROM dual;
--5.查询指定的员工的姓名，员工号，以及他的管理者的姓名和员工号
SELECT * FROM employees;
SELECT emp.employee_id,
  emp.last_name,
  man.EMPLOYEE_ID,
  man.last_name
FROM employees emp,
  employees man
WHERE emp.MANAGER_ID=man.EMPLOYEE_ID(+);
--AND emp.EMPLOYEE_ID =101;


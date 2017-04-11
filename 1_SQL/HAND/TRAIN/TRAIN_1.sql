--1.根据数据字典,查询当前用户下有哪些表
SELECT * FROM user_tables;                  --当前用户是hr用户
SELECT * FROM all_tables WHERE t.owner='hr';--当前用户是sys/system用户
--2.查询所有员工编号，员工姓名、邮件、雇佣日期、  /部门、部门详细地址信息.  not ok
SELECT DISTINCT employees.employee_id AS "员工编号",
  employees.first_name
  ||' '
  ||employees.last_name       AS "员工姓名",
  employees.email             AS "邮件",
  employees.hire_date         AS "雇佣日期",
  departments.department_name AS "部门名称",
  (SELECT street_address
  FROM locations
  WHERE location_id=departments.location_id
  )
FROM employees,
  departments;
--3.查询2003(1997年无数据，故改为2003)年入职员工员工编号，员工姓名，雇佣日期，工龄(保留2位小数)、按照First_Name升序排列
SELECT employee_id                              AS "员工编号",
  concat(first_name,concat(' ',last_name))      AS "员工姓名",
  hire_date                                     AS "雇佣日期",
  TRUNC(months_between(sysdate,hire_date)/12,2) AS "工龄"
FROM employees
WHERE TO_CHAR(hire_date,'yyyy')='2003'
ORDER BY first_name;
--4.显示姓、薪水，佣金（commission） ，然后按薪水降序排列
SELECT first_name,
  last_name,
  salary,
  COMMISSION_PCT
FROM employees
ORDER BY salary DESC;
--5.显示姓名、薪水，佣金（commission），佣金为空的，统一加上0.05;其余的加上0.03，按照薪资降序、变更后佣金升序排列
SELECT first_name,
  last_name,
  commission_pct,
  DECODE(commission_pct,NULL,0.05,commission_pct+0.03)
FROM employees
ORDER BY salary DESC ,
  commission_pct;
--6.显示名字以J、K、L、M开头的雇员
SELECT *
FROM employees
WHERE first_name LIKE 'J%'
OR first_name LIKE 'K%'
OR first_name LIKE 'L%'
OR first_name LIKE 'M%';
--7.显示员工姓名，薪水，调整后薪水(按部门调整：IT提升30%,Salse 提升50%、其余部门提升20%)；按照调整后薪水升序排列
SELECT emp.first_name,
  emp.last_name,
  emp.salary,
  DECODE(dep.DEPARTMENT_NAME,'IT',emp.salary*1.3,'Sales',emp.salary*1.5,emp.salary*1.2) newsalary
FROM employees emp,
  departments dep
WHERE emp.department_id=dep.DEPARTMENT_ID
ORDER BY newsalary;
--8.显示各个部门名称，平均工资、最高工资、最低工资、部门人数  not ok
SELECT emp.DEPARTMENT_ID,
  ROUND(AVG(emp.salary),2),
  MAX(emp.salary),
  MIN(emp.salary),
  COUNT(emp.last_name)
FROM employees emp,
  departments dep
GROUP BY emp.department_id;
--9.显示在每月中旬雇佣的员工,显示姓名，雇佣日期
SELECT first_name
  ||' '
  ||last_name,
  TO_CHAR(hire_date,'yyyy-mm-dd')
FROM employees
WHERE to_number(TO_CHAR(hire_date,'dd')) BETWEEN 11 AND 20
ORDER BY hire_date;

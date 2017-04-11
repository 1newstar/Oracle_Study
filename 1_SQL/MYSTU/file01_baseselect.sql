--基本select语句用法
SELECT sysdate FROM dual;
SELECT TO_CHAR(sysdate,'yyyy-mm-dd') FROM dual;
--1.查询工资大于8000的员工的姓名和工资
SELECT * FROM employees WHERE salary > 8000;
--2.查询176号员工的性，姓名和工资
SELECT first_name
  ||' '
  ||last_name AS "员工姓名",
  salary      AS "员工薪水"
FROM employees
WHERE employee_id=176;
--3.查询工资不在5000到12000的员工的姓名和薪水
SELECT first_name
  ||' '
  ||last_name AS "员工姓名",
  salary      AS "员工薪水"
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000
ORDER BY salary;
--4.查询雇佣时间在1998-02-01到1998-05-01之间的员工姓名，job_id和雇佣时间
SELECT * FROM employees;
SELECT first_name
  ||' '
  ||last_name                     AS "员工姓名",
  job_id                          AS "工作编号",
  TO_CHAR(hire_date,'yyyy-mm-dd') AS "雇佣时间"
FROM employees
WHERE TO_CHAR(hire_date,'yyyy-mm-dd') BETWEEN '2003-02-01' AND '2005-05-01'
ORDER BY hire_date;
--5.查询公司中没有管理者的员工
SELECT * FROM employees;
SELECT * FROM employees WHERE manager_id IS NULL;
--6.选择名字中含有a和e的员工的信息
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%e%'
OR last_name LIKE '%e%a%';
--双重排序
SELECT * FROM employees ORDER BY salary , employee_id DESC;

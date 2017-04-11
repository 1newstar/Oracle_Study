--1.显示部门编号、部门名字、该部门的员工数、每个部门的平均工资，部门内的员工信息，包括姓名、薪水、职业；平均工资保留2位小数，千分位分隔符显示；结果按部门升序
SELECT dep.DEPARTMENT_ID,
  dep.DEPARTMENT_NAME,
  AVG(salary)
FROM employees emp,
  departments dep
GROUP BY dep.DEPARTMENT_IDe
HAVING emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;
--2.显示员工数最多的部门信息，显示部门ID、名称、部门员工数，部门的主管经理姓名
SELECT * FROM departments;
SELECT department_id, COUNT(*) FROM employees GROUP BY department_id;
SELECT emp.department_id AS eid,
  COUNT(*)
FROM employees emp,
  departments dep
GROUP BY emp.department_id
HAVING COUNT(*) = ANY
  (SELECT MAX(COUNT(*)) FROM employees GROUP BY department_id
  )
AND emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;
--3.显示工号、姓名、薪水(?)、部门编号、薪资，薪资与部门平均工资的差异情况；按照部门ID排序
SELECT SUM(SALARY)/COUNT(*)
FROM EMPLOYEES;
SELECT emp.EMPLOYEE_ID,
  emp.last_name,
  emp.DEPARTMENT_ID,
  emp.salary,
  ROUND(emp.SALARY-
  (SELECT AVG(salary) FROM EMPLOYEES
  ),2) AS salary_gap
FROM employees emp
ORDER BY emp.DEPARTMENT_ID;
--4.周几录取的人数最少，显示人名和日期
SELECT * FROM employees;
SELECT hire_date,COUNT(*) FROM employees GROUP BY hire_date;
--5.自己做练习，验证 between .. and  的外链接
--6.验证rollback ；并提供例子
--7.查询所有hr用户下的索引
SELECT ic.index_name,
  ic.column_name,
  ic.column_position col_pos,
  ix.uniqueness
FROM user_indexes ix,
  user_ind_columns ic
WHERE ic.index_name = ix.index_name
AND ic.table_name   ='employees';
SELECT * FROM user_indexes;



--查询job_id与141号员工相同,salaty比143号员工多的员工的姓名，job_id和工资
SELECT employee_id,
  last_name,
  job_id,
  salary
FROM employees
WHERE job_id=
  (SELECT job_id FROM employees emp WHERE emp.employee_id=141
  )
AND salary >
  (SELECT salary FROM employees WHERE employee_id=143
  );
--1.��ʾ���ű�š��������֡��ò��ŵ�Ա������ÿ�����ŵ�ƽ�����ʣ������ڵ�Ա����Ϣ������������нˮ��ְҵ��ƽ�����ʱ���2λС����ǧ��λ�ָ�����ʾ���������������
SELECT dep.DEPARTMENT_ID,
  dep.DEPARTMENT_NAME,
  AVG(salary)
FROM employees emp,
  departments dep
GROUP BY dep.DEPARTMENT_IDe
HAVING emp.DEPARTMENT_ID=dep.DEPARTMENT_ID;
--2.��ʾԱ�������Ĳ�����Ϣ����ʾ����ID�����ơ�����Ա���������ŵ����ܾ�������
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
--3.��ʾ���š�������нˮ(?)�����ű�š�н�ʣ�н���벿��ƽ�����ʵĲ�����������ղ���ID����
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
--4.�ܼ�¼ȡ���������٣���ʾ����������
SELECT * FROM employees;
SELECT hire_date,COUNT(*) FROM employees GROUP BY hire_date;
--5.�Լ�����ϰ����֤ between .. and  ��������
--6.��֤rollback �����ṩ����
--7.��ѯ����hr�û��µ�����
SELECT ic.index_name,
  ic.column_name,
  ic.column_position col_pos,
  ix.uniqueness
FROM user_indexes ix,
  user_ind_columns ic
WHERE ic.index_name = ix.index_name
AND ic.table_name   ='employees';
SELECT * FROM user_indexes;



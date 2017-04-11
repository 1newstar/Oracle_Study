SELECT employees.FIRST_NAME,
  employees.LAST_NAME
FROM employees
ORDER BY employees.DEPARTMENT_ID;

--һ.���ϲ���
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

--��.��ǿ
--1.group by �Ӿ���ǿ
SELECT department_id,job_id,AVG(salary) FROM employees GROUP BY department_id,job_id;

SELECT department_id,job_id,AVG(salary) FROM employees GROUP BY ROLLUP(department_id,job_id);

SELECT department_id,AVG(salary) FROM employees GROUP BY department_id;

SELECT DISTINCT department_id FROM departments;


SELECT * FROM user_tables;


--��ϰ

--1.��ѯ���ŵĲ��ź�,���в�����job_id��'ST_CLERK'�Ĳ��ź�
SELECT department_id FROM departments
MINUS
SELECT department_id FROM employees WHERE job_id='ST_CLERK';

--2.��ѯ10,50,20�Ų��ŵ�job_id,department_id,����department_id��10,50,20��˳������
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
 ִ��pl/sql����:COLUMN no_prin noprint;
 �������������ӱ��� no_prin  
 */


--3.��ѯ����Ա����last_name,department_id��department_name
SELECT LAST_NAME, DEPARTMENT_ID, TO_CHAR(NULL)
  FROM EMPLOYEES
UNION
SELECT TO_CHAR(NULL), DEPARTMENT_ID, DEPARTMENT_NAME
  FROM DEPARTMENTS;




--with��ʹ��
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


--�ݹ��ѯ
SELECT EMPLOYEE_ID,
       MANAGER_ID,
       LEVEL, --�õ��ȼ�
       LPAD(FIRST_NAME, LENGTH(FIRST_NAME) + (LEVEL * 2), '_') AS EMP_LEVEL --lpad(�ֶ���,��䳤��,�����ַ�)
  FROM EMPLOYEES
 START WITH FIRST_NAME = 'Steven' --��ѯ�������ʼ���ڵ���޶�����
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID; --�������������ڸ��ӹ�ϵ��

--���ϲ���(����,����,�)
--1.����  �ؼ���: union/union all     ȥ��/��ȥ��
SELECT employee_id,job_id FROM EMPLOYEES UNION SELECT employee_id,job_id FROM JOB_HISTORY;
SELECT employee_id,job_id FROM EMPLOYEES UNION ALL SELECT employee_id,job_id FROM JOB_HISTORY ORDER BY employee_id;
--2.����  �ؼ���:interset  

--3.�  �ؼ���:minus

--exist/not exist

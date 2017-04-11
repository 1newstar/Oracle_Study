--1.��ʾ���ű�š��������֡��ò��ŵ�Ա������ÿ�����ŵ�ƽ�����ʣ�
--  �����ڵ�Ա����Ϣ������������нˮ��ְҵ��ƽ�����ʱ���2λС����ǧ��λ�ָ�����ʾ���������������
SELECT DEPARTMENT_ID AS SDEP_ID,
       (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID = EMP.DEPARTMENT_ID) AS SDEP_NAME,
       COUNT(EMP.EMPLOYEE_ID) AS SEMPS,
       AVG(EMP.SALARY) AS SAVG_SAL
  FROM EMPLOYEES EMP
 GROUP BY DEPARTMENT_ID;

--2.��ʾԱ�������Ĳ�����Ϣ����ʾ����ID�����ơ�����Ա���������ŵ����ܾ�������
--a.��ʾ�������ŵ�Ա������
SELECT DEPARTMENT_ID, COUNT(EMPLOYEE_ID)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY COUNT(EMPLOYEE_ID) DESC;
--b.��ȡԱ�����Ĳ��ŵ�����
SELECT MAX(COUNT(EMPLOYEE_ID)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
--c.��ȡԱ���������Ĳ���id
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID) = (SELECT MAX(COUNT(EMPLOYEE_ID))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID);
--e.��ȡ��ϸ��Ϣ, it's ok!
SELECT EMP.DEPARTMENT_ID,
       (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID = EMP.DEPARTMENT_ID) AS DEPARTMENT_NAME,
       COUNT(EMP.EMPLOYEE_ID) AS EMPLOYEES,
       (SELECT FIRST_NAME || ' ' || LAST_NAME
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID =
               (SELECT MANAGER_ID
                  FROM DEPARTMENTS
                 WHERE DEPARTMENT_ID = EMP.DEPARTMENT_ID)) AS MANAGER_NAME
  FROM EMPLOYEES EMP
 GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID) = (SELECT MAX(COUNT(EMPLOYEE_ID))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID);

--3.��ʾ���š�������нˮ�����ű�š�н�ʣ�н���벿��ƽ�����ʵĲ�����������ղ���ID����
--a.����������ŵ�ƽ��н��
SELECT DEPARTMENT_ID, AVG(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID = 100;
--b.������첢����ʾ, it's ok!
SELECT EMP.EMPLOYEE_ID,
       EMP.LAST_NAME,
       EMP.DEPARTMENT_ID,
       EMP.SALARY,
       ROUND(EMP.SALARY -
             (SELECT AVG(SALARY)
                FROM EMPLOYEES
               GROUP BY DEPARTMENT_ID
              HAVING DEPARTMENT_ID = EMP.DEPARTMENT_ID),
             2) AS SALARY_GAP
  FROM EMPLOYEES EMP
 ORDER BY DEPARTMENT_ID;

--4.�ܼ�¼ȡ���������٣���ʾ����������
SELECT COUNT(DECODE(TO_CHAR(HIRE_DATE, 'day'), '����һ', 1, NULL))
  FROM EMPLOYEES;
--a.�������ڷ���
SELECT TO_CHAR(HIRE_DATE, 'day'), COUNT(*)
  FROM EMPLOYEES
 GROUP BY TO_CHAR(HIRE_DATE, 'day');
--b.��ȡ¼ȡ�������ٵ�����
SELECT MIN(COUNT(*)) FROM EMPLOYEES GROUP BY TO_CHAR(HIRE_DATE, 'day');
--c.��������������ȡ����
--d.��ȡ��ϸ��Ϣ
SELECT EMP.EMPLOYEE_ID,
       EMP.FIRST_NAME,
       EMP.LAST_NAME,
       TO_CHAR(EMP.HIRE_DATE, 'day')
  FROM EMPLOYEES EMP
 WHERE TO_CHAR(HIRE_DATE, 'day') =
       (SELECT TO_CHAR(HIRE_DATE, 'day')
          FROM EMPLOYEES
         GROUP BY TO_CHAR(HIRE_DATE, 'day')
        HAVING COUNT(*) = (SELECT MIN(COUNT(*))
                            FROM EMPLOYEES
                           GROUP BY TO_CHAR(HIRE_DATE, 'day')));
                           
                           
--xk����ϰ
SELECT E.EMPLOYEE_ID, E.LAST_NAME
  FROM EMPLOYEES E,
	   (SELECT D.C, D.HIRE hire_d
		  FROM (SELECT COUNT(EMPLOYEE_ID) C, TO_CHAR(E.HIRE_DATE, 'day') HIRE
				  FROM EMPLOYEES E
				 GROUP BY TO_CHAR(E.HIRE_DATE, 'day')
				 ORDER BY C) D
		 WHERE ROWNUM < = 1) N
 WHERE TO_CHAR(E.HIRE_DATE, 'day') = N.HIRE_d;
 
                           
                           
                           

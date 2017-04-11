--1.��ѯ������͵�Ա������Ϣ
SELECT * FROM EMPLOYEES WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES);

--2.��ѯƽ��������Ϣ��͵Ĳ�����Ϣ
SELECT DEPARTMENT_ID, AVG(SALARY) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
SELECT DEP.*
  FROM DEPARTMENTS DEP
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING AVG(SALARY) = (SELECT MIN(AVG(SALARY))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID));

--3.��ѯƽ��������͵Ĳ�����Ϣ�͸ò��ŵ�ƽ������
SELECT DEP.*,
       ROUND((SELECT AVG(SALARY)
               FROM EMPLOYEES
              WHERE DEPARTMENT_ID = DEP.DEPARTMENT_ID),
             2) AVG_SAL
  FROM DEPARTMENTS DEP
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING AVG(SALARY) = (SELECT MIN(AVG(SALARY))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID));

--a.���50�Ų��ŵ�ƽ������
SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;
SELECT AVG(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID = 50;
--���������ǵ�Ч��

--4.��ѯƽ��������ߵ�job��Ϣ
--a.�г����й�����ƽ������
SELECT JOB_ID, AVG(SALARY) FROM EMPLOYEES GROUP BY JOB_ID;
--b.�ҵ���ߵ�
SELECT MAX(AVG(SALARY)) FROM EMPLOYEES GROUP BY JOB_ID;
--c.��ȡ��ߵĹ�����job_id
SELECT JOB_ID
  FROM EMPLOYEES
 GROUP BY JOB_ID
HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY)) FROM EMPLOYEES GROUP BY JOB_ID);
--d.���ݻ�ȡ��job_id�õ�job����ϸ��Ϣ,it's ok!
SELECT *
  FROM JOBS
 WHERE JOB_ID = (SELECT JOB_ID
                   FROM EMPLOYEES
                  GROUP BY JOB_ID
                 HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY))
                                        FROM EMPLOYEES
                                       GROUP BY JOB_ID));

--5.��ѯƽ�����ʸ��ڹ�˾ƽ�����ʵĲ�������Щ
--a.��ȡ��˾��ƽ������
SELECT AVG(SALARY) FROM EMPLOYEES;
--b.��ȡ���ڹ�˾ƽ�����ʵĲ��ŵ�id
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM EMPLOYEES);
--c.����id��ȡ��ϸ��Ϣ, it's ok!
SELECT DEP.*,
       ROUND((SELECT AVG(SALARY)
               FROM EMPLOYEES
              WHERE DEPARTMENT_ID = DEP.DEPARTMENT_ID),
             2) AVG_SAL
  FROM DEPARTMENTS DEP
 WHERE DEPARTMENT_ID IN
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM EMPLOYEES));

--6.��ѯ��˾������manager����Ϣ
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEES);

--7.���������У���߲�������͵��Ǹ����ŵ���͹����Ƕ���
--������������������߹�����͵��Ǹ����ŵ���͹���
--a.��ȡ�������ŵ���߹���,����Ϊ�˺�����ڷ���,��߹�����͵���10�Ų��ţ�Ϊ4400
SELECT DEPARTMENT_ID, MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY MAX(SALARY);
--b.��ȡ��߹�����͵��Ǹ����ŵ���߹���
SELECT MIN(MAX(SALARY)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
--c.��ȡ��߹�����͵��Ǹ����ŵĲ��ű��
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) = (SELECT MIN(MAX(SALARY))
                        FROM EMPLOYEES
                       GROUP BY DEPARTMENT_ID);
--d.������һ����ȡ�Ĳ��ű�Ż�ȡ�ò��ŵ���͹���, it's ok!
SELECT MIN(SALARY)
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING MAX(SALARY) = (SELECT MIN(MAX(SALARY))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID));

--8.��ѯƽ��������ߵĲ��ŵ�manager����ϸ��Ϣ
--a.�г����в��ŵĲ���id��ƽ������
SELECT DEPARTMENT_ID, AVG(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY AVG(SALARY) DESC;
--b.��ȡƽ��������ߵĲ��ŵ���߹���
SELECT MAX(AVG(SALARY)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
--c.�������ƽ�����ʻ�ȡ����id
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY))
                        FROM EMPLOYEES
                       GROUP BY DEPARTMENT_ID);
--d.���ݲ���id��ȡmanager��id
SELECT MANAGER_ID
  FROM DEPARTMENTS
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
        HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY))
                               FROM EMPLOYEES
                              GROUP BY DEPARTMENT_ID));
--e.����manager_id��ȡmanager����ϸ��Ϣ, it's ok!
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID =
       (SELECT MANAGER_ID
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID =
               (SELECT DEPARTMENT_ID
                  FROM EMPLOYEES
                 GROUP BY DEPARTMENT_ID
                HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY))
                                       FROM EMPLOYEES
                                      GROUP BY DEPARTMENT_ID)));

--9.��ѯ2005�����˾������Ա���й�����ߵ�Ա������Ϣ
--a.��ȡ����2005����빫˾��Ա������߹���
SELECT *
  FROM EMPLOYEES
 WHERE TO_CHAR(HIRE_DATE, 'yyyy') = '2005'
 ORDER BY SALARY DESC;
SELECT MAX(SALARY)
  FROM EMPLOYEES
 WHERE TO_CHAR(HIRE_DATE, 'yyyy') = '2005';
--b.��ȡ��߹���Ա���ı��,��ȷ����2005����ְ
SELECT EMPLOYEE_ID
  FROM EMPLOYEES
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES
                  WHERE TO_CHAR(HIRE_DATE, 'yyyy') = '2005')
   AND TO_CHAR(HIRE_DATE, 'yyyy') = '2005';
--c.���ݱ�Ż�ȡԱ����Ϣ, it's ok!
SELECT *
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID IN
       (SELECT EMPLOYEE_ID
          FROM EMPLOYEES
         WHERE SALARY =
               (SELECT MAX(SALARY)
                  FROM EMPLOYEES
                 WHERE TO_CHAR(HIRE_DATE, 'yyyy') = '2005')
           AND TO_CHAR(HIRE_DATE, 'yyyy') = '2005');

SELECT HIRE_DATE FROM EMPLOYEES ORDER BY HIRE_DATE;



--1.��ʾ�����Ƿ���Ա����ţ�ԭ���Ĺ��ʺ����ӵĹ��ʣ� 
-- ���ź�10��50��110����5%���Ƿ������ź�Ϊ60����10%�����ʲ��ź�Ϊ20��80�Ƿ�Ϊ15%������Ϊ90�Ĳ��ǹ���
SELECT DECODE(DEPARTMENT_ID,
              10,
              '5%',
              50,
              '5%',
              110,
              '5%',
              60,
              '10%',
              20,
              '15%',
              80,
              '15%',
              90,
              '0%',
              NULL) AS RAISE,
       EMPLOYEE_ID,
       SALARY,
       DECODE(DEPARTMENT_ID,
              10,
              0.05 * SALARY,
              50,
              0.05 * SALARY,
              110,
              0.05 * SALARY,
              60,
              0.1 * SALARY, 
              20,
              0.15 * SALARY,
              80,
              0.15 * SALARY,
              90,
              0 * SALARY,
              NULL) AS NEW_SAL
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (10, 20, 50, 60, 80, 90, 110);

--2.�ҳ��ĸ�����������ʴ���������˾�����Ĺ��ʵ�һ�룬ʹ��with�Ӿ䣬��ʾ���������������
--a.��ȡ��˾������ʵ�һ��
--b.��ȡÿ�����������Ĺ���id
--c.չʾ������������ϸ��Ϣ�������н�����
SELECT EMP.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS WHERE JOB_ID = EMP.JOB_ID),
       MAX(EMP.SALARY)
  FROM EMPLOYEES EMP
 GROUP BY JOB_ID
HAVING MAX(SALARY) > (SELECT MAX(SALARY) / 2 FROM EMPLOYEES)
 ORDER BY MAX(SALARY) DESC;

--3.ʹ��EXISTS/NOT EXISTS �ҳ�����Ա����������3�Ĳ�����Ϣ����ʾ���ű�ţ���������
--a.��ȡԱ������С��4(������3)�Ĳ��ŵ�id
--b.����id��ȡ������Ϣ,it's ok!
SELECT *
  FROM DEPARTMENTS
 WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                           FROM EMPLOYEES
                          GROUP BY DEPARTMENT_ID
                         HAVING COUNT(EMPLOYEE_ID) < 4);

--4.��ʾԱ����š���˾���ȼ����գ�Ҫ����ǰ������»��ߣ��ȼ�Խ�ͺ���Խ��

--5.��employees���Ƶ�EMP_CPY,��EMP_CPY�����SEX�У�����ʵ���������sex�����ݲ�������;��ϰgroup rollup����




--�Ӳ�ѯ��ϰ2
--1.��ѯ��Zlotkey��ͬ���ŵ�Ա�������͹�Ӷ����
--a.��ȡZlotkeyԱ������Ϣ
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Zlotkey';
--b.��ѯ��ͬ���ŵ�Ա������Ϣ
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID =
       (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME = 'Zlotkey') AND last_name <> 'Zlotkey';

--2.��ѯ���ʱȹ�˾ƽ�����ʸߵ�Ա����Ա���ţ������͹���
--a.��ȡ��˾��ƽ��Ա������
SELECT AVG(salary) FROM employees; 
--b.��ȡ��ƽ�����ʸߵ�Ա����Ϣ
SELECT * FROM employees WHERE salary>(SELECT AVG(salary) FROM employees);

--3.��ѯ���������й��ʱȱ�����ƽ�����ʸߵ�Ա������Ϣ
--a.��ȡ�������ŵ�ƽ������
SELECT department_id,AVG(salary) FROM employees GROUP BY department_id HAVING department_id=80;
--b.��ѯ��ƽ�����ʸߵ�Ա����Ϣ
SELECT * FROM employees emp WHERE salary>(SELECT AVG(salary) FROM employees GROUP BY department_id HAVING department_id=emp.department_id);






--������,��ĳһ���¼�����ʱ�����Ĳ���,���ܴ��ݲ���,���¼�����
--��������Ϊ�м�����伶
--1.������һ��������
CREATE OR REPLACE TRIGGER select_emp_trigger01
AFTER --��ʾ���¼�����֮��ִ��
	update ON employees
FOR EACH ROW
BEGIN
	dbms_output.put_line('select��һ��!');
END;


--2.�����ڶ���������
CREATE OR REPLACE TRIGGER select_emp_trigger_before

BEFORE --��ʾ���¼�����֮ǰִ��
	SELECT ON employees
FOR EACH ROW
BEGIN
	dbms_output.put_line('select��һ��!');
END;






SELECT * FROM employees WHERE employee_id=100;
UPDATE employees SET salary = salary + 1000 WHERE employee_id=100;
--�ع�
ROLLBACK;


--����:��дһ��������,�ڶ�emp��(�ڴ��?)����delete��ʱ��,��emp_bak���б��ݶ�Ӧ�ļ�¼





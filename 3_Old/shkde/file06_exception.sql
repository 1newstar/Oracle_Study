--�쳣��ϰ
--1.ͨ��select ... into ... from ... ��ѯĳ�˵Ĺ���,��û�в�ѯ��,�����'δ�ҵ�����' 
--ע��:is null �� = null�ǲ�һ����
DECLARE
	emp employees%ROWTYPE;
	no_data_find EXCEPTION;
BEGIN
	SELECT * INTO emp FROM employees WHERE employee_id=&emp_id;
	dbms_output.put_line('lalala>>>'||emp.manager_id);
    IF emp.manager_id IS NULL THEN
    	RAISE no_data_find;
    END IF;
    dbms_output.put_line(emp.employee_id||' '||emp.last_name||' '||emp.salary);
    EXCEPTION
    WHEN no_data_find THEN dbms_output.put_line('��������ϰ�!!!');
END;
/


--no_results�쳣

SELECT * FROM employees WHERE manager_id IS NULL;

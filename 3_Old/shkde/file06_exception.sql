--异常练习
--1.通过select ... into ... from ... 查询某人的工资,若没有查询到,则输出'未找到数据' 
--注意:is null 和 = null是不一样的
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
    WHEN no_data_find THEN dbms_output.put_line('这哥们是老板!!!');
END;
/


--no_results异常

SELECT * FROM employees WHERE manager_id IS NULL;

--触发器,当某一个事件发生时触发的操作,不能传递参数,由事件启动
--触发器分为行级和语句级
--1.创建第一个触发器
CREATE OR REPLACE TRIGGER select_emp_trigger01
AFTER --表示在事件触发之后执行
	update ON employees
FOR EACH ROW
BEGIN
	dbms_output.put_line('select了一行!');
END;


--2.创建第二个触发器
CREATE OR REPLACE TRIGGER select_emp_trigger_before

BEFORE --表示在事件触发之前执行
	SELECT ON employees
FOR EACH ROW
BEGIN
	dbms_output.put_line('select了一行!');
END;






SELECT * FROM employees WHERE employee_id=100;
UPDATE employees SET salary = salary + 1000 WHERE employee_id=100;
--回滚
ROLLBACK;


--任务:编写一个触发器,在对emp表(内存表?)进行delete的时候,在emp_bak表中备份对应的记录





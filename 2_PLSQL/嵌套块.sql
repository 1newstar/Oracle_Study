--今日任务
--1.嵌套块



--2.outer   inner
<<OUTER>>
DECLARE
	onum_01 NUMBER;
BEGIN
	<<INNER>>
    DECLARE
    	inum_01 NUMBER;
    BEGIN
    	onum_01:=100;
    END;
	dbms_output.put_line(onum_01);

END;
/

--2.plsql异常处理
--a.预定义异常(大概有24个)
DECLARE
	sal employees.salary%TYPE;
BEGIN
	SELECT salary INTO sal FROM employees;
EXCEPTION
	WHEN too_many_rows THEN dbms_output.put_line('返回了太多行!');	
	WHEN OTHERS THEN dbms_output.put_line('有其他异常!');
END;
/

--b.非预定义异常
DECLARE
	my_excep EXCEPTION;
    PRAGMA EXCEPTION_INIT(my_excep,-2292);
BEGIN
	DELETE FROM employees WHERE employee_id=100;
    EXCEPTION
    WHEN my_excep THEN
 		dbms_output.put_line('违反完整性约束,不能删除!');
END;
/


--b.用户自定义异常
DECLARE
	TOO_HIGH_SAL EXCEPTION;
	V_SAL EMPLOYEES.SALARY%TYPE;
BEGIN
	SELECT SALARY INTO V_SAL FROM EMPLOYEES WHERE employee_id=100;
	IF V_SAL > 5000 THEN
		RAISE TOO_HIGH_SAL;
	END IF;
EXCEPTION
	WHEN TOO_HIGH_SAL THEN
		DBMS_OUTPUT.PUT_LINE('工资太高,超过党和人民的底线!'||v_sal);
END;
/















--3.package的使用
--3.1 package的使用,head
CREATE OR REPLACE PACKAGE HELLO IS
	--声明所有过程和函数
	FUNCTION HELLO_FUN(ANAME IN VARCHAR2) RETURN VARCHAR2;
	PROCEDURE HELLO_PRO(BNAME IN VARCHAR2);
END HELLO;
/
--3.2 package的使用,body
CREATE OR REPLACE PACKAGE BODY HELLO IS
	--定义所有私有的变量
	--定义所有公有/私有过程和方法

	--方法01  输出hello
	FUNCTION HELLO_FUN(ANAME IN VARCHAR2) RETURN VARCHAR2 IS
	BEGIN
		RETURN('hello ' || ANAME || ', im function of package!');
	END HELLO_FUN;
	--过程01,调用函数hello
	PROCEDURE HELLO_PRO(BNAME IN VARCHAR2) IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('hello' || BNAME ||
							 ', im procedure of package!');
	END HELLO_PRO;
END HELLO;
/
--调用包的函数
SELECT hello.HELLO_FUN('aaa')  FROM dual;
--调用包的存储过程
BEGIN
  HELLO.HELLO_PRO('naruto');
END;
/


CREATE  FUNCTION aa
RETURN NUMBER AS
BEGIN 
	dbms_output.put_line('lalalla');
  RETURN 1;
END;

CREATE OR REPLACE PROCEDURE AAA IS
BEGIN
	DBMS_OUTPUT.PUT_LINE('123');
END;
DECLARE
begin
SELECT aaa FROM dual;
END;











-----------------


<<dept_block>>         --带块运行总是不行
DECLARE   dept_name    varchar2(30); 
BEGIN   
SELECT department_name   INTO dept_name   FROM departments  
WHERE department_id = 230;   DBMS_OUTPUT.PUT_LINE(dept_name);
 DBMS_OUTPUT.PUT_LINE(dept_name); 
END; 
--output
IT Helpdesk
IT Helpdesk


<<dept_block>> 
DECLARE   dept_name    varchar2(30); 
BEGIN   
SELECT department_name   INTO dept_name   FROM departments   WHERE department_id = 230;   
DBMS_OUTPUT.PUT_LINE(dept_name); 
END dept_block; 
--output
IT Helpdesk
--在PL/SQL中带块名能运行，但没有部门名输出
--PL/SQL 过程已成功完成。




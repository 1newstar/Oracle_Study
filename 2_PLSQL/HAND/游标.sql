--游标的使用
--注意:
--游标只能open一次,再次open就会报错
--处理异常之前最好先关闭游标,处理一次异常前都要关闭游标
--显式游标显式打开显式关闭
--程序正常结束之前必须关闭游标

--注意
--sql和plsql数据类型的区别

--12-29作业
--1.实现一个测试用例,异常处理中关闭游标(系统预设异常/用户自定义异常/other),证明关闭游标很重要的


--0.使用记录类型保存数据,输出100号员工的信息
DECLARE
  --a.声明一个记录类型
  TYPE memp IS RECORD(
       empno employees.employee_id%TYPE,
       empname employees.last_name%TYPE,
       empsal employees.salary%Type
  );
  --b.定义记录类型的成员变量
  vemp memp;
BEGIN
  --c.为记录类型赋值
  SELECT employee_id,last_name,salary INTO vemp  FROM employees WHERE employee_id=100;
  dbms_output.put_line(vemp.empno||' '||vemp.empname||' '||vemp.empsal);
END;
/

--0.1 使用记录类型保存信息
DECLARE
	TYPE mstore IS RECORD(
    	mid NUMBER,
        mname VARCHAR2(20),
        gender VARCHAR2(20)
    );
    
    sto mstore;
BEGIN
	sto.mid:=12;
    sto.mname:='naruto';
	sto.gender:='男';
    dbms_output.put_line(sto.mid||' '||sto.mname||' '||sto.gender);
END;
/

--1.显式游标使用
DECLARE
  --1.定义结果集的记录类型
  TYPE MTYPE IS RECORD(
    EMPNO   EMPLOYEES.EMPLOYEE_ID%TYPE,
    EMPNAME EMPLOYEES.LAST_NAME%TYPE,
    EMPSAL  EMPLOYEES.SALARY%TYPE);
  MT MTYPE;
  --2.定义指针
  CURSOR SOR IS
    SELECT EMPLOYEE_ID, LAST_NAME, SALARY FROM EMPLOYEES;
  EMPCOUNT NUMBER := 0;
BEGIN
  --3.打开游标
  OPEN SOR;
--  OPEN SOR;
  FETCH SOR
    INTO MT;
  LOOP
    EXIT WHEN SOR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(RPAD('编号-->' || MT.EMPNO, 20, ' ') ||
                         RPAD('名字-->' || MT.EMPNAME, 21, ' ') ||
                         RPAD('薪资-->' || MT.EMPSAL, 21, ' '));
  
    FETCH SOR
      INTO MT;
    EMPCOUNT := EMPCOUNT + 1;
  END LOOP;
  --4.关闭游标
  CLOSE SOR;
  DBMS_OUTPUT.PUT_LINE('员工总数:' || EMPCOUNT);
END;  
/
--2.隐式游标使用
DECLARE

BEGIN
  UPDATE EMPLOYEES SET LAST_NAME = '你是傻逼' WHERE EMPLOYEE_ID = 12334;
  IF SQL%NOTFOUND THEN
    DBMS_OUTPUT.PUT_LINE('更新失败...');
  END IF;
END;
/

--3.引用类型的使用  %type    %rowtype
--a.%type
DECLARE
   empid employees.employee_id%TYPE;    
BEGIN
  SELECT employee_id INTO empid FROM employees WHERE UPPER(last_name)='ABEL';
  dbms_output.put_line('待输出的id-->'||empid);
END;
/
--b.%rowtype
DECLARE
  memp employees%ROWTYPE;
BEGIN
  SELECT * INTO memp FROM employees WHERE employee_id=100;
  dbms_output.put_line(memp.employee_id||' '||memp.first_name||' '||memp.last_name||' '||memp.salary);
 END;
/

--练习
--a.打印出100号部门所有员工的信息(使用pl/sql)
--1.loop...exit...
DECLARE
	--①.定义员工信息记录类型
	TYPE hemp IS RECORD(
    	empno employees.employee_id%TYPE,
        empname employees.last_name%TYPE,
        emphire employees.hire_date%TYPE,
    	empsal employees.salary%TYPE,
        empdep employees.department_id%TYPE
    );
    --②.创建类型的对象
    vemp hemp;
	CURSOR empc IS SELECT employee_id,last_name,hire_date,salary,department_id FROM employees WHERE department_id=&depid;
BEGIN
	--③.打开游标
	OPEN empc;
    LOOP
    	EXIT WHEN empc%NOTFOUND;
        dbms_output.put_line(vemp.empno||' '||vemp.empname||' '||vemp.empdep);
        FETCH empc INTO vemp;
    END LOOP;
	--④.关闭游标
	CLOSE empc;
END;
/

--2.while...loop
DECLARE
	--①.定义员工信息记录类型
	TYPE hemp IS RECORD(
    	empno employees.employee_id%TYPE,
        empname employees.last_name%TYPE,
        emphire employees.hire_date%TYPE,
    	empsal employees.salary%TYPE,
        empdep employees.department_id%TYPE
    );
    --②.创建类型的对象
    vemp hemp;
	CURSOR empc IS SELECT employee_id,last_name,hire_date,salary,department_id FROM employees WHERE department_id=&depid;
BEGIN
	--③.打开游标
	OPEN empc;
    FETCH empc INTO vemp; --为什么要写这句话:如果不写的话while的empc%found会返回false,即返回null值
	WHILE empc%FOUND LOOP
	    dbms_output.put_line(vemp.empno||' '||vemp.empname||' '||vemp.emphire||' '||vemp.empsal||' '||vemp.empdep);
   		FETCH empc INTO vemp;
    END LOOP;
	CLOSE empc;
END;
/

--3.for...loop...
--隐式打开
DECLARE
	CURSOR empc IS SELECT employee_id,last_name,hire_date,salary,department_id FROM employees WHERE department_id=&depid;
BEGIN
	for	emp IN empc LOOP
	    dbms_output.put_line(emp.employee_id||' '||emp.last_name||' '||emp.hire_date||' '||emp.salary||' '||emp.department_id);
    END LOOP;
END;
/

DECLARE
	--
BEGIN
	for	emp IN (SELECT * FROM employees) LOOP
	    dbms_output.put_line(emp.employee_id||' '||emp.last_name||' '||emp.hire_date||' '||emp.salary||' '||emp.department_id);
    END LOOP;
END;
/

--plsql实践
--oracle专家编程


    

    





--t1.测试plsql输入提示,本日必做









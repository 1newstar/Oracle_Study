--v_* 表示变量
--c_* 表示常量

--plsql块的练习
--1.annoymous
--前面的都是

--自行测试sql row count

--2.Procedure
PROCEDURE hello IS

BEGIN
	dbms_output.put_line('hello procedure!');
END;

--3.function
FUNCTION func01 RETURN NUMBER IS BEGIN
	RETURN 100;
END;


--这就是匿名块
DECLARE

BEGIN
	func01();
END;
/


--plsql资料11页验证
DECLARE
	variable inum number;
BEGIN
	BEGIN
       	SELECT employee_id INTO :inum FROM employees WHERE last_name='Abel';
    END;
    /
	print inum;
END;




VARIABLE g_salary NUMBER
BEGIN
SELECT salary
INTO :g_salary
FROM employees
WHERE employee_id = 178;
END;
/


--记录类型的使用
DECLARE
	--1.定义记录类型
    TYPE memp IS RECORD(
		emp_no employees.employee_id%TYPE, --保存员工id
        emp_name employees.last_name%TYPE, --保存员工姓名
        emp_sal employees.salary%TYPE      --保存员工薪水
    );
    --2.创建记录类型实例
    v_iemp memp;
BEGIN
	--3.手动为记录类型赋值
    v_iemp.emp_no:=1000;
    v_iemp.emp_name:='xiaoming';
	v_iemp.emp_sal:=12000;
    --4.输出自定义类型的数据
    dbms_output.put_line('编号:'||v_iemp.emp_no||'  名字:'||v_iemp.emp_name||'  薪水:'||v_iemp.emp_sal);
END;
/

--记录类型结合游标使用
DECLARE
	--1.定义记录类型
	TYPE MEMP IS RECORD(
		EMP_NO   EMPLOYEES.EMPLOYEE_ID%TYPE, --保存员工id
		EMP_NAME EMPLOYEES.LAST_NAME%TYPE, --保存员工姓名
		EMP_SAL  EMPLOYEES.SALARY%TYPE --保存员工薪水
		);
	--2.创建记录类型实例
	V_IEMP MEMP;
	--3.定义一个游标
	CURSOR EMPC IS
		SELECT EMPLOYEE_ID, LAST_NAME, SALARY FROM EMPLOYEES;
BEGIN
	--重要一:打开游标
	OPEN EMPC;
	--4.循环打印数据
	LOOP
		EXIT WHEN EMPC%NOTFOUND;
		--5.将游标的数据捕获到记录类型中
		FETCH EMPC
			INTO V_IEMP;
		--6.输出自定义类型的数据
		DBMS_OUTPUT.PUT_LINE('编号:' || V_IEMP.EMP_NO || '  名字:' ||
							 V_IEMP.EMP_NAME || '  薪水:' || V_IEMP.EMP_SAL);
	END LOOP;
	--重要二:关闭游标
	CLOSE EMPC;
END;
/

--1.陈光把截图发群里了

--2.测试sql%rowcount

--3.测试异常



--数据库触发器暂时不用了解,扯淡


--验证游标
DECLARE
	--存储emp
	TYPE memp IS RECORD(
    	emp_id employees.employee_id%TYPE,
        emp_name employees.last_name,
        emp_sal employees.salary
    );
    --存储dep
    TYPE mdep IS RECORD(
    	dep_id departments.department_id%TYPE,
        dep_name departments.department_name%TYPE, 
    );
	--emp游标
	CURSOR EMPC IS
		SELECT * FROM EMPLOYEES;
	--dep游标
	CURSOR DEPC IS
		SELECT * FROM DEPARTMENTS;
	--loc游标
	CURSOR LOCC IS
		SELECT * FROM LOCATIONS;
	--job游标
	CURSOR JOBC IS
		SELECT * FROM JOBS;
	--job_his游标
	CURSOR JOBHC IS
		SELECT * FROM JOB_HISTORY;
	--cou游标
	CURSOR COUC IS
		SELECT * FROM COUNTRIES;
	--reg游标
	CURSOR REGC IS
		SELECT * FROM REGIONS;
BEGIN
	OPEN EMPC;
	OPEN DEPC;

END;
/




SELECT employee_id AS "编号",
  last_name        AS "名字",
  department_id    AS "部门编号",
  --                          if         esif     else
  DECODE(department_id,10,'我是10', 20,'我是20', '我是30') AS "decode语句"
FROM employees
WHERE department_id IN (10,20,30);

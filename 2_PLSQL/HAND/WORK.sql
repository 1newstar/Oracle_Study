--2016-12-19 作业
--1.按照部门编号获取(部门编号自行输入)
DECLARE
	--总工资
	TOTAL_STAFF NUMBER := 0;
	--总人数
	TOTAL_SALARY NUMBER := 0;
	--异常信息
	EXCE_INFO VARCHAR2(30);
BEGIN
	--输出工资
	DBMS_OUTPUT.PUT_LINE('工资表');
	--输出表格标题
	DBMS_OUTPUT.PUT_LINE(RPAD('员工编号', 20, ' ') || RPAD('员工姓名', 30, ' ') ||
						 RPAD('薪水', 20, ' '));
	--for循环获取游标数据,并且接受用户输入
	FOR EMP IN (SELECT *
				  FROM EMPLOYEES
				 WHERE DEPARTMENT_ID = &DEP_ID
				 ORDER BY EMPLOYEE_ID) LOOP
		--输出薪资信息
		DBMS_OUTPUT.PUT_LINE(RPAD(EMP.EMPLOYEE_ID || '', 20, ' ') ||
							 RPAD(EMP.FIRST_NAME || ' ' || EMP.LAST_NAME,
								  30,
								  ' ') || RPAD(EMP.SALARY, 20, ' '));
		TOTAL_STAFF  := TOTAL_STAFF + 1;
		TOTAL_SALARY := TOTAL_SALARY + EMP.SALARY;
	END LOOP;
	--输出统计信息
	DBMS_OUTPUT.PUT_LINE(RPAD('部门编号:' || &DEP_ID, 20, ' ') ||
						 RPAD('员工人数:' || TOTAL_STAFF, 20, ' ') ||
						 RPAD(' 总工资:' || TOTAL_SALARY, 30, ' ') ||
						 RPAD(' 平均工资:' ||
							  ROUND(TOTAL_SALARY / TOTAL_STAFF, 2),
							  20,
							  ' '));
	--异常处理
EXCEPTION
	WHEN ZERO_DIVIDE THEN
		DBMS_OUTPUT.PUT_LINE(EXCE_INFO || '部门的人数为0!');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('发生其他异常!');
END;
/

--2.测试sql%rowcount--每一次打印都输出一次rowcount的值,并与自定义的icount(自定义计数器,遍历游标的时候依次 +1),
--同时输出这两个数据并进行比较,同时输出employee_id进行辅助证明
--证明结果:sql%rowcount表示游标当前遍历的行数
DECLARE
--声明游标
CURSOR EMPC IS
	SELECT * FROM EMPLOYEES;
--声明自定义行数计数器
ICOUNT NUMBER := 0;
BEGIN
	--输出表格标题
	DBMS_OUTPUT.PUT_LINE(RPAD('-ROWCOUNT-', 15, ' ') ||
						 RPAD('-ICOUNT-', 15, ' ') ||
						 RPAD('-EMP_ID-', 15, ' '));
	--DBMS_OUTPUT.PUT_LINE(RPAD('ROWCOUNT:' || EMPC%ROWCOUNT, 15, ' '));--游标打开之前不能获取rowcount
	--使用for循环从游标中取数据
	FOR EMP IN EMPC LOOP
		--计数器加1
		ICOUNT := ICOUNT + 1;
		--输出rowcount,icount,emp_id
		DBMS_OUTPUT.PUT_LINE(RPAD('ROWCOUNT:' || EMPC%ROWCOUNT, 15, ' ') ||
							 RPAD('ICOUNT:' || ICOUNT, 15, ' ') ||
							 RPAD('EMP_ID:' || EMP.EMPLOYEE_ID, 15, ' '));
	END LOOP;
	--DBMS_OUTPUT.PUT_LINE(RPAD('ROWCOUNT:' || EMPC%ROWCOUNT, 15, ' '));--游标关闭之后不能获取rowcount
END;
/

--3.测试游标未关闭异常
--思路:分别验证3个游标验证不同的游标打开情况
DECLARE
--emp游标
CURSOR EMPC IS
	SELECT EMPLOYEE_ID, LAST_NAME, SALARY FROM EMPLOYEES;
--dep游标
CURSOR DEPC IS
	SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS;
--loc游标
CURSOR LOCC IS
	SELECT LOCATION_ID, STREET_ADDRESS, CITY FROM LOCATIONS;
BEGIN
	--操作01:游标open之后再次open,错误操作
	OPEN EMPC;
	OPEN EMPC;
	--结果01:一个游标不能open两次

	--操作02:游标open之后关闭再次open,正确操作
	OPEN DEPC;
	CLOSE DEPC;
	OPEN DEPC;
	--结果02:一个游标第二次打开之前必须先关闭

	--操作03:游标open之前先close,错误操作
	CLOSE LOCC;
	OPEN LOCC;
	--结果03:游标close之前必须open
END;
/


--郭美蓉
DECLARE
	--记录变量保存department信息
	TYPE V_EMP IS RECORD(
		EMP_ID   EMPLOYEES.EMPLOYEE_ID%TYPE,
		EMP_NAME EMPLOYEES.LAST_NAME%TYPE,
		EMP_SAL  EMPLOYEES.SALARY%TYPE,
		EMP_DEP  EMPLOYEES.DEPARTMENT_ID%TYPE);
	--声明自定义类型
	C_EMP V_EMP;
	--声明游标
	CURSOR CUR_EMP IS
		SELECT EMPLOYEE_ID, LAST_NAME, SALARY, DEPARTMENT_ID
		  FROM EMPLOYEES
		 ORDER BY EMPLOYEE_ID;

BEGIN
	--重点:打开游标
	-- dbms_output.put_line('游标打开之前:'|| cur_emp%ROWCOUNT); --验证在open之前不能使用cur_emp%ROWCOUNT
	OPEN CUR_EMP;
	--DBMS_OUTPUT.PUT_LINE('游标打开之后and遍历之前:' || CUR_EMP%ROWCOUNT); --验证sql%notfound只能在open之后获取
	--使用loop循环遍历游标
	LOOP
		EXIT WHEN CUR_EMP%NOTFOUND;
		FETCH CUR_EMP
			INTO C_EMP;
		DBMS_OUTPUT.PUT_LINE(C_EMP.EMP_ID || '    ' ||
							 RPAD(C_EMP.EMP_NAME, 15, ' ') ||
							 RPAD(CUR_EMP%ROWCOUNT || '', 10, ' '));
	END LOOP;
	--重点:关闭游标
	--dbms_output.put_line('游标关闭之前:'|| cur_emp%ROWCOUNT); --验证游标在关闭之前可以使用
	CLOSE CUR_EMP;
	dbms_output.put_line('游标关闭之后:'|| cur_emp%ROWCOUNT);--验证游标关闭之后不可以使用
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('sql%rowcount异常!');
END;
/


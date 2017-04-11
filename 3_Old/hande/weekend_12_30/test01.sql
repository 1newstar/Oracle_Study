--1.判断下列不合法的声明并且解释原因
--a.不合法
DECLARE
	v_name VARCHAR(20);
    v_dept VARCHAR2(20);
BEGIN
	v_name:='name';
    v_dept:='leafdept';
	dbms_output.put_line(v_name||' '||v_dept);
END;
/

--b.正确
DECLARE
	v_test NUMBER(5);
BEGIN
	v_test:=50;
	dbms_output.put_line(v_test);
END;
/

--c.正确
DECLARE
	v_test NUMBER(7,2);
BEGIN
	v_test:=5000;
	dbms_output.put_line(v_test);
END;
/
--d.错误
DECLARE
	v_date BOOLEAN := SYSDATE;
BEGIN
	dbms_output.put_line(''||v_date);
END;
/

--2.
--a.varchar2
DECLARE
	v_date VARCHAR(20) := 'aaaa '||to_char(' lalalala');
BEGIN
	dbms_output.put_line(v_date);
END;
/
--b.错误,返回了无效的月份
--c.number
DECLARE
	v_sal NUMBER:=(10*12)+500;
BEGIN
	dbms_output.put_line(v_sal);
END;
/
--d.boolean
--e.boolean
DECLARE
	v_sal BOOLEAN;
BEGIN
    v_sal:=(1>2);
	IF v_sal=TRUE THEN
		dbms_output.put_line('true');
    ELSE 
    	dbms_output.put_line('false');
    END IF;
END;
/
--f.date

--SELECT TO_CHAR(TO_DATE('04-JUL-15', 'DD-MON-RR'), 'DD-MON-YYYY'),TO_CHAR(TO_DATE('04-JUL-55', 'DD-MON-RR'), 'DD-MON-YYYY') FROM dual;

--3.
DECLARE
	v_custid	 NUMBER(4) := 1600;
	v_custname	 VARCHAR2(300) := 'Women Sports Club';
	v_new_custid	 NUMBER(3) := 500;
BEGIN
  	DECLARE
	  	v_custid	  NUMBER(4) := 0;
	  	v_custname  VARCHAR2(300) := 'Shape up Sports Club';
	  	v_new_custid  NUMBER(3) := 300;
	  	v_new_custname  VARCHAR2(300) := 'Jansports Club';
  	BEGIN
	  	v_custid := v_new_custid;
	  	v_custname := v_custname || ' ' ||  v_new_custname;
--(1)
        dbms_output.put_line(v_custid); --a 300
        dbms_output.put_line(V_NEW_CUSTNAME); --d 'Jansports Club'
  	END;
--(2)
	dbms_output.put_line(v_custname); --b 'Women Sports Club'
    dbms_output.put_line(V_NEW_CUSTID); --c 500
    dbms_output.put_line(V_CUSTID); --e 1600
    dbms_output.put_line(V_CUSTNAME); --f 'Women Sports Club'
	v_custid := (v_custid *12) / 10;
END;
/

--猜想一:内部块会改变外部块的值,这个猜想是错误的
--a.V_CUSTID在（1）的值是: 300  (对)
--b.V_CUSTNAME 在（2）的值是: 'Shape up Sports Club - Jansports Club' (错)
--c.V_NEW_CUSTID 在（2）的值是: 300 (错)
--d.V_NEW_CUSTNAME 在（1）的值是: 'Jansports Club' (对)
--e.V_CUSTID 在（2）的值是: 300  (错)
--f.V_CUSTNAME 在（2）的值是: 'Shape up Sports Club - Jansports Club' (错)


--4.判断某一年是不是闰年
/*
if((num%4==0&&num%100!=0)||(num%400==0)){
			System.out.println(num+" yes!");
		}else{
			System.out.println(num+" no!");
		}
*/
DECLARE
	INUM NUMBER(4);
BEGIN
	INUM := &YEARS;
	IF (((MOD(INUM,4) = 0) AND (MOD(INUM,100) <> 0)) OR (MOD(INUM,400) = 0)) THEN
		DBMS_OUTPUT.PUT_LINE(INUM || '是闰年!');
	ELSE
		DBMS_OUTPUT.PUT_LINE(INUM || '不是闰年!');
	END IF;
END;
/


SELECT MOD(309,100) FROM dual;




--6.
--a.sqlplus替换变量存储部门编号
DECLARE
	dep_id NUMBER;
BEGIN
	dep_id := &&depno;
    dbms_output.put_line(&dep_id);
END;
/

--b.输出工作在某部门的员工数量
DECLARE 
	--员工数量
	total_emp NUMBER:=0;
    --部门编号
    dep_id NUMBER;
BEGIN
	dep_id:=&depid;--接受输入
   	SELECT COUNT(*) INTO total_emp FROM employees GROUP BY department_id HAVING department_id=dep_id; --查询部门总数
    dbms_output.put_line(dep_id||'部门有'||total_emp||'个员工');--打印结果
END;
/

--SELECT department_id,COUNT(*) FROM employees GROUP BY department_id;


--7,打印员工薪资
DECLARE
	i_last_name VARCHAR2(30);--员工姓名
    v_salary NUMBER;--薪资
BEGIN
	i_last_name:= '&lastnl';--接受输入
	SELECT salary INTO v_salary FROM employees WHERE LOWER(LAST_NAME) = i_last_name;
    IF v_salary<3000 THEN
		dbms_output.put_line(i_last_name||' '||v_salary||'-->'||(v_salary+500)||',工资已经涨了500块!');
    ELSIF v_salary >= 3000 THEN
    	dbms_output.put_line(i_last_name||' '||v_salary);
    END IF;
EXCEPTION
WHEN too_many_rows THEN
	dbms_output.put_line('匹配了太多行!');
END;
/

SELECT * FROM employees WHERE salary<3000;


--8.薪水以及奖金的计算
DECLARE
	annual_salary NUMBER:=0;
    v_bonus NUMBER:=0;
    CURSOR empc IS SELECT * FROM employees;
BEGIN
	FOR emp IN empc LOOP
    	annual_salary:=emp.salary*12;
		IF annual_salary >= 200000 THEN 
        	dbms_output.put_line(RPAD('salary:'||emp.salary,20,' ')||
            					RPAD('bones:'||2000,20,' '));
        ELSIF annual_salary>100000 AND annual_salary<199999 THEN
            dbms_output.put_line(RPAD('salary:'||emp.salary,20,' ')||
            					RPAD('bones:'||1000,20,' '));
		ELSIF annual_salary<=9999 THEN 
                	dbms_output.put_line(RPAD('salary:'||emp.salary,20,' ')||
            					RPAD('bones:'||500,20,' '));
        END IF;
	END LOOP;
END;
/


--9.更新部门编号和薪水,用EMP表更新新的部门编号和薪水涨幅，更新成功显式'update complete',失败显式'no data found'
--a.为了保护数据库的数据,复制表employees
CREATE TABLE emp1 AS SELECT * FROM employees;
DECLARE
	--定义员工id,部门id,薪水涨幅,以及员工是否存在的标记flag
	v_nemp_id NUMBER:=&empid;
    v_ndep_id NUMBER:=&dep;
    v_new_com NUMBER(4,2):=&comm;
    v_flag NUMBER;
BEGIN
	--判断员工是否存在,不存在就抛出异常
	SELECT employee_id INTO v_flag  FROM emp1 WHERE employee_id=v_nemp_id;
    IF v_flag IS NULL THEN
	   	RAISE no_data_found;
    END IF;
    --更新员工表
	UPDATE emp1 SET department_id=v_ndep_id , commission_pct=v_new_com WHERE employee_id=v_nemp_id; 
    dbms_output.put_line('update complete!');
EXCEPTION
	--出现异常,显示异常信息
	WHEN no_data_found THEN
    	dbms_output.put_line('no data found!');
   	WHEN OTHERS THEN
    	dbms_output.put_line('others error!');
END;
/


SELECT * FROM emp1 ;

--10.创建一个匿名块来定义一个游标EMP_CUR，游标内有EMPLOYEES表内的员工姓名、薪水、入职时间，
--处理游标里每一行数据，如果薪水大于1500并且入职时间晚于1988年2月1号，显示此员工的相关信息
DECLARE
	--定义一个employees的游标
    CURSOR empc IS SELECT * FROM employees ORDER BY hire_date;
BEGIN
	dbms_output.put_line(to_char(to_date('2007-2-12','yyyy-mm-dd'),'yyyy-mm-dd')||'之前入职的员工信息:');
	FOR emp IN empc LOOP
		IF emp.salary>1500 AND emp.hire_date>to_date('2007-2-12','yyyy-mm-dd') THEN
        	dbms_output.put_line(RPAD('编号:'||emp.employee_id,20,' ')||
            					RPAD('姓名:'||emp.last_name,20,' ')||
            					 RPAD('薪水:'||emp.salary,20,' ')||
					     		 RPAD('入职时间:'||to_char(emp.hire_date,'yyyy-mm-dd'),20,' '));
        END IF;
    END LOOP;
END;
/


--11.检索员工表内所有员工号（EMPLOYEE_ID）小于114的员工姓名及部门编号，从得到的数据建立两个表
DECLARE
	CURSOR empc IS SELECT * FROM employees WHERE employee_id<114;
BEGIN
	FOR emp IN empc LOOP
		dbms_output.put_line(RPAD('编号:'||emp.employee_id,20,' ')||RPAD('名字:'||emp.last_name,20,' ')||RPAD('部门编号:'||emp.department_id,20,' '));    
    END LOOP;
END;
/



--12.创建一个匿名块，声明一个DATE_CUR游标，传递一个日期类型参数给游标，
--并且输出所有入职晚于这一日期的员工的具体信息
DECLARE
	IDATE DATE := TO_DATE('&indval', 'yyyy-mm-dd');
	CURSOR EMPC IS
		SELECT * FROM EMPLOYEES WHERE HIRE_DATE > IDATE ORDER BY hire_date;
BEGIN
	DBMS_OUTPUT.PUT_LINE('晚于' || TO_CHAR(IDATE, 'yyyy-mm-dd') ||
						 '入职的员工信息:');
	FOR EMP IN EMPC LOOP
		DBMS_OUTPUT.PUT_LINE(RPAD('编号:'||emp.employee_id,20,' ')||
        						RPAD('姓名:'||emp.last_name,20,' ')||
                                RPAD('年份:'||to_char(emp.hire_date,'yyyy-mm-dd'),20,' '));
	END LOOP;
END;
/

--13.创建一个块，给工资超过3000而且工作是SH_CLERK(SR CLERK未找到)的员工涨10%的薪水，使用
--游标 FOR UPDATE 和current of语法
DECLARE
	CURSOR EMPC IS
		SELECT *
		  FROM EMP1
		 WHERE SALARY > 3000
		   AND JOB_ID = 'SH_CLERK';
BEGIN
	FOR EMP IN EMPC LOOP
		DBMS_OUTPUT.PUT_LINE(RPAD('员工编号:' || EMP.EMPLOYEE_ID, 20, ' ')||
        					RPAD('姓名:' || EMP.LAST_NAME, 20, ' ')||
                            RPAD('薪水:' || EMP.SALARY, 20, ' ')||
                            RPAD('加薪啦:' || EMP.SALARY*(1+0.1),20,' ')||
                            RPAD('工作:' || EMP.JOB_ID, 20, ' '));
        UPDATE EMP1
		   SET salary=(SALARY *(1 + 0.1))
		 WHERE EMPLOYEE_ID = EMP.EMPLOYEE_ID;
	END LOOP;
    dbms_output.put_line('数据更新完成!');
END;
/

--15.创建一个ADD_JOBS存储过程来输入新的命令到JOBS表里。 
--这个过程应该接受三个变量，分别是JOB_ID， JOB_TITLE，min_salary，每个JOB_ID的最大工资更新为最小工资的两倍；
--a.拷贝jobs表,不带数据
--CREATE TABLE jobs1 AS SELECT * FROM jobs WHERE 1=2;
CREATE OR REPLACE PROCEDURE add_jobs(job_id VARCHAR2,job_title VARCHAR2,min_salary NUMBER) IS 
	
BEGIN
	INSERT INTO jobs1 VALUES(job_id,job_title,min_salary,min_salary*2);
    dbms_output.put_line('插入成功!');
END;
--测试
DECLARE
BEGIN
	add_jobs('SY_ANAL','System Analyst',6000);
END;
/
SELECT * FROM jobs1;
--16.创建一个名称为ADD_JOB_HIST的存储过程在JOB_HISTORY表添加新一行，要求该员工的job_id改成第15题b创建的job_id.
--使用更换了工作的员工号（employee ID ）、新的工作编号（job ID ）作为参量。并从EMPLOYEES表中获得相应的员工编号插入到JOB_HISTORY表。
--在JOB_HISTORY表中将员工的雇佣时间作为开始时间，系统时间作为结束时间；
--在EMPLOYEES表中将雇佣时间设为今天的日期，更新员工的job_id为15题b创建的job_id，并且工资等于job_id+500员工的最小工资；
--包含例外程序处理当插入一个不存在的员工。此表的工作编号，而且水于该共醉最小薪水加上500
--a.拷贝job_history
--CREATE TABLE job_his1 AS SELECT * FROM job_history;
CREATE OR REPLACE PROCEDURE add_job_hist(emp_id NUMBER,job_id VARCHAR2) IS
	start_date employees.hire_date%TYPE;
	dep_id employees.department_id%TYPE;
BEGIN
	SELECT hire_date,department_id INTO start_date,dep_id FROM emp1 WHERE employee_id=emp_id;
	  
    --to_date(to_char(SYSDATE,'yyyy-mm-dd'),'yyyy-mm-dd'):插入yyyy-mm-dd日期的类型
    INSERT INTO job_his1 VALUES(emp_id,start_date,to_date(to_char(SYSDATE,'yyyy-mm-dd'),'yyyy-mm-dd'),job_id,dep_id);
    
	--在EMPLOYEES表中将雇佣时间设为今天的日期，更新员工的job_id为15题b创建的job_id，并且工资等于job_id+500员工的最小工资
    UPDATE emp1 SET hire_date =to_date(to_char(SYSDATE,'yyyy-mm-dd'),'yyyy-mm-dd') WHERE employee_id=emp_id;
    dbms_output.put_line(emp_id||'  '||to_char(start_date,'yyyy-mm-dd')||'  '||job_id||'  '||dep_id||'  his插入成功!emp1表更新完成!');    
EXCEPTION
	WHEN no_data_found THEN
    	dbms_output.put_line('数据未发现!');
	WHEN OTHERS THEN
    	dbms_output.put_line('others的错误!');
END;

--调用
DECLARE
BEGIN
	add_job_hist(100,'SY_ANAL');
END;
/

--17.创建一个存储过程UPD_SAL来更新JOBS表一个特定job_id的最小工资和最大工资,
--传递三个参数给过程：工作编号，新最小工资，新最大工资。增加例外处理无效的的工作编号。
--当然，当最大工资小于最小工资，抛出一个例外。如果jobs表中数据被锁或者无法改变则在窗口中显示合适的消息
--被锁现在是无法判断的
--创建jobs的副本,从此开始,操作副本
--CREATE TABLE jobs2 AS SELECT * FROM jobs;
CREATE OR REPLACE PROCEDURE UPD_SAL(JOB_IN  VARCHAR,
									MIN_SAL NUMBER,
									MAX_SAL NUMBER) IS
	DATA_NOT_MATCH EXCEPTION;
	ISOK VARCHAR(35);
BEGIN
	--判断数据是否可以找到
	SELECT JOB_TITLE INTO ISOK FROM JOBS2 WHERE JOB_ID = JOB_IN;
	IF MIN_SAL > MAX_SAL THEN
		RAISE DATA_NOT_MATCH;
	END IF;
	UPDATE JOBS2
	   SET MIN_SALARY = MIN_SAL, MAX_SALARY = MAX_SAL
	 WHERE JOB_ID = JOB_IN;
	DBMS_OUTPUT.PUT_LINE('更新完成!');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('未找到数据!工作ID未发现!');
	WHEN DATA_NOT_MATCH THEN
		DBMS_OUTPUT.PUT_LINE('数据异常!最小值大于最大值!');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('others错误!');
END;/
--调用17
DECLARE

BEGIN
	upd_sal('AD_PRES',110,2011);
END;
/



--18.创建一个过程监视员工是否已经超过平均工资,有点无法理解题意
--a.创建employees的副本,从此开始操作这个副本
--CREATE TABLE emp2 AS SELECT * FROM employees;
--b.执行脚本
/*
ALTER TABLE emp2
	 ADD (sal_limit_indicate  VARCHAR2(3) DEFAULT 'NO'
  	      CONSTRAINT emp_sallimit_ck CHECK
           (sal_limit_indicate IN ('YES', 'NO')));
ALTER TABLE emp2
	 DROP COLUMN sal_limit_indicate;    
*/
CREATE OR REPLACE PROCEDURE check_avg_sal(emp_id NUMBER) IS 
	
BEGIN
	NULL;
END;

--19.创建一个程序检索某个员工的工龄,错误,好好读题,2017-01-03 10:28开始修改
--如果返回-1,那么说明没有这个员工
SELECT * FROM JOB_HISTORY;
CREATE OR REPLACE FUNCTION GET_SERVICE_YRS(EMP_ID NUMBER)
	RETURN NUMBER IS STARTDATE DATE; --保存开始日期
ENDDATE DATE; --保存结束日期
ISOK NUMBER; --保存是否查找到对应员工
BET_YEAR NUMBER(4, 2); --保存入职年份
BEGIN
	--判断员工是否存在
	SELECT EMPLOYEE_ID INTO ISOK FROM EMPLOYEES WHERE EMPLOYEE_ID = EMP_ID;
	IF ISOK IS NULL THEN
		RAISE NO_DATA_FOUND;
	END IF;
	--获取雇佣日期
	SELECT START_DATE, END_DATE
	  INTO STARTDATE, ENDDATE
	  FROM EMPLOYEES EMP, JOB_HISTORY HIS
	 WHERE EMP.EMPLOYEE_ID = HIS.EMPLOYEE_ID;
	--计算年份
	BET_YEAR := MONTHS_BETWEEN(ENDDATE, STARTDATE);
	--返回入职年份
	RETURN BET_YEAR;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		--异常处理无效的员工输入
		DBMS_OUTPUT.PUT_LINE('未查找到数据!');
		RETURN - 1;
END;
/
--调用函数
SELECT GET_SERVICE_YRS(emp.employee_id) FROM employees emp,job_history his WHERE emp.employee_id=his.employee_id;
SELECT * FROM employees emp,job_history his WHERE emp.employee_id=his.employee_id;
SELECT * FROM job_history ORDER BY employee_id;
SELECT GET_SERVICE_YRS(101) FROM dual;
EXECUTE dbms_output.put_line(GET_SERVICE_YRS(100));





--20.创建一个程序检索员工在任职期间的工作数量
CREATE OR REPLACE FUNCTION get_job_count(emp_id NUMBER) RETURN NUMBER IS 
	job_count NUMBER;--保存做过的工作数
BEGIN
	--获取工作的个数
	SELECT COUNT(employee_id) INTO job_count FROM job_history WHERE employee_id=emp_id GROUP BY employee_id;
	--返回工作个数
    RETURN job_count;
END;
/
--调用函数
SELECT (SELECT last_name FROM employees WHERE employee_id=&empid)||'做过'||get_job_count(&empid)||'个工作!' FROM dual;


--21.创建一个包和包体叫做EMP_JOB_PKG，包含 ADD_JOBS,ADD_JOB_HIST, 和 UPD_SAL过程，和GET_SERVICE_YRS函数
--
SELECT employee_id,COUNT(employee_id) FROM job_history GROUP BY employee_id;
SELECT * FROM emp2;

SELECT * FROM user_tables;

ROLLBACK;

SELECT * FROM employees;
ALTER TABLE employees
	 DROP COLUMN sal_limit_indicate;  
SELECT * FROM jobs1;


SELECT * FROM jobs;





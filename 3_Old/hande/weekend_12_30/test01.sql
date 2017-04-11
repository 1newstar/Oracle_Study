--1.�ж����в��Ϸ����������ҽ���ԭ��
--a.���Ϸ�
DECLARE
	v_name VARCHAR(20);
    v_dept VARCHAR2(20);
BEGIN
	v_name:='name';
    v_dept:='leafdept';
	dbms_output.put_line(v_name||' '||v_dept);
END;
/

--b.��ȷ
DECLARE
	v_test NUMBER(5);
BEGIN
	v_test:=50;
	dbms_output.put_line(v_test);
END;
/

--c.��ȷ
DECLARE
	v_test NUMBER(7,2);
BEGIN
	v_test:=5000;
	dbms_output.put_line(v_test);
END;
/
--d.����
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
--b.����,��������Ч���·�
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

--����һ:�ڲ����ı��ⲿ���ֵ,��������Ǵ����
--a.V_CUSTID�ڣ�1����ֵ��: 300  (��)
--b.V_CUSTNAME �ڣ�2����ֵ��: 'Shape up Sports Club - Jansports Club' (��)
--c.V_NEW_CUSTID �ڣ�2����ֵ��: 300 (��)
--d.V_NEW_CUSTNAME �ڣ�1����ֵ��: 'Jansports Club' (��)
--e.V_CUSTID �ڣ�2����ֵ��: 300  (��)
--f.V_CUSTNAME �ڣ�2����ֵ��: 'Shape up Sports Club - Jansports Club' (��)


--4.�ж�ĳһ���ǲ�������
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
		DBMS_OUTPUT.PUT_LINE(INUM || '������!');
	ELSE
		DBMS_OUTPUT.PUT_LINE(INUM || '��������!');
	END IF;
END;
/


SELECT MOD(309,100) FROM dual;




--6.
--a.sqlplus�滻�����洢���ű��
DECLARE
	dep_id NUMBER;
BEGIN
	dep_id := &&depno;
    dbms_output.put_line(&dep_id);
END;
/

--b.���������ĳ���ŵ�Ա������
DECLARE 
	--Ա������
	total_emp NUMBER:=0;
    --���ű��
    dep_id NUMBER;
BEGIN
	dep_id:=&depid;--��������
   	SELECT COUNT(*) INTO total_emp FROM employees GROUP BY department_id HAVING department_id=dep_id; --��ѯ��������
    dbms_output.put_line(dep_id||'������'||total_emp||'��Ա��');--��ӡ���
END;
/

--SELECT department_id,COUNT(*) FROM employees GROUP BY department_id;


--7,��ӡԱ��н��
DECLARE
	i_last_name VARCHAR2(30);--Ա������
    v_salary NUMBER;--н��
BEGIN
	i_last_name:= '&lastnl';--��������
	SELECT salary INTO v_salary FROM employees WHERE LOWER(LAST_NAME) = i_last_name;
    IF v_salary<3000 THEN
		dbms_output.put_line(i_last_name||' '||v_salary||'-->'||(v_salary+500)||',�����Ѿ�����500��!');
    ELSIF v_salary >= 3000 THEN
    	dbms_output.put_line(i_last_name||' '||v_salary);
    END IF;
EXCEPTION
WHEN too_many_rows THEN
	dbms_output.put_line('ƥ����̫����!');
END;
/

SELECT * FROM employees WHERE salary<3000;


--8.нˮ�Լ�����ļ���
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


--9.���²��ű�ź�нˮ,��EMP������µĲ��ű�ź�нˮ�Ƿ������³ɹ���ʽ'update complete',ʧ����ʽ'no data found'
--a.Ϊ�˱������ݿ������,���Ʊ�employees
CREATE TABLE emp1 AS SELECT * FROM employees;
DECLARE
	--����Ա��id,����id,нˮ�Ƿ�,�Լ�Ա���Ƿ���ڵı��flag
	v_nemp_id NUMBER:=&empid;
    v_ndep_id NUMBER:=&dep;
    v_new_com NUMBER(4,2):=&comm;
    v_flag NUMBER;
BEGIN
	--�ж�Ա���Ƿ����,�����ھ��׳��쳣
	SELECT employee_id INTO v_flag  FROM emp1 WHERE employee_id=v_nemp_id;
    IF v_flag IS NULL THEN
	   	RAISE no_data_found;
    END IF;
    --����Ա����
	UPDATE emp1 SET department_id=v_ndep_id , commission_pct=v_new_com WHERE employee_id=v_nemp_id; 
    dbms_output.put_line('update complete!');
EXCEPTION
	--�����쳣,��ʾ�쳣��Ϣ
	WHEN no_data_found THEN
    	dbms_output.put_line('no data found!');
   	WHEN OTHERS THEN
    	dbms_output.put_line('others error!');
END;
/


SELECT * FROM emp1 ;

--10.����һ��������������һ���α�EMP_CUR���α�����EMPLOYEES���ڵ�Ա��������нˮ����ְʱ�䣬
--�����α���ÿһ�����ݣ����нˮ����1500������ְʱ������1988��2��1�ţ���ʾ��Ա���������Ϣ
DECLARE
	--����һ��employees���α�
    CURSOR empc IS SELECT * FROM employees ORDER BY hire_date;
BEGIN
	dbms_output.put_line(to_char(to_date('2007-2-12','yyyy-mm-dd'),'yyyy-mm-dd')||'֮ǰ��ְ��Ա����Ϣ:');
	FOR emp IN empc LOOP
		IF emp.salary>1500 AND emp.hire_date>to_date('2007-2-12','yyyy-mm-dd') THEN
        	dbms_output.put_line(RPAD('���:'||emp.employee_id,20,' ')||
            					RPAD('����:'||emp.last_name,20,' ')||
            					 RPAD('нˮ:'||emp.salary,20,' ')||
					     		 RPAD('��ְʱ��:'||to_char(emp.hire_date,'yyyy-mm-dd'),20,' '));
        END IF;
    END LOOP;
END;
/


--11.����Ա����������Ա���ţ�EMPLOYEE_ID��С��114��Ա�����������ű�ţ��ӵõ������ݽ���������
DECLARE
	CURSOR empc IS SELECT * FROM employees WHERE employee_id<114;
BEGIN
	FOR emp IN empc LOOP
		dbms_output.put_line(RPAD('���:'||emp.employee_id,20,' ')||RPAD('����:'||emp.last_name,20,' ')||RPAD('���ű��:'||emp.department_id,20,' '));    
    END LOOP;
END;
/



--12.����һ�������飬����һ��DATE_CUR�α꣬����һ���������Ͳ������α꣬
--�������������ְ������һ���ڵ�Ա���ľ�����Ϣ
DECLARE
	IDATE DATE := TO_DATE('&indval', 'yyyy-mm-dd');
	CURSOR EMPC IS
		SELECT * FROM EMPLOYEES WHERE HIRE_DATE > IDATE ORDER BY hire_date;
BEGIN
	DBMS_OUTPUT.PUT_LINE('����' || TO_CHAR(IDATE, 'yyyy-mm-dd') ||
						 '��ְ��Ա����Ϣ:');
	FOR EMP IN EMPC LOOP
		DBMS_OUTPUT.PUT_LINE(RPAD('���:'||emp.employee_id,20,' ')||
        						RPAD('����:'||emp.last_name,20,' ')||
                                RPAD('���:'||to_char(emp.hire_date,'yyyy-mm-dd'),20,' '));
	END LOOP;
END;
/

--13.����һ���飬�����ʳ���3000���ҹ�����SH_CLERK(SR CLERKδ�ҵ�)��Ա����10%��нˮ��ʹ��
--�α� FOR UPDATE ��current of�﷨
DECLARE
	CURSOR EMPC IS
		SELECT *
		  FROM EMP1
		 WHERE SALARY > 3000
		   AND JOB_ID = 'SH_CLERK';
BEGIN
	FOR EMP IN EMPC LOOP
		DBMS_OUTPUT.PUT_LINE(RPAD('Ա�����:' || EMP.EMPLOYEE_ID, 20, ' ')||
        					RPAD('����:' || EMP.LAST_NAME, 20, ' ')||
                            RPAD('нˮ:' || EMP.SALARY, 20, ' ')||
                            RPAD('��н��:' || EMP.SALARY*(1+0.1),20,' ')||
                            RPAD('����:' || EMP.JOB_ID, 20, ' '));
        UPDATE EMP1
		   SET salary=(SALARY *(1 + 0.1))
		 WHERE EMPLOYEE_ID = EMP.EMPLOYEE_ID;
	END LOOP;
    dbms_output.put_line('���ݸ������!');
END;
/

--15.����һ��ADD_JOBS�洢�����������µ����JOBS��� 
--�������Ӧ�ý��������������ֱ���JOB_ID�� JOB_TITLE��min_salary��ÿ��JOB_ID������ʸ���Ϊ��С���ʵ�������
--a.����jobs��,��������
--CREATE TABLE jobs1 AS SELECT * FROM jobs WHERE 1=2;
CREATE OR REPLACE PROCEDURE add_jobs(job_id VARCHAR2,job_title VARCHAR2,min_salary NUMBER) IS 
	
BEGIN
	INSERT INTO jobs1 VALUES(job_id,job_title,min_salary,min_salary*2);
    dbms_output.put_line('����ɹ�!');
END;
--����
DECLARE
BEGIN
	add_jobs('SY_ANAL','System Analyst',6000);
END;
/
SELECT * FROM jobs1;
--16.����һ������ΪADD_JOB_HIST�Ĵ洢������JOB_HISTORY�������һ�У�Ҫ���Ա����job_id�ĳɵ�15��b������job_id.
--ʹ�ø����˹�����Ա���ţ�employee ID �����µĹ�����ţ�job ID ����Ϊ����������EMPLOYEES���л����Ӧ��Ա����Ų��뵽JOB_HISTORY��
--��JOB_HISTORY���н�Ա���Ĺ�Ӷʱ����Ϊ��ʼʱ�䣬ϵͳʱ����Ϊ����ʱ�䣻
--��EMPLOYEES���н���Ӷʱ����Ϊ��������ڣ�����Ա����job_idΪ15��b������job_id�����ҹ��ʵ���job_id+500Ա������С���ʣ�
--�����������������һ�������ڵ�Ա�����˱�Ĺ�����ţ�����ˮ�ڸù�����Снˮ����500
--a.����job_history
--CREATE TABLE job_his1 AS SELECT * FROM job_history;
CREATE OR REPLACE PROCEDURE add_job_hist(emp_id NUMBER,job_id VARCHAR2) IS
	start_date employees.hire_date%TYPE;
	dep_id employees.department_id%TYPE;
BEGIN
	SELECT hire_date,department_id INTO start_date,dep_id FROM emp1 WHERE employee_id=emp_id;
	  
    --to_date(to_char(SYSDATE,'yyyy-mm-dd'),'yyyy-mm-dd'):����yyyy-mm-dd���ڵ�����
    INSERT INTO job_his1 VALUES(emp_id,start_date,to_date(to_char(SYSDATE,'yyyy-mm-dd'),'yyyy-mm-dd'),job_id,dep_id);
    
	--��EMPLOYEES���н���Ӷʱ����Ϊ��������ڣ�����Ա����job_idΪ15��b������job_id�����ҹ��ʵ���job_id+500Ա������С����
    UPDATE emp1 SET hire_date =to_date(to_char(SYSDATE,'yyyy-mm-dd'),'yyyy-mm-dd') WHERE employee_id=emp_id;
    dbms_output.put_line(emp_id||'  '||to_char(start_date,'yyyy-mm-dd')||'  '||job_id||'  '||dep_id||'  his����ɹ�!emp1��������!');    
EXCEPTION
	WHEN no_data_found THEN
    	dbms_output.put_line('����δ����!');
	WHEN OTHERS THEN
    	dbms_output.put_line('others�Ĵ���!');
END;

--����
DECLARE
BEGIN
	add_job_hist(100,'SY_ANAL');
END;
/

--17.����һ���洢����UPD_SAL������JOBS��һ���ض�job_id����С���ʺ������,
--�����������������̣�������ţ�����С���ʣ�������ʡ��������⴦����Ч�ĵĹ�����š�
--��Ȼ���������С����С���ʣ��׳�һ�����⡣���jobs�������ݱ��������޷��ı����ڴ�������ʾ���ʵ���Ϣ
--�����������޷��жϵ�
--����jobs�ĸ���,�Ӵ˿�ʼ,��������
--CREATE TABLE jobs2 AS SELECT * FROM jobs;
CREATE OR REPLACE PROCEDURE UPD_SAL(JOB_IN  VARCHAR,
									MIN_SAL NUMBER,
									MAX_SAL NUMBER) IS
	DATA_NOT_MATCH EXCEPTION;
	ISOK VARCHAR(35);
BEGIN
	--�ж������Ƿ�����ҵ�
	SELECT JOB_TITLE INTO ISOK FROM JOBS2 WHERE JOB_ID = JOB_IN;
	IF MIN_SAL > MAX_SAL THEN
		RAISE DATA_NOT_MATCH;
	END IF;
	UPDATE JOBS2
	   SET MIN_SALARY = MIN_SAL, MAX_SALARY = MAX_SAL
	 WHERE JOB_ID = JOB_IN;
	DBMS_OUTPUT.PUT_LINE('�������!');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('δ�ҵ�����!����IDδ����!');
	WHEN DATA_NOT_MATCH THEN
		DBMS_OUTPUT.PUT_LINE('�����쳣!��Сֵ�������ֵ!');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('others����!');
END;/
--����17
DECLARE

BEGIN
	upd_sal('AD_PRES',110,2011);
END;
/



--18.����һ�����̼���Ա���Ƿ��Ѿ�����ƽ������,�е��޷��������
--a.����employees�ĸ���,�Ӵ˿�ʼ�����������
--CREATE TABLE emp2 AS SELECT * FROM employees;
--b.ִ�нű�
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

--19.����һ���������ĳ��Ա���Ĺ���,����,�úö���,2017-01-03 10:28��ʼ�޸�
--�������-1,��ô˵��û�����Ա��
SELECT * FROM JOB_HISTORY;
CREATE OR REPLACE FUNCTION GET_SERVICE_YRS(EMP_ID NUMBER)
	RETURN NUMBER IS STARTDATE DATE; --���濪ʼ����
ENDDATE DATE; --�����������
ISOK NUMBER; --�����Ƿ���ҵ���ӦԱ��
BET_YEAR NUMBER(4, 2); --������ְ���
BEGIN
	--�ж�Ա���Ƿ����
	SELECT EMPLOYEE_ID INTO ISOK FROM EMPLOYEES WHERE EMPLOYEE_ID = EMP_ID;
	IF ISOK IS NULL THEN
		RAISE NO_DATA_FOUND;
	END IF;
	--��ȡ��Ӷ����
	SELECT START_DATE, END_DATE
	  INTO STARTDATE, ENDDATE
	  FROM EMPLOYEES EMP, JOB_HISTORY HIS
	 WHERE EMP.EMPLOYEE_ID = HIS.EMPLOYEE_ID;
	--�������
	BET_YEAR := MONTHS_BETWEEN(ENDDATE, STARTDATE);
	--������ְ���
	RETURN BET_YEAR;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		--�쳣������Ч��Ա������
		DBMS_OUTPUT.PUT_LINE('δ���ҵ�����!');
		RETURN - 1;
END;
/
--���ú���
SELECT GET_SERVICE_YRS(emp.employee_id) FROM employees emp,job_history his WHERE emp.employee_id=his.employee_id;
SELECT * FROM employees emp,job_history his WHERE emp.employee_id=his.employee_id;
SELECT * FROM job_history ORDER BY employee_id;
SELECT GET_SERVICE_YRS(101) FROM dual;
EXECUTE dbms_output.put_line(GET_SERVICE_YRS(100));





--20.����һ���������Ա������ְ�ڼ�Ĺ�������
CREATE OR REPLACE FUNCTION get_job_count(emp_id NUMBER) RETURN NUMBER IS 
	job_count NUMBER;--���������Ĺ�����
BEGIN
	--��ȡ�����ĸ���
	SELECT COUNT(employee_id) INTO job_count FROM job_history WHERE employee_id=emp_id GROUP BY employee_id;
	--���ع�������
    RETURN job_count;
END;
/
--���ú���
SELECT (SELECT last_name FROM employees WHERE employee_id=&empid)||'����'||get_job_count(&empid)||'������!' FROM dual;


--21.����һ�����Ͱ������EMP_JOB_PKG������ ADD_JOBS,ADD_JOB_HIST, �� UPD_SAL���̣���GET_SERVICE_YRS����
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





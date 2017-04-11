--v_* ��ʾ����
--c_* ��ʾ����

--plsql�����ϰ
--1.annoymous
--ǰ��Ķ���

--���в���sql row count

--2.Procedure
PROCEDURE hello IS

BEGIN
	dbms_output.put_line('hello procedure!');
END;

--3.function
FUNCTION func01 RETURN NUMBER IS BEGIN
	RETURN 100;
END;


--�����������
DECLARE

BEGIN
	func01();
END;
/


--plsql����11ҳ��֤
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


--��¼���͵�ʹ��
DECLARE
	--1.�����¼����
    TYPE memp IS RECORD(
		emp_no employees.employee_id%TYPE, --����Ա��id
        emp_name employees.last_name%TYPE, --����Ա������
        emp_sal employees.salary%TYPE      --����Ա��нˮ
    );
    --2.������¼����ʵ��
    v_iemp memp;
BEGIN
	--3.�ֶ�Ϊ��¼���͸�ֵ
    v_iemp.emp_no:=1000;
    v_iemp.emp_name:='xiaoming';
	v_iemp.emp_sal:=12000;
    --4.����Զ������͵�����
    dbms_output.put_line('���:'||v_iemp.emp_no||'  ����:'||v_iemp.emp_name||'  нˮ:'||v_iemp.emp_sal);
END;
/

--��¼���ͽ���α�ʹ��
DECLARE
	--1.�����¼����
	TYPE MEMP IS RECORD(
		EMP_NO   EMPLOYEES.EMPLOYEE_ID%TYPE, --����Ա��id
		EMP_NAME EMPLOYEES.LAST_NAME%TYPE, --����Ա������
		EMP_SAL  EMPLOYEES.SALARY%TYPE --����Ա��нˮ
		);
	--2.������¼����ʵ��
	V_IEMP MEMP;
	--3.����һ���α�
	CURSOR EMPC IS
		SELECT EMPLOYEE_ID, LAST_NAME, SALARY FROM EMPLOYEES;
BEGIN
	--��Ҫһ:���α�
	OPEN EMPC;
	--4.ѭ����ӡ����
	LOOP
		EXIT WHEN EMPC%NOTFOUND;
		--5.���α�����ݲ��񵽼�¼������
		FETCH EMPC
			INTO V_IEMP;
		--6.����Զ������͵�����
		DBMS_OUTPUT.PUT_LINE('���:' || V_IEMP.EMP_NO || '  ����:' ||
							 V_IEMP.EMP_NAME || '  нˮ:' || V_IEMP.EMP_SAL);
	END LOOP;
	--��Ҫ��:�ر��α�
	CLOSE EMPC;
END;
/

--1.�¹�ѽ�ͼ��Ⱥ����

--2.����sql%rowcount

--3.�����쳣



--���ݿⴥ������ʱ�����˽�,����


--��֤�α�
DECLARE
	--�洢emp
	TYPE memp IS RECORD(
    	emp_id employees.employee_id%TYPE,
        emp_name employees.last_name,
        emp_sal employees.salary
    );
    --�洢dep
    TYPE mdep IS RECORD(
    	dep_id departments.department_id%TYPE,
        dep_name departments.department_name%TYPE, 
    );
	--emp�α�
	CURSOR EMPC IS
		SELECT * FROM EMPLOYEES;
	--dep�α�
	CURSOR DEPC IS
		SELECT * FROM DEPARTMENTS;
	--loc�α�
	CURSOR LOCC IS
		SELECT * FROM LOCATIONS;
	--job�α�
	CURSOR JOBC IS
		SELECT * FROM JOBS;
	--job_his�α�
	CURSOR JOBHC IS
		SELECT * FROM JOB_HISTORY;
	--cou�α�
	CURSOR COUC IS
		SELECT * FROM COUNTRIES;
	--reg�α�
	CURSOR REGC IS
		SELECT * FROM REGIONS;
BEGIN
	OPEN EMPC;
	OPEN DEPC;

END;
/




SELECT employee_id AS "���",
  last_name        AS "����",
  department_id    AS "���ű��",
  --                          if         esif     else
  DECODE(department_id,10,'����10', 20,'����20', '����30') AS "decode���"
FROM employees
WHERE department_id IN (10,20,30);

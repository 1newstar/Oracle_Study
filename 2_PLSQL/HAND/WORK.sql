--2016-12-19 ��ҵ
--1.���ղ��ű�Ż�ȡ(���ű����������)
DECLARE
	--�ܹ���
	TOTAL_STAFF NUMBER := 0;
	--������
	TOTAL_SALARY NUMBER := 0;
	--�쳣��Ϣ
	EXCE_INFO VARCHAR2(30);
BEGIN
	--�������
	DBMS_OUTPUT.PUT_LINE('���ʱ�');
	--���������
	DBMS_OUTPUT.PUT_LINE(RPAD('Ա�����', 20, ' ') || RPAD('Ա������', 30, ' ') ||
						 RPAD('нˮ', 20, ' '));
	--forѭ����ȡ�α�����,���ҽ����û�����
	FOR EMP IN (SELECT *
				  FROM EMPLOYEES
				 WHERE DEPARTMENT_ID = &DEP_ID
				 ORDER BY EMPLOYEE_ID) LOOP
		--���н����Ϣ
		DBMS_OUTPUT.PUT_LINE(RPAD(EMP.EMPLOYEE_ID || '', 20, ' ') ||
							 RPAD(EMP.FIRST_NAME || ' ' || EMP.LAST_NAME,
								  30,
								  ' ') || RPAD(EMP.SALARY, 20, ' '));
		TOTAL_STAFF  := TOTAL_STAFF + 1;
		TOTAL_SALARY := TOTAL_SALARY + EMP.SALARY;
	END LOOP;
	--���ͳ����Ϣ
	DBMS_OUTPUT.PUT_LINE(RPAD('���ű��:' || &DEP_ID, 20, ' ') ||
						 RPAD('Ա������:' || TOTAL_STAFF, 20, ' ') ||
						 RPAD(' �ܹ���:' || TOTAL_SALARY, 30, ' ') ||
						 RPAD(' ƽ������:' ||
							  ROUND(TOTAL_SALARY / TOTAL_STAFF, 2),
							  20,
							  ' '));
	--�쳣����
EXCEPTION
	WHEN ZERO_DIVIDE THEN
		DBMS_OUTPUT.PUT_LINE(EXCE_INFO || '���ŵ�����Ϊ0!');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('���������쳣!');
END;
/

--2.����sql%rowcount--ÿһ�δ�ӡ�����һ��rowcount��ֵ,�����Զ����icount(�Զ��������,�����α��ʱ������ +1),
--ͬʱ������������ݲ����бȽ�,ͬʱ���employee_id���и���֤��
--֤�����:sql%rowcount��ʾ�α굱ǰ����������
DECLARE
--�����α�
CURSOR EMPC IS
	SELECT * FROM EMPLOYEES;
--�����Զ�������������
ICOUNT NUMBER := 0;
BEGIN
	--���������
	DBMS_OUTPUT.PUT_LINE(RPAD('-ROWCOUNT-', 15, ' ') ||
						 RPAD('-ICOUNT-', 15, ' ') ||
						 RPAD('-EMP_ID-', 15, ' '));
	--DBMS_OUTPUT.PUT_LINE(RPAD('ROWCOUNT:' || EMPC%ROWCOUNT, 15, ' '));--�α��֮ǰ���ܻ�ȡrowcount
	--ʹ��forѭ�����α���ȡ����
	FOR EMP IN EMPC LOOP
		--��������1
		ICOUNT := ICOUNT + 1;
		--���rowcount,icount,emp_id
		DBMS_OUTPUT.PUT_LINE(RPAD('ROWCOUNT:' || EMPC%ROWCOUNT, 15, ' ') ||
							 RPAD('ICOUNT:' || ICOUNT, 15, ' ') ||
							 RPAD('EMP_ID:' || EMP.EMPLOYEE_ID, 15, ' '));
	END LOOP;
	--DBMS_OUTPUT.PUT_LINE(RPAD('ROWCOUNT:' || EMPC%ROWCOUNT, 15, ' '));--�α�ر�֮���ܻ�ȡrowcount
END;
/

--3.�����α�δ�ر��쳣
--˼·:�ֱ���֤3���α���֤��ͬ���α�����
DECLARE
--emp�α�
CURSOR EMPC IS
	SELECT EMPLOYEE_ID, LAST_NAME, SALARY FROM EMPLOYEES;
--dep�α�
CURSOR DEPC IS
	SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS;
--loc�α�
CURSOR LOCC IS
	SELECT LOCATION_ID, STREET_ADDRESS, CITY FROM LOCATIONS;
BEGIN
	--����01:�α�open֮���ٴ�open,�������
	OPEN EMPC;
	OPEN EMPC;
	--���01:һ���α겻��open����

	--����02:�α�open֮��ر��ٴ�open,��ȷ����
	OPEN DEPC;
	CLOSE DEPC;
	OPEN DEPC;
	--���02:һ���α�ڶ��δ�֮ǰ�����ȹر�

	--����03:�α�open֮ǰ��close,�������
	CLOSE LOCC;
	OPEN LOCC;
	--���03:�α�close֮ǰ����open
END;
/


--������
DECLARE
	--��¼��������department��Ϣ
	TYPE V_EMP IS RECORD(
		EMP_ID   EMPLOYEES.EMPLOYEE_ID%TYPE,
		EMP_NAME EMPLOYEES.LAST_NAME%TYPE,
		EMP_SAL  EMPLOYEES.SALARY%TYPE,
		EMP_DEP  EMPLOYEES.DEPARTMENT_ID%TYPE);
	--�����Զ�������
	C_EMP V_EMP;
	--�����α�
	CURSOR CUR_EMP IS
		SELECT EMPLOYEE_ID, LAST_NAME, SALARY, DEPARTMENT_ID
		  FROM EMPLOYEES
		 ORDER BY EMPLOYEE_ID;

BEGIN
	--�ص�:���α�
	-- dbms_output.put_line('�α��֮ǰ:'|| cur_emp%ROWCOUNT); --��֤��open֮ǰ����ʹ��cur_emp%ROWCOUNT
	OPEN CUR_EMP;
	--DBMS_OUTPUT.PUT_LINE('�α��֮��and����֮ǰ:' || CUR_EMP%ROWCOUNT); --��֤sql%notfoundֻ����open֮���ȡ
	--ʹ��loopѭ�������α�
	LOOP
		EXIT WHEN CUR_EMP%NOTFOUND;
		FETCH CUR_EMP
			INTO C_EMP;
		DBMS_OUTPUT.PUT_LINE(C_EMP.EMP_ID || '    ' ||
							 RPAD(C_EMP.EMP_NAME, 15, ' ') ||
							 RPAD(CUR_EMP%ROWCOUNT || '', 10, ' '));
	END LOOP;
	--�ص�:�ر��α�
	--dbms_output.put_line('�α�ر�֮ǰ:'|| cur_emp%ROWCOUNT); --��֤�α��ڹر�֮ǰ����ʹ��
	CLOSE CUR_EMP;
	dbms_output.put_line('�α�ر�֮��:'|| cur_emp%ROWCOUNT);--��֤�α�ر�֮�󲻿���ʹ��
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('sql%rowcount�쳣!');
END;
/


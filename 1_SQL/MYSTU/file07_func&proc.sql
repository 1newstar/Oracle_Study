	--һ.�洢����ѧϰ
	--1.�޲�
	--a.���ص�ǰ����
	CREATE OR REPLACE FUNCTION GET_DATE RETURN DATE IS
	--��������
BEGIN
	--ִ���߼�
	RETURN SYSDATE;
END;
/
	--2.�в�
	--a.�������
	CREATE OR REPLACE FUNCTION NUM_ADD(NUM1 NUMBER, NUM2 NUMBER) RETURN NUMBER IS
BEGIN
	RETURN NUM1 + NUM2;
END;
/
	--b.���庯��:��ȡָ�����ŵĹ����ܺ�,Ҫ��:���źŶ���Ϊ����,�����ܶ�Ϊ����ֵ
	CREATE OR REPLACE FUNCTION GET_SUM(DEP_ID NUMBER) RETURN NUMBER IS
	SUM_SAL NUMBER;
BEGIN
	SELECT SUM(SALARY) INTO SUM_SAL FROM EMPLOYEES WHERE DEPARTMENT_ID = DEP_ID; RETURN SUM_SAL;
END;
/
	--ע��:out��ʹ��:ʵ�ֶ������ֵ
	CREATE OR REPLACE FUNCTION GET_SUM2(DEP_ID NUMBER, TOTAL_EMP OUT NUMBER) RETURN NUMBER IS
	SUM_SAL NUMBER;
BEGIN
	SELECT COUNT(EMPLOYEE_ID), SUM(SALARY) INTO TOTAL_EMP, SUM_SAL FROM EMPLOYEES WHERE DEPARTMENT_ID = DEP_ID; RETURN SUM_SAL;
END;
/
	--��.�洢����ѧϰ
	--a.����һ���洢����:��ȡ�������ŵĹ�������(ͨ��out����),Ҫ��:���źź͹����ܶ�Ϊ����
	CREATE OR REPLACE PROCEDURE GET_SALSUM(DEP_ID NUMBER, SAL_SUM OUT NUMBER) IS
	CURSOR EMPC IS
	SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = DEP_ID;
BEGIN
	SAL_SUM := 0; FOR EMP IN EMPC LOOP SAL_SUM := SAL_SUM + EMP.SALARY;
END LOOP; DBMS_OUTPUT.PUT_LINE('proн��:' || SAL_SUM);
END;
/ --�洢���̲��ܴ�/

	--b.�Ը�������(��Ϊ�������)��Ա�����м�н����,���䵽��˾��ʱ���� (?,2003),Ϊ���н5%,  [2003,2006),Ϊ���н3%, 
	--                                                                                        [2006,?)Ϊ���н1%
	--�õ����·��ؽ��,Ϊ�˴μ�н��˾ÿ������Ҫ���⸶�����ٳɱ�(����һ��out�͵��������),���Խ���α�(��ѡ)
	--�����ֵ��ַ���������ʽת��
CREATE OR REPLACE PROCEDURE ADD_SAL(DEP_ID NUMBER, EXTRA_COST OUT NUMBER) IS
	--��ʼ������Ϊ0
	V_RATIO NUMBER := 0;
	--�����α�
	CURSOR EMPC IS
		SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = DEP_ID;
BEGIN
	--������ĸ����ɱ���Ϊ0
	EXTRA_COST := 0;
	--ִ������
	FOR EMP IN EMPC LOOP
		IF TO_CHAR(EMP.HIRE_DATE, 'yyyy') < '2003' THEN
			V_RATIO := 0.05;
		ELSIF TO_CHAR(EMP.HIRE_DATE, 'yyyy') >= '2003' AND
			  TO_CHAR(EMP.HIRE_DATE, 'yyyy') < '2006' THEN
			V_RATIO := 0.03;
		ELSIF TO_CHAR(EMP.HIRE_DATE, 'yyyy') >= '2006' THEN
			V_RATIO := 0.01;
		END IF;
		EXTRA_COST := EXTRA_COST + EMP.SALARY * V_RATIO;
		DBMS_OUTPUT.PUT_LINE(RPAD('���:' || EMP.EMPLOYEE_ID, 20, ' ') ||
							 RPAD('����:' || EMP.LAST_NAME, 20, ' ') ||
							 RPAD('����:' || EMP.DEPARTMENT_ID, 20, ' ') ||
							 RPAD('ԭнˮ:' || EMP.SALARY, 20, ' ') ||
							 RPAD('��нˮ:' || EMP.SALARY * (1 + V_RATIO),
								  20,
								  ' ') ||
							 RPAD('�Ƿ�:' || TO_CHAR(V_RATIO, 'FM99990.099'),
								  20,
								  ' ') ||
							 RPAD('��ְ���:' ||
								  TO_CHAR(EMP.HIRE_DATE, 'yyyy'),
								  20,
								  ' '));
	END LOOP;
END;

SELECT TO_NUMBER(TO_CHAR(HIRE_DATE, 'yyyy')), TO_CHAR('2017-12-12', 'yyyy') < '2003' FROM EMPLOYEES; SELECT TO_NUMBER(TO_CHAR(HIRE_DATE, 'yyyy')), COUNT(*) FROM EMPLOYEES WHERE DEPARTMENT_ID = 100 GROUP BY TO_NUMBER(TO_CHAR(HIRE_DATE, 'yyyy')) ORDER BY TO_NUMBER(TO_CHAR(HIRE_DATE, 'yyyy')); SELECT TO_NUMBER(TO_CHAR(HIRE_DATE, 'yyyy')) > '2003' FROM EMPLOYEES;

	--***ִ��
	DECLARE EXTRA_COST NUMBER := 0;
BEGIN
	ADD_SAL(&dep_id, EXTRA_COST); DBMS_OUTPUT.PUT_LINE('����ĳɱ�:' || EXTRA_COST);
END;
/

	DECLARE SAL NUMBER;
BEGIN
	GET_SALSUM(80, SAL); DBMS_OUTPUT.PUT_LINE('lala-->' || SAL);
END;
/
	DECLARE TE NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('�ܹ���:' || GET_SUM2(80, TE)); DBMS_OUTPUT.PUT_LINE('Ա������:' || TE);
END;
/
	SELECT GET_SUM(80) FROM DUAL; SELECT NUM_ADD(1, 2) FROM DUAL; SELECT GET_DATE FROM DUAL;

	SELECT TO_CHAR(0.5, 'FM99999990.099') FROM DUAL;

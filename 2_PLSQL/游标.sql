--�α��ʹ��
--ע��:
--�α�ֻ��openһ��,�ٴ�open�ͻᱨ��
--�����쳣֮ǰ����ȹر��α�,����һ���쳣ǰ��Ҫ�ر��α�
--��ʽ�α���ʽ����ʽ�ر�
--������������֮ǰ����ر��α�

--ע��
--sql��plsql�������͵�����

--12-29��ҵ
--1.ʵ��һ����������,�쳣�����йر��α�(ϵͳԤ���쳣/�û��Զ����쳣/other),֤���ر��α����Ҫ��


--0.ʹ�ü�¼���ͱ�������,���100��Ա������Ϣ
DECLARE
  --a.����һ����¼����
  TYPE memp IS RECORD(
       empno employees.employee_id%TYPE,
       empname employees.last_name%TYPE,
       empsal employees.salary%Type
  );
  --b.�����¼���͵ĳ�Ա����
  vemp memp;
BEGIN
  --c.Ϊ��¼���͸�ֵ
  SELECT employee_id,last_name,salary INTO vemp  FROM employees WHERE employee_id=100;
  dbms_output.put_line(vemp.empno||' '||vemp.empname||' '||vemp.empsal);
END;
/

--0.1 ʹ�ü�¼���ͱ�����Ϣ
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
	sto.gender:='��';
    dbms_output.put_line(sto.mid||' '||sto.mname||' '||sto.gender);
END;
/

--1.��ʽ�α�ʹ��
DECLARE
  --1.���������ļ�¼����
  TYPE MTYPE IS RECORD(
    EMPNO   EMPLOYEES.EMPLOYEE_ID%TYPE,
    EMPNAME EMPLOYEES.LAST_NAME%TYPE,
    EMPSAL  EMPLOYEES.SALARY%TYPE);
  MT MTYPE;
  --2.����ָ��
  CURSOR SOR IS
    SELECT EMPLOYEE_ID, LAST_NAME, SALARY FROM EMPLOYEES;
  EMPCOUNT NUMBER := 0;
BEGIN
  --3.���α�
  OPEN SOR;
--  OPEN SOR;
  FETCH SOR
    INTO MT;
  LOOP
    EXIT WHEN SOR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(RPAD('���-->' || MT.EMPNO, 20, ' ') ||
                         RPAD('����-->' || MT.EMPNAME, 21, ' ') ||
                         RPAD('н��-->' || MT.EMPSAL, 21, ' '));
  
    FETCH SOR
      INTO MT;
    EMPCOUNT := EMPCOUNT + 1;
  END LOOP;
  --4.�ر��α�
  CLOSE SOR;
  DBMS_OUTPUT.PUT_LINE('Ա������:' || EMPCOUNT);
END;  
/
--2.��ʽ�α�ʹ��
DECLARE

BEGIN
  UPDATE EMPLOYEES SET LAST_NAME = '����ɵ��' WHERE EMPLOYEE_ID = 12334;
  IF SQL%NOTFOUND THEN
    DBMS_OUTPUT.PUT_LINE('����ʧ��...');
  END IF;
END;
/

--3.�������͵�ʹ��  %type    %rowtype
--a.%type
DECLARE
   empid employees.employee_id%TYPE;    
BEGIN
  SELECT employee_id INTO empid FROM employees WHERE UPPER(last_name)='ABEL';
  dbms_output.put_line('�������id-->'||empid);
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

--��ϰ
--a.��ӡ��100�Ų�������Ա������Ϣ(ʹ��pl/sql)
--1.loop...exit...
DECLARE
	--��.����Ա����Ϣ��¼����
	TYPE hemp IS RECORD(
    	empno employees.employee_id%TYPE,
        empname employees.last_name%TYPE,
        emphire employees.hire_date%TYPE,
    	empsal employees.salary%TYPE,
        empdep employees.department_id%TYPE
    );
    --��.�������͵Ķ���
    vemp hemp;
	CURSOR empc IS SELECT employee_id,last_name,hire_date,salary,department_id FROM employees WHERE department_id=&depid;
BEGIN
	--��.���α�
	OPEN empc;
    LOOP
    	EXIT WHEN empc%NOTFOUND;
        dbms_output.put_line(vemp.empno||' '||vemp.empname||' '||vemp.empdep);
        FETCH empc INTO vemp;
    END LOOP;
	--��.�ر��α�
	CLOSE empc;
END;
/

--2.while...loop
DECLARE
	--��.����Ա����Ϣ��¼����
	TYPE hemp IS RECORD(
    	empno employees.employee_id%TYPE,
        empname employees.last_name%TYPE,
        emphire employees.hire_date%TYPE,
    	empsal employees.salary%TYPE,
        empdep employees.department_id%TYPE
    );
    --��.�������͵Ķ���
    vemp hemp;
	CURSOR empc IS SELECT employee_id,last_name,hire_date,salary,department_id FROM employees WHERE department_id=&depid;
BEGIN
	--��.���α�
	OPEN empc;
    FETCH empc INTO vemp; --ΪʲôҪд��仰:�����д�Ļ�while��empc%found�᷵��false,������nullֵ
	WHILE empc%FOUND LOOP
	    dbms_output.put_line(vemp.empno||' '||vemp.empname||' '||vemp.emphire||' '||vemp.empsal||' '||vemp.empdep);
   		FETCH empc INTO vemp;
    END LOOP;
	CLOSE empc;
END;
/

--3.for...loop...
--��ʽ��
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

--plsqlʵ��
--oracleר�ұ��


    

    





--t1.����plsql������ʾ,���ձ���









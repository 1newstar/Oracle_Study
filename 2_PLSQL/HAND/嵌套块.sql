--��������
--1.Ƕ�׿�



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

--2.plsql�쳣����
--a.Ԥ�����쳣(�����24��)
DECLARE
	sal employees.salary%TYPE;
BEGIN
	SELECT salary INTO sal FROM employees;
EXCEPTION
	WHEN too_many_rows THEN dbms_output.put_line('������̫����!');	
	WHEN OTHERS THEN dbms_output.put_line('�������쳣!');
END;
/

--b.��Ԥ�����쳣
DECLARE
	my_excep EXCEPTION;
    PRAGMA EXCEPTION_INIT(my_excep,-2292);
BEGIN
	DELETE FROM employees WHERE employee_id=100;
    EXCEPTION
    WHEN my_excep THEN
 		dbms_output.put_line('Υ��������Լ��,����ɾ��!');
END;
/


--b.�û��Զ����쳣
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
		DBMS_OUTPUT.PUT_LINE('����̫��,������������ĵ���!'||v_sal);
END;
/















--3.package��ʹ��
--3.1 package��ʹ��,head
CREATE OR REPLACE PACKAGE HELLO IS
	--�������й��̺ͺ���
	FUNCTION HELLO_FUN(ANAME IN VARCHAR2) RETURN VARCHAR2;
	PROCEDURE HELLO_PRO(BNAME IN VARCHAR2);
END HELLO;
/
--3.2 package��ʹ��,body
CREATE OR REPLACE PACKAGE BODY HELLO IS
	--��������˽�еı���
	--�������й���/˽�й��̺ͷ���

	--����01  ���hello
	FUNCTION HELLO_FUN(ANAME IN VARCHAR2) RETURN VARCHAR2 IS
	BEGIN
		RETURN('hello ' || ANAME || ', im function of package!');
	END HELLO_FUN;
	--����01,���ú���hello
	PROCEDURE HELLO_PRO(BNAME IN VARCHAR2) IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('hello' || BNAME ||
							 ', im procedure of package!');
	END HELLO_PRO;
END HELLO;
/
--���ð��ĺ���
SELECT hello.HELLO_FUN('aaa')  FROM dual;
--���ð��Ĵ洢����
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


<<dept_block>>         --�����������ǲ���
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
--��PL/SQL�д����������У���û�в��������
--PL/SQL �����ѳɹ���ɡ�




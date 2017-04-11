--日期相关
--next_day()
SELECT next_day('03-1月-16',1) FROM dual;
SELECT next_day('03-1月-16','星期日') FROM dual; --当前日期加上对应的星期几的数
SELECT to_char(SYSDATE,'yyyy-mm-dd day hh24:mi:ss AM RR') FROM dual;
SELECT to_char(to_date('1965-12-01','yyyy-mm-dd'),'yyyy-mm-dd day hh24:mi:ss AM RR') FROM dual;

--数字相关
SELECT to_char(0.123,'00.9999'),123456.7890,to_char(123456.7890,'$000,000.0000') FROM dual;

SELECT to_number('$123,456.789','$999,999.999') FROM dual;
SELECT to_number('$4,456,455.000','$999,999,999,999.999') FROM dual;

SELECT USERENV('language') FROM DUAL;


SELECT SUM(commission_pct) FROM employees;
SELECT SUM(NVL(commission_pct,0)) FROM employees;
SELECT COUNT(commission_pct),COUNT(*) FROM employees;

SELECT * FROM user_tables;


SELECT * FROM emp1;
DELETE FROM emp1;
DROP TABLE emp1;
CREATE Table emp1 AS SELECT * FROM employees;
--从employees中拷贝一行数据到emp1中
INSERT INTO emp1 SELECT * FROM employees WHERE employee_id=100;


INSERT INTO
	(SELECT EMPLOYEE_ID,
			LAST_NAME,
			EMAIL,
			HIRE_DATE,
			JOB_ID,
			SALARY,
			DEPARTMENT_ID
	   FROM emp1
	  WHERE DEPARTMENT_ID = 50)
VALUES
	(99999,
	 'Taylor',
	 'DTAYLOR',
	 TO_DATE('07-7月-99', 'DD-MON-RR'),
	 'ST_CLERK',
	 5000,
	 50);

SELECT * FROM emp1;

SELECT * FROM employees;


--使用merge语句
MERGE INTO emp1 EMPC
USING EMPLOYEES EMP
ON (EMPC.EMPLOYEE_ID = EMP.EMPLOYEE_ID)
WHEN MATCHED THEN
	INSERT VALUES (EMP.*)
WHEN NOT MATCHED THEN
	INSERT VALUES (EMP.*);
    
   





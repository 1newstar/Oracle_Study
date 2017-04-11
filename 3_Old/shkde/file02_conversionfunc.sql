--转化函数，条件表达式

--单行函数(字符,数字，日期，转换，通用)
SELECT * FROM employees WHERE lower(last_name)='king';
SELECT * FROM employees WHERE upper(last_name)='KING';
DESC departments;
SELECT * FROM departments;
SELECT ROUND(ROUND(sysdate-hire_date,2)/30,2)    AS "月数",
  ROUND(ROUND(sysdate     -hire_date,2)/30/12,2) AS "年数"
FROM employees;
--sysdate显示详细时间
SELECT TO_CHAR(sysdate,'yyyy-mm-dd-hh24-MI-SS') FROM dual;
--练习
--1.获取来公司的员工中，每个月第二天来公司的员工有哪些?
SELECT last_name,
  TO_CHAR(hire_date,'yyyy-mm-dd')
FROM employees
WHERE hire_date=last_day(hire_date)-1;
--隐式转化
SELECT 12+'2' FROM dual;
SELECT sysdate AS "今天",sysdate+2 AS "今天+2"FROM dual;
--显式转化
SELECT 123,456,789.23+2 AS "年薪" FROM dual;                     --这是错误的
SELECT TO_CHAR(1234567.89,'L999,999,999.99') AS "年薪" FROM dual;--显式转化，这是正确的，本地货币
SELECT TO_CHAR(1234567.89,'$999,999,999.99') AS "年薪" FROM dual;--显式转化，这是正确的,美元
SELECT TO_CHAR(1234567.89,'000,000,000.99') AS "年薪" FROM dual; --显式转化，这是正确的
SELECT TO_CHAR(123456.789,'999,999,999.999') FROM dual;
SELECT TO_CHAR(123456.789,'L000,999,999.999') FROM dual;
SELECT to_number('￥000,123,456.789','L000,999,999.999')+10 FROM dual;
SELECT to_date('1998-02-11','yyyy-mm-dd') FROM dual;
--to_char(123456,'999999')
--通用函数
--nvl(val1,val2):将空值转化为已知值，val1为null，则用val2代替
--nvl2(v1,v2,v3):v1不为null返回v2,反之返回v3
--nullif(v1,v2):相等返回null,不等返回v1
--coalesce(v1,v2,v3,...)
SELECT months_between(to_date('2002-10-11','yyyy-mm-dd'),to_date('2001-12-12','yyyy-mm-dd'))
FROM dual;
SELECT sysdate FROM dual;
--查询first_name和last_name长度相同的员工信息
SELECT NULLIF(LENGTH(first_name),LENGTH(last_name))
FROM employees;
--重点:if-then-else
--1.case表达式的写法
SELECT * FROM employees;
SELECT employee_id AS "编号",
  last_name        AS "姓名",
  department_id    AS "部门编号",
  CASE department_id
    WHEN 10
    THEN '我是10'
    WHEN 20
    THEN '我是20'
    ELSE '我是30'
  END AS "case语句"
FROM employees
WHERE department_id IN (10,20,30);
--2.decode表达式的写法
SELECT employee_id AS "编号",
  last_name        AS "名字",
  department_id    AS "部门编号",
  --                          if         esif     else
  DECODE(department_id,10,'我是10', 20,'我是20', '我是30') AS "decode语句"
FROM employees
WHERE department_id IN (10,20,30);
--单行函数练习
--1.打印出 "2010年10月12日 08:21:13" 格式的当前系统的日期和时间
SELECT TO_CHAR(sysdate,'yyyy"年"mm"月"dd"日" hh24:mi:ss')
FROM dual;
--2.格式化数字1234567.89转化为1,234,567.89
SELECT '123456.78'+100 FROM dual;                                  --无特殊字符
SELECT to_number('123,456,789.12','999,999,999.999')+100 FROM dual;--有特殊字符
--3.查询员工工号，姓名，工资，以及工资提高20%之后的结果(new salary)
SELECT * FROM employees;
SELECT employee_id,last_name,salary,salary*1.2 AS "加薪" FROM employees;
--4.将员工的姓名按照首字母排序，第二个字母作为备用排序，并且显示出姓名的长度
SELECT employee_id,
  last_name,
  LENGTH(last_name)
FROM employees
ORDER BY SUBSTR(last_name,1,1),
  SUBSTR(last_name,2,1);
--5.查询员工的姓名，并且显示员工在公司的工作月数,并按照工作月数降序排列
SELECT employee_id,
  last_name,
  hire_date,
  ROUND(months_between(sysdate,hire_date),2) AS workmonths
FROM employees
ORDER BY workmonths DESC;
--6.做一个查询产生如下结果
-- <last_name> 每月挣钱 <salary>，但是他想要每月挣钱<salary*3>
SELECT last_name
  ||'每月挣钱'
  ||TO_CHAR(salary,'L999999')
  ||',但是他想要每月挣钱'
  ||TO_CHAR(salary*3,'$999999') AS "这是梦想"
FROM employees;

select start_date,end_date from job_history;
select months_between(end_date,start_date) from job_history;
select months_between(to_date(end_date,'yyyy-mm-dd'),to_date(start_date,'yyyy-mm-dd')) from job_history;
select to_date(end_date,'yyyy-mm-dd') from job_history;

select months_between(to_date('2003/6/12','yyyy-mm-dd'),to_date('2002/6/12','yyyy-mm-dd')) from dual;
select * from employees order by hire_date;

select * from user_tables;
select * from employees order by hire_date;
select * from job_history;


select employees.employee_id,
concat(employees.first_name,employees.last_name) NAME,
employees.hire_date,
months_between(job_history.end_date,job_history.start_date)/12 as work_age
from employees,job_history
where employees.employee_id=job_history.employee_id order by first_name;

select * from employees,job_history where employees.employee_id=job_history.JOB_ID;

select months_between(end_date,start_date) from job_history;

select count(*) from job_history;

select * from user_tables;
select * from employees;
select * from job_grade;
select * from departments;


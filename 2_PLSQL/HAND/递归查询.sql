--递归查询
SELECT EMPLOYEE_ID,
       MANAGER_ID,
       LEVEL, --得到等级
       LPAD(FIRST_NAME, LENGTH(FIRST_NAME) + (LEVEL * 2), '_') AS EMP_LEVEL --lpad(字段名,填充长度,填充的字符)
  FROM EMPLOYEES
 START WITH FIRST_NAME = 'Steven' --查询结果中起始根节点的限定条件
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID; --连接条件（存在父子关系）

--集合操作(并集,交集,差集)
--1.并集  关键字: union/union all     去重/不去重
SELECT employee_id,job_id FROM EMPLOYEES UNION SELECT employee_id,job_id FROM JOB_HISTORY;
SELECT employee_id,job_id FROM EMPLOYEES UNION ALL SELECT employee_id,job_id FROM JOB_HISTORY ORDER BY employee_id;
--2.交集  关键字:interset  

--3.差集  关键字:minus




--exist/not exist







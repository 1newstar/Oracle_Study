--�ݹ��ѯ
SELECT EMPLOYEE_ID,
       MANAGER_ID,
       LEVEL, --�õ��ȼ�
       LPAD(FIRST_NAME, LENGTH(FIRST_NAME) + (LEVEL * 2), '_') AS EMP_LEVEL --lpad(�ֶ���,��䳤��,�����ַ�)
  FROM EMPLOYEES
 START WITH FIRST_NAME = 'Steven' --��ѯ�������ʼ���ڵ���޶�����
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID; --�������������ڸ��ӹ�ϵ��

--���ϲ���(����,����,�)
--1.����  �ؼ���: union/union all     ȥ��/��ȥ��
SELECT employee_id,job_id FROM EMPLOYEES UNION SELECT employee_id,job_id FROM JOB_HISTORY;
SELECT employee_id,job_id FROM EMPLOYEES UNION ALL SELECT employee_id,job_id FROM JOB_HISTORY ORDER BY employee_id;
--2.����  �ؼ���:interset  

--3.�  �ؼ���:minus




--exist/not exist







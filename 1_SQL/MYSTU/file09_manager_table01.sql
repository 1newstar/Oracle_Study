--�����͹����
/*
1.���������ݿ����
	��: ��������,һֱ����,����˵
    ��ͼ:�ӱ��г���߼�����ص����ݼ���
    ����:�ṩͷ���ɵ���ֵ
    ����:��߲�ѯ��Ч��
    ͬ���:�����������
*/


--�鿴�û������ı�
SELECT * FROM user_tables;
--�鿴�û�����ĸ������ݿ����
SELECT DISTINCT object_type FROM user_objects;
--�鿴�û�����ı�,��ͼ,ͬ��ʺ�����
SELECT * FROM user_catalog;

--�鿴��ͼ
SELECT * FROM EMP_DETAILS_VIEW;


--1.��������������������
--a.��������ĸ��ͷ
--b.������1-30���ַ�֮��
--c.ֻ�ܰ���A-Z,a-z,0-9,_,$,#
--d.���ܺ��û������������������
--e.������oracle�ı�����

--����ѧ����
CREATE TABLE students(
	stu_id NUMBER PRIMARY KEY,
    stu_name VARCHAR2(20) NOT NULL,
    stu_gender VARCHAR(20) NOT NULL,
    stu_school VARCHAR2(20) NOT NULL,
    stu_age NUMBER NOT NULL
);
	










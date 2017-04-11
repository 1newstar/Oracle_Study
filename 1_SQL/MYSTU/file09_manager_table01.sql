--创建和管理表
/*
1.常见的数据库对象
	表: 基本对象,一直在用,不多说
    视图:从表中抽出逻辑上相关的数据集合
    序列:提供头规律的数值
    索引:提高查询的效率
    同义词:给对象起别名
*/


--查看用户创建的表
SELECT * FROM user_tables;
--查看用户定义的各种数据库对象
SELECT DISTINCT object_type FROM user_objects;
--查看用户定义的表,视图,同义词和序列
SELECT * FROM user_catalog;

--查看视图
SELECT * FROM EMP_DETAILS_VIEW;


--1.表名和列名的命名规则
--a.必须以字母开头
--b.必须在1-30个字符之间
--c.只能包含A-Z,a-z,0-9,_,$,#
--d.不能和用户定义的其他对象重名
--e.不能是oracle的保留字

--创建学生表
CREATE TABLE students(
	stu_id NUMBER PRIMARY KEY,
    stu_name VARCHAR2(20) NOT NULL,
    stu_gender VARCHAR(20) NOT NULL,
    stu_school VARCHAR2(20) NOT NULL,
    stu_age NUMBER NOT NULL
);
	










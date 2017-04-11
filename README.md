## 对原有内容进行了删减，删除了git无法追踪的二进制文件


create user qlexam identified by plsqlexam;


# 创建用户
``` sql
create user c##scott identified by tiger;

grant create session to c##scott;

grant create user,drop user,alter user,create any view,connect,resource,dba,create session,create any sequence to c##scott;

```

## 注意
1.lsnrctl start/stop   启停数据库监听
2.我的数据版本:11.2.0.1.0
3.运算方面:任何数据与NULL进行四则运算，其结果都是NULL


# Oracle数据字典

## 1.数据字典视图分类
    1.DBA_*** 包含数据库中整个信息的对象
    2.ALL_***  某个用户所能看到的全部数据库信息
    3.USER_*** 包含当前用户访问的数据库对象信息
## 2.使用数据字典视图
    1.select * from user_tables; 查看当前用户所拥有的表
    2.select * from user_indexes; 查看当前用户创建的索引
    3.select * from user_views; 查看当前用户所拥有的视图
    4.desc table_name/view_name; 查看表/视图的结构
    5.select * from user_catalog; 查看当前用户所有表的名字和类型


# PL/SQL学习

### 一.流程控制
#### 1.分支结构
* 1.if语句
``` sql
   	begin 
		if i=10 then
			...do something;
		end if;
	end;
```

* 2.if...else
``` sql
	begin
		if i=10 then
			...do something;
		else 		
			...do something;
		end if;
	end;
```

* 3.else...if
``` sql	
	begin
		if i=10 then
			...do something;
		elsif i=15 then
			...do something;
		elsif i=20 then 
			...do something;
		...
		else 
			...do something;
		end if;
	end;
```
* 4.case 结构
``` sql
	begin 
		case i 
			when 5 then
				...do something;
			when 10 then 
				...do something;
			...
			else
				...do something;
		end case;
	end;
```


#### 2.循环结构
* 1.loop...exit
``` sql
	begin
		loop
			exit when i=100;
			...do something;
		end loop;
	end;
```
 * 2.while...loop
``` sql
	begin
		while i<100 loop
			...something;
		end loop;
	end;
```

 * 3.for...loop
``` sql
	begin 
		for i in 1..10 loop
			...something;
		end loop;
	end;
```


### 二.使用游标
#### 1.基本格式
``` sql
	declare 
		--0.准备存放数据的变量(个人认为使用记录类型比较好)
		type mtype is record(
			empno emp.empno%type;
			ename emp.ename%type;
			...
		);
		vtype mtype;
		--1.声明游标
		cursor mcursor is select ...;
	begin
		--2.打开游标
		open mcursor;
		--3.提取数据
		fetch mcursor into vtype; 
		loop
			--3.5.循环提取数据
			...do something;
		end loop;
		--4.关闭游标
		close mcursor;
	end;
```
#### 2.使用for循环
``` sql
	declare
		cursor ccursor is select ...;
	begin
		for mc in ccursor loop
			dbms_output.put_line(mc.ename||'...'||mc..||'...'||mc..);
		end loop;
	end;
```

#### 3.使用隐式游标
``` sql
	begin
		update s set sname='**' where sno=*;
		--sql%notfound即为隐式游标
		if sql%notfound then
			dbms_output.put_line('未找到数据！');
		end if; 
	end;
```



Segoe UI
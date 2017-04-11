show user;
create table s(
  sno number(10) primary key,
  sname varchar2(20) not null,
  gender varchar(20) not null,
  school varchar(20)
);

select * from user_tables;
select * from s;
insert into s values(01,'刘叶','男','西安石油大学');
delete from s where sno=091;
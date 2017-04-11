-- Create table ѧ����Ϣ
create table HAND_STUDENT
(
  STUDENT_NO     VARCHAR2(10) not null,
  STUDENT_NAME   VARCHAR2(20),
  STUDENT_AGE    NUMBER(2),
  STUDENT_GENDER VARCHAR2(5)
);
-- Add comments to the table 
comment on table HAND_STUDENT
  is 'ѧ����Ϣ��';
-- Add comments to the columns 
comment on column HAND_STUDENT.STUDENT_NO
  is 'ѧ��';
comment on column HAND_STUDENT.STUDENT_NAME
  is '����';
comment on column HAND_STUDENT.STUDENT_AGE
  is '����';
comment on column HAND_STUDENT.STUDENT_GENDER
  is '�Ա�';
-- Create/Recreate primary, unique and foreign key constraints 
alter table HAND_STUDENT add primary key (STUDENT_NO);

-- Create table ��ʦ��Ϣ��
create table HAND_TEACHER
(
  TEACHER_NO   VARCHAR2(10) not null,
  TEACHER_NAME VARCHAR2(20),
  MANAGER_NO   VARCHAR2(10)
);
-- Add comments to the table 
comment on table HAND_TEACHER
  is '��ʦ��Ϣ��';
-- Add comments to the columns 
comment on column HAND_TEACHER.TEACHER_NO
  is '��ʦ���';
comment on column HAND_TEACHER.TEACHER_NAME
  is '��ʦ����';
comment on column HAND_TEACHER.MANAGER_NO
  is '�ϼ����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table HAND_TEACHER add primary key (TEACHER_NO);

-- Create table �γ���Ϣ��
create table HAND_COURSE
(
  COURSE_NO   VARCHAR2(10) not null,
  COURSE_NAME VARCHAR2(20),
  TEACHER_NO  VARCHAR2(20) not null
);
-- Add comments to the table 
comment on table HAND_COURSE
  is '�γ���Ϣ��';
-- Add comments to the columns 
comment on column HAND_COURSE.COURSE_NO
  is '�γ̺�';
comment on column HAND_COURSE.COURSE_NAME
  is '�γ�����';
comment on column HAND_COURSE.TEACHER_NO
  is '��ʦ���';
-- Create/Recreate primary, unique and foreign key constraints 
alter table HAND_COURSE add constraint PK_COURSE primary key (COURSE_NO, TEACHER_NO);

-- Create table �ɼ���Ϣ��
create table HAND_STUDENT_CORE
(
  STUDENT_NO VARCHAR2(10) not null,
  COURSE_NO  VARCHAR2(10) not null,
  CORE       NUMBER(4,2)
);
-- Add comments to the table 
comment on table HAND_STUDENT_CORE
  is 'ѧ���ɼ���';
-- Add comments to the columns 
comment on column HAND_STUDENT_CORE.STUDENT_NO
  is 'ѧ��';
comment on column HAND_STUDENT_CORE.COURSE_NO
  is '�γ̺�';
comment on column HAND_STUDENT_CORE.CORE
  is '����';
-- Create/Recreate primary, unique and foreign key constraints 
alter table HAND_STUDENT_CORE add constraint PK_SC primary key (STUDENT_NO, COURSE_NO);


/*******��ʼ��ѧ���������******/
insert into HAND_STUDENT values ('s001','����',23,'��');
insert into HAND_STUDENT values ('s002','����',23,'��');
insert into HAND_STUDENT values ('s003','����',25,'��');
insert into HAND_STUDENT values ('s004','����',20,'Ů');
insert into HAND_STUDENT values ('s005','����',20,'Ů');
insert into HAND_STUDENT values ('s006','�',21,'��');
insert into HAND_STUDENT values ('s007','����',21,'��');
insert into HAND_STUDENT values ('s008','����',21,'Ů');
insert into HAND_STUDENT values ('s009','������',23,'Ů');
insert into HAND_STUDENT values ('s010','����',22,'Ů');
commit;
/******************��ʼ����ʦ��***********************/
insert into HAND_TEACHER values ('t001', '����','');
insert into HAND_TEACHER values ('t002', '����','t001');
insert into HAND_TEACHER values ('t003', '������','t002');
commit;
/***************��ʼ���γ̱�****************************/
insert into HAND_COURSE values ('c001','J2SE','t002');
insert into HAND_COURSE values ('c002','Java Web','t002');
insert into HAND_COURSE values ('c003','SSH','t001');
insert into HAND_COURSE values ('c004','Oracle','t001');
insert into HAND_COURSE values ('c005','SQL SERVER 2005','t003');
insert into HAND_COURSE values ('c006','C#','t003');
insert into HAND_COURSE values ('c007','JavaScript','t002');
insert into HAND_COURSE values ('c008','DIV+CSS','t001');
insert into HAND_COURSE values ('c009','PHP','t003');
insert into HAND_COURSE values ('c010','EJB3.0','t002');
commit;
/***************��ʼ���ɼ���***********************/
insert into HAND_STUDENT_CORE values ('s001','c001',58.9);
insert into HAND_STUDENT_CORE values ('s002','c001',80.9);
insert into HAND_STUDENT_CORE values ('s003','c001',81.9);
insert into HAND_STUDENT_CORE values ('s004','c001',60.9);
insert into HAND_STUDENT_CORE values ('s001','c002',82.9);
insert into HAND_STUDENT_CORE values ('s002','c002',72.9);
insert into HAND_STUDENT_CORE values ('s003','c002',81.9);
insert into HAND_STUDENT_CORE values ('s001','c003','59');
commit;

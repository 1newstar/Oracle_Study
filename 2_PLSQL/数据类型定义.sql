--数据类型的定义
--变量
--if ,case,for,loop(open),while
--open和复杂变量类型结合
--bulk collect(元旦了解,批量处理,非常重要),取游标很费时
--forall(重要哦)
--exception(系统预设,用户自定义,异常处理)
--自行设计以及编写测试用例
--本周五发视频资料(timestamp:2016-12-28)

--ems pda

--虚拟机
--utl file
--ebs system
--java解析excel并将其解析为数据库可识别数据类型

--分部门打印所有员工的信息

DECLARE
  TOTAL_STAFF  NUMBER := 0;
  TOTAL_SALARY NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('工资表');
  FOR EMP IN (SELECT * FROM EMPLOYEES ORDER BY EMPLOYEE_ID) LOOP
    DBMS_OUTPUT.PUT_LINE(EMP.EMPLOYEE_ID || ' ' ||
                         RPAD(EMP.FIRST_NAME || ' ' || EMP.LAST_NAME,
                              10,
                              ' ') || ' ' || EMP.SALARY);
    TOTAL_STAFF  := TOTAL_STAFF + 1;
    TOTAL_SALARY := TOTAL_SALARY + EMP.SALARY;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('员工人数' || TOTAL_STAFF || ' 总工资' || TOTAL_SALARY ||
                       ' 平均工资' || ROUND(TOTAL_SALARY / TOTAL_STAFF, 2));
END;


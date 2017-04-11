--pl/sql学习

--一.流程控制
--1.分支结构
--a.if...else...
DECLARE
  INUM NUMBER;
BEGIN
  INUM := &PNUM;
  IF INUM = 1 THEN
    DBMS_OUTPUT.PUT_LINE('你输入的是数字1!');
  END IF;
END;

--b.if...else...
DECLARE
  INUM NUMBER;
BEGIN
  INUM := &PNUM;
  IF INUM = 1 THEN
    DBMS_OUTPUT.PUT_LINE('你输入的是1!');
  ELSE
    DBMS_OUTPUT.PUT_LINE('你输入的是其它数!');
  END IF;
END;

--c.else...if...
DECLARE
  INUM NUMBER;
BEGIN
  INUM := &PNUM;
  DBMS_OUTPUT.PUT_LINE('');
  IF INUM = 1 THEN
    DBMS_OUTPUT.PUT_LINE('你输入的是-->1');
  ELSIF INUM = 2 THEN
    DBMS_OUTPUT.PUT_LINE('你输入的是-->2');
  ELSE
    DBMS_OUTPUT.PUT_LINE('你输入的是其他数!');
  END IF;
  DBMS_OUTPUT.PUT_LINE('the end');
END;

--d.case结构
DECLARE
  INUM NUMBER;
BEGIN
  INUM := &PNUM;
  CASE INUM
    WHEN 1 THEN
      DBMS_OUTPUT.PUT_LINE('你输入的是--->1');
    WHEN 2 THEN
      DBMS_OUTPUT.PUT_LINE('你输入的是--->2');
    WHEN 3 THEN
      DBMS_OUTPUT.PUT_LINE('你输入的是--->3');
    ELSE
      DBMS_OUTPUT.PUT_LINE('你输入的数字是不合法的!');
  END CASE;
END;

--2.循环结构
--a.loop...exit
DECLARE
  INUM NUMBER := &PNUM;
BEGIN
  LOOP
    EXIT WHEN INUM > 12;
    DBMS_OUTPUT.PUT_LINE('本次打印-->' || INUM);
    INUM := INUM + 1;
  END LOOP;
END;

--b.while...loop...
DECLARE
  INUM NUMBER := &PNUM;
BEGIN
  WHILE INUM < 100 LOOP
    DBMS_OUTPUT.PUT_LINE('本次打印-->' || INUM);
    INUM := INUM + 1;
  END LOOP;
END;

--c.for...loop...
DECLARE

BEGIN
  FOR INUM IN 1 .. 100 LOOP
    DBMS_OUTPUT.PUT_LINE('本次打印...' || INUM);
  END LOOP;
END;
/

--d.for...loop...倒叙输出
DECLARE
BEGIN
 FOR i IN reverse 1..10 LOOP
  dbms_output.put_line('本次打印-->'||i);   
 END LOOP; 
END;

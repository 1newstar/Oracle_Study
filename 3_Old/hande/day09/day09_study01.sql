--pl/sqlѧϰ

--һ.���̿���
--1.��֧�ṹ
--a.if...else...
DECLARE
  INUM NUMBER;
BEGIN
  INUM := &PNUM;
  IF INUM = 1 THEN
    DBMS_OUTPUT.PUT_LINE('�������������1!');
  END IF;
END;

--b.if...else...
DECLARE
  INUM NUMBER;
BEGIN
  INUM := &PNUM;
  IF INUM = 1 THEN
    DBMS_OUTPUT.PUT_LINE('���������1!');
  ELSE
    DBMS_OUTPUT.PUT_LINE('���������������!');
  END IF;
END;

--c.else...if...
DECLARE
  INUM NUMBER;
BEGIN
  INUM := &PNUM;
  DBMS_OUTPUT.PUT_LINE('');
  IF INUM = 1 THEN
    DBMS_OUTPUT.PUT_LINE('���������-->1');
  ELSIF INUM = 2 THEN
    DBMS_OUTPUT.PUT_LINE('���������-->2');
  ELSE
    DBMS_OUTPUT.PUT_LINE('���������������!');
  END IF;
  DBMS_OUTPUT.PUT_LINE('the end');
END;

--d.case�ṹ
DECLARE
  INUM NUMBER;
BEGIN
  INUM := &PNUM;
  CASE INUM
    WHEN 1 THEN
      DBMS_OUTPUT.PUT_LINE('���������--->1');
    WHEN 2 THEN
      DBMS_OUTPUT.PUT_LINE('���������--->2');
    WHEN 3 THEN
      DBMS_OUTPUT.PUT_LINE('���������--->3');
    ELSE
      DBMS_OUTPUT.PUT_LINE('������������ǲ��Ϸ���!');
  END CASE;
END;

--2.ѭ���ṹ
--a.loop...exit
DECLARE
  INUM NUMBER := &PNUM;
BEGIN
  LOOP
    EXIT WHEN INUM > 12;
    DBMS_OUTPUT.PUT_LINE('���δ�ӡ-->' || INUM);
    INUM := INUM + 1;
  END LOOP;
END;

--b.while...loop...
DECLARE
  INUM NUMBER := &PNUM;
BEGIN
  WHILE INUM < 100 LOOP
    DBMS_OUTPUT.PUT_LINE('���δ�ӡ-->' || INUM);
    INUM := INUM + 1;
  END LOOP;
END;

--c.for...loop...
DECLARE

BEGIN
  FOR INUM IN 1 .. 100 LOOP
    DBMS_OUTPUT.PUT_LINE('���δ�ӡ...' || INUM);
  END LOOP;
END;
/

--d.for...loop...�������
DECLARE
BEGIN
 FOR i IN reverse 1..10 LOOP
  dbms_output.put_line('���δ�ӡ-->'||i);   
 END LOOP; 
END;

--�������͵Ķ���
--����
--if ,case,for,loop(open),while
--open�͸��ӱ������ͽ��
--bulk collect(Ԫ���˽�,��������,�ǳ���Ҫ),ȡ�α�ܷ�ʱ
--forall(��ҪŶ)
--exception(ϵͳԤ��,�û��Զ���,�쳣����)
--��������Լ���д��������
--�����巢��Ƶ����(timestamp:2016-12-28)

--ems pda

--�����
--utl file
--ebs system
--java����excel���������Ϊ���ݿ��ʶ����������

--�ֲ��Ŵ�ӡ����Ա������Ϣ

DECLARE
  TOTAL_STAFF  NUMBER := 0;
  TOTAL_SALARY NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('���ʱ�');
  FOR EMP IN (SELECT * FROM EMPLOYEES ORDER BY EMPLOYEE_ID) LOOP
    DBMS_OUTPUT.PUT_LINE(EMP.EMPLOYEE_ID || ' ' ||
                         RPAD(EMP.FIRST_NAME || ' ' || EMP.LAST_NAME,
                              10,
                              ' ') || ' ' || EMP.SALARY);
    TOTAL_STAFF  := TOTAL_STAFF + 1;
    TOTAL_SALARY := TOTAL_SALARY + EMP.SALARY;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Ա������' || TOTAL_STAFF || ' �ܹ���' || TOTAL_SALARY ||
                       ' ƽ������' || ROUND(TOTAL_SALARY / TOTAL_STAFF, 2));
END;


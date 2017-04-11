SELECT * FROM CUX_ORDER_HEADERS_ALL;
hand_plsql_autocreate

SELECT * FROM dba_policies t WHERE t.OBJECT_NAME LIKE 'CUX%';


BEGIN
	dbms_rls.drop_policy(object_name =>'CUX_ORDER_HEADERS' ,policy_name => 'ORG_SEC');
    	dbms_rls.drop_policy(object_name =>'CUX_ORDER_HEADERS_ALL' ,policy_name => 'ORG_SEC');
        END;

cux_order_headers_pkg

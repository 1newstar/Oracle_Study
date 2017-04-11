PL/SQL Developer Test script 3.0
7
begin
  -- Call the procedure
  hand_plsql_autocreate.form_table_handle(p_block_name => :p_block_name,
                                          p_package_name => :p_package_name,
                                          p_table_name => :p_table_name,
                                          p_primary_key => :p_primary_key);
end;
4
p_block_name
1
ORDER_HEADERS
5
p_package_name
1
CUX_ORDER_HEADERS_PKG
5
p_table_name
1
CUX_ORDER_HEADERS_ALL
5
p_primary_key
1
HEADER_ID
5
0

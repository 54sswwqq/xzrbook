<!--#include file=conn.asp -->
<%
Response.write "<p>�û��б�</p>"
Call openconn()
sql="Select * from reg Order By regid asc"
Set rs= conn.execute(sql)
Do While Not rs.eof
	Response.write "<li>"& rs("regname") &","& rs("regtime") &"</li>"
	rs.movenext
loop
rs.close
Call closeconn()
%>
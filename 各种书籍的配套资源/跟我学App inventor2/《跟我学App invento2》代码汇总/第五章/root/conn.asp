<%
Dim mdb,conn,StrSQL
'�������ݿ�
Sub openconn()
	mdb="reg.mdb"
	set conn=server.createobject("ADODB.Connection")
	StrSQL="DBQ="&server.mappath(mdb)&";DRIVER={Microsoft Access Driver (*.mdb)};"
	conn.open StrSQL
end sub
'�ر����ݿ�
Sub closeconn()
	conn.close
	Set conn = Nothing
End Sub
'����һ��SafeRequest����������ע��©��
Function SafeRequest(ParaName)
	Dim ParaValue
	ParaValue=Request(ParaName)
	ParaValue=replace(ParaValue,"'","")
	SafeRequest=ParaValue
End Function
%>
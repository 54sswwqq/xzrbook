<%
Sub echo(str)
	Response.write str
End Sub

Function SafeRequest(ParaName,ParaType)
	Dim ParaValue
	ParaValue=Request(ParaName)
	if ParaValue<>"" then
		If ParaType=1 then
			If not isNumeric(ParaValue) Then
				ReDim s(1)
				'Response.write "����" & ParaName & "����Ϊ�����ͣ�"
				s(0)="0"
				s(1)="����" & ParaName & "����Ϊ�����ͣ�"
				Response.Write toJSON(s)
				Response.end
			End if
		Else
		ParaValue=replace(ParaValue,"'","''")
		ParaValue=replace(ParaValue,";","")
		ParaValue=replace(ParaValue," ","")
		End if
		SafeRequest=ParaValue
	else
		SafeRequest=""
	end if
End function

dim db,conn,connstr
db="words.mdb"
set Conn = server.CreateObject("ADODB.Connection")
connstr="provider=microsoft.jet.oledb.4.0;Persist Security Info=False;data source=" & server.MapPath(db)
conn.Open connstr
%>
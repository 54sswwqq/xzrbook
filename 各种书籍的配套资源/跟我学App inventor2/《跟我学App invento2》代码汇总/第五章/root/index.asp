<!--#include file=conn.asp -->
<!--#include file="json.inc"-->
<%
Dim regname,regpass,action,s1,s2
regname=SafeRequest("u")
regpass=SafeRequest("p")
action=Request("a")
Call openconn()
If action="1" Then 'ע��
	If regname<>"" and regpass<>"" Then
		sql="Select * from reg where regname='" & regname & "'"
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If rs.eof Or rs.bof Then
			rs.addnew
			rs("regname")=regname
			rs("regpass")=regpass
			rs("regtime")=now()
			rs("count")=0
			rs.update
			s1="1":s2="ע��ɹ���"
		Else
			s1="0":s2="ע��ʧ��,�û����Ѿ����ڣ�"
		End If
		rs.close
	Else
		s1="0":s2="ע��ʧ��,�û����������벻��Ϊ�գ�"
	End if
Elseif action="2" Then '��½
	If regname<>"" and regpass<>"" Then
		sql="Select * from reg where (regname='" & regname & "' and regpass='" & regpass & "')"
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If Not (rs.eof Or rs.bof) Then
			rs("count")=rs("count")+1
			rs("logintime")=now()
			rs.update
			s1="1":s2="��¼�ɹ�,��¼����:"& rs("count")
		Else
			s1="0":s2="��¼ʧ��!"
		End If
		rs.close
	Else
		s1="1":s2="��½ʧ�ܣ��û����������벻��Ϊ��!"
	End If
Else
	s1="0":s2="ȱ�ٱ�Ҫ�Ĳ���!"
End If
Call closeconn()

dim json,jsonStr
set json=new Aien_Json			'������json����
json.JsonType="object"			'json���ݽṹΪ����
json.addData "errNum",s1		'�������
json.addData "errMsg",s2
jsonStr=json.getJson(json)		'��ȡ������ɵ�json�ַ���
Response.write jsonStr          '���
set json=nothing
%>
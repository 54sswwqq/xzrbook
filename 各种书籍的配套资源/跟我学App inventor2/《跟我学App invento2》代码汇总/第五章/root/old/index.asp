<!--#include file=conn.asp -->
<!--#include file=config.asp -->
<%
'�ӿ�
'appidΪӦ�ó��������,action��Ϊ����:��ѯ1,��½2,���3,�޸�4,���·���5,�����ѯ6
'�����Ϣ��ǰ�����ַ���:ok����no,������Ϊ�������Ϣ��
'��ѯ��ʽ:index.asp?appid=1&regname=xzr&action=1
'�������˳���������
'��½��ʽ:index.asp?appid=1&regname=xzr&regpass=123&action=2
'��Ӹ�ʽ:index.asp?appid=1&regname=xzr&regpass=123&action=3
'�޸ĸ�ʽ:index.asp?appid=1&regname=xzr&regpass=123&newregpass=321&action=4
'���·�����ʽ������ͳ�������:index.asp?appid=1&regname=xzr&score=99&action=5
'��ѯ��ʽ������ע���û��ͷ��������:index.asp?appid=1&action=6
'ע���û�:*;��Ч����������0��:*;ƽ������:*;��߷�:*;��ͷ�:*;

Dim appid,regname,regpass,action
appid=SafeRequest("appid",1)
regname=SafeRequest("regname",0)
regpass=SafeRequest("regpass",0)
action=Request("action")
If appid<>"" Then 
Call openconn()
'��ѯ
If action="1" Then
	If regname<>"" Then
		sql="Select * from reg where regname='" & regname & "' and appid="&appid
		'echo sql
		Set rs=conn.execute(sql)
		If Not(rs.eof or rs.bof) Then
			echo "ok,����:"& rs("score")
		Else
			echo "no,�û������ڣ�"
		End If
		rs.close
	Else
		echo "no,�û�������Ϊ�գ�"
	End if
End If
'��½
If action="2" Then
	If regname<>"" and regpass<>"" Then
		sql="Select * from reg where (regname='" & regname & "' and regpass='" & regpass & "') and appid="&appid
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If Not (rs.eof Or rs.bof) Then
			'sql="update reg set count=count+1,logintime='" & now() &"' where (regname='" & regname & "' and regpass='" & regpass & "') and appid="&appid
			'conn.execute(sql)
			rs("count")=rs("count")+1
			rs("logintime")=now()
			rs.update
			echo "ok,��½�ɹ���"
		Else
			echo "no,��½ʧ�ܣ�"
		End If
		rs.close
	Else
		echo "no,�û����������벻��Ϊ�գ�"
	End if
End If
'ע��
If action="3" Then
	If regname<>"" and regpass<>"" Then
		sql="Select * from reg where regname='" & regname & "' and appid="&appid
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If rs.eof Or rs.bof Then
			'conn.execute("insert into reg (regname,regpass,appid) values ('" & regname & "','" & regpass & "'," & appid &")")
			rs.addnew
			rs("regname")=regname
			rs("regpass")=regpass
			rs("appid")=appid
			rs.update
			echo "ok,ע��ɹ���"
		Else
			echo "no,ע��ʧ�ܣ�"
		End If
		rs.close
	Else
		echo "no,�û����������벻��Ϊ�գ�"
	End if
End If
'�޸�
If action="4" Then
	If regname<>"" and regpass<>"" Then
		newregpass=SafeRequest("newregpass",0)
		If newregpass<>"" then
			sql="Select * from reg where (regname='" & regname & "' and regpass='" & regpass & "') and appid="&appid
			Set rs= Server.CreateObject("ADODB.Recordset")
			rs.open sql,conn,1,3
			If Not (rs.eof Or rs.bof) Then
				'sql="update reg set regpass='"& newregpass &"',logintime='" & now() &"' where (regname='" & regname & "' and regpass='" & regpass & "') and appid="&appid
				rs("regpass")=newregpass
				rs("logintime")=now()
				rs.update
				echo "ok,�����޸ĳɹ���"
			Else
				echo "no,�����޸�ʧ��,�����û�����ԭ���룡"
			End If
		Else
			echo "no,�����벻��Ϊ�գ�"		
		End if
		rs.close
	Else
		echo "no,�û����������벻��Ϊ�գ�"
	End If
End If
'���·���,���������
If action="5" Then
score=SafeRequest("score",1)
	If regname<>"" And score<>"" Then
		sql="Select * from reg where regname='" & regname & "' and appid="&appid
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,3
		If rs.eof Or rs.bof Then
			'����û������ڣ������
			rs.addnew
			rs("regname")=regname
			rs("regpass")="123456"
			rs("appid")=appid
		End If
		'sql="update reg set score="& score &" where regname='" & regname & "' and appid="&appid
		rs("score")=score
		rs.update
		rs.close
		Set rs=conn.execute("select count(regid) as c0 from reg where score>" & score &" and appid="& appid)
		c=rs(0)+1
		Set rs=conn.execute("select count(regid) as c1,max(score) as c2 ,min(score) as c3,avg(score) as c4  from reg where score>0 and appid="& appid)
		echo "ok,���³ɹ�������:"& c &";��Ч����:"& rs(0) &";���:"& rs(1) &";���:"& rs(2) &";ƽ��:"& rs(3)
		rs.close
	Else
		echo "no,�û������߲�������Ϊ�գ�"
	End if
End If
'�ۺϲ�ѯ��appid��
'ע���û�:*;��Ч����������0��:*;ƽ������:*;��߷�:*;��ͷ�:*;
If action="6" Then
	sql="Select count(*) as c from reg where appid="&appid
	Set rs=conn.execute(sql)
	c=rs(0)
	Set rs=conn.execute("select count(regid) as c1,max(score) as c2 ,min(score) as c3,avg(score) as c4  from reg where score>0 and appid="& appid)
	echo "ok,ע������:"& c &";��Ч����:"& rs(0) &";���:"& rs(1) &";���:"& rs(2) &";ƽ��:"& rs(3)
	rs.close
End If

Call closeconn()
else
	'response.redirect("index.htm")
	echo "no,Appid����Ϊ�գ�"
End if
%>

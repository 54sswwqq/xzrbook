<%
Function SafeRequest(ParaName,ParaType)
Dim ParaValue
ParaValue=Request(ParaName)
if ParaValue<>"" then
If ParaType=1 then
If not isNumeric(ParaValue) then
Response.write "no������" & ParaName & "����Ϊ�����ͣ�"
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

sub mygoto(str,url)
zjcss.mygoto str,url
response.end
end sub

'''''''''��ʾ����
Sub chkErr(Err) 
If Err Then
echo "<style>body{margin:8;border:none;overflow:hidden;background-color:buttonface;}</style>"
echo "<br/><font size=2><li>����: " & Err.Description & "</li><li>����Դ: " & Err.Source & "</li><br/>"
Err.Clear
Response.End
End If
End Sub

'''''''''���
Sub echo(str)
Response.Write(str)
End Sub

sub copyright()
zjcss.copyright()
end sub

'**************************************************
'��������showpage
'��  �ã���ʾ����һҳ ��һҳ������Ϣ
'��  ����sfilename  ----���ӵ�ַ
'       totalnumber ----������
'       maxperpage  ----ÿҳ����
'       ShowTotal   ----�Ƿ���ʾ������
'       ShowAllPages ---�Ƿ��������б���ʾ����ҳ���Թ���ת����ĳЩҳ�治��ʹ�ã���������JS����
'       strUnit     ----������λ
'**************************************************
sub showpage(sfilename,totalnumber,maxperpage,ShowTotal,ShowAllPages,strUnit)
	dim n, i,strTemp,strUrl
	if totalnumber mod maxperpage=0 then
    	n= totalnumber \ maxperpage
  	else
    	n= totalnumber \ maxperpage+1
  	end if
  	strTemp= "<table align='center'><tr><td>"
	if ShowTotal=true then 
		strTemp=strTemp & "�� <b>" & totalnumber & "</b> " & strUnit & "&nbsp;&nbsp;"
	end if
	strUrl=JoinChar(sfilename)
  	if CurrentPage<2 then
    		strTemp=strTemp & "��ҳ ��һҳ&nbsp;"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=1'>��ҳ</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage-1) & "'>��һҳ</a>&nbsp;"
  	end if

  	if n-currentpage<1 then
    		strTemp=strTemp & "��һҳ βҳ"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage+1) & "'>��һҳ</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & n & "'>βҳ</a>"
  	end if
   	strTemp=strTemp & "&nbsp;ҳ�Σ�<strong><font color=red>" & CurrentPage & "</font>/" & n & "</strong>ҳ "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "/ҳ"
	if ShowAllPages=True then
		strTemp=strTemp & "&nbsp;ת����<select name='page' size='1' onchange=""javascript:window.location='" & strUrl & "page=" & "'+this.options[this.selectedIndex].value;"">"   
    	for i = 1 to n   
    		strTemp=strTemp & "<option value='" & i & "'"
			if cint(CurrentPage)=cint(i) then strTemp=strTemp & " selected "
			strTemp=strTemp & ">��" & i & "ҳ</option>"   
	    next
		strTemp=strTemp & "</select>"
	end if
	strTemp=strTemp & "</td></tr></table>"
	response.write strTemp
end sub
'**************************************************
'��������JoinChar
'��  �ã����ַ�м��� ? �� &
'��  ����strUrl  ----��ַ
'����ֵ������ ? �� & ����ַ
'**************************************************
function JoinChar(Urlstr)
if Urlstr="" then
	JoinChar=""
	exit function
end if
if InStr(Urlstr,"?")<len(Urlstr) then 
	if InStr(Urlstr,"?")>1 then
		if InStr(Urlstr,"&")<len(Urlstr) then 
			JoinChar = Urlstr & "&"
		else
			JoinChar = Urlstr
		end if
	else
		JoinChar = Urlstr & "?"
	end if
else
	JoinChar = Urlstr
end if
end function

'��ֹSQLע��,����������id
Function FilterIDs(byval strIDs)
	Dim arrIDs,i,strReturn
	strIDs=Trim(strIDs)
	If Len(strIDs)=0  Then Exit Function
	arrIDs=Split(strIDs,",")
	For i=0 To Ubound(arrIds)
		If IsNumeric(arrIDs(i)) Then
			strReturn=strReturn & "," & Int(arrIDs(i))
		End If
	Next
	If Left(strReturn,1)="," Then strReturn=Right(strReturn,Len(strReturn)-1)
	FilterIDs=strReturn
End Function

'''�ж�ĳ�����Ƿ������ĳ�ַ�����
'����˵����id:������str:�ַ�����fg:�ָ���
Function iscunzai(id,str,fg)
mystr=split(str,fg)
iscunzai=0
for i=0 to UBound(mystr)   
   if trim(mystr(i))=cstr(id) then
   iscunzai=1
   exit for
   end if   
next
End Function
%>
<!--#include file="json.inc"-->
<%
mystr=split("a b c d e f"," ")

dim json,json1,json2,json3,jsonStr
set json=new Aien_Json				'������json����
json.JsonType="object"				'json���ݽṹΪ����
json.addData "name","anlige"		'�������
json.addData "isboy",true
json.addData "age",23
json.addData "luckyNumber",Array(34,31,42)
json.addData "words",mystr

set json2=new Aien_Json				'����һ��json�Ӷ���
json2.JsonType="object"				'���ݽṹΪ����
json2.addData "wife","Tandy"		'�������
json2.addData "school","OUC"
	
set json3=new Aien_Json				'����һ��json�Ӷ���
json3.JsonType="object"				'���ݽṹΪ����
json3.addData "chinese",85			'�������
json3.addData "english",90
		
set json1=new Aien_Json				'����һ��json�Ӷ���
json1.JsonType="array"				'���ݽṹΪ����
json1.addData "color1","green"		'�������
json1.addData "color2","red"

json2.addData "classes",json3		'��json3��ӵ�json2�У�����Ϊclasses	
json.addData "colors",json1			'��json1��ӵ�json�У�����Ϊcolors
json.addData "others",json2			'��json2��ӵ�json�У�����Ϊothers

jsonStr=json.getJson(json)			'��ȡ������ɵ�json�ַ�����������ֻ�е�һ�ε�����Ч
Response.write jsonStr
set json3=nothing
set json2=nothing
set json1=nothing
set json=nothing
%>

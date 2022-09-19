USE UNIVER;

SELECT Teacher [���_�������������], Teacher_Name [���_�������������], Gender[���], Pulpit [�������] from TEACHER
where Pulpit = '���'
for xml raw('�������������'), root('������_��������������')

-------------------------------------------task 2------------------------------------------------------

SELECT AUDITORIUM_TYPE.Auditorium_TypeName [���_���������], AUDITORIUM.Auditorium_Name [�����_���������],
       AUDITORIUM.Auditorium_Capacity [�����������_���������]
	   From AUDITORIUM inner join AUDITORIUM_TYPE On AUDITORIUM.Auditorium_Type = AUDITORIUM_TYPE.Auditorium_Type
	   where AUDITORIUM_TYPE.Auditorium_Type like '%��%'
	   order by [���_���������]
	   for xml auto, root('������_���������'), elements

-------------------------------------------task 3------------------------------------------------------

declare @xmlHandle int = 0,
      @xml varchar(2000) = '<?xml version="1.0" encoding="windows-1251" ?>
					<SUBJECTS> 
						<SUBJECTT SUBJECTT="��" SUBJECTT_NAME="�����" PULPIT="���" /> 
						<SUBJECTT SUBJECTT="����" SUBJECTT_NAME="���������" PULPIT="��������" /> 
						<SUBJECTT SUBJECTT="�����_���" SUBJECTT_NAME="����� ���" PULPIT="����"  />  
					</SUBJECTS>'
exec sp_xml_preparedocument @xmlHandle output, @xml
SELECT * from openxml(@xmlHandle, '/SUBJECTS/SUBJECTT', 0)
	with(SUBJECTT char(10), SUBJECTT_NAME varchar(100), PULPIT char(20))       

begin tran
insert into SUBJECTT SELECT * from openxml(@xmlHandle, '/SUBJECTS/SUBJECTT', 0)
	with(SUBJECTT char(10), SUBJECTT_NAME varchar(100), PULPIT char(20)) 
SELECT * from SUBJECTT where SUBJECTT LIKE '%�'
rollback tran
exec sp_xml_removedocument @xmlHandle

SELECT * from SUBJECTT

-------------------------------------------task 4------------------------------------------------------

begin tran
insert into STUDENT (IDGroup,Namee,Bday,Info)
values (	30,
			'��������� ��� ����������', '1971-05-04',
'<�������>
<������� �����="CI" �����="1111111" ����="05.09.2017"/>
<�������>1234567</�������>
<�����>
       <������>������������� ����������</������>
       <�����>������</�����>
       <�����>��� ����</�����>
       <���>1</���>
       <��������>1</��������>
</�����>
</�������>')

update STUDENT set INFO= '
<�������>
	<������� �����="MP" �����="1234567" ����="13.03.2022"/>
	<�������>1234567</�������>
	<�����>
		   <������>��������</������>
		   <�����>�����</�����>
		   <�����>�����������</�����>
		   <���>21</���>
		   <��������>414</��������>
	</�����>
</�������>' where Info.value('(�������/�����/�����)[1]','varchar(10)')='������';

SELECT IDGroup,Namee,Bday, 
Info.value('(/�������/�������/@�����)[1]','varchar(10)') [�����],
Info.value('(/�������/�������/@�����)[1]', 'varchar(10)') [����� ��������],
Info.query('/�������/�����')[�����]
from  STUDENT;

rollback

-------------------------------------------task 5------------------------------------------------------

drop xml schema collection Student;

begin tran
CREATE xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="�������">
<xs:complexType><xs:sequence>
<xs:element name="�������" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="�����" type="xs:string" use="required" />
    <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="����"  use="required"  >
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
<xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>'

alter table STUDENT alter column Info xml(Student);

begin tran
insert into STUDENT (IDGroup,Namee,Bday,Info)
values (	30,
			'��������� ��� ����������', '1971-05-04',
'<�������>
<������� �����="CI" �����="1111111" ����="05.09.2017"/>
<�������>1234567</�������>
<�����>
       <������>������������� ����������</������>
       <�����>������</�����>
       <�����>��� ����</�����>
       <���>1</���>
       <��������>1</��������>
</�����>
</�������>')

update STUDENT set INFO= '
<�������>
	<������� �����="MP" �����="1234567" ����="13.03.2022"/>
	<�������>1234567</�������>
	<�����>
		   <������>��������</������>
		   <�����>�����</�����>
		   <�����>�����������</�����>
		   <���>21</���>
		   <��������>414</��������>
	</�����>
</�������>' where Info.value('(�������/�����/�����)[1]','varchar(10)')='������';

SELECT IDGroup,Namee,Bday, 
Info.value('(/�������/�������/@�����)[1]','varchar(10)') [�����],
Info.value('(/�������/�������/@�����)[1]', 'varchar(10)') [����� ��������],
Info.query('/�������/�����')[�����]
from  STUDENT;

rollback

-------------------------------------------task 6------------------------------------------------------

SELECT rtrim(FACULTY.FACULTY) as '@���',
(SELECT COUNT(*) from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY) as '����������_������',
(SELECT rtrim(PULPIT.PULPIT) as '@���',
(SELECT rtrim(TEACHER.TEACHER) as '�������������/@���', TEACHER.TEACHER_NAME as '�������������'

from TEACHER where TEACHER.PULPIT = PULPIT.PULPIT for xml path(''),type, root('�������������'))
from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY for xml path('�������'), type, root('�������'))
from FACULTY for xml path('���������'), type, root('�����������')

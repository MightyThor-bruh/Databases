USE SH_MyBase;
CREATE table ������������
( ��������_������������ nvarchar(50) primary key, 
  ����_����������� date not null, 
  ���������� int not null,
  ����_�������� date not null,
  �������_�������� nvarchar(50) not null
) on FG1;
CREATE table ���������� 
( id_�������������� int primary key,
  ������� nvarchar(50) not null,
  ��� nvarchar(20) not null,
  �������� nvarchar(50),
  ��������� nvarchar(50) not null,
  ����_������_��_������ date not null
) on FG1;
CREATE table ����� 
( ������������� nvarchar(50) primary key,
  ���_������������ nvarchar(50) not null foreign key references ������������(��������_������������),
  ���_���������� int not null foreign key references ����������(id_��������������)
) on FG1;
ALTER table ����� ADD ���������� int;
SELECT * FROM �����;
ALTER table ����� DROP CONSTRAINT UQ__�����__F11B377B2F8DCC68;
ALTER table ����� DROP COLUMN ����������;
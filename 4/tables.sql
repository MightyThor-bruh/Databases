USE UNIVER;
CREATE table FACULTY
( Faculty char(10) primary key,
  Faculty_Name varchar(50) default '???'
)

CREATE table PROFESSION 
( Profession char(20) primary key,
  Faculty char(10) not null foreign key references FACULTY(Faculty),
  Profession_Name varchar(100) null, 
  Qualification varchar(50) null
)

CREATE table PULPIT 
( Pulpit char(20) primary key,
  Pulpit_Name varchar(100) null,
  Faculty char(10) not null foreign key references FACULTY(Faculty)
)

CREATE table TEACHER 
( Teacher char(10) primary key,
  Teacher_Name varchar(100) null, 
  Gender char(1) check(Gender in ('�','�')),
  Pulpit char(20) not null foreign key references PULPIT(Pulpit)
)

CREATE table SUBJECTT
( Subjectt char(10) primary key,
  Subjectt_Name varchar(100) null unique,
  Pulpit char(20) not null foreign key references PULPIT(Pulpit)
)

CREATE table AUDITORIUM_TYPE 
( Auditorium_Type char(10) primary key,
  Auditorium_TypeName varchar(30) null
)

CREATE table AUDITORIUM 
( Auditorium char(20) primary key,
  Auditorium_Type char(10) not null foreign key references AUDITORIUM_TYPE(Auditorium_Type),
  Auditorium_Capacity int default 1 check(Auditorium_Capacity between 1 and 300),
  Auditorium_Name varchar(50) null
)

CREATE table GROUPA
( IDGroup int primary key,
  Faculty char(10)  not null foreign key references FACULTY(Faculty),
  Profession char(20) not null foreign key references PROFESSION(Profession),
  Year_First smallint check(Year_First <=Year(Getdate())),
  Course tinyint
)

CREATE table STUDENT 
( IDStudent int primary key identity (1000,1),
  IDGroup int not null foreign key references GROUPA(IDGroup),
  Namee nvarchar(100),
  Bday date,
  Stamp timestamp,
  Info xml default 'null',
  Photo varbinary(max)
)

CREATE table PROGRESS 
( Subjectt char(10) foreign key references SUBJECTT(Subjectt),
  IDStudent int  foreign key references STUDENT(IDStudent),
  PDate date,
  Note int check(Note between 1 and 100)
)
 set identity_insert STUDENT ON
 INSERT into STUDENT(IDStudent, IDGroup, Namee, Bday)
  values (1000, 22, '����� ������ ����������', '12/01/1996'),
         (1001, 23, '������ ������� ��������', '19/07/1996'),
		 (1002, 24, '������ ����� ����������', '22/05/1996'),
         (1003, 25, '������ ������ ��������', '08/12/1996'),
		 (1004, 26, '������ ������ ����������', '11/11/1995'),
         (1005, 27, '������ ������� ����������', '24/08/1996'),
		 (1006, 28, '����� ���� �������������', '15/09/1996'),
         (1007, 29, '������ ���� ��������', '16/10/1996')

INSERT into PROGRESS(Subjectt, IDStudent, PDate, Note)
  values ('��', 1000,'12/01/2014', '4'),
         ('����', 1001,  '19/01/2014', '5'),
		 ('���', 1002,'08/01/2014', '9'),
         ('���', 1003, '11/01/2014', '8'),
		 ('����', 1004, '15/01/2014', '4'),
         ('����', 1005, '16/01/2014', '7'),
		 ('���', 1006, '27/01/2014', '6')